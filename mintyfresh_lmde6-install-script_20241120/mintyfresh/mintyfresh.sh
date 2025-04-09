#!/usr/bin/env bash
# Purpose: Configure device after a fresh install of Linux Mint Debian Edition
# Author : Daniel Wayne Armstrong <hello@dwarmstrong.org>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE. See the LICENSE file for more details.

set -euo pipefail

SCRIPT=$(basename $0)
NAME="LMDE"
LONG_NAME="Linux Mint Debian Edition"
VERSION="6"
CODENAME="faye"
PURPOSE="Configure device after a fresh install of $LONG_NAME ($NAME $VERSION)"
USERNAME="${BASH_ARGV[0]}"
ZRAM="y"
# ANSI escape codes
RED="\\033[1;31m"
GREEN="\\033[1;32m"
BLUE="\\033[1;34m"
YELLOW="\\033[1;33m"
PURPLE="\\033[1;35m"
NC="\\033[0m" # no colour


Help() {
  echo "usage: $SCRIPT [OPTION] USERNAME"
  echo ""
  echo "$PURPOSE"
  echo ""
  echo "positional arguments:"
  echo "  USERNAME  primary user"
  echo ""
  echo "options:"
  echo "  -h        show this help message and exit"
  echo "  -z        disable zramswap (default: False)"
}


run_options() {
  while getopts ":hz" OPT; do
    case $OPT in
      h)  Help
          exit;;
      z)  ZRAM="n"
          ;;
      \?) echo "error: Invalid option"
          exit;;
    esac
  done
}


load_libraries () {
  local lib="lib_linux_setup.sh"
  local source="https://gitlab.com/dwarmstrong/homebin/-/blob/master/${lib}"
  local libhome="files/${lib}"
  
  # Add useful functions:
  if [[ -f "${libhome}" ]]; then
    source $libhome
  else
    echo "error: $libhome not found"
    echo "source: $source"
    exit 1
  fi
}


verify_version() {
  local version="VERSION_ID=\"${VERSION}\""
  local name="VERSION_CODENAME=${CODENAME}"
  local file="/etc/os-release"
  
  if ! [[ $(grep $version $file) ]] || ! [[ $(grep $name $file) ]]; then
    err "Script requires $NAME ${VERSION}."
    exit 1
  fi
}


verify_user() {
  if ! [[ -d "/home/${USERNAME}" ]]; then
    err "Home directory for $USERNAME not found."
    exit 1
  fi
}


greeting() {
  local message
  message="Script \"${SCRIPT}\" configures a fresh install of $LONG_NAME "
  message+="(${NAME} ${VERSION})."
  
  clear
  echo_yellow "(O< -- Hello! $message"
  echo_yellow "(/)_"
  echo ""
  echo "Run '${SCRIPT} -h' for options and see README for details."
  echo ""
}


confirm_go() {
  while : ; do
    read -r -n 1 -p "GO for setup? [Yn] => " reply
    if [[ "${reply}" == [nN] ]]; then
      echo ""
      echo "Exit."
      exit 0
    elif [[ "${reply}" == [yY] || "${reply}" == "" ]]; then
      echo ""
      countdown 5
      break
    else
      echo ""
    fi
  done
}


configure_consolefont() {
  echo "Change the font and font-size used in the console."
  echo "Example: TERMINUS font in size 10x20."
  echo ""
  while : ; do
    read -r -n 1 -p "Setup a different console font? [Yn] => " reply
    if [[ "${reply}" == [nN] ]]; then
      break
    elif [[ "${reply}" == [yY] || "${reply}" == "" ]]; then
      dpkg-reconfigure console-setup
      break
    else
      invalid_reply
    fi
  done
}


upgrade_system() {
  apt-get update
  apt-get -y dist-upgrade
}


console_packages() {
  local pyenv
  local console
  pyenv="make build-essential libssl-dev zlib1g-dev libbz2-dev "
  pyenv+="libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev "
  pyenv+="xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev"
  console="${pyenv} acpi apt-file apt-show-versions apt-utils aptitude "
  console+="command-not-found cbonsai cowsay cryptsetup "
  console+="espeak figlet git gnupg htop imagemagick libxcb-xinerama0 "
  console+="lm-sensors lolcat ncal ncdu newsboat openssh-server plocate "
  console+="rsync shellcheck sl speedtest-cli tealdeer tmux tree unzip "
  console+="vim whois zstd"

  apt-get -y install $console
  apt-file update
}


desktop_packages() {
  local desktop
  desktop="dconf-editor ffmpeg fonts-firacode gimp gimp-data-extras "
  desktop+="gimp-help-en libxcb-cursor0 mint-meta-codecs pavucontrol "
  desktop+="qpdfview rofi vlc"

  apt-get -y install $desktop
}


virtual_packages() {
  local virtual
  local conf
  virtual="qemu-system-x86 libvirt-clients libvirt-daemon "
  virtual+="libvirt-daemon-system virtinst virt-manager bridge-utils"
  conf="/etc/libvirt/qemu.conf"

  apt-get -y install $virtual
  adduser $USERNAME kvm
  adduser $USERNAME libvirt
  adduser $USERNAME libvirt-qemu
  backup_file $conf
  sed -i "s/^#user = \"libvirt-qemu\"/user = \"${USERNAME}\"/" $conf
  systemctl start libvirtd
}


