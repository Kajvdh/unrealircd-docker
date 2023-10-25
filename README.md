# unrealircd-docker

## Goal

The goal of this project is to run an [unrealircd](https://www.unrealircd.org/) inside a Docker container. I opted to use [alpine](https://hub.docker.com/_/alpine) for the base image to keep the image size as low as possible.

## Default configuration

The default configuration that gets shipped by unrealircd (used version 6.1.2.3) was added in `./default_config` to use as reference when creating custom configuration files, but it is recommended to always verify this in the [unrealircd documentation](https://www.unrealircd.org/docs/Main_Page).