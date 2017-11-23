FROM openjdk:7
LABEL maintainer="Stefan Kuethe <crazycapivara@gmail.com>"

# Environment variables
ENV HADOOP_VERSION "2.9.0"
ENV MIRROR "http://mirror.netcologne.de/apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz"
ENV HADOOP_PREFIX "/hadoop-sandbox"

# Install ssh server (and vim) in order to run hadoop in (pseudo-)distributed mode
RUN apt-get update && apt-get install -y --no-install-recommends \
		openssh-server \
		vim.tiny \
	&& rm -rf /var/lib/apt/lists/*

# Set up ssh server
RUN mkdir /var/run/sshd \
	&& ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
	&& cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
	&& chmod 0600 ~/.ssh/authorized_keys
COPY ssh-config /root/.ssh/config

# Install hadoop
RUN mkdir $HADOOP_PREFIX \
	&& curl $MIRROR | tar -xz --strip 1 -C $HADOOP_PREFIX \
	&& sed -i s/'${JAVA_HOME}'/'\/docker-java-home'/g $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh 

# Set hadoop environment variables
RUN echo "export HADOOP_VERSION=$HADOOP_VERSION" >> /root/.profile \
	&& echo "export HADOOP_PREFIX=$HADOOP_PREFIX" >> /root/.profile \
	&& echo 'export PATH=$PATH:$HADOOP_PREFIX/bin:$HADOOP_PREFIX/sbin' >> /root/.profile
ENV PATH $HADOOP_PREFIX/bin:$HADOOP_PREFIX/sbin:$PATH
WORKDIR $HADOOP_PREFIX

# Add hadoop config and setup files
COPY ./config /hd-config
COPY ./set-up-and-start-dfs.sh /
COPY ./set-up-and-start-yarn.sh /
COPY ./examples $HADOOP_PREFIX/examples

# Expose ports
## hdfs
EXPOSE 50090 50075 50070 9000

## yarn
EXPOSE 8088 8042

## ssh
EXPOSE 22

# Startup
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bash"]

