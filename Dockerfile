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

# Install software-properties-common and add deadsnakes PPA
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update

# Install Python 3.10 and related packages
RUN apt-get install -y \
    python3.10 \
    python3.10-distutils \
    python3-pip \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Ensure pip is upgraded and install PyYAML
RUN python3.10 -m pip install --upgrade pip \
    && python3.10 -m pip install PyYAML

# Copy the script and entrypoint
COPY feed.py /usr/bin/feed.py
COPY entrypoint.sh /entrypoint.sh

# Ensure the entrypoint script is executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
