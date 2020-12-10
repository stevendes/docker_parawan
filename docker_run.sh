#!/bin/bash

xhost +local:docker

docker-compose run padawan
docker-compose stop padawan
