FROM gitpod/workspace-full

USER root
RUN apt-get update && \
    apt-get install -y wget samtools nano && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER gitpod
