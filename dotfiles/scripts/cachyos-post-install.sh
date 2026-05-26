#!/bin/bash

paru -Sy --noconfirm --needed cachyos-gaming-meta steam gamescope mangohud goverlay heroic-games-launcher-bin \ 
flatpak gvfs gvfs-mtp gvfs-afc terminus-font ttf-hack ttf-roboto ttf-roboto-nerd ttf-dejavu-nerd ttf-fantasque-mono \ 
ttf-jetbrains-mono awesome-terminal-fonts gpu-screen-recorder-ui trash-cli termdown asciiquarium fastfetch \ 
starship mpv vlc qview dolphin ark kitty kate libreoffice-fresh brave-origin-beta-bin wl-clipboard \ 
cliphist cava nwg-look hyprland-git aquamarine-git hyprutils-git hyprcursor-git hyprgraphics-git \ 
hyprland-guiutils-git hyprland-protocols-git hyprland-qt-support-git hyprlang-git hyprpicker hyprshot \ 
hyprpolkitagent hyprtoolkit-git hyprwayland-scanner-git hyprwire-git xdg-desktop-portal-hyprland-git \ 
dms-shell-git dsearch-bin greetd-dms-greeter-git pavucontrol-qt quickshell-git qt6ct-kde \ 
adw-gtk-theme breeze breeze-icons breeze5 breeze-cursors breezex-cursor-theme mission-center yazi \ 
discord lsfg-vk nvtop bazecor openrazer-daemon-dkms polychromatic qt5ct

mkdir -p $HOME/.local/share/icons
mkdir -p $HOME/.local/share/themes
sudo cp -r /usr/share/themes/BreezeX-Light $HOME/.local/share/icons/
sudo cp -r /usr/share/themes/BreezeX-Dark $HOME/.local/share/icons/
sudo cp -r /usr/share/themes/BreezeX-Black $HOME/.local/share/icons/
paru -Rns breezex-cursor-theme

flatpak install protonplus flatseal

