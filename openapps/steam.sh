steam & disown
sleep 2
pkill -9 steamwebhelper
pkill -9 steam

notify-send "Steam" "Prepping Steam for launch..."
sleep 1

export STEAM_FORCE_IPV4=1
steam & disown
