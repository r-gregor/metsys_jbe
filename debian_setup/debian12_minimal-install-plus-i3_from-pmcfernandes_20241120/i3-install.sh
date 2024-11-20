#!/bin/bash

########## Install i3 in Debian Minimal Distro ##########
# Author: Pedro Fernandes 
# URL: https://github.com/pmcfernandes/
#########################################################

apt install software-properties-common
apt update

apt-add-repository contrib
apt-add-repository non-free

# Upgrade distro
apt-get update && apt-get upgrade -y

# Install xorg/i3 and usefull packages
apt-get install -y sudo intel-microcode i3 xorg suckless-tools lightdm rofi firefox-esr gnome-terminal thunar wicd cups xfce4-power-manager conky htop pulseaudio pavucontrol alsa-utils xbindkeys arandr xbacklight feh compton snapd numlockx unclutter cmus ufw
apt-get install -y pasystray paprefs pavumeter pulseaudio-module-zeroconf

# Install usefull and cool snap packages
snap install cool-retro-term --classic
snap install sublime-text --classic
 
# Configure sound
pactl set-sink-mute 0 false
pactl set-sink-volume @DEFAULT_SINK@ 50%

# Init numlockx
numlockx on

# Install zsh
apt install -y zsh
zsh
chsh -s /bin/zsh

# Install gaps
sudo apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake make gcc libxcb-shape0-dev git

cd /tmp

# clone the repository
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install

sleep 5
reboot


