--    ╻┏ ┏━╸╻ ╻   ┏┓ ╻┏┓╻╺┳┓┏━┓
--    ┣┻┓┣╸ ┗┳┛   ┣┻┓┃┃┗┫ ┃┃┗━┓
--    ╹ ╹┗━╸ ╹    ┗━┛╹╹ ╹╺┻┛┗━┛
-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/

-- Set Variables
local mainMod     = "SUPER"
local browser     = "librewolf"
local discord     = "vesktop"
local terminal    = "kitty"
local fileManager = "nautilus"
local editor      = "zeditor"
local ipc         = "noctalia msg "

-- Panel Launchers
hl.bind(mainMod .. " + SPACE",
    hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))

hl.bind(mainMod .. " + SHIFT + E",
    hl.dsp.exec_cmd(ipc .. "panel-toggle launcher /emo "))

hl.bind("CTRL + ALT + DELETE",
    hl.dsp.exec_cmd(ipc .. "panel-toggle session"))

hl.bind(mainMod .. " + V",
    hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard"))

hl.bind(mainMod .. " + CTRL + W",
    hl.dsp.exec_cmd(ipc .. "panel-toggle wallpaper"))

hl.bind(mainMod .. " + COMMA",
    hl.dsp.exec_cmd(ipc .. "settings-toggle"))

-- Apps
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(discord))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("steam"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(editor))

-- Actions
--hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f - '))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(ipc .. 'screenshot-region'))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(ipc .. "wallpaper-random DP-1"))

-- Noctalia Related
--hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd(ipc .. "plugin:assistant-panel toggle"))

-- Window Related Rules
local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + I", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

local function switchWorkspaceOnActive(action, key)
    return string.format(
        [[bash -lc 'mon=$(hyprctl monitors -j | jq -r ".[] | select(.focused == true).name"); off=0; [ "$mon" = "DP-2" ] && off=3; ws=$((%d + off)); hyprctl dispatch "hl.dsp.%s({ workspace = $ws })"']],
        key,
        action
    )
end

for key = 1, 3 do
    hl.bind(
        mainMod .. " + " .. key,
        hl.dsp.exec_cmd(switchWorkspaceOnActive("focus", key))
    )

    hl.bind(
        mainMod .. " + SHIFT + " .. key,
        hl.dsp.exec_cmd(switchWorkspaceOnActive("window.move", key))
    )
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + N", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. " volume-up"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. " volume-down"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. " volume-mute"),
    { locked = true, repeating = false })
hl.bind("XF86VoiceCommand", hl.dsp.exec_cmd(ipc .. " mic-mute"),
    { locked = true, repeating = false })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. " volume-down"),
    { locked = true, repeating = true })
