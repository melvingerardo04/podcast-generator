FROM ubuntu:latest

# Update package list and install Python, pip, git, and build tools
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
