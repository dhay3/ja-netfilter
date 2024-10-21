#!/usr/bin/env bash
# shellcheck disable=SC1090
# shellcheck disable=SC2155
# shellcheck disable=SC2034

set -eo pipefail

. "$( cd "$(dirname "${0}")" && readlink -f lib.sh )"

declare -rg BASE_PATH=$(dirname "$(cd "$(dirname "${0}")" && pwd)")
declare -rg JA_NETFILTER_CORE="ja-netfilter-jar-with-dependencies.jar"
declare -rg JA_NETFILTER_CORE_PATH="${BASE_PATH}/${JA_NETFILTER_CORE}"
declare -rg JA_NETFILTER_PLUGINS_PATH="${BASE_PATH}/plugins"
declare -rg JB_APPNAME="jetbrains"
declare -rg JB_CONFIGS_PATH="${BASE_PATH}/config-${JB_APPNAME}"
declare -rg JB_PLUGINS_PATH="${BASE_PATH}/plugins-${JB_APPNAME}"
declare -rg JB_BASE_VM_OPTIONS_PATH="${BASE_PATH}/__base.vmoptions"
declare -g JB_PRODUCTION_S


function install::listBanner() {
  echo   'Special thanks to https://linux.do/'
  echo
  printf '     %s (_)%s__  %s/ /_%s/ /_%s  _____%s____ _%s\n' ${FMT_RAINBOW} ${FMT_RESET}
  printf '    %s / /%s _ \%s/ __%s/ __ \%s/ ___%s/ __ `/%s\n' ${FMT_RAINBOW} ${FMT_RESET}
  printf '   %s / /%s  __%s/ /_%s/ /_/ %s/ /  %s/ /_/ / %s\n' ${FMT_RAINBOW} ${FMT_RESET}
  printf ' %s__/ /%s\___/%s\__%s/_.___%s/_/   %s\__,_/  %s\n' ${FMT_RAINBOW} ${FMT_RESET}
  printf '%s/___/%s     %s   %s      %s      %s         %s\n' ${FMT_RAINBOW} ${FMT_RESET}
  echo
}


function install::preCheck(){
  local ret
  [[ -f "${JA_NETFILTER_CORE_PATH}" ]] ||
    lib::fmt::errorMessage "Core jar has not been found in ${BASE_PATH}" && ret=1
  [[ -h "${JB_PLUGINS_PATH}" && -n $(ls "${JB_PLUGINS_PATH}") ]] ||
    lib::fmt::errorMessage "plugins-jetbrains has not been found in ${BASE_PATH} or an empty directory" && ret=1
  [[ -d "${JB_CONFIGS_PATH}" && -n $(ls "${JB_CONFIGS_PATH}") ]] ||
    lib::fmt::errorMessage "config-jetbrains has not been found in ${BASE_PATH} or an empty directory" && ret=1
  [[ -f "${JB_BASE_VM_OPTIONS_PATH}" ]] ||
    lib::fmt::errorMessage "__base.vmoptions has not been found in ${BASE_PATH}" && ret=1
#  [[ "${ret}" == 1 ]] && exit 1
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


function install::createVmOptionFile(){
  for JB_PRODUCTION in "${JB_PRODUCTION_S[@]}";do
    local jb_production_vm_options="${JB_PRODUCTION}.vmoptions"
    local jb_production_vm_options_path="${BASE_PATH}/vmoptions/${jb_production_vm_options}"
    install -D "${JB_BASE_VM_OPTIONS_PATH}" "${jb_production_vm_options_path}"
    echo "-javaagent:${JA_NETFILTER_CORE_PATH}=${JB_APPNAME}" >> "${jb_production_vm_options_path}"
    lib::fmt::succeedMessage "${JB_PRODUCTION} vmoptions has been created"
  done
}


#function install::(){
#  noop
#}

function go(){
    install::listBanner
    install::preCheck
    install::chooseMenu
    install::createVmOptionFile


}

__main__(){
  go
}

__main__ "${@}"
