------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Monitors/
hl.monitor({
    output   = "DP-1",
    mode     = "3440x1440@165",
    position = "1152x700",
    scale    = "1.25",
})
hl.monitor({
    output    = "DP-2",
    mode      = "2560x1440@144",
    position  = "0x0",
    scale     = "1.25",
    transform = 1,
})
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@60",
    position = "3905x900",
    scale    = "1",
})


---------------------
---- MY PROGRAMS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Keywords/

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "dms ipc call spotlight-bar toggle"
local browser 	  = "brave-origin-beta"
local sysMonitor  = "missioncenter"


-------------------
---- AUTOSTART ----
-------------------

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this
 hl.on("hyprland.start", function () 
   hl.exec_cmd("$HOME/.config/hypr/scaling-xorg.sh")
   hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
   hl.exec_cmd("dbus-update-activation-environment --systemd --all")
   hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
   hl.exec_cmd("systemctl --user start hyprpolkitagent")
   hl.exec_cmd("systemctl --user set-environment")
   hl.exec_cmd("systemctl --user import-environment")
   hl.exec_cmd("hyprctl setcursor Breeze_Light 24")
   hl.exec_cmd("kbuildsycoca6 --noincremental")
   hl.exec_cmd("$HOME/.config/hypr/hyprdesktop.sh")
   hl.exec_cmd("bash -c 'wl-paste --watch cliphist store &'")
   hl.exec_cmd("dms run")
 end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Breeze_Light")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORMTHEME_QT6", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")


------------------
---- XWAYLAND ----
------------------

hl.config({
	xwayland = {
		force_zero_scaling = true,
		use_nearest_neighbor = false,
	}
})


--------------------
---- WORKSPACES ----
--------------------

hl.workspace_rule({ workspace = "1", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "DP-1", persistent = true, layout = "monocle" })
hl.workspace_rule({ workspace = "4", monitor = "DP-2", persistent = true, layout = "dwindle" })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1", persistent = true, layout = "dwindle" })
hl.workspace_rule({ workspace = "special:scratchpad", persistent = true, layout = "monocle" })


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Variables/

-- https://wiki.hypr.land/Configuring/Variables/#general
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 2,

        -- https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
        col = {
            active_border   = "rgba(9ECAFCee)",
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "scrolling",
    },
})

-- https://wiki.hypr.land/Configuring/Variables/#decoration
hl.config({
    decoration = {
        rounding       = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 10,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        -- https://wiki.hypr.land/Configuring/Variables/#blur
        blur = {
            enabled   = true,
            size      = 10,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },
})

-- https://wiki.hypr.land/Configuring/Variables/#animations
hl.config({
    animations = {
        enabled = true,
    },
})

-- Default curves, see https://wiki.hypr.land/Configuring/Animations/#curves
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default animations, see https://wiki.hypr.land/Configuring/Animations/
hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
        split_width_multiplier = 1.5,
    },
})

-- See https://wiki.hypr.land/Configuring/Master-Layout/ for more
hl.config({
    master = {
        new_status = "slave",
    },
})

-- See https://wiki.hypr.land/Configuring/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.5,
        focus_fit_method = 1,
        explicit_column_widths = "0.5, 0.75, 1.0",
    },
})

-- https://wiki.hypr.land/Configuring/Variables/#misc
hl.config({
    misc = {
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
        focus_on_activate = true,
        on_focus_under_fullscreen = 0,
        vrr = 3,
    },
    render = {
    	direct_scanout = 2,
    },
    cursor = {
    	no_hardware_cursors = 1,
    	no_break_fs_vrr = 2,
    },
})


---------------
---- INPUT ----
---------------

-- https://wiki.hypr.land/Configuring/Variables/#input
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

