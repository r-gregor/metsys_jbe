#!/usr/bin/env bash
# Purpose: Install LMDE in expert-mode
# Author : Daniel Wayne Armstrong <hello@dwarmstrong.org>

set -euo pipefail

SCRIPT=$(basename $0)
NAME="LMDE"
LONG_NAME="Linux Mint Debian Edition"
VERSION="6"
CODENAME="faye"
PURPOSE="Install $LONG_NAME ($NAME $VERSION) in expert-mode."
URL="https://www.dwarmstrong.org/lmde-install-expert-mode/"
# Disk variables
DISK="/dev/${BASH_ARGV[0]}"
EFI_PART="1"
BOOT_PART="2"
ROOT_PART="3"
HOME_PART="4"
EFI_SIZE="300m"
BOOT_SIZE="1g"
ROOT_SIZE="64g"
HOME_SIZE="->END"
if [[ $DISK =~ "nvme" ]]; then
  EFI_DISK="${DISK}p${EFI_PART}"
  BOOT_DISK="${DISK}p${BOOT_PART}"
  ROOT_DISK="${DISK}p${ROOT_PART}"
  HOME_DISK="${DISK}p${HOME_PART}"
else
  EFI_DISK="${DISK}${EFI_PART}"
  BOOT_DISK="${DISK}${BOOT_PART}"
  ROOT_DISK="${DISK}${ROOT_PART}"
  HOME_DISK="${DISK}${HOME_PART}"
fi
# Encrypted devices
ROOT_DEV="/dev/mapper/root"
HOME_DEV="/dev/mapper/home"
# ANSI escape codes
RED="\\033[1;31m"
GREEN="\\033[1;32m"
BLUE="\\033[1;34m"
YELLOW="\\033[1;33m"
PURPLE="\\033[1;35m"
NC="\\033[0m" # no colour


Help() {
  echo "usage: $SCRIPT [OPTION...] DISK"
  echo ""
  echo "$PURPOSE"
  echo ""
  echo "positional arguments:"
  echo "  DISK      storage device for the $NAME install, for example sda"
  echo ""
  echo "options:"
  echo "  -h        show this help message and exit"
  echo "  -e NUM    efi partition size (default: $EFI_SIZE)"
  echo "  -b NUM    boot partition size (default: $BOOT_SIZE)"
  echo "  -r NUM    root partition size (default: $ROOT_SIZE)"
  echo "  -o NUM    home partition size (default: ->END)"
}


run_options() {
  while getopts ":he:b:r:o:" OPT; do
    case $OPT in
      h)  Help
          exit;;
      e)  EFI_SIZE=$OPTARG
          ;;
      b)  BOOT_SIZE=$OPTARG
          ;;
      r)  ROOT_SIZE=$OPTARG
          ;;
      o)  HOME_SIZE=$OPTARG
          ;;
      \?) echo "error: Invalid option"
          exit;;
    esac
  done
}


load_libraries() {
  # Add useful functions
  local lib="lib_linux_setup.sh"
  local src="https://gitlab.com/dwarmstrong/homebin/-/blob/master/${lib}"

  if [ -f $lib ]; then
    source $lib
  else
    echo "error: $lib not found"
    echo "source: $src"
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


greeting() {
  local message="Script \"${SCRIPT}\" prepares a disk for the ${NAME} "
  local message+="\"expert-mode\" [1] installer."
  
  clear
  echo_yellow "(O< -- Hello! $message"
  echo_yellow "(/)_"
  echo ""
  echo "See '${SCRIPT} -h' for options."
  echo ""
  echo "[1] \"Install $LONG_NAME in Expert Mode\""
  echo_blue "   <https://www.dwarmstrong.org/lmde-install-expert-mode/>"
}


confirm_partitions() {
  echo "Device will use a GPT partition with 4 partitions:"
  echo ""
  echo_green "* Partition 1: $EFI_DISK    Size: $EFI_SIZE"
  echo "  * Format: vfat    Use as: EFI system partition"
  echo_green "* Partition 2: $BOOT_DISK    Size: $BOOT_SIZE"
  echo "  * Format: ext4    Use as: bootloader"
  echo_green "* Partition 3: $ROOT_DISK   Size: $ROOT_SIZE"
  echo "  * Format: luks    Use as: encrypted partition"
  echo "    * Device: /dev/mapper/root  Format: ext4    Use as: root device"
  echo_green "* Partition 4: $HOME_DISK    Size: $HOME_SIZE"
  echo "  * Format: luks    Use as: encrypted partition"
  echo "    * Device: /dev/mapper/home  Format: ext4    Use as: home device"
  echo ""
  echo_red "#"
  echo_red "#"
  echo_red "####  ALL DATA ON DISK WILL BE WIPED  ####"
  echo_red "#"
  echo_red "#"
  echo ""

  while : ; do
    read -r -n 1 -p "Proceed? [Yn] => " reply
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


wipe_disk() {
  wipefs -af $DISK
  sgdisk --zap-all --clear $DISK
  partprobe $DISK
}


partition_disk() {
  local efi_code="${EFI_PART}:ef00"
  local boot_code="${BOOT_PART}:8300"
  local root_code="${ROOT_PART}:8309"
  local home_code="${HOME_PART}:8309"

  # Create the EFI system partition:
  sgdisk -n "${EFI_PART}:1m:+${EFI_SIZE}" -t "${efi_code}" -c 0:esp $DISK
  # Create the boot partition:
  sgdisk -n "${BOOT_PART}:0:+${BOOT_SIZE}" -t "${boot_code}" -c 0:boot $DISK
  # Create the root partition:
  sgdisk -n "${ROOT_PART}:0:+${ROOT_SIZE}" -t "${root_code}" -c 0:root $DISK
  # Create the home partition (remaining disk space):
  if [[ "${HOME_SIZE}" == "->END" ]]; then
    sgdisk -n "${HOME_PART}:0:-10m" -t "${home_code}" -c 0:home $DISK
  else
    sgdisk -n "${ROOT_PART}:0:+${HOME_SIZE}" -t "${home_code}" -c 0:root $DISK
  fi
  partprobe $DISK
  sgdisk -p $DISK
}


encrypt_root() {
  cryptsetup luksFormat --type luks2 -y $ROOT_DISK
  cryptsetup open $ROOT_DISK root
}


encrypt_home() {
  cryptsetup luksFormat --type luks2 -y $HOME_DISK
  cryptsetup open $HOME_DISK home
}


create_filesystems() {
  mkfs.vfat -n ESP $EFI_DISK
  mkfs.ext4 -L bootfs $BOOT_DISK
  mkfs.ext4 -L rootfs $ROOT_DEV
  mkfs.ext4 -L homefs $HOME_DEV
}


expert_mode() {
  cat <<EOF
Pause here, and switch to a new tab/window in the terminal.
.
.
.
.
Launch the ${NAME} installer in expert-mode:

mint@mint:~$ sudo live-installer-expert-mode

Proceed as normal up to "Installation Type". Select "Manual Partitioning".

In the "Partitioning" window, click "Expert mode".
.
.
.
.
Then return here to the script.

Before continuing, we mount our target filesystems on "/target".

EOF

  while : ; do
    read -r -n 1 -p "Mount filesystems? [Yn] => " reply
    if [[ "${reply}" == [nN] ]]; then
      echo ""
      echo "Install terminated."
      exit 0
    elif [[ "${reply}" == [yY] || "${reply}" == "" ]]; then
      echo ""
      break
    else
      echo ""
    fi
  done
}


mount_filesystems() {
  mount --mkdir LABEL=rootfs /target
  mount --mkdir LABEL=homefs /target/home
  mount --mkdir LABEL=bootfs /target/boot
  mount --mkdir LABEL=ESP /target/boot/efi
}


install_packages() {
  local pkgs="cowsay lolcat sl"
  
  apt-get update
  apt-get -y install $pkgs
  # ... train kept a rollin' ...
  /usr/games/sl | /usr/games/lolcat
}


install() {
  cat <<EOF
Pause here, and switch back to the installer window and click "Next".
.
.
.
.
Proceed to "Summary" and confirm:

* Home encryption: disabled (entire partition is LUKS-encrypted)
* Install bootloader on $DISK
* Use already-mounted /target

When satisfied, click "Install".

${NAME} install proceeds as per usual up to "Installation paused".
.
.
.
.
Then return here to the script.

Before continuing, we configure the "fstab" and "crypttab" files.

EOF

  while : ; do
    read -r -n 1 -p "Configure files? [Yn] => " reply
    if [[ "${reply}" == [nN] ]]; then
      echo ""
      echo "Install terminated."
      exit 0
    elif [[ "${reply}" == [yY] || "${reply}" == "" ]]; then
      echo ""
      break
    else
      echo ""
    fi
  done
}


configure_fstab() {
  # Set filesystems that will be mounted at boot:
  echo "LABEL=ESP     /boot/efi   vfat  defaults  0 1" >> /target/etc/fstab
  echo "LABEL=bootfs  /boot       ext4  defaults  0 1" >> /target/etc/fstab
  echo "LABEL=rootfs  /           ext4  defaults  0 1" >> /target/etc/fstab
  echo "LABEL=homefs  /home       ext4  defaults  0 2" >> /target/etc/fstab
}


configure_crypttab() {
  # Set root and home to be opened at boot:
  echo "root PARTLABEL=root none luks,discard" >> /target/etc/crypttab
  echo "home PARTLABEL=home none luks,discard" >> /target/etc/crypttab
}


finish_install() {
  local task="Unmount partitions and remove encrypted devices"

  cat <<EOF
Pause here, and switch back to installer window. Click "Next" to finish install.
.
.
.
.
When prompted...

"Do you want to restart your computer to use the new system?"

...choose "No".
.
.
.
.
Then return here to the script.

EOF

  while : ; do
    read -r -n 1 -p "${task}? [Yn] => " reply
    if [[ "${reply}" == [nN] ]]; then
      au_revoir
    elif [[ "${reply}" == [yY] || "${reply}" == "" ]]; then
      echo ""
      break
    else
      echo ""
    fi
  done
}


cleanup() {
  # /target/boot/efi and /target/boot are auto-unmounted by the installer:
  umount /target/home
  umount -l -n -R /target
  # Remove the encrypted device mapping:
  cryptsetup close home
  cryptsetup close root
}


main() {
  verify_version
  verify_efi
  verify_root
  banner "START"
  greeting
  banner "PARTITION LAYOUT FOR $DISK"
  confirm_partitions
  banner "WIPE $DISK"
  wipe_disk
  banner "PARTITION $DISK"
  partition_disk
  banner "ENCRYPT ROOT PARTITION"
  encrypt_root
  banner "ENCRYPT HOME PARTITION"
  encrypt_home
  banner "CREATE FILESYSTEMS"
  create_filesystems
  banner "PAUSE AND SWITCH TO INSTALLER (EXPERT MODE)"
  expert_mode
  banner "MOUNT FILESYSTEMS"
  mount_filesystems
  banner "INSTALL PACKAGES"
  install_packages
  banner "PAUSE AND SWITCH TO INSTALLER (INSTALL)"
  install
  banner "CONFIGURE FSTAB"
  configure_fstab
  banner "CONFIGURE CRYPTTAB"
  configure_crypttab
  banner "PAUSE AND SWITCH TO INSTALLER (INSTALL COMPLETION)"
  finish_install
  banner "CLEANUP"
  cleanup
  banner "FINISH"
  au_revoir "Done! ${NAME} is in tip-top form and ready to reboot."
}


# (O<  Let's go!
# (/)_
run_options "$@"
load_libraries
main
