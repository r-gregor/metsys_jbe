#! /usr/bin/env bash

sudo add-apt-repository ppa:mozillateam/ppa
sudo snap remove --purge firefox
sudo apt purge --autoremove firefox
echo -e '\nPackage: *\nPin: release o=LP-PPA-mozillateam\nPin-Priority: 1002' | sudo tee /etc/apt/preferences.d/mozilla-firefox
sudo apt update
sudo apt install firefox
