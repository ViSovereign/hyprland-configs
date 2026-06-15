#!/usr/bin/env bash
#    ┏━╸╺┳╸╻┏
#    ┃╺┓ ┃ ┣┻┓
#    ┗━┛ ╹ ╹ ╹
# https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland

#Datetime the log for some reason
log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') $*" >> gtk_output.log
}

# Start with Setting new log content
echo "Starting GTK settings script" > gtk_output.log

# Check that settings file exists
config="$HOME/.config/gtk-3.0/settings.ini"
if [ ! -f "$config" ]; then exit 1; fi

# Read settings file
gnome_schema="org.gnome.desktop.interface"
gtk_theme="$(grep 'gtk-theme-name' "$config" | sed 's/.*\s*=\s*//')"
icon_theme="$(grep 'gtk-icon-theme-name' "$config" | sed 's/.*\s*=\s*//')"
cursor_theme="$(grep 'gtk-cursor-theme-name' "$config" | sed 's/.*\s*=\s*//')"
cursor_size="$(grep 'gtk-cursor-theme-size' "$config" | sed 's/.*\s*=\s*//')"
font_name="$(grep 'gtk-font-name' "$config" | sed 's/.*\s*=\s*//')"
prefer_dark_theme="$(grep 'gtk-application-prefer-dark-theme' "$config" | sed 's/.*\s*=\s*//')"
terminal="kitty"

# Value for debugging
log "GTK-Theme:" $gtk_theme
log "Icon Theme:" $icon_theme
log "Cursor Theme:" $cursor_theme
log "Cursor Size:" $cursor_size
if [ $prefer_dark_theme == "0" ]; then
    prefer_dark_theme_value="prefer-light"
else
    prefer_dark_theme_value="prefer-dark"
fi
log "Color Theme:" $prefer_dark_theme_value
log "Font Name:" $font_name
log "Terminal:" $terminal

# Update gsettings
gsettings set "$gnome_schema" gtk-theme "$gtk_theme"
gsettings set "$gnome_schema" icon-theme "$icon_theme"
gsettings set "$gnome_schema" cursor-theme "$cursor_theme"
gsettings set "$gnome_schema" font-name "$font_name"
gsettings set "$gnome_schema" color-scheme "$prefer_dark_theme_value"

# Update cursor for Hyprland
hyprctl setcursor $cursor_theme $cursor_size

# Update gsettings for open any terminal
gsettings set org.cinnamon.desktop.default-applications.terminal exec "$terminal"
gsettings set org.gnome.nautilus use-generic-terminal-name "true"
#gsettings set com.github.stunkymonkey.nautilus-open-any-terminal keybindings "<Ctrl><Alt>t"
