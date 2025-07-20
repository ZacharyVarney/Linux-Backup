if status is-interactive
    fastfetch
    set fish_greeting
    starship init fish | source

    alias wine-reset="bash $HOME/Documents/Linux-Backup/dotfiles/scripts/wine-reset.sh"
    alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
    alias update-kernel="sudo mkinitcpio -P"
    alias update-system="paru -Syu; flatpak update"
end

function sudol
    sudo (history --max=1)
end
