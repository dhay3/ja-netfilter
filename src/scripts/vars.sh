# shellcheck disable=SC2034
# shellcheck disable=SC2155

declare -rg BASE_PATH=$(dirname "$(cd "$(dirname "${0}")" && pwd)")
declare -rg JA_NETFILTER_CORE="ja-netfilter-jar-with-dependencies.jar"
declare -rg JA_NETFILTER_CORE_PATH="${BASE_PATH}/${JA_NETFILTER_CORE}"
declare -rg JA_NETFILTER_PLUGINS_PATH="${BASE_PATH}/plugins"

declare -rg JB_APPNAME="jetbrains"
declare -rg JB_CONFIGS_HOME="${BASE_PATH}/config-${JB_APPNAME}"
declare -rg JB_PLUGINS_HOME="${BASE_PATH}/plugins-${JB_APPNAME}"
declare -rg JB_LICENSES_HOME="${BASE_PATH}/licenses"
declare -rg JB_BASE_VM_OPTIONS_PATH="${BASE_PATH}/__base.vmoptions"
declare -rg JB_VM_OPTIONS_HOME="${BASE_PATH}/vmoptions"
declare -rg JB_ENV_PATH="${BASE_PATH}/jetbrains.conf"
declare -rg JB_ENV_SYS_PATH=~/.config/environment.d/jetbrains.conf