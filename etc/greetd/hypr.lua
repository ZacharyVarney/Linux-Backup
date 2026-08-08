hl.env("DMS_RUN_GREETER", "1")


hl.monitor({
    output   = "DP-1",
    mode     = "3440x1440@165",
    position = "1152x700",
    scale    = "1.25",
	bitdepth = 10,
	cm = "srgb",
})
hl.monitor({
    output    = "DP-2",
    mode      = "2560x1440@144",
    position  = "0x0",
    scale     = "1.25",
    transform = 1,
	cm = "srgb",
})
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@60",
    position = "3905x900",
    scale    = "1",
})


hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "", --colemak_dh_ortho
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },

        accel_profile = "flat",
    },
})


hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
    ecosystem = {
    	no_donation_nag = true,
    	no_update_news = true,
    },
})