-- See https://wiki.hypr.land/Configuring/Gestures/
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Keywords/#per-device-input-configs for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Keywords/
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + CTRL + C", hl.dsp.window.kill())
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd(sysMonitor))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("hyprshot -z -m output -o $HOME/Pictures/Screenshots/"))
hl.bind(mainMod .. " + CTRL + I", hl.dsp.exec_cmd("hyprshot -z -m region -o $HOME/Pictures/Screenshots/"))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd("hyprshot -z -m window -o $HOME/Pictures/Screenshots/"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("pavucontrol-qt"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("dms ipc call lock lock"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("dms ipc call clipboard toggle"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("dms ipc call keybinds toggle hyprland"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("dms ipc call notepad toggle"))
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("dms ipc call overview toggle"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("hyprctl dispatch 'hl.config({cursor = {zoom_factor = 4.0,},})'"))
hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.exec_cmd("hyprctl dispatch 'hl.config({cursor = {zoom_factor = 1.0,},})'"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move windows around with mainMod + arrow keys
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- Move scrolling windows around
hl.bind(mainMod .. " + CTRL + left", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + H", hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.layout("colresize -conf"))

-- Move monocle windows around
hl.bind(mainMod .. " + D", hl.dsp.layout("cyclenext"))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.layout("cycleprev"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + CTRL + " .. key,      hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("dms ipc call audio increment 3"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("dms ipc call audio decrement 3"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("dms ipc call audio mute"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("dms ipc call audio micmute"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("dms ipc call brightness increment 5 ''"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("dms ipc call brightness decrement 5 ''"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("dms ipc call mpris next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("dms ipc call mpris playPause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("dms ipc call mpris playPause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("dms ipc call mpris previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Float specific windows
hl.window_rule({
	name = "flaoting-windows",
	match = {
		title = "Steam - Self Updater", 
	},
	float = true,
})

-- Fix broken blur & border around the xwayland gtk file chooser
hl.window_rule({
	name = "xgtk-chooser-fix",
	match = {
		class = "Xdg-desktop-portal-gtk",	
	},
	border_size = 0,
	no_blur = true,
	opaque = true,
	no_shadow = true,
})

-- MPV fixes
hl.window_rule({
	name = "mpv-tweaks",
	match = {
		class = "mpv",	
	},
	no_vrr = true,
})

-- Unreal Engine fixes
hl.window_rule({
	name = "unreal-engine-tweaks",
	match = {
		class = "UnrealEditor",
		title = "\\w*",	
	},
	no_initial_focus = true,
	suppress_event = "activate",
})

-- Davinci Resolve fixes
hl.window_rule({
	name = "davinci-resolve-tweaks",
	match = {
		class = "resolve",
		title = "resolve",	
	},
	no_blur = true,
	border_size = 0,
	no_shadow = true,
})

-- Gaming stuff
hl.window_rule({
	name = "steam-tweaks",
	match = {
		class = "steam",
	},
	min_size = "1 1",
})
-- Tagging game windows
hl.window_rule({
	name = "proton-game-tag",
	match = {
		xdg_tag = "proton-game",
	},
	tag = "+game",
})
hl.window_rule({
	name = "steam-apps-tag",
	match = {
		initial_class = "steam_app_.*",
	},
	tag = "+game",
})
hl.window_rule({
	name = "cs2-tag",
	match = {
		class = "cs2",
	},
	tag = "+game",
})
hl.window_rule({
	name = "momentum-tag",
	match = {
		class = "momentum",
	},
	tag = "+game",
})
hl.window_rule({
	name = "moonlight-tag",
	match = {
		class = "com.moonlight_stream.Moonlight",
	},
	tag = "+game",
})
hl.window_rule({
	name = "gamescope-tag",
	match = {
		class = "gamescope",
	},
	tag = "+game",
})
hl.window_rule({
	name = "minecraft-tag",
	match = {
		class = "Minecraft.*",
	},
	tag = "+game",
})
-- Rules to apply
hl.window_rule({
	name = "games",
	match = {
		tag = "game",
		fullscreen = true,	
	},
	border_size = 0,
	rounding = 0,
	decorate = false,
	force_rgbx = true,
	sync_fullscreen = true,
	no_anim = true,
	no_blur = true,
	no_dim = true,
	no_max_size = true,
	no_shadow = true,
	persistent_size = true,
	focus_on_activate = true,
	immediate = true,
})
hl.window_rule({
	name = "game-popups",
	match = {
		tag = "game"
	},
	content = "game",
	workspace = 3,
	center = true,
	idle_inhibit = "always",
})


----------------------------
---- GAME TEARING HOOK -----
----------------------------

-- This is useful for competitive or latency sensitive games that benefit from tearing because vrr does not play nice with tearing enabled at the same time.

local tearingGames = {
    ["cs2"] = true,
    ["momentum"] = true,
    ["steam_app_2622380"] = true,
}

local activeGames = 0
local tearingEnabled = false

local function enableTearing()
    if tearingEnabled then
        return
    end

    hl.config({
        general = {
            allow_tearing = true,
        },
        misc = {
            vrr = 0,
        },
        cursor = {
            no_break_fs_vrr = 0,
        },
    })

    hl.exec_cmd([[notify-send "Gaming Mode" "Tearing Enabled // VRR Disabled"]])

    tearingEnabled = true
end

local function disableTearing()
    if not tearingEnabled then
        return
    end

    hl.config({
        general = {
            allow_tearing = false,
        },
        misc = {
            vrr = 3,
        },
        cursor = {
            no_break_fs_vrr = 2,
        },
    })

    hl.exec_cmd([[notify-send "Gaming Mode" "Tearing Disabled // VRR Enabled"]])

    tearingEnabled = false
end

hl.on("window.open", function(win)
    if win.class and tearingGames[win.class] then
        activeGames = activeGames + 1
        enableTearing()
    end
end)

hl.on("window.close", function(win)
    if win.class and tearingGames[win.class] then
        activeGames = activeGames - 1

        if activeGames == 0 then
            disableTearing()
        end
    end
end)


-------------------------------
---- GAME PERFORMANCE HOOK ----
-------------------------------

local gamePerfPatterns = {
    "cs2",
    "momentum",
    "^steam_app_",
    "gamescope",
    "^Minecraft",
}

local activePerfGames = 0
local gamePerfEnabled = false

local function isGamePerfWindow(class)
    if not class then return false end

    for _, pattern in ipairs(gamePerfPatterns) do
        if string.match(class, pattern) then
            return true
        end
    end

    return false
end

local function enableGamePerf()
    if gamePerfEnabled then return end
    hl.exec_cmd("powerprofilesctl set performance")
    hl.exec_cmd("dms ipc notifications enableDoNotDisturbIndefinitely")
    gamePerfEnabled = true
end

local function disableGamePerf()
    if not gamePerfEnabled then return end
    hl.exec_cmd("powerprofilesctl set balanced")
    hl.exec_cmd("dms ipc notifications disableDoNotDisturb")
    gamePerfEnabled = false
end

hl.on("window.open", function(win)
    if isGamePerfWindow(win.class) then
        activePerfGames = activePerfGames + 1
        enableGamePerf()
    end
end)

hl.on("window.close", function(win)
    if isGamePerfWindow(win.class) then
        activePerfGames = math.max(0, activePerfGames - 1)

        if activePerfGames == 0 then
            disableGamePerf()
        end
    end
end)


require("dms.cursor")

require("dms.binds")

require("dms.binds-user")
