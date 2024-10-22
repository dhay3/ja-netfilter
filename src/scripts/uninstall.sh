#!/usr/bin/env bash
# shellcheck disable=SC1090

set -eo pipefail

. "$( cd "$(dirname "${0}")" && readlink -f lib.sh )"

jb_production_env_sys=~/.config/environment.d/jetbrains.conf

rm -f "${jb_production_env_sys}"