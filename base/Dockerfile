ARG HASKELL_VERSION=${HASKELL_VERSION:-8.0.2}

FROM haskell:${HASKELL_VERSION}

ARG GITIT_BRANCH=${GITIT_BRANCH:-0.12.2.1}
ARG GITIT_REPOSITORY=${GITIT_REPOSITORY:-https://github.com/jgm/gitit}

ENV STACK_ROOT /opt/stack

ADD rootfs /

RUN apt-get update && \
    apt-get install -y \
    darcs \
    git \
    mercurial \
    mime-support && \
    git clone -b ${GITIT_BRANCH} --depth 1 ${GITIT_REPOSITORY} /opt/gitit && \
    cd /opt/gitit && \
    stack install && \
    rm -rf /var/lib/apt/lists/*

ARG HASKELL_VERSION_LONG=${HASKELL_VERSION_LONG:-8.0.2}
ARG HASKELL_VERSION_SHORT=${LTS_VERSION_SHORT:-8.0}

ENV PATH ${STACK_ROOT}/snapshots/x86_64-linux/lts-${HASKELL_VERSION_SHORT}/${HASKELL_VERSION_LONG}/bin:$PATH

ENTRYPOINT [ "/entrypoint.sh" ]
