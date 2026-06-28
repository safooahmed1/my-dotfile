#!/bin/bash

COLOR_FILE="$HOME/.cache/wal/colors.sh"

if [[ ! -f "$COLOR_FILE" ]]; then
    echo "Error: colors.sh not found!"
    exit 1
fi

source "$COLOR_FILE"

DIR_1="$HOME/.config/rofi/colors.css"
DIR_2="$HOME/.config/rofi/powermenu/styles/colors.rasi"

cat <<EOL | tee "$DIR_1" "$DIR_2" > /dev/null
* {
    background:     ${color0}aa;
    background-alt: ${color1}e6;
    foreground:     ${color7};
    selected:       ${color2};
    active:         ${color3};
    urgent:         ${color1};
    border:         ${color2}80;
}
EOL

echo "✓ Rofi colors updated"