#!/bin/bash

set -euo pipefail

GITIT_PLUGINS_DIR="${GITIT_WORK_DIR}/plugins"

if [ -n "${TIMEZONE:-}" ]
then
    ln -fsv "/usr/share/zoneinfo/${TIMEZONE}" /etc/localtime
fi

id -g ${GITIT_GID}" &>/dev/null || groupadd -g "${GITIT_GID}" -o "${GITIT_USER}"
id -u ${GITIT_USER}" &>/dev/null || useradd -g "${GITIT_USER}" -m -o -u "${GITIT_UID}" "${GITIT_USER}"

if [ ! -e "${GITIT_CONF}" ]
then
    gitit-print-default-config > "${GITIT_CONF}"
    chown "${GITIT_USER}:${GITIT_USER}" "${GITIT_CONF}"
fi

if [ ! -e "${GITIT_WORK_DIR}" ]
then
    mkdir -p "${GITIT_WORK_DIR}"
    chown "${GITIT_USER}:${GITIT_USER}" "${GITIT_WORK_DIR}"
fi

if [ ! -e "${GITIT_PLUGINS_DIR}" ]
then
    mkdir -p "${GITIT_PLUGINS_DIR}"
    chown "${GITIT_USER}:${GITIT_USER}" "${GITIT_PLUGINS_DIR}"
fi

if [ -z "$(ls -A "${GITIT_PLUGINS_DIR}")" ]
then
    gitit-list-plugins | xargs cp -r -t "${GITIT_PLUGINS_DIR}"
fi

cd "${GITIT_WORK_DIR}"

if [ ${#@} -eq 0 ]
then
    exec gosu "${GITIT_USER}" gitit -f "${GITIT_CONF}"
else
    exec "${@}"
fi
