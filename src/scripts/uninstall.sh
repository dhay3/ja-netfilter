#!/usr/bin/env bash
# shellcheck disable=SC1090

set -eo pipefail

. "$( cd "$(dirname "${0}")" && readlink -f lib.sh )"
. "$( cd "$(dirname "${0}")" && readlink -f vars.sh )"


function run(){
  read -rp ":: Do you Want to uninstall Jetbra? [Y/n] " yn
  case "${yn}" in
    y|Y|yes|Yes)
      [[ -f "${JB_ENV_SYS_PATH}" ]] && (rm -f "${JB_ENV_SYS_PATH}" && lib::fmt::succeedMessage "Jetbra has been uninstalled") \
        || lib::fmt::errorMessage "Jetbra has not been installed"
      ;;
    n|N|not|Not) exit 0;;
    *) exit 1;;
  esac
}

__main__(){
  lib::fmt::listBanner
  run
  lib::fmt::warningMessage "$(lib::fmt::boldMessage "Log out current session to activate")"
}


__main__ "${@}"