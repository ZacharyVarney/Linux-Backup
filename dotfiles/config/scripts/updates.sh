#!/usr/bin/env bash

clear
echo " "
echo "Removing old backups & creating new one before updates."
echo " "
echo " "
sleep 5
sudo timeshift --delete-all
echo " "
sudo timeshift --create --comments "before update"
echo " "
echo " "
echo "Backup has been created. Now beginning AOR & AUR updates."
echo " "
echo " "
sleep 3
paru -Syu
echo " "
echo " "
echo "AOR & AUR updates have finished. Now beginning flatpak updates."
echo " "
echo " "
sleep 3
flatpak update
echo " "
echo " "
echo "Now regenerating grub."
echo " "
echo " "
sleep 3
sudo grub-mkconfig -o /boot/grub/grub.cfg
echo " "
echo " "
echo "All updates have finished, it is important to check for any errors & reboot the system to fully apply updates."
echo " "
echo " "
sleep 5
