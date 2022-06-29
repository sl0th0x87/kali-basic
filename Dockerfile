FROM kalilinux/kali-rolling:latest

LABEL maintainer="sl0th0x87@gmail.com"
LABEL description="Kali Linux basic image for penetration testing"

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /root

# basic system tools with apt
RUN apt -y update && apt -y dist-upgrade && apt -y install \
      ca-certificates \
      curl \
      git \
      golang \
      libpcap-dev \
      openssh-client \
      openssl \
      python3 \
      tmux \
      vim \
      wget \
      zsh

# pentesting tools with apt
RUN apt -y install \
      amass \
      exploitdb \
      ffuf \
      john \
      metasploit-framework \
      netcat-traditional \
      nikto \
      nmap \
      seclists \
      subfinder \
      sublist3r \
      wordlists

# install golang tools
RUN go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest && \
    go install github.com/projectdiscovery/tlsx/cmd/tlsx@latest && \
    go install github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest && \
    go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest && \
    go install github.com/tomnomnom/waybackurls@latest && \
    go install github.com/tomnomnom/anew@latest && \
    go install github.com/tomnomnom/gf@latest

# configure application with update-alternatives
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 0

# cleanup
RUN rm -rf /var/cache/apt/*

# expose some ports for attack methodes (python, nc, ...)
EXPOSE 80 443 1234 4444 8888

CMD ["/bin/zsh"]
