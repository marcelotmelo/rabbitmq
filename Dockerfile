#
# RabbitMQ Dockerfile
#
# https://github.com/dockerfile/rabbitmq
#

# Pull base image.
FROM dockerfile/ubuntu

# Add files.
ADD bin/rabbitmq-start /usr/local/bin/
ADD etc/rabbitmq.config /etc/rabbitmq/
ADD etc/rabbitmq.json /etc/rabbitmq/

# Install RabbitMQ.
RUN \
  wget -qO - https://www.rabbitmq.com/rabbitmq-signing-key-public.asc | apt-key add - && \
  echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y rabbitmq-server && \
  rm -rf /var/lib/apt/lists/* && \
  rabbitmq-plugins enable rabbitmq_management rabbitmq_federation rabbitmq_federation_management && \
  chmod +x /usr/local/bin/rabbitmq-start

# Define environment variables.
ENV RABBITMQ_LOG_BASE /var/rabbit/data/log
ENV RABBITMQ_MNESIA_BASE /var/rabbit/data/mnesia

# Define mount points.
VOLUME ["/var/rabbit/data/log", "/var/rabbit/data/mnesia"]

# Define working directory.
WORKDIR /var/rabbit/

# Define default command.
CMD ["rabbitmq-start"]

# Expose ports.
EXPOSE 5672
EXPOSE 15672
