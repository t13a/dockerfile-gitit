ARG GITIT_IMAGE=t13a/gitit

FROM ${GITIT_IMAGE}

ARG GITIT_PLUGINS_BRANCH=master
ARG GITIT_PLUGINS_REPOSITORY=https://github.com/t13a/gitit-plugins

RUN apt-get update && \
    apt-get install -y --no-install-recommends python-pip python-setuptools python-wheel && \
    rm -rf /var/lib/apt/lists/* && \
    pip --no-cache-dir install plantuml && \
    git clone -b "${GITIT_PLUGINS_BRANCH}" --depth 1 "${GITIT_PLUGINS_REPOSITORY}" /opt/gitit-plugins

COPY rootfs /
