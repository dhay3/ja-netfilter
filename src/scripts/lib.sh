# shellcheck disable=SC2155
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
$(printf '\033[38;5;129m')
"

function lib::fmt::lowerCase() {
  local param="${*,,}"
  echo "${param}"
}

function lib::fmt::upperCase() {
  local param="${*^^}"
  echo "${param}"
}

function lib::fmt::boldMessage() {
  local msg="${*}"
  printf "%s%s%s" "${FMT_BOLD}" "${msg}" "${FMT_RESET}"
}

function lib::fmt::underlineMessage() {
  local msg="${*}"
  printf "%s%s%s" "${FMT_UNDERLINE}" "${msg}" "${FMT_RESET}"
}

function lib::fmt::codeMessage() {
  local msg="${*}"
  printf "\`%s%s%s\`" "${FMT_CODE}" "${msg}" "${FMT_RESET}"
}

function lib::fmt::errorMessage() {
  local msg="${*}"
  printf "%s%s[EROR] %s%s\n" "${FMT_RED}" "${FMT_BOLD}" "${FMT_RESET}" "${msg}" >&2
}

function lib::fmt::succeedMessage() {
  local msg="${*}"
  printf "%s%s[SUCC] %s%s\n" "${FMT_GREEN}" "${FMT_BOLD}" "${FMT_RESET}" "${msg}" >&2
}

function lib::fmt::warningMessage() {
  local msg="${*}"
  printf "%s%s[WARN] %s%s\n" "${FMT_YELLOW}" "${FMT_BOLD}" "${FMT_RESET}" "${msg}" >&2
}

function lib::fmt::infoMessage() {
  local msg="${*}"
  printf "%s%s[INFO] %s%s\n" "${FMT_BLUE}" "${FMT_BOLD}" "${FMT_RESET}" "${msg}" >&2
}
