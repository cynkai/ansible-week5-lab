FROM jenkins/inbound-agent:latest
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 python3-venv openssh-client git && \
    rm -rf /var/lib/apt/lists/*
RUN python3 -m venv /opt/ansible && \
    /opt/ansible/bin/pip install --no-cache-dir ansible-core ansible-lint
ENV PATH="/opt/ansible/bin:${PATH}"
USER jenkins
