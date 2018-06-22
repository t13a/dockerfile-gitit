#!/bin/bash

set -euo pipefail

PUID="${PUID:-1000}"
PGID="${PGID:-1000}"
GITIT_DATA="${GITIT_DATA:-/gitit}"
GITIT_CONF="${GITIT_CONF:-${GITIT_DATA}/gitit.conf}"
GITIT_PLUGINS="${GITIT_PLUGINS:-${GITIT_DATA}/plugins}"

if [ -n "${TIMEZONE:-}" ]
then
    ln -sf "/usr/share/zoneinfo/${TIMEZONE}" /etc/localtime
fi

groupadd -g "${PGID}" -o gitit
useradd -g "${PGID}" -m -o -u "${PUID}" gitit

if [ ! -e "${GITIT_DATA}" ]
then
    mkdir "${GITIT_DATA}"
    chown gitit:gitit "${GITIT_DATA}"
fi

if [ ! -e "${GITIT_CONF}" ]
then
    populate-gitit-conf "${GITIT_CONF}"
    chown gitit:gitit "${GITIT_CONF}"
fi

if [ ! -e "${GITIT_PLUGINS}" ]
then
    mkdir -p "${GITIT_PLUGINS}"
    populate-gitit-plugins "${GITIT_PLUGINS}"
    chown -R gitit:gitit "${GITIT_PLUGINS}"
fi

cd "${GITIT_DATA}"

if [ ${#@} -eq 0 ]
then
    exec su gitit -c "exec gitit-with-env -f ${GITIT_CONF}"
else
    exec "${@}"
fi
