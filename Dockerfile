FROM ubuntu:14.04.3
ADD http://stedolan.github.io/jq/download/linux64/jq /usr/bin/
RUN chmod +x /usr/bin/jq
RUN echo deb http://archive.ubuntu.com/ubuntu trusty-backports main universe | \
      sudo tee /etc/apt/sources.list.d/backports.list
RUN apt-get update && apt-get install -y \
    busybox \
    curl \
    dnsmasq \
    iptables \
    monit \
    socat \
    psmisc \
    tcpdump \
    uuid-runtime \
    vim-tiny \
    openssl \
    libssl-dev \
    haproxy -t trusty-backports && \
    rm -rf /var/lib/apt/lists
ADD startup.sh /etc/init.d/agent-instance-startup
CMD ["/etc/init.d/agent-instance-startup", "init"]
# Work around overlay bug
RUN touch /etc/monit/conf.d/.hold
