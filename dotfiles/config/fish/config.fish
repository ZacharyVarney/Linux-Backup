if status is-interactive
    neofetch

    set fish_greeting

    starship init fish | source

    alias cat="bat"

    alias wine-reset="sudo bash /home/zach/.scripts/wine-reset.sh"
end
