FROM ubuntu:22.04

# Install prerequisites and Python 3.10
RUN apt-get update && apt-get install -y \
    software-properties-common

# Add deadsnakes PPA for Python 3.10
RUN add-apt-repository ppa:deadsnakes/ppa

# Update again and install Python 3.10 and other dependencies
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3.10-distutils \
    python3-pip \
    git \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Use pip3.10 to install PyYAML
RUN python3.10 -m pip install --upgrade pip \
    && pip3.10 install PyYAML

# Copy your scripts to the container
COPY feed.py /usr/bin/feed.py
COPY entrypoint.sh /entrypoint.sh

# Ensure entrypoint.sh is executable
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
