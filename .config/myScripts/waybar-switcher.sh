#!/bin/bash

WAYBAR_DIR="$HOME/.config/waybar"
ROFI_THEME="$HOME/.config/rofi/style-1.rasi"

STYLES=$(find "$WAYBAR_DIR/themes" \
  -maxdepth 1 \
  -type d \
  -name "style-*" \
  -exec basename {} \;
)

CHOICE=$(printf "%s\n" $STYLES | rofi \
  -dmenu \
  -p "󰥔 Waybar Style" \
  -theme "$ROFI_THEME")

[[ -z "$CHOICE" ]] && exit

THEME_DIR="$WAYBAR_DIR/themes/$CHOICE"

cp "$THEME_DIR/config.jsonc" "$WAYBAR_DIR/config.jsonc"
cp "$THEME_DIR/style.css" "$WAYBAR_DIR/style.css"

if pgrep -x waybar >/dev/null 2>&1; then
    killall -SIGUSR2 waybar
else
    waybar &
    disown
fi
