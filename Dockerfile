ROM kalilinux/kali-rolling:latest

LABEL maintainer="sl0th0x87@gmail.com"
LABEL description="Kali Linux basic image for penetration testing"

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /root

# basic system tools with apt
RUN apt-get -y update && apt-get -y dist-upgrade && apt-get -y install \
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
      tmux \
      vim-nox \
      wget \
      zsh \
      zsh-syntax-highlighting

# pentesting tools with apt
RUN apt-get -y install \
      amass \
      exploitdb \
      ffuf \
      john \
      masscan \
      metasploit-framework \
      netcat-traditional \
      nikto \
      nmap \
      proxychains4 \
      seclists \
      socat \
      subfinder \
      sublist3r \
      webshells \
      wfuzz \
      wordlists \
      wpscan

# install golang tools
RUN go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest && \
    go install github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest && \
    go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest && \
    go install github.com/projectdiscovery/tlsx/cmd/tlsx@latest && \
    go install github.com/tomnomnom/anew@latest && \
    go install github.com/tomnomnom/gf@latest && \
    go install github.com/tomnomnom/waybackurls@latest && \
    go install github.com/jaeles-project/jaeles@latest

# configure application with update-alternatives
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 0

# cleanup
RUN rm -rf /var/cache/apt/*

CMD ["/bin/zsh"]
