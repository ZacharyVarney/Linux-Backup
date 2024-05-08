if status is-interactive
    neofetch

    set fish_greeting

    starship init fish | source

    alias cat="bat"

    alias wine-reset="sudo bash /home/zach/Documents/wine-reset.sh"
end
