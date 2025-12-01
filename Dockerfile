FROM python:3-alpine
 
WORKDIR /srv/ansible
 
RUN set eux; \
    apk add --update --no-cache \
    ansible \
    ansible-lint \
    bash \
    openssh \
    openssl \
    sshpass \
    git \
    py3-jinja2 \
    grep \
    curl \
    tree \
    yq \
    jq \
    && rm -rf /var/cache/apk/*

COPY requirements.yml .

RUN ansible-galaxy collection install -r requirements.yml

RUN pip install --no-cache-dir \
    j2cli \
    setuptools \
    importlib

RUN addgroup -S ansible; \
    adduser -S ansible -G ansible -h /srv/ansible -s /bin/bash;
 
USER ansible:ansible
CMD ["ansible", "--version"]
