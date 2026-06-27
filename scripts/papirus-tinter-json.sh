#!/bin/bash
#    ╺┳╸╻┏┓╻╺┳╸   ┏━┓┏━┓┏━┓╻┏━┓╻ ╻┏━┓
#     ┃ ┃┃┗┫ ┃    ┣━┛┣━┫┣━┛┃┣┳┛┃ ┃┗━┓
#     ╹ ╹╹ ╹ ╹    ╹  ╹ ╹╹  ╹╹┗╸┗━┛┗━┛
# # Requires: jq (JSON parser), papirus-folders\

COLORS_FILE="$HOME/.config/matugen/templates/colorsCH.json"
PRIMARY_COLOR=$(jq -r '.on_primary' "$COLORS_FILE")

if [[ -z "$PRIMARY_COLOR" || "$PRIMARY_COLOR" == "null" ]]; then
    echo "No primary color found in $COLORS_FILE"
    exit 1
fi

# Function to find closest Papirus color (simple RGB distance; expand presets as needed)
find_closest_color() {
    local target_hex="$1"
    # Convert hex to RGB (remove # and parse)
    target_hex=${target_hex#\#}
    local r=$((16#${target_hex:0:2}))
    local g=$((16#${target_hex:2:2}))
    local b=$((16#${target_hex:4:2}))

    # Papirus-Dark supported colors (from `papirus-folders -l`)
    declare -A presets=(
        ["blue"]="#42a5f5"
        ["lightblue"]="#29b6f6"
        ["cyan"]="#26c6da"
        ["teal"]="#26a69a"
        ["green"]="#66bb6a"
        ["orange"]="#ffa726"
        ["red"]="#ef5350"
        ["pink"]="#ec407a"
        ["purple"]="#ab47bc"
        ["deeppurple"]="#7e57c2"
        ["yellow"]="#ffee58"
        ["grey"]="#78909c"
    )


    local min_dist=999999
    local closest="blue"  # Default fallback

    for preset in "${!presets[@]}"; do
        local p_hex="${presets[$preset]}"
        p_hex=${p_hex#\#}
        local pr=$((16#${p_hex:0:2}))
        local pg=$((16#${p_hex:2:2}))
        local pb=$((16#${p_hex:4:2}))

        local dist=$(( (r-pr)*(r-pr) + (g-pg)*(g-pg) + (b-pb)*(b-pb) ))
        if (( dist < min_dist )); then
            min_dist=$dist
            closest="$preset"
        fi
    done

    echo "$closest"
}

# Find closest color preset
COLOR_PRESET=$(find_closest_color "$PRIMARY_COLOR")
echo "Selected preset: $COLOR_PRESET" >&2

# Apply color to Papirus (user-level)
if [[ -d "$HOME/.local/share/icons/Papirus" ]]; then
    papirus-folders --theme Papirus -C "$COLOR_PRESET" 2>/tmp/papirus-folders.log
else
    echo "Warning: Papirus not found in ~/.local/share/icons" >&2
fi

if [[ $? -eq 0 ]]; then
    echo "Folder icons tinted to $COLOR_PRESET based on primary color $PRIMARY_COLOR" >&2
else
    echo "Error: Failed to apply color $COLOR_PRESET. Check /tmp/papirus-folders.log" >&2
    exit 1
fi
