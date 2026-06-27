#!/usr/bin/env sh
#    ┏━╸╻┏━┓┏━┓╺┳╸   ╻  ┏━┓╻ ╻┏┓╻┏━╸╻ ╻
#    ┣╸ ┃┣┳┛┗━┓ ┃    ┃  ┣━┫┃ ┃┃┗┫┃  ┣━┫
#    ╹  ╹╹┗╸┗━┛ ╹    ┗━╸╹ ╹┗━┛╹ ╹┗━╸╹ ╹

make_color_text () {
  gum style --foreground "$1" "$2"
}

# Check if Hyprland is running
if pgrep -x "Hyprland" > /dev/null; then
    # Hyprland is running, execute fastfetch
    fastfetch --config ~/.config/fastfetch/launch.jsonc
else

	# LCARS Color Palette (ANSI escape codes)
	LCARS_BLUE="#8899ff"
	LCARS_YELLOW="#ffaa00"
	LCARS_RED="#cc4444"

	LCARS_ORANGE="#ff8800"
	LCARS_PINK="#cc55ff"

	# Get current hour (24-hour format)
	current_hour=$(date +%H)

	# Determine time of day greeting
	if [ "$current_hour" -ge 5 ] && [ "$current_hour" -lt 12 ]; then
	    greeting="Good morning"
	elif [ "$current_hour" -ge 12 ] && [ "$current_hour" -lt 18 ]; then
	    greeting="Good afternoon"
	else
	    greeting="Good evening"
	fi

	# Get username and current date/time
	current_date=$(date +"%Y%m%d")
	current_time=$(date +"%H%M")

	# Welcome message
	gum style \
		--border normal \
		--margin "1" \
		--padding "1" \
		--border-foreground $LCARS_PINK \
		" $greeting, $(make_color_text $LCARS_BLUE 'Captain'). 🖖 it is stardate $(make_color_text $LCARS_YELLOW $current_date).$(make_color_text $LCARS_RED $current_time). Hyprland Drive is offline, terminal engines only."

    # Hyprland is not running, offer choice to start it
	if gum confirm \
	--affirmative "Engage" \
	--negative "Abort" \
	--prompt.foreground="#FFF" \
	--selected.foreground="#FFF" \
	--selected.background="$LCARS_BLUE" \
	--unselected.foreground="$LCARS_RED" \
	"Go to Warp GUI?"; then
		exec hyprland
	fi
fi
