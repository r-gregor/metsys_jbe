#!/usr/bin/env bash
# Purpose: Library of functions for Linux setup scripts
# Author : Daniel Wayne Armstrong <hello@dwarmstrong.org>

# ANSI escape codes
RED="\\033[1;31m"
GREEN="\\033[1;32m"
BLUE="\\033[1;34m"
YELLOW="\\033[1;33m"
PURPLE="\\033[1;35m"
NC="\\033[0m" # no colour


echo_red() {
  echo -e "${RED}${1}${NC}"
}


echo_green() {
  echo -e "${GREEN}${1}${NC}"
}


echo_blue() {
  echo -e "${BLUE}${1}${NC}"
}


echo_purple() {
  echo -e "${PURPLE}${1}${NC}"
}


echo_yellow() {
  echo -e "${YELLOW}${1}${NC}"
}


banner() {
  echo ""
  echo -e "${YELLOW}####  ${1}  ####${NC}"
  echo ""
}


backup_file() {
  for f in "$@"; do cp "${f}" "${f}.$(date +'%Y-%m-%dT%H%M%S').bak"; done
}


err() {
  echo_red "[$(date +'%Y-%m-%dT%H:%M:%S')]: ${1}"
}


verify_efi() {
  local dirname="/sys/firmware/efi/efivars"
  
  if [[ ! -d "${dirname}" ]]; then
    err "Script requires UEFI boot: ${dirname} not found."
    exit 1
  fi
}


verify_root() {
  if (( EUID != 0 )); then
    err "Permission denied. Are you root?"
    exit 1
  fi
}


countdown() {
  # Display countdown from $start to 1
  local start="${1}"
  
  while [ "${start}" -ge 0 ]; do
    echo -n "${start}...."
    start=$((start - 1))
    sleep 1
  done
  echo ""
}


au_revoir() {
  local message="${1}"
  local cow="/usr/games/cowsay"
  local lol="/usr/games/lolcat"

  echo ""
  if [[ -x $cow ]] && [[ -x $lol ]]; then
    echo "${message}" | $cow -W 80 -f tux | $lol 2>/dev/null
  else
    echo "${message}"
  fi
  exit 0
}
