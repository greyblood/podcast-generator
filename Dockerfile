# FROM ubuntu:latest

# RUN apt-get update && apt-get install -y \
#     python3.10 \
#     python3-pip \
#     git 

# # RUN pip3 install PyYAML
# RUN python3.10 -m pip install PyYAML

# COPY feed.py /usr/bin/feed.py

# COPY entrypoint.sh /entrypoint.sh

# ENTRYPOINT ["/entrypoint.sh"]

FROM ubuntu:latest

# Install required dependencies and add the deadsnakes PPA
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update

# Install Python 3.10 and required packages
RUN apt-get install -y \
    python3.10 \
    python3.10-distutils \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install pip using get-pip.py
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10

# Install PyYAML
RUN python3.10 -m pip install PyYAML

# Copy the script and entrypoint
COPY feed.py /usr/bin/feed.py
COPY entrypoint.sh /entrypoint.sh

# Ensure the entrypoint script is executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
