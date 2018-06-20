#!/bin/bash

set -euo pipefail

PUID="${PUID:-1000}"
PGID="${PGID:-1000}"
GITIT_USER=gitit
GITIT_HOME=/gitit
GITIT_CONF=/gitit.conf

if [ -n "${TIMEZONE:-}" ]
then
    ln -sf "/usr/share/zoneinfo/${TIMEZONE}" /etc/localtime
fi

groupadd -g "${PGID}" -o "${GITIT_USER}"
useradd -d "${GITIT_HOME}" -g "${PGID}" -o -u "${PUID}" "${GITIT_USER}"

if [ ! -e "${GITIT_HOME}" ]
then
    mkdir "${GITIT_HOME}"
    chown "${GITIT_USER}:${GITIT_USER}" "${GITIT_HOME}"
fi

if [ ! -e "${GITIT_CONF}" ]
then
    gitit --print-default-config > "${GITIT_CONF}"
fi

cd "${GITIT_HOME}"

if [ ${#@} -eq 0 ]
then
    exec su "${GITIT_USER}" -c "exec gitit -f ${GITIT_CONF}"
else
    exec "${@}"
fi
