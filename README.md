# Build Container for Angular (Docker)

![GitHub release (latest by date)](https://img.shields.io/github/v/release/alexanderwolz/angular-docker)
![GitHub](https://img.shields.io/badge/angular-15-orange)
![GitHub](https://img.shields.io/badge/docker-23.0.1-orange)
![GitHub](https://img.shields.io/github/license/alexanderwolz/angular-docker)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/alexanderwolz/angular-docker)
![GitHub all releases](https://img.shields.io/github/downloads/alexanderwolz/angular-docker/total?color=informational)

# About
This repository holds a Dockerfile to provide the needed toolchain for building Angular web applications.

# Environmental Setup
The Angular CLI is wrapped inside the Docker container and can be easily accessed using ```bash ng.sh```.

## Wrapping in an Alias
Adding an ```alias ng="bash myfolder/angular_builder/ng.sh"``` to the environment profile (e.g. *~/.zshrc*), the Angular CLI can be used as if it is installed locally

## Starting the Angular environment
Switch into the container by using ```bash ng.sh bash```.

## Running ng serve
Because ng serve does not bind to an open connection by default (as we need in a Docker container), we have to start the command with the *--host* flag: e.g. ```ng serve --host 0.0.0.0 --disable-host-check```
