#!/bin/bash/

sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

sudo pacman -Sy

sudo pacman -S nvidia-settings grub-customizer flatpak teamspeak3 discord code steam rofi terminator

sudo flatpak install spotify

trizen -S brave-bin timeshift
