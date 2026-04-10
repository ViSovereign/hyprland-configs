#!/bin/bash
# =============================================================================
# Papirus Icon Color from .conf file
# Uses ONLY the exact colors from `papirus-folders -l`
# Properly parses: $primary = rgb(56d7f6)
# =============================================================================

set -euo pipefail

# ----------------------------- Configuration -----------------------------
CONF_FILE="$HOME/.config/hypr/noctalia/noctalia-colors.conf"

if [[ ! -f "$CONF_FILE" ]]; then
    echo "Error: Config file not found: $CONF_FILE" >&2
    exit 1
fi

echo "Reading color from: $CONF_FILE" >&2

# ====================== ROBUST EXTRACTION ======================
PRIMARY_RAW=$(grep -E '^\s*(\$)?primary\s*=' "$CONF_FILE" | head -n1)

if [[ -z "$PRIMARY_RAW" ]]; then
    echo "Error: Could not find 'primary' or '\$primary' in $CONF_FILE" >&2
    exit 1
fi

# Extract and clean the value after '='
PRIMARY=$(echo "$PRIMARY_RAW" | sed 's/.*=\s*//' | tr -d '";' | xargs)

echo "Raw primary value: '$PRIMARY'" >&2

# Convert rgb() or hex to #RRGGBB
if [[ "$PRIMARY" =~ ^rgb\((.*)\)$ ]]; then
    inside="${BASH_REMATCH[1]}"

    # rgb(56d7f6) — hex inside rgb()
    if [[ "$inside" =~ ^[0-9a-fA-F]{6}$ ]]; then
        HEX="#${inside}"

    # rgb(86, 215, 246) — decimal RGB values
    elif [[ "$inside" =~ ^([0-9]+)[[:space:]]*,[[:space:]]*([0-9]+)[[:space:]]*,[[:space:]]*([0-9]+)$ ]]; then
        r=$(printf '%02x' "${BASH_REMATCH[1]}")
        g=$(printf '%02x' "${BASH_REMATCH[2]}")
        b=$(printf '%02x' "${BASH_REMATCH[3]}")
        HEX="#${r}${g}${b}"
    else
        echo "Error: Unsupported rgb() format: rgb($inside)" >&2
        exit 1
    fi

elif [[ "$PRIMARY" =~ ^#?([0-9a-fA-F]{6})$ ]]; then
    HEX="#${BASH_REMATCH[1]}"
else
    echo "Error: Could not parse color: $PRIMARY" >&2
    exit 1
fi

echo "Converted to: $HEX" >&2

# ====================== EXACT PAPIRUS COLORS (from your list) ======================
find_closest_color() {
    local target_hex="${1#\#}"
    local r=$((16#${target_hex:0:2}))
    local g=$((16#${target_hex:2:2}))
    local b=$((16#${target_hex:4:2}))

    declare -A presets=(
        ["adwaita"]="#3584e4"
        ["black"]="#212121"
        ["blue"]="#4285f4"
        ["bluegrey"]="#607d8b"
        ["breeze"]="#3daee9"
        ["brown"]="#795548"
        ["carmine"]="#a51c2d"
        ["cyan"]="#00bcd4"
        ["darkcyan"]="#00acc1"
        ["deeporange"]="#ff5722"
        ["green"]="#4caf50"
        ["grey"]="#9e9e9e"
        ["indigo"]="#3f51b5"
        ["magenta"]="#e91e63"
        ["nordic"]="#81a1c1"
        ["orange"]="#ff9800"
        ["palebrown"]="#a1887f"
        ["paleorange"]="#ffab40"
        ["pink"]="#e91e63"
        ["red"]="#f44336"
        ["teal"]="#009688"
        ["violet"]="#7c4dff"
        ["white"]="#fafafa"
        ["yaru"]="#3584e4"
        ["yellow"]="#ffeb3b"
    )

    local min_dist=999999999
    local closest="blue"

    for name in "${!presets[@]}"; do
        local p_hex="${presets[$name]#\#}"
        local pr=$((16#${p_hex:0:2}))
        local pg=$((16#${p_hex:2:2}))
        local pb=$((16#${p_hex:4:2}))

        local dist=$(( (r-pr)*(r-pr) + (g-pg)*(g-pg) + (b-pb)*(b-pb) ))
        if (( dist < min_dist )); then
            min_dist=$dist
            closest="$name"
        fi
    done

    echo "$closest"
}

COLOR_PRESET=$(find_closest_color "$HEX")
echo "Selected Papirus color: $COLOR_PRESET" >&2

# ====================== APPLY ======================
if ! command -v papirus-folders &>/dev/null; then
    echo "Error: 'papirus-folders' is not installed." >&2
    echo "Install with: sudo apt install papirus-folders" >&2
    exit 1
fi

echo "Applying color '$COLOR_PRESET' to Papirus folders..." >&2

if [[ -d "$HOME/.local/share/icons/Papirus" ]]; then
    if papirus-folders --theme Papirus -C "$COLOR_PRESET" 2>/tmp/papirus-folders.log; then
        echo "Success: Papirus folders tinted with '$COLOR_PRESET' (closest to $HEX)" >&2
    else
        echo "Error: papirus-folders failed. Check /tmp/papirus-folders.log" >&2
        exit 1
    fi
else
    echo "Warning: User Papirus directory not found. Trying system-wide..." >&2
    if papirus-folders -C "$COLOR_PRESET" 2>/tmp/papirus-folders.log; then
        echo "Success: Applied system-wide with color '$COLOR_PRESET'" >&2
    else
        echo "Error: Failed to apply color." >&2
        exit 1
    fi
fi
