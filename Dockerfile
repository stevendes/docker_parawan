FROM ubuntu:18.04


ENV DEBIAN_FRONTEND=noninteractive

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# Setup environment
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    apt-utils \
    bash-completion \
    build-essential \
    curl \
    dirmngr \
    gpg-agent \
    gnupg2 \
    lsb-core \
    mesa-utils \
    pkg-config \
    python-vcstools \
    python-pip \
    software-properties-common \
    ssh \
    sudo \
    tmux

# Set the locale
RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8

# ENV \
#   LANG=en_US.UTF-8 \
#   DEBIAN_FRONTEND=noninteractive \
#   TERM=xterm

# Setup your sources.list
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# Set up your keys
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# Install ROS

RUN apt-get update && \
    apt-get install -y \
    ros-melodic-desktop

# Dependencies for building packages
RUN apt-get update && \
    apt install -y \
    python-rosdep \
    python-rosinstall \
    python-rosinstall-generator \
    python-wstool \
    build-essential


# Environment setup

RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

# Initialize rosdep

RUN rosdep init
RUN rosdep update

CMD ["bash"]

WORKDIR /catkin_ws
