#
# RabbitMQ Dockerfile
#
# https://github.com/marcelotmelo/rabbitmq-cluster/ubuntu
#
# based on https://github.com/dockerfile/rabbitmq

# Pull base image.
FROM marcelotmelo/rabbitmq-cluster

MAINTAINER marcelomelofilho@gmail.com

# Install RabbitMQ.
RUN \
  chmod 600 /var/lib/rabbitmq/.erlang.cookie && \
  wget -qO - https://www.rabbitmq.com/rabbitmq-signing-key-public.asc | apt-key add - && \
  echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y rabbitmq-server && \
  rm -rf /var/lib/apt/lists/* && \
  rabbitmq-plugins enable rabbitmq_management rabbitmq_federation rabbitmq_federation_management && \
  chmod +x /usr/local/bin/rabbitmq-start
#  chown rabbitmq. /var/lib/rabbitmq/.erlang.cookie && \

# Define default command.
CMD ["rabbitmq-start"]
