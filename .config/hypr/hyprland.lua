-- My programs
local terminal = "footclient"
local fileManager = "footclient zsh -i -c yazi"
local browser = "qutebrowser"
local editor = "footclient nvim"
local bar = "qs -p ~/.config/quickshell/"

local gamemode = false
local colors = {}
for line in io.lines(os.getenv("HOME").."/.cache/wal/colors") do
    colors[#colors+1] = line
end
colors.background = colors[1]
colors.foreground = colors[15]


hl.env("HYPRCURSOR_THEME", "Agnes_Tachyon_Experiment")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Agnes_Tachyon_Experiment")
hl.env("XCURSOR_SIZE", "24")
hl.env("QS_ICON_THEME", "Papirus")

hl.monitor({
		output = "DP-2",
		position = "1920x0",
		mode = "1366x768@60",
})

hl.monitor({
		output = "HDMI-A-1",
		position = "0x0",
		mode = "1920x1080@75",
    vrr = 2,
})

hl.on("hyprland.start", function ()
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("hyprsunset")
	hl.exec_cmd("sh ~/scripts/changetheme.sh")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("foot --server")
	hl.exec_cmd("otd-daemon")
	hl.exec_cmd("udiskie")
	hl.exec_cmd(bar)
end)


local visual = {
    general = {
        gaps_in  = 2,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border   = { colors = {colors[2], colors[2], colors[3]}, angle = 45 },
            inactive_border = colors.background,
        },

        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 5,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
}
hl.config(visual)

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
hl.curve("easy",           { type = "spring", mass = 0.5000001, stiffness = 71.2633*2, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
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


hl.config({
    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    scrolling = {
        fullscreen_on_one_column = true,
    },

    misc = {
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us,br",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:ctrl_space_toggle",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity = 0,
        numlock_by_default = true,

        tablet = {
            output = "current"
        }
    },
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"
hl.bind(mainMod .. " + Q",              hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + W",              hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + escape",         hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + escape", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))
hl.bind(mainMod .. " + E",              hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",              hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Space",          hl.dsp.global("quickshell:apprunner"))
hl.bind(mainMod .. " + P",              hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T",              hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F",              hl.dsp.window.fullscreen({}))
hl.bind(mainMod .. " + delete",         hl.dsp.exec_cmd("$HOME/scripts/powermenu.sh"))
hl.bind(mainMod .. " + B",              hl.dsp.exec_cmd("killall qs || " .. bar))

hl.bind(mainMod .. " + S", function ()
    local currLayout = hl.get_config("general.layout") == "dwindle" and "scrolling" or "dwindle"
    hl.config({general = {layout = currLayout}})
    hl.exec_cmd("notify-send 'Current layout: '"..currLayout)
end)
hl.bind(mainMod .. " + G", function ()
    hl.config(gamemode and visual or {
        general = {gaps_in = 0, gaps_out = 0, border_size = 1},
        decoration = {blur = {enabled = false}, shadow = {enabled = false}, rounding = 0},
        animations = {enabled = false}
    })
    gamemode = not gamemode
    hl.exec_cmd("notify-send 'Game mode '"..(gamemode and "ON" or "OFF"))
end)

hl.bind(mainMod .. " + F1",             hl.dsp.exec_cmd('ls scripts | rofi -dmenu -no-custom -p "Run script" | xargs -I{} sh "$HOME/scripts/{}"'))
hl.bind(mainMod .. " + insert",         hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + home",           hl.dsp.exec_cmd("rofi -show ssh"))

hl.bind(mainMod .. " + Tab",            hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + Tab",    hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + equal",          hl.dsp.layout("colresize +0.2"))
hl.bind(mainMod .. " + minus",          hl.dsp.layout("colresize -0.2"))
hl.bind(mainMod .. " + SHIFT + equal",  hl.dsp.layout("colresize +0.1"))
hl.bind(mainMod .. " + SHIFT + minus",  hl.dsp.layout("colresize -0.1"))

hl.bind(mainMod .. " + CTRL + left",    hl.dsp.window.move({workspace ="-1"}))
hl.bind(mainMod .. " + CTRL + right",   hl.dsp.window.move({workspace ="+1"}))
hl.bind(mainMod .. " + CTRL + H",       hl.dsp.window.move({workspace ="-1"}))
hl.bind(mainMod .. " + CTRL + L",       hl.dsp.window.move({workspace ="+1"}))


for i=1, 4 do
    local dir = select(i, "left", "right", "up", "down")
    local vik = select(i, "H", "L", "K", "J")

    hl.bind(mainMod .. " + " .. dir, hl.dsp.focus({direction = dir}))
    hl.bind(mainMod .. " + " .. vik, hl.dsp.focus({direction = dir}))

    hl.bind(mainMod .. "+ SHIFT +" .. dir, hl.dsp.window.swap({direction = dir}))
    hl.bind(mainMod .. "+ SHIFT +" .. vik, hl.dsp.window.swap({direction = dir}))
end

for i = 1, 10 do
    local key = i % 10
    local kpkey = select(i, "KP_End", "KP_Down", "KP_Next", "KP_Left", "KP_Begin", "KP_Right", "KP_Home", "KP_Up", "KP_Prior", "KP_Insert")

    hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + " .. kpkey,         hl.dsp.focus({ workspace = i}))

    hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. kpkey, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + mouse:275", hl.dsp.exec_cmd('zsh "/home/thales/scripts/translate.sh" "$(wl-paste --primary)"'))

hl.bind("mouse:275", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("mouse:276", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind("XF86Calculator",  hl.dsp.exec_cmd("rofi -show calc -modi calc -no-show-match -no-sort"))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })

hl.window_rule({
    name  = "no-gaps-wtv1",
    match = { float = false, workspace = "w[tv1]" },
    border_size = 0,
    rounding    = 0,
})
hl.window_rule({
    name  = "no-gaps-f1",
    match = { float = false, workspace = "f[1]" },
    border_size = 0,
    rounding    = 0,
})

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
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

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule {
    name = "fix-ueberzugpp",
    match = {title = "ueberzugpp.*"},

    no_anim = true,
    no_blur = true,
    no_focus = true,
    no_shadow = true,
    focus_on_activate = false,
    no_initial_focus = true,
    float = true,
}
