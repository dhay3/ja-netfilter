#!/usr/bin/env bash

set -eo pipefail

declare -rg FMT_RED=$(printf '\033[31m')
declare -rg FMT_GREEN=$(printf '\033[32m')
declare -rg FMT_BLUE=$(printf '\033[34m')
declare -rg FMT_YELLOW=$(printf '\033[33m')
declare -rg FMT_BOLD=$(printf '\033[1m')
declare -rg FMT_UNDERLINE=$(printf '\033[4m')
declare -rg FMT_CODE=$(printf '\033[2m')
declare -rg FMT_RESET=$(printf '\033[0m')
declare -rg FMT_RAINBOW="
$(printf '\033[38;5;196m')
$(printf '\033[38;5;202m')
$(printf '\033[38;5;226m')
$(printf '\033[38;5;082m')
$(printf '\033[38;5;021m')
"
declare -rg BASE_PATH=$(dirname "$(cd "$(dirname "${0}")" && pwd)")
declare -rg JA_NETFILTER_CORE="ja-netfilter-jar-with-dependencies.jar"
declare -rg JA_NETFILTER_CORE_PATH="${BASE_PATH}/${JA_NETFILTER_CORE}"
declare -rg JA_NETFILTER_PLUGINS_PATH="${BASE_PATH}/plugins"
declare -rg JB_APPNAME="jetbrains"
declare -rg JB_CONFIGS_PATH="${BASE_PATH}/config-${JB_APPNAME}"
declare -rg JB_PLUGINS_PATH="${BASE_PATH}/plugin-${JB_APPNAME}"


function fmt::lowerCase() {
  local param="${*,,}"
  echo "${param}"
}

function fmt::upperCase() {
  local param="${*^^}"
  echo "${param}"
}

function fmt::boldMessage() {
  local msg="${*}"
  printf "%s%s%s" "${FMT_BOLD}" "${msg}" "${FMT_RESET}"
}

function fmt::underlineMessage() {
  local msg="${*}"
  printf "%s%s%s" "${FMT_UNDERLINE}" "${msg}" "${FMT_RESET}"
}

function fmt::codeMessage() {
  local msg="${*}"
  printf "\`%s%s%s\`" "${FMT_CODE}" "${msg}" "${FMT_RESET}"
}

function fmt::errorMessage() {
  local msg="${*}"
  printf "%s%s[EROR] %s%s\n" "${FMT_RED}" "${FMT_BOLD}" "${FMT_RESET}" "${msg}" >&2
}

function fmt::succeedMessage() {
  local msg="${*}"
  printf "%s%s[SUCC] %s%s\n" "${FMT_GREEN}" "${FMT_BOLD}" "${FMT_RESET}" "${msg}" >&2
}

function fmt::warningMessage() {
  local msg="${*}"
  printf "%s%s[WARN] %s%s\n" "${FMT_YELLOW}" "${FMT_BOLD}" "${FMT_RESET}" "${msg}" >&2
}

function fmt::infoMessage() {
  local msg="${*}"
  printf "%s%s[INFO] %s%s\n" "${FMT_BLUE}" "${FMT_BOLD}" "${FMT_RESET}" "${msg}" >&2
}

function core::preCheck(){
  local retcode
  if [[ ! -f "${JA_NETFILTER_CORE_PATH}" ]];then
    fmt::errorMessage "${JA_NETFILTER_CORE} has not been found in ${BASE_PATH}!" && retcode=1
  else
    fmt:succeedMessage "Core jar has been found"
  fi
  if [[ ! -d ${JA_NETFILTER_PLUGINS_PATH} || ! -h ${JB_PLUGINS_PATH} ]];then
    fmt::errorMessage "Plugins has not been found in ${BASE_PATH}!" && retcode=1
  else
    fmt::succeedMessage "Plugins has been found"
  fi
  if [[ ! -d ${JA_NETFILTER_CONFIGS_PATH} ]];then
    fmt::errorMessage "Confs has not been found in ${BASE_PATH}!" && retcode=1
  else
    fmt::succeedMessage "Confs has been found"
  fi
#  [[ "${retcode}" == 1 ]] && exit 1
}

function core::listMenu(){
  fmt::infoMessage "Choose which IDE(s) should be activated"
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

__main__(){
  core::preCheck
  core::listMenu
  read -p "ide" ide
  case "${ide}" in
    0 | idea);;
    1 | pycharm);;
    2 | clion);;
    3 | goland);;
    4 | webstorm);;
    5 | phpstorm);;
    6 | datagrip);;
    7 | rubymine);;
    8 | rider) ;;
    9 | all);;
  esac

}

__main__








#list::menu
#read -p "33333"