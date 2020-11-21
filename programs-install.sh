#!/bin/bash/

# Programs I usually install everytime I install linux

sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

sudo pacman -Syy

sudo pacman -S nvidia-settings grub-customizer teamspeak3 discord code steam rofi

sudo flatpak install spotify

trizen -S brave-bin timeshift
