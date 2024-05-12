if status is-interactive
    fastfetch
    set fish_greeting
    starship init fish | source

    alias cat="bat"
    alias wine-reset="sudo bash /home/zach/Documents/wine-reset.sh"
    alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
end
