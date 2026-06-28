#!/bin/bash

WALL_DIR="$HOME/Pictures/Wallpaper"
CACHE_DIR="$HOME/.cache/wal"
ROFI_DIR="$HOME/.config/rofi"
ROFI_THEME='style-2'
SCRIPTS_DIR="$HOME/.config/myScripts"
THUMB_DIR="$HOME/.cache/wallpaper-thumbs"

mkdir -p "$THUMB_DIR"

pgrep -x awww-daemon > /dev/null || awww-daemon &

for img in "$WALL_DIR"/*; do
  fname=$(basename "$img")
  thumb="$THUMB_DIR/$fname"
  if [[ ! -f "$thumb" ]]; then
    magick "$img" -thumbnail 200x120^ -gravity center -extent 200x120 "$thumb" 2>/dev/null
  fi
done

CHOICE=$(for img in "$WALL_DIR"/*; do
  fname=$(basename "$img")
  echo -en "$fname\0icon\x1f$THUMB_DIR/$fname\n"
done | rofi \
  -dmenu -i -p "󰸉 Select Wallpaper" \
  -theme "${ROFI_DIR}/${ROFI_THEME}.rasi" \
  -show-icons \
  -hover-select \
  -me-select-entry '' \
  -me-accept-entry MousePrimary
)

[[ -z "$CHOICE" ]] && exit 1

FULL_PATH="$WALL_DIR/$CHOICE"

awww img "$FULL_PATH" \
  --transition-type grow \
  --transition-pos center \
  --transition-duration 1 \
  --transition-step 90 \
  --transition-fps 60

wal -q -i "$FULL_PATH"

while [[ ! -f "$CACHE_DIR/colors.sh" ]]; do sleep 0.1; done

bash "$SCRIPTS_DIR/pywal-color.sh"

killall -SIGUSR2 waybar
cat "$CACHE_DIR/sequences"

pkill -x swaync
sleep 0.3
swaync &
sleep 0.3

notify-send -u low -i "$FULL_PATH" "Wallpaper Updated" "$(basename "$FULL_PATH")"
