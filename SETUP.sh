#!/bin/bash

clear

echo "The commands run in this script will require root privileges"
sleep 5

cd $HOME

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
cd ..
rm -rf paru

echo " "
echo " "
echo "Updating pacman.conf"
sudo cp Linux-Backup/pacman.conf /etc/
sudo pacman -Syuu

echo " "
echo " "
echo "Installing recommended AUR packages"
paru -S timeshift brave-bin mangohud lib32-mangohud goverlay-bin

echo " "
echo " "
echo "Installing recommended flatpak packages"
flatpak install pcsx2 dolphin-emu duckstation citra yuzu ppsspp retroarch rpcs3 pupgui2 app.xemu.xemu

echo " "
echo " "
echo " "
echo "Setup has finished, you can now reboot your system"
sleep 5
