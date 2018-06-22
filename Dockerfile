ARG DEBIAN_VERSION=${DEBIAN_VERSION:-stretch}

FROM debian:${DEBIAN_VERSION}

ARG LTS_VERSION=${LTS_VERSION:-8.0}
ARG GHC_VERSION=${GHC_VERSION:-8.0.2}
ARG GITIT_BRANCH=${GITIT_BRANCH:-0.12.2.1}
ARG GITIT_REPOSITORY=${GITIT_REPOSITORY:-https://github.com/jgm/gitit}

ENV LTS_VERSION=${LTS_VERSION}
ENV GHC_VERSION=${GHC_VERSION}
ENV LANG C.UTF-8
ENV STACK_ROOT /opt/stack

ADD rootfs /

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    darcs \
    git \
    mercurial \
    mime-support \
    netbase && \
    curl -sSL https://get.haskellstack.org/ | sh && \
    git clone -b ${GITIT_BRANCH} --depth 1 ${GITIT_REPOSITORY} /opt/gitit && \
    cd /opt/gitit && \
    stack install && \
    echo "resolver: lts-${LTS_VERSION}" >> ${STACK_ROOT}/global-project/stack.yaml && \
    ln -s ${STACK_ROOT}/snapshots/x86_64-linux/lts-${LTS_VERSION}/${GHC_VERSION}/share/x86_64-linux-ghc-${GHC_VERSION}/pandoc-*/data /pandoc && \
    rm -rf \
    ${STACK_ROOT}/indices \
    ${STACK_ROOT}/programs/x86_64-linux/ghc-${GHC_VERSION}.tar.xz \
    /tmp/* \
    /var/lib/apt/lists/*

ENTRYPOINT [ "/entrypoint.sh" ]
