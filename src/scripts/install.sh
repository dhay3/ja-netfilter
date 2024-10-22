#!/usr/bin/env bash
# shellcheck disable=SC1090
# shellcheck disable=SC2155
# shellcheck disable=SC2034

set -eo pipefail

. "$( cd "$(dirname "${0}")" && readlink -f lib.sh )"
. "$( cd "$(dirname "${0}")" && readlink -f vars.sh )"

declare -g JB_PRODUCTION_S


function install::preCheck(){
  [[ -f "${JA_NETFILTER_CORE_PATH}" ]] ||
    lib::fmt::errorMessage "Core jar has not been found in ${BASE_PATH}"
  [[ -h "${JB_PLUGINS_HOME}" && -n $(ls "${JB_PLUGINS_HOME}") ]] ||
    lib::fmt::errorMessage "plugins-jetbrains has not been found in ${BASE_PATH} or an empty directory"
  [[ -d "${JB_CONFIGS_HOME}" && -n $(ls "${JB_CONFIGS_HOME}") ]] ||
    lib::fmt::errorMessage "config-jetbrains has not been found in ${BASE_PATH} or an empty directory"
  [[ -d "${JB_LICENSES_HOME}" && -n $(ls "${JB_LICENSES_HOME}") ]] ||
    lib::fmt::errorMessage "${JB_LICENSES_HOME} has not been found in ${BASE_PATH} or an empty directory"
  lib::fmt::infoMessage "Jetbra installation preCheck done"
  [[ -f "${JB_BASE_VM_OPTIONS_PATH}" ]] ||
    lib::fmt::errorMessage "__base.vmoptions has not been found in ${BASE_PATH}"
}


function install::listMenu(){
cat << EOF
        0)  Idea
        1)  Pycharm
        2)  CLion
        3)  GoLand
        4)  WebStorm
        5)  PhPStorm
        6)  DataGrip
        7)  RubyMine
        8)  Rider
        9)  All
EOF
}


function install::chooseMenu(){
  lib::fmt::infoMessage "Choose which IDE(s) should be activated"
  function __(){
      install::listMenu
      read -rp "        :: Please Input a number: " JB_PRODUCTION_S
         case "${JB_PRODUCTION_S}" in
           0) JB_PRODUCTION_S=Idea;;
           1) JB_PRODUCTION_S=Pycharm;;
           2) JB_PRODUCTION_S=CLion;;
           3) JB_PRODUCTION_S=GoLand;;
           4) JB_PRODUCTION_S=WebStorm;;
           5) JB_PRODUCTION_S=PhPStorm;;
           6) JB_PRODUCTION_S=DataGrip;;
           7) JB_PRODUCTION_S=RubyMine;;
           8) JB_PRODUCTION_S=Rider;;
           9) JB_PRODUCTION_S=(Idea Pycharm CLion GoLand WebStorm PhPStorm DataGrip RubyMine Rider);;
           *) lib::fmt::warningMessage "Choose from [0 - 9]" && __
          esac
  }
  __
}


function install::createEnvAndCallbackLicense(){
  # at this time now wayland do not support global environments configuration, it can be done by environment.d as well as xorg
  # [[ "${XDG_SESSION_TYPE}" == x11 ]] || [[ "${XDG_SESSION_TYPE}" == wayland ]]
  local jb_production="${1}"
  local jb_production_u=$(lib::fmt::upperCase "${JB_PRODUCTION}")
  local jb_production_vm_options_path="${JB_VM_OPTIONS_HOME}/${jb_production}.vmoptions"

    function __(){
      for license in "${JB_LICENSES_HOME}"/*;do
        if [[ "${license^^}" =~ ${jb_production_u} ]];then
          lib::fmt::infoMessage "$(lib::fmt::boldMessage "Please paste ${license}'s activation code to ${jb_production}")"
        fi
      done
    }

  install -D "${JB_BASE_VM_OPTIONS_PATH}" "${jb_production_vm_options_path}"
  echo "-javaagent:${JA_NETFILTER_CORE_PATH}=${JB_APPNAME}" >> "${jb_production_vm_options_path}"
  touch "${JB_ENV_PATH}"
  sed -i "/${jb_production_u}_VM_OPTIONS=/d" "${JB_ENV_PATH}"
  echo "${jb_production_u}_VM_OPTIONS=${jb_production_vm_options_path}" >> "${JB_ENV_PATH}"
  install -D  "${JB_ENV_PATH}" "${JB_ENV_SYS_PATH}"
  lib::fmt::infoMessage "Write ${jb_production_u}_VM_OPTIONS to ${JB_ENV_SYS_PATH}"
   __
}


function install::postCheck(){
  [[ -f "${JB_ENV_SYS_PATH}" ]] ||
    lib::fmt::errorMessage "${JB_ENV_SYS_PATH} has not been found"
  lib::fmt::infoMessage "Jetbra installation postCheck done"
}

function run(){
    install::preCheck
    install::chooseMenu
    for JB_PRODUCTION in "${JB_PRODUCTION_S[@]}";do install::createEnvAndCallbackLicense "${JB_PRODUCTION}";done
    install::postCheck
}


__main__(){
  lib::fmt::listBanner
  run
  lib::fmt::succeedMessage "Jetbra has been installed"
  lib::fmt::warningMessage "$(lib::fmt::boldMessage "Log out current session to activate")"
}


__main__ "${@}"