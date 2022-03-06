
from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = "st"

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
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    
    # Replacing with dmenu
    #Key([mod], "r", lazy.spawncmd(),
    #    desc="Spawn a command using a prompt widget"),
    Key([mod], "p", lazy.spawn("dmenu_run -fn monospace:size=10"),
        desc="Spawn a command using a prompt widget"),

]


groups = [Group(i) for i in [
    "www",
    "dev",
    "cmd",
    "doc",
    "5",
    "6",
    "7",
    "8",
    "9"
]]

group_keys = [
    "ampersand",
    "eacute",
    "quotedbl",
    "apostrophe",
    "parenleft",
    "minus",
    "egrave",
    "underscore",
    "ccedilla"
]


for i, grp in enumerate(groups):
    keys.extend([
        Key([mod], str(group_keys[i]), lazy.group[grp.name].toscreen(),
            desc=f"Switch to group {grp.name}"),
        #Key([mod, "shift"], str(group_keys[i]), lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])


layouts = [
    layout.Columns(border_focus_stack=['#d75f5f', '#8f3d3d'], border_width=4),
    layout.Max(),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    layout.Tile(border_focus_stack=['#d75f5f', '#8f3d3d'], border_width=2),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='Ubuntu Mono',  # Default -> sans
    fontsize=15,
    padding=2,
)
extension_defaults = widget_defaults.copy()


screens = [
    Screen(
        top=bar.Bar( [
                widget.GroupBox(),
                widget.CurrentLayout(),

                widget.WindowName(),
                
                widget.CPU(format="CPU {load_percent}%"),
                widget.Memory(
                    format="RAM {MemUsed: .0f}{mm}/{MemTotal: .0f}{mm} "
                ),
                widget.Net(format="NET {down} ↓↑ {up} "),

                widget.Systray(),
                widget.Clock(format=" %I:%M "),
            ],
            17,  # default value -> 24
        ),

        #bottom=bar.Bar(
        #    [
        #        # Windows logo
        #        widget.Image(
        #            filename="/home/yuesubi/Images/WindowsIcons/logo.png",
        #        ),
        #        # Search bar
        #        widget.Image(
        #            filename="/home/yuesubi/Images/WindowsIcons/search_bar.png",
        #        ),
        #
        #        widget.CurrentLayout(),
        #        widget.GroupBox(),
        #        widget.Prompt(),
        #        widget.WindowName(),
        #        widget.Chord(
        #            chords_colors={
        #                'launch': ("#ff0000", "#ffffff"),
        #            },
        #            name_transform=lambda name: name.upper(),
        #        ),
        #        widget.Systray(),
        #        widget.Clock(format='%a %d-%m %I:%M %p'),
        #        widget.QuickExit(),
        #    ],
        #    40,  # default value -> 24
        #)
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
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

auto_minimize = True

wmname = "LG3D"
