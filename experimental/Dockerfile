ARG PARENT=${PARENT:-t13a/gitit}

FROM ${PARENT}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python-pip \
    python-setuptools && \
    rm -rf /var/lib/apt/lists/*

ARG GITIT_PLUGINS_BRANCH=${GITIT_PLUGINS_BRANCH:-master}
ARG GITIT_PLUGINS_REPOSITORY=${GITIT_PLUGINS_REPOSITORY:-https://github.com/t13a/gitit-plugins}

RUN git clone -b ${GITIT_PLUGINS_BRANCH} ${GITIT_PLUGINS_REPOSITORY} /opt/gitit-plugins && \
    pip install plantuml

ADD rootfs /
