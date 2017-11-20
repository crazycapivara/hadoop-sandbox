FROM openjdk:7
LABEL maintainer="Stefan Kuethe <crazycapivara@gmail.com>"

# Environment variables
#ENV MIRROR="http://apache.lauf-forum.at/hadoop/common/hadoop-2.8.2/hadoop-2.8.2.tar.gz"
ENV MIRROR="http://mirror.netcologne.de/apache.org/hadoop/common/hadoop-2.8.2/hadoop-2.8.2.tar.gz"
ENV INSTALL_DIR="/hadoop-sandbox"

# Install ssh server in order to run hadoop on a single-node in a pseudo-distributed mode
RUN apt-get update \
	&& apt-get install -y openssh-server \
	&& mkdir /var/run/sshd \
	&& ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
	&& cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
	&& chmod 0600 ~/.ssh/authorized_keys

# Install hadoop 
RUN mkdir $INSTALL_DIR
WORKDIR $INSTALL_DIR
#RUN wget $MIRROR && archive=$(basename $MIRROR) \
#	&& tar -xzf $archive --strip 1 \
#	&& rm $archive
# --- Same as above, but maybe slower, NEEDS TO BE CHECKED! ---
RUN curl $MIRROR | tar -xz --strip 1  \
	&& sed -i s/'${JAVA_HOME}'/'\/docker-java-home'/g ./etc/hadoop/hadoop-env.sh
ENV PATH $INSTALL_DIR/bin:$PATH

# Add config files
#COPY ./input /hadoop-sandbox/some-input
COPY ./config /hd-config
RUN cat /hd-config/set-hadoop-env-vars.sh >> /root/.bashrc \
	&& cp /hd-config/*.xml $INSTALL_DIR/etc/hadoop/

# Expose ports
EXPOSE 50070 22

# Startup
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bash"]

