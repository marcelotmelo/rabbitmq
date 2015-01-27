#
# RabbitMQ Dockerfile
#
# https://github.com/marcelotmelo/rabbitmq-cluster/rhel
#
# based on https://github.com/dockerfile/rabbitmq

# Pull base image.
FROM rhel-server-docker-6.5-12.x86_64

MAINTAINER marcelomelofilho@gmail.com

# Add files.
COPY bin/rabbitmq-start /usr/local/bin/rabbitmq-start
COPY etc/rabbitmq.config /etc/rabbitmq/rabbitmq.config
COPY etc/rabbitmq.json /etc/rabbitmq/rabbitmq.json
COPY etc/erlang.cookie /var/lib/rabbitmq/.erlang.cookie

# Install RabbitMQ.
RUN \
  chmod 600 /var/lib/rabbitmq/.erlang.cookie && \
#  curl -L --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u76-b13/jdk-7u76-linux-x64.rpm -o jdk-7u76-linux-x64.rpm && \
#  echo "993d0d6425951d2a3fe39d8ad2e550fc jdk-7u76-linux-x64.rpm" | md5sum -c && \
#  rpm -i jdk-7u76-linux-x64.rpm  && \
  curl -L http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm -o erlang-solutions-1.0-1.noarch.rpm && \
  rpm -Uvh erlang-solutions-1.0-1.noarch.rpm && \
  yum install erlang && \
  rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc && \
  yum install rabbitmq-server--1.noarch.rpm && \
  rabbitmq-plugins enable rabbitmq_management rabbitmq_federation rabbitmq_federation_management && \
#  chmod +x /usr/local/bin/rabbitmq-start
#  chown rabbitmq. /var/lib/rabbitmq/.erlang.cookie && \

# Define environment variables.
ENV RABBITMQ_LOG_BASE /var/log/rabbitmq
ENV RABBITMQ_MNESIA_BASE /var/lib/rabbitmq/mnesia

# Define mount points.
VOLUME ["/var/log/rabbitmq", "/var/lib/rabbitmq/mnesia"]

# Define working directory.
WORKDIR /var/lib/rabbitmq/

# Define default command.
CMD ["rabbitmq-start"]

# Expose ports.
EXPOSE 5672
EXPOSE 15672

# Cluster ports.
EXPOSE 4369
EXPOSE 25672