syncthing_package() {
  local keyring="/etc/apt/keyrings/syncthing-archive-keyring.gpg"
  local repository="https://apt.syncthing.net/"
  local list="/etc/apt/sources.list.d/syncthing.list"
  local pin="Pin: origin apt.syncthing.net"
  local prefer="/etc/apt/preferences.d/syncthing.pref"

  # Enable system to check package authenticity by adding the release PGP key:
  curl -L -o ${keyring} https://syncthing.net/release-key.gpg
  # Stable channel is updated with stable release builds, usually every first
  # Tuesday of the month. Add the "stable" channel to APT sources:
  echo "deb [signed-by=${keyring}] $repository syncthing stable" > $list
  # Ensure system packages do not take preference over those in the syncthing
  # repo by assigning packages in that repo a higher priority ("pinning"):
  printf "Package: *\n${pin}\nPin-Priority: 990\n" > $prefer
  # Install:
  apt update
  #apt install syncthing
}


boinc_package() {
  local keyring="/etc/apt/keyrings/boinc-archive-keyring.gpg"
  local keyserver="--keyserver keyserver.ubuntu.com"
  local key="--recv-keys 40254C9B29853EA6"
  local distro="bookworm bookworm main"
  local repository="https://boinc.berkeley.edu/dl/linux/stable/${distro}"
  local list="/etc/apt/sources.list.d/boinc.list"
  local pin="Pin: origin boinc.berkeley.edu"
  local prefer="/etc/apt/preferences.d/boinc.pref"

  gpg --homedir /tmp --no-default-keyring --keyring $keyring $keyserver $key
  echo "deb [arch=amd64 signed-by=${keyring}] $repository" > $list
  printf "Package: *\n${pin}\nPin-Priority: 990\n" > $prefer
  apt update
  #apt install boinc
}


third_party_packages() {
  boinc_package
  syncthing_package
}


install_packages() {
  console_packages
  desktop_packages
  virtual_packages
  third_party_packages
  # ... train kept rolling ...
  /usr/games/sl | /usr/games/lolcat
}


auto_remove_kernels() {
  # Remove obsolete kernels and dependencies on a weekly basis. Always leave
  # at least one older kernel installed and never remove manually installed
  # kernels:
  systemctl enable --now mintupdate-automation-autoremove.timer
  # Create empty placeholder file:
  touch /var/lib/linuxmint/mintupdate-automatic-removals-enabled
}


zram_swap() {
  local conf="/etc/default/zramswap"

  apt-get -y install zram-tools
  swapoff --all
  zramswap stop
  backup_file $conf
  sed -i "s/^#ALGO.*/ALGO=zstd/" $conf
  sed -i "s/^#PERCENT.*/PERCENT=25/" $conf
  sed -i "s/^#PRIORITY.*/PRIORITY=100/" $conf
  backup_file /etc/fstab
  sed -e '/swap/ s/^#*/#/' -i /etc/fstab
  zramswap start
}


grub() {
  local conf="61_mintyfresh-theme.cfg"
  local font="dejavu-sans-mono-20.pf2"
  local theme="mintyfresh"
  local background="${theme}/background.png"

  if ! [[ -d "/boot/grub/themes/${theme}" ]]; then
    cp -av /boot/grub/themes/linuxmint /boot/grub/themes/${theme}
    cp files/grub/${background} /boot/grub/themes/${background}
    cp files/grub/${theme}/theme.txt /boot/grub/themes/${theme}/theme.txt
  fi
  if ! [[ -f "/boot/grub/fonts/${font}" ]]; then
    cp files/grub/${theme}/${font} /boot/grub/fonts/${font}
  fi
  if ! [[ -f "/etc/default/grub.d/${conf}" ]]; then
    cp files/grub/${theme}/${conf} /etc/default/grub.d/${conf}
  fi
  update-grub
}


sudo_nopasswd() {
  echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/sudoer_${USERNAME}
}


main() {
  verify_version
  verify_efi
  verify_root
  verify_user
  banner "START"
  greeting
  banner "BEGIN SETUP FOR $USERNAME"
  confirm_go
  banner "CONFIGURE CONSOLE FONT"
  configure_consolefont
  banner "UPGRADE SYSTEM"
  upgrade_system
  banner "INSTALL PACKAGES"
  install_packages
  banner "AUTO-REMOVE OBSOLETE KERNELS"
  auto_remove_kernels
  if [[ "${ZRAM}" == "y" ]]; then
    banner "ENABLE ZRAM SWAP"
    zram_swap
  fi
  banner "CUSTOMIZE GRUB"
  grub
  banner "SUDO NO PASSWORD FOR ${USERNAME}"
  sudo_nopasswd
  banner "FINISH"
  au_revoir "Done! ${NAME} is in tip-top form and ready to reboot."
}


# (O<  Let's go!
# (/)_
run_options "$@"
load_libraries
main
