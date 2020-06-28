ARG HASKELL_IMAGE=haskell:8.8.3

FROM ${HASKELL_IMAGE}

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        darcs \
        git \
        gosu \
        mercurial \
        mime-support \
    && rm -rf /var/lib/apt/lists/*

ARG GITIT_BRANCH=0.13.0.0
ARG GITIT_REPOSITORY=https://github.com/jgm/gitit

ENV LANG=C.UTF-8 \
    STACK_ROOT=/opt/stack

RUN stack config set system-ghc --global true \
    && stack config set install-ghc --global false \
    && git clone -b "${GITIT_BRANCH}" --depth 1 "${GITIT_REPOSITORY}" /opt/gitit \
    && cd /opt/gitit \
    && stack --allow-different-user build --flag pandoc:embed_data_files \
    && stack clean \
    && rm -rf \
        ${STACK_ROOT}/pantry \
        ${STACK_ROOT}/setup-exec-cache \
        ${STACK_ROOT}/setup-exec-src

COPY rootfs /

ENV GITIT_USER=gitit \
    GITIT_UID=1000 \
    GITIT_GID=1000 \
    GITIT_CONF=/gitit.conf \
    GITIT_WORK_DIR=/gitit

ENTRYPOINT [ "/entrypoint.sh" ]
