FROM openjdk:7
LABEL maintainer="Stefan Kuethe <crazycapivara@gmail.com>"
# Install ssh server in order to run hadoop on a single-node in a pseudo-distributed mode
RUN apt-get update \
	&& apt-get install -y openssh-server \
	&& mkdir /var/run/sshd \
	&& ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
	&& cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
	&& chmod 0600 ~/.ssh/authorized_keys
# Install hadoop
RUN mkdir /hadoop-sandbox 
WORKDIR /hadoop-sandbox
RUN curl http://apache.lauf-forum.at/hadoop/common/hadoop-2.8.2/hadoop-2.8.2.tar.gz | tar xvz --strip 1 
#RUN cd hadoop-2.8.2 && \
RUN sed -i s/'${JAVA_HOME}'/'\/docker-java-home'/g ./etc/hadoop/hadoop-env.sh
#COPY ./input /hadoop-sandbox/some-input
COPY ./docker-entrypoint.sh /
COPY ./config /hd-config
#more ./etc/hadoop/hadoop-env.sh

EXPOSE 50070
#ENTRYPOINT ["/docker-entrypoint.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/bash"]
#ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
#cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
#chmod 0600 ~/.ssh/authorized_keys

# set java home in etc/hadoop/hadoop-env.sh
#JAVA_HOME=/docker-java-homei

