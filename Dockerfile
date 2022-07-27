FROM kalilinux/kali-rolling:latest

LABEL maintainer="sl0th0x87@gmail.com"
LABEL description="Kali Linux basic image"

ENV DEBIAN_FRONTEND noninteractive
ENV PATH=$PATH:/opt/apps/go/bin
ENV GOPATH=/opt/apps/go

WORKDIR /root

# basic system tools with apt
RUN apt-get -y update && apt-get -y dist-upgrade && apt-get -y install \
      acl \
      ca-certificates \
      curl \
      dnsutils \
      git \
      golang \
      libpcap-dev \
      openssh-client \
      openssl \
      python3 \
      python3-pip \
      rsync \
      smbclient \
      tmux \
      vim-nox \
      wget \
      zsh \
      zsh-syntax-highlighting

# create /pentest dir for work and volume mount
RUN mkdir /pentest && \
    addgroup --gid 1100 pentest && \
    chgrp pentest /pentest && \
    chmod 770 /pentest && \
    setfacl -Rm g:pentest:rwX /pentest && \
    setfacl -Rm d:g:pentest:rwX /pentest

# create /opt/apps/go dir for golang apps
RUN mkdir -p /opt/apps/go && \
    chmod 770 /opt/apps/go && \
    chgrp pentest /opt/apps/go && \
    setfacl -Rm g:pentest:rwX /opt/apps/go && \
    setfacl -Rm d:g:pentest:rwX /opt/apps/go && \
    echo 'export PATH=$PATH:/opt/apps/go/bin' >> /etc/profile && \
    echo 'export GOPATH=/opt/apps/go' >> /etc/profile

# configure application with update-alternatives
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 0

# cleanup
RUN rm -rf /var/cache/apt/*
    
VOLUME /pentest

CMD ["/bin/zsh"]
