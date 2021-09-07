from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile import hook
import os
import subprocess

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])

mod = "mod4"
mod2 = "mod1"
terminal = "alacritty"

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "t", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "c", lazy.window.kill(), desc="Kill focused window"),

	# Application shortcuts
	Key([mod], "r", lazy.spawn("rofi -modi drun,run -show drun -show-icons"), desc="Run prompt"),
	Key([mod], "b", lazy.spawn("brave"), desc="Run browser"),
	Key([mod], "f", lazy.spawn("pcmanfm"), desc="Run file manager"),
	Key([mod], "v", lazy.spawn("gnome-system-monitor"), desc="Run system monitor"),
	Key([mod], "p", lazy.spawn("pavucontrol"), desc="Run sound mixer"),
	Key([mod], "Print", lazy.spawn("flameshot screen -p /home/zach/Pictures/Screenshots"), desc="Take screenshot"),
	Key([mod], "u", lazy.spawn("betterlockscreen -l blur --time-format \"%l:%M %p\""), desc="Lockscreen"),
	Key([mod], "o", lazy.spawn("killall picom"), desc="Kill compositor"),
	Key([mod], "i", lazy.spawn("picom --experimental-backend"), desc="Start compositor"),
	Key([mod2], "Tab", lazy.spawn("rofi -modi window -show window -show-icons"), desc="Show open window list"),

	# Qtile
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
]

def init_group_names():
	return [("  ", {'layout': 'max'}),
			("  ", {'layout': 'max'}),
			("  ", {'layout': 'columns'}),
			("  ", {'layout': 'columns'}),
			("  ", {'layout': 'max'}),
			("  ", {'layout': 'columns'})]

def init_groups():
	return [Group(name, **kwargs) for name, kwargs in group_names]

if __name__ in ["config", "__main__"]:
	group_names = init_group_names()
	groups = init_groups()

for i, (name, kwargs) in enumerate(group_names, 1):
	keys.append(Key([mod], str(i), lazy.group[name].toscreen()))
	keys.append(Key([mod, "control"], str(i), lazy.window.togroup(name)))
	keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name, switch_group=True)))

layouts = [
	layout.Tile(
		margin = 20,
		border_focus = '#0D6DE8',
		border_normal = '#000000'
	),
	layout.RatioTile(
		margin = 20,
		border_focus = '#0D6DE8',
		border_normal = '#000000'
	),
    layout.Columns(
		margin = 15,
		border_focus = '#0D6DE8',
		border_normal = '#000000'
    ),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='SFMono Nerd Font Mono',
    fontsize=13,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
					highlight_method = 'block',
					disable_drag = True,
					use_mouse_wheel = False,
					rounded = False,
					padding = 9,
					margin_x = 0,
					other_current_screen_border = '#0D6DE8',
					other_screen_border = '#1E1E1E',
					this_current_screen_border = '0D6DE8',
					this_screen_border = '#1E1E1E',
					urgent_alert_method = 'block',
					fontsize = 26
                ),
                widget.WindowName(
					empty_group_string = 'Arch Linux - Qtile',
					max_chars = 45,
					padding = 15,
					foreground = '#ffffff',
					font = 'Fira Sans Condensed SemiBold'
                ),
                #widget.OpenWeather(
				#	app_key = 'ade9990c9f83722d69a21e49432916d1',
				#	cityid = 4303543,
				#	font = 'Fira Sans Condensed SemiBold',
				#	fontsize = 16,
				#	metric = False,
				#	padding = 15,
				#	update_interval = 1200,
				#	format = ' {main_temp} °{units_temperature} {weather_details}'
                #),
                widget.Memory(
					padding = 15,
					format = ' {MemUsed: .0f}{mm}',
					font = 'Fira Sans Condensed SemiBold',
					fontsize = 16,
					measure_mem = 'G'
                ),
                widget.CPU(
					padding = 15,
					format = ' {load_percent}%',
					font = 'Fira Sans Condensed SemiBold',
					fontsize = 16
                ),
                widget.CheckUpdates(
					distro = 'Arch_checkupdates',
					display_format = ' {updates}',
					padding = 15,
					execute = 'terminator -e paru -Syu',
					no_update_string = ' 0',
					fontsize = 16,
					font = 'Fira Sans Condensed SemiBold'
                ),
                widget.Clock(
					format='%a %b %d, %l:%M %p',
					padding = 15,
					font = 'Fira Sans Condensed SemiBold'
                ),
                widget.Systray(
					icon_size = 18
                ),
            ],
            34,
            background = '#121212',
            margin=[0, 0, 0, 0],
            opacity=0.8,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(wm_class='Steam'),  # steam
    Match(title='branchdialog'),  # gitk
    Match(title='Nitrogen'),  # nitrogen
    Match(title='pinentry'),  # GPG key password entry
], border_focus = '#ffffff', border_width = 1)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

wmname = "qtile"
