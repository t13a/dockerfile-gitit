#!/bin/bash

set -euo pipefail

if [ -n "${TIMEZONE:-}" ]
then
    ln -fsv "/usr/share/zoneinfo/${TIMEZONE}" /etc/localtime
fi

id -g "${GITIT_GID}" &>/dev/null || groupadd -g "${GITIT_GID}" -o "${GITIT_USER}"
id -u "${GITIT_USER}" &>/dev/null || useradd -g "${GITIT_USER}" -m -o -u "${GITIT_UID}" "${GITIT_USER}"

export GHC_PACKAGE_PATH="$(cd /opt/gitit && stack path --ghc-package-path)"
export PATH="${PATH}:$(cd /opt/gitit && stack path --local-install-root)/bin"

for SCRIPT in $(find /entrypoint.d -type f -executable | sort)
do
    "${SCRIPT}"
done

cd "${GITIT_WORK_DIR}"

if [ ${#@} -eq 0 ]
then
    exec gosu "${GITIT_USER}" gitit -f "${GITIT_CONF}"
else
    exec "${@}"
fi
