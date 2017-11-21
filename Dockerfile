FROM openjdk:7
LABEL maintainer="Stefan Kuethe <crazycapivara@gmail.com>"

# Environment variables
ENV HADOOP_VERSION "2.8.2"
#ENV MIRROR="http://apache.lauf-forum.at/hadoop/common/hadoop-2.8.2/hadoop-2.8.2.tar.gz"
ENV MIRROR "http://mirror.netcologne.de/apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz"
ENV HADOOP_HOME "/hadoop-sandbox"

# Install ssh server in order to run hadoop in (pseudo-)distributed mode
RUN apt-get update \
	&& apt-get install -y openssh-server \
	&& mkdir /var/run/sshd \
	&& ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
	&& cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
	&& chmod 0600 ~/.ssh/authorized_keys
COPY ssh-config /root/.ssh/config

# Install hadoop 
RUN mkdir $HADOOP_HOME \
	&& curl $MIRROR | tar -xz --strip 1 -C $HADOOP_HOME \
	&& sed -i s/'${JAVA_HOME}'/'\/docker-java-home'/g $HADOOP_HOME/etc/hadoop/hadoop-env.sh
ENV PATH $HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH
WORKDIR $HADOOP_HOME

# Add hadoop config and setup files
COPY ./config /hd-config
COPY ./set-up-and-start-dfs.sh /
COPY ./examples $HADOOP_HOME/examples

# Expose ports
EXPOSE 50070 22

# Startup
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bash"]

