#!/bin/bash
set -euo pipefail

SAVEDIR="${SAVEDIR:-/root/.openttd/save}"

latest_save=""
if [ -d "$SAVEDIR" ]; then
    latest_save=$(
        find "$SAVEDIR" -type f -name '*.sav' -printf '%T@ %p\n' \
        | sort -n \
        | tail -1 \
        | cut -f2- -d" "
    )
fi

if [ "$latest_save" != "" ]; then
    exec /opt/openttd/openttd -D -x -g "$latest_save" "$@"
else
    exec /opt/openttd/openttd -D -x "$@"
fi
