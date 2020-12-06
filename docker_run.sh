#!/bin/bash

IMAGE=padawan

docker run -it \
  --rm \
  --network=host \
  -e DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  -v "$HOME/.Xauthority:/root/.Xauthority:rw" \
  -v "/etc/localtime:/etc/localtime:ro" \
  -v "/dev/input:/dev/input" \
  --gpus all \
  -v "$PWD:/home/" \
  padawan
