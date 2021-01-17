#!/bin/bash

## Installing Programs

echo "Installing the components that make up the Fusion Desktop Environment"

sleep 2

echo "Installing main components"

sudo pacman -S openbox lxsession-gtk3 lightdm lightdm-gtk-greeter picom tint2 lxappearance-obconf-gtk3 --noconfirm

sudo systemctl enable lightdm.service

echo "Finished installing main components"

sleep 2

echo "Now installing system applications"

sudo pacman -S git vlc gpicview mpv geany geany-plugins nano pcmanfm-gtk3 terminator htop lxtask redshift network-manager-applet pavucontrol volumeicon materia-gtk-theme papirus-icon-theme --noconfirm

git clone https://github.com/trizen/trizen.git

cd trizen

sudo makepkg -si

cd ~

echo "These packages come from the Arch User Repository & WILL require some user input"

sleep 4

trizen -S pamac-aur brave-bin timeshift

echo "Installation of components complete continuing setup"

sleep 2

clear

## Some Themeing Setup

echo "Setup complete FOR NOW"

sleep 3
