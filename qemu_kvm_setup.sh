#! /usr/bin/env bash
# 20241113 -- jbe

echo "[INFO] Updating system ..."
sudo apt update
sudo apt upgrade -y

echo "[INFO] Installing qemu/kvm and virtmanager ..."
sudo apt install qemu-kvm virt-manager virtinst libvirt-clients bridge-utils libvirt-daemon-system -y

echo "[INFO] Starting libvirtd service ..."
sudo systemctl enable --now libvirtd
sudo systemctl start libvirtd
sudo systemctl status libvirtd

echo "[INFO] adding $USER to libvirt and kvm groups ..."
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER

read -p "If installation went OK -- test run?"
sudo virt-manager

