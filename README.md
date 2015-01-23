## Clustered RabbitMQ Dockerfile


This repository contains **Dockerfile** of [RabbitMQ](http://www.rabbitmq.com/) clustered configuration for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/marcelotmelo/rabbitmq-cluster/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

This is a custom generated image, one which has a default `admin` user set with the tags _administrator_ applied and the `r@bb1tmul3` password assigned to it defined on the rabbit.config file.

The rabbit.config file also loads a rabbit.json file which defines a `mule` user with no tags and the `mul3r@bb1t`password that has permissions to configure, read and write any resource with the `"mule.*"` name. It also loads two durable, fanout exchanges named `mule.esb.deploy` and `mule.esb.command`.

Most of these defaults are sensible only to me, but can be easily changed on the files.

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


1. Run the first broker, which the other brokers will connect to (notice the __--name__ and __-e "HOSTNAME="__ parameters)
    `docker run -p 5672:5672 -p 15672:15672 --name rabbit1 -e HOSTNAME=rabbit1 -d marcelotmelo/rabbitmq-cluster`

2. Run the second broker, which will connect to the first one through the __--link__ parameter
    `docker run -p 5673:5672 -p 15673:15672 --name rabbit2 -e HOSTNAME=rabbit2 -e CLUSTER_WITH=rabbit1 --link rabbit1:rabbit1 -d marcelotmelo/rabbitmq-cluster`

3. Run the third broker, which will connect to the first and second one through the __--link__ parameter

    `docker run -p 5674:5672 -p 15674:15672 --name rabbit3 -e HOSTNAME=rabbit3 -e CLUSTER_WITH=rabbit1 --link rabbit1:rabbit1 --link rabbit2:rabbit2 -d marcelotmelo/rabbitmq-cluster`

4. Run the nth broker...
