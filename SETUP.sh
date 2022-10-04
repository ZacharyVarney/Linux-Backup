#!/bin/bash

clear

echo "In order for these commands to work properly you need to be chrooted into installed system."
sleep 8

echo " "
echo " "
echo "Enabling newly installed services"
sudo systemctl enable sshd.service
sudo systemctl enable cronie.service
sudo systemctl enable sddm.service

echo " "
echo " "
echo "Installing Paru AUR helper"
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

echo " "
echo " "
echo "Installing recommended AUR apps"
paru -S timeshift brave-bin

echo " "
echo " "
echo "Post installation finished, you are now fine to reboot."
