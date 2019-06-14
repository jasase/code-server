FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
	openssl \
	net-tools \
	git \
	locales \
	sudo \
	dumb-init \
	vim \
	curl \
	wget

RUN mkdir /data

RUN ls -la

RUN wget https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz \
    tar -xvf go1.12.6.linux-amd64.tar.gz \
    mv go /usr/local/ \    
    mkdir /data/go \    
    export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

ENV GOROOT=/usr/local/go
ENV GOPATH=/data/go
ENV PATH=${GOPATH}/bin:${GOROOT}/bin:${PATH}

RUN wget https://github.com/cdr/code-server/releases/download/1.1156-vsc1.33.1/code-server1.1156-vsc1.33.1-linux-x64.tar.gz \
    tar -xzf code-server1.1156-vsc1.33.1-linux-x64.tar.gz \
    mv code-server1.1156-vsc1.33.1-linux-x64/code-server /usr/local/bin/code-server


RUN mkdir /data/project
WORKDIR /data/project

VOLUME [ "/data" ]
EXPOSE 8443
ENTRYPOINT ["dumb-init", "code-server"]