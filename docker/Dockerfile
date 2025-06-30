FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y git python3 python3-pip wget samtools nano build-essential

RUN pip install nanoplot multiqc

RUN git clone --recursive https://github.com/hasindu2008/f5c.git && \
    cd f5c && \
    make && \
    make install

RUN wget https://github.com/lh3/minimap2/releases/download/v2.26/minimap2-2.26_x64-linux.tar.bz2 && \
    tar -xjf minimap2-2.26_x64-linux.tar.bz2 && \
    mv minimap2-2.26_x64-linux/minimap2 /usr/local/bin/

RUN wget https://github.com/pjedge/longshot/releases/download/v0.4.3/longshot_linux_static && \
    chmod +x longshot_linux_static && \
    mv longshot_linux_static /usr/local/bin/longshot

ENV PATH="/usr/local/bin:${PATH}"
