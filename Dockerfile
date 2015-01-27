#
# RabbitMQ Dockerfile
#
# https://github.com/marcelotmelo/rabbitmq-cluster
#
# based on https://github.com/dockerfile/rabbitmq

# Pull base image.
FROM dockerfile/ubuntu

MAINTAINER marcelomelofilho@gmail.com

# Add files.
COPY common/bin/rabbitmq-start /usr/local/bin/rabbitmq-start
COPY common/etc/rabbitmq.config /etc/rabbitmq/rabbitmq.config
COPY common/etc/rabbitmq.json /etc/rabbitmq/rabbitmq.json
COPY common/etc/erlang.cookie /var/lib/rabbitmq/.erlang.cookie

# Define environment variables.
ENV RABBITMQ_LOG_BASE /var/log/rabbitmq
ENV RABBITMQ_MNESIA_BASE /var/lib/rabbitmq/mnesia

# Define mount points.
VOLUME ["/var/log/rabbitmq", "/var/lib/rabbitmq/mnesia"]

# Define working directory.
WORKDIR /var/lib/rabbitmq/

# Expose ports.
EXPOSE 5672
EXPOSE 15672

# Cluster ports.
EXPOSE 4369
EXPOSE 25672
