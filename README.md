## Clustered RabbitMQ Dockerfile


This repository contains **Dockerfile** of [RabbitMQ](http://www.rabbitmq.com/) clustered configuration for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/marcelotmelo/rabbitmq-cluster/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [dockerfile/ubuntu](http://dockerfile.github.io/#/ubuntu)


### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/marcelotmelo/rabbitmq-cluster/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull marcelotmelo/rabbitmq-cluster`

   (alternatively, you can build an image from Dockerfile: `docker build -t="marcelotmelo/rabbitmq-cluster" github.com/marcelotmelo/rabbitmq-cluster`)


### Usage

#### Run `rabbitmq-server`

    docker run -d -p 5672:5672 -p 15672:15672 marcelotmelo/rabbitmq-cluster

#### Run `rabbitmq-server` w/ persistent shared directories.

    docker run -d -p 5672:5672 -p 15672:15672 -v <log-dir>:/data/log -v <data-dir>:/data/mnesia dockerfile/rabbitmq
    
#### Run `rabbitmq-server` clustered

    docker run -p 5672:5672 -p 15672:15672 --name rabbit1 -e HOSTNAME=rabbit1 -d marcelotmelo/rabbitmq-cluster
    docker run -p 5673:5672 -p 15673:15672 --name rabbit2 -e HOSTNAME=rabbit2 -e CLUSTER_WITH=rabbit1 --link rabbit1:rabbit1 -d marcelotmelo/rabbitmq-cluster
    docker run -p 5674:5672 -p 15674:15672 --name rabbit3 -e HOSTNAME=rabbit3 -e CLUSTER_WITH=rabbit1 --link rabbit1:rabbit1 --link rabbit2:rabbit2 -d marcelotmelo/rabbitmq-cluster
