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

ENV PATH /opt/stack/snapshots/x86_64-linux/lts-8.0/8.0.2/bin:$PATH

ENTRYPOINT [ "/entrypoint.sh" ]
