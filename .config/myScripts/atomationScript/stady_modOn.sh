#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WALL_DIR="$HOME/Pictures/Wallpaper"
WAYBAR_DIR="$HOME/.config/waybar"
SCRIPTS_DIR="$HOME/.config/myScripts"
CACHE_DIR="$HOME/.cache/wal"
WALLPAPER="$WALL_DIR/b-642.jpg"

# 1. Switch waybar to style-2 (before wallpaper reload)
cp "$WAYBAR_DIR/themes/style-2/config.jsonc" "$WAYBAR_DIR/config.jsonc"
cp "$WAYBAR_DIR/themes/style-2/style.css" "$WAYBAR_DIR/style.css"

# 2. Set wallpaper with pywal colors
awww img "$WALLPAPER" \
  --transition-type grow \
  --transition-pos center \
  --transition-duration 1 \
  --transition-step 90 \
  --transition-fps 60

wal -q -i "$WALLPAPER"

while [[ ! -f "$CACHE_DIR/colors.sh" ]]; do sleep 0.1; done

bash "$SCRIPTS_DIR/pywal-color.sh"

killall -SIGUSR2 waybar
cat "$CACHE_DIR/sequences"

pkill -x swaync
sleep 0.3
swaync &
sleep 0.3

# 3. Do Not Disturb
swaync-client -d

# 4. Open Obsidian in workspace 3 and NotbookLM in workspace 1
hyprctl dispatch exec [workspace 1] gio launch ~/.local/share/applications/chrome-gjcmcplpgihbecacndmmbaenpfgimlec-Default.desktop
hyprctl dispatch exec [workspace 3] obsidian

# 5. Spotify scratch (bluetooth + scratchpad)
"$SCRIPT_DIR/spotify_scratch.sh"
