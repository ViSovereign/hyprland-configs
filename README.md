# Sov's Hyprland Config

My personal Hyprland configuration files!

This setup includes Hyprland configs for keybindings, window rules, animations, noctalia v5 and snappy-switcher. Intended for a dual montior setup.

## Preview

<img src="./screenshots/desktop.png" alt="Master Chef sees something on your right" width="650"/>

## Install
> [!CAUTION]
> Take a backup of your existing config first, this will override whatever you have!

```bash
git clone https://github.com/ViSovereign/hyprland-configs.git
cd hyprland-config
```

Copy to ```~/.config/hypr``` and run ```hyprctl reload```


## Features

- Custom keybindings
  - Focus on having three workspaces for both monitors but the same SUPER + # to switch between whatever monitor is the active one.
  - SUPER and ~ switches between the monitors.
- Zed stubs
- Dope window rules and workspace rules for two monitors
  - The Pop out window rules are pretty snazzy!
- Theming, screenshots, clipboard, Polkit agent provided by noctalia
- Animations
  - Kinda stock for the moment. Will tweak soonTM.

## Packages

Please install the following!

1. [noctalia v5](https://github.com/noctalia-dev)
2. [jq](https://github.com/jqlang/jq)
3. [snappy-switcher](https://github.com/noctalia-dev)

### Arch

```paru -S noctalia-git jq snappy-switcher```

## Directory Structure
> [!TIP]
> Nice graphic below made with [tree](https://peteretelej.github.io/tree/)

```text
.
├── autostart.lua
├── colors.lua
├── env.lua
├── hyprland.conf
├── hyprland.lua
├── keybinds.lua
├── monitors.lua
├── noctalia.lua
├── README.md
├── screenshots
│   └── desktop.png
├── scripts
│   ├── firstlaunch.sh
│   ├── papirus-tinter-conf.sh
│   └── papirus-tinter-json.sh
├── templatecolors.lua
└── windowrule.lua
```
# Keybinds

| Keybind | Action |
| --- | --- |
| `SUPER + X` | Open terminal |
| `SUPER + Z` | Open editor |
| `SUPER + E` | Open file manager |
| `SUPER + SPACE` | Open noctalia app launcher |
| `SUPER + Q` | Close active window |
| `SUPER + F` | Toggle fullscreen |
| `SUPER + B` | Open browser (Zen-browser) |
| `SUPER + S` | Open steam |
| `SUPER + D` | Open discord (vesktop) |
| `SUPER + A` | noctalia screenshot |
| `SUPER + ~` | Switch between monitors |
| `SUPER + 1` | Open workspace 1 if on Montior DP-1, Open workspace 4 if on Montior DP-2 |
| `SUPER + 2` | Open workspace 2 if on Montior DP-1, Open workspace 5 if on Montior DP-2 |
| `SUPER + 3` | Open workspace 3 if on Montior DP-1, Open workspace 6 if on Montior DP-2 |

## Variable Opens

At the top of ```keybinds.lua``` edit what your defualt apps are!

```lua
-- Set Variables
local browser     = "zen-browser"
local discord     = "vesktop"
local terminal    = "kitty"
local fileManager = "nautilus"
local editor      = "zeditor"
```
