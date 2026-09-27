FROM ubuntu:22.04
RUN apt-get update && \
    apt-get install -y openssh-server python3 sudo curl && \
    mkdir -p /var/run/sshd /root/.ssh && chmod 700 /root/.ssh && \
    sed -i 's/^#*PermitRootLogin.*/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config && \
    sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    rm -rf /var/lib/apt/lists/*
COPY ansible_lab.pub /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
