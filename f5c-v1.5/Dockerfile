FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y git python3 python3-pip wget samtools nano build-essential minimap2

# Install Python tools
RUN pip install nanoplot multiqc

# Install f5c
RUN git clone --recursive https://github.com/hasindu2008/f5c.git && \
    cd f5c && \
    make && \
    make install

# Install longshot
RUN wget https://github.com/pjedge/longshot/releases/download/v0.4.3/longshot_linux_x86_64 && \
    chmod +x longshot_linux_x86_64 && \
    mv longshot_linux_x86_64 /usr/local/bin/longshot

RUN git clone https://github.com/pjedge/longshot.git && \
    cd longshot && \
    make && \
    cp longshot /usr/local/bin/

ENV PATH="/usr/local/bin:${PATH}"

