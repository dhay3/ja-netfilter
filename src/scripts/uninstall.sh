#!/usr/bin/env bash
# shellcheck disable=SC1090

set -eo pipefail

. "$( cd "$(dirname "${0}")" && readlink -f lib.sh )"
. "$( cd "$(dirname "${0}")" && readlink -f vars.sh )"


function run(){
  read -rp ":: Wanna uninstall jetbra? [Y/n]" yn
  case "${yn}" in
    y|Y|yes|Yes) rm -f "${JB_ENE_SYS_PATH}" ;;
    n|N|not|Not) exit 0;;
    *) exit 1;;
  esac
}

__main__(){
  lib::fmt::listBanner
  run
  lib::fmt::succeedMessage "$(lib::fmt::boldMessage "Log out current session to activate")"
}


__main__ "${@}"

