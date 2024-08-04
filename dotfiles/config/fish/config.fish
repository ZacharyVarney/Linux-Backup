if status is-interactive
    fastfetch
    set fish_greeting
    starship init fish | source

    alias cat="bat"
    alias wine-reset="bash /home/zach/.config/scripts/wine-reset.sh"
    alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
    alias update-kernel="sudo mkinitcpio -P"
end
