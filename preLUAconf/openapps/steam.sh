notify-send "Steam" "Prepping Steam for launch..."
sleep 1

export STEAM_FORCE_IPV4=1
systemctl --user restart pipewire
steam & disown
