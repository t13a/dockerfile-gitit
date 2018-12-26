ARG DEBIAN_IMAGE=debian:stretch

FROM ${DEBIAN_IMAGE}

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl git libtinfo-dev netbase && \
    curl -sSL https://get.haskellstack.org/ | sh && \
    rm -rf /var/lib/apt/lists/*

ARG GITIT_BRANCH=0.12.3
ARG GITIT_REPOSITORY=https://github.com/jgm/gitit

ENV LANG=C.UTF-8 \
    STACK_ROOT=/opt/stack

RUN git clone -b "${GITIT_BRANCH}" --depth 1 "${GITIT_REPOSITORY}" /opt/gitit && \
    cd /opt/gitit && \
    stack build --flag pandoc:embed_data_files && \
    stack clean && \
    rm -rf ${STACK_ROOT}/indices && \
    rm -rf ${STACK_ROOT}/programs/*/ghc-*.tar.xz

RUN apt-get update && \
    apt-get install -y --no-install-recommends darcs git gosu mercurial mime-support && \
    rm -rf /var/lib/apt/lists/*

COPY rootfs /

ENV GITIT_USER=gitit \
    GITIT_UID=1000 \
    GITIT_GID=1000 \
    GITIT_CONF=/gitit.conf \
    GITIT_WORK_DIR=/gitit

ENTRYPOINT [ "/entrypoint.sh" ]
