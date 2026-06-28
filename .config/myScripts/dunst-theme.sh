#!/bin/bash

COLOR_FILE="$HOME/.cache/wal/colors.sh"

if [[ ! -f "$COLOR_FILE" ]]; then
    echo "Error: colors.sh not found!"
    exit 1
fi

source "$COLOR_FILE"

DUNST_CONF="$HOME/.config/dunst/dunstrc"

cat <<EOL > "$DUNST_CONF"
[global]
    monitor = 0
    follow = none
    width = 300
    height = 145
    origin = top-right
    alignment = "left"
    vertical_alignment = "center"
    ellipsize = "middle"
    offset = "15x15"
    padding = 15
    horizontal_padding = 15
    text_icon_padding = 15
    icon_position = "left"
    min_icon_size = 48
    max_icon_size = 64
    progress_bar = true
    progress_bar_height = 8
    progress_bar_frame_width = 1
    progress_bar_min_width = 150
    progress_bar_max_width = 300
    separator_height = 2
    frame_width = 2
    frame_color = "${color1}" 
    separator_color = "frame" 
    corner_radius = 8 
    transparency = 0 
    gap_size = 8 
    line_height = 0 
    notification_limit = 0 
    idle_threshold = 120 
    history_length = 20 
    show_age_threshold = 60 
    markup = "full" 
    font = "monospace 10" 
    format = "<b>%s</b>\n%b" 
    word_wrap = "yes" 
    sort = "yes" 
    shrink = "no" 
    indicate_hidden = "yes" 
    sticky_history = "yes" 
    ignore_newline = "no" 
    show_indicators = "no" 
    stack_duplicates = true 
    always_run_script = true 
    hide_duplicate_count = false 
    ignore_dbusclose = false 
    force_xwayland = false 
    force_xinerama = false 
    mouse_left_click = "do_action" 
    mouse_middle_click = "close_all" 
    mouse_right_click = "close_current" 

[experimental]
    per_monitor_dpi = false

[urgency_low]
    background = "${color0}e6"
    foreground = "${color7}"
    highlight = "${color4}"
    timeout = 4

[urgency_normal]
    background = "${color0}e6"
    foreground = "${color7}"
    highlight = "${color4}"
    timeout = 6

[urgency_critical]
    background = "${color1}e6"
    foreground = "${color7}"
    highlight = "${color3}"
    timeout = 0
EOL

echo "✓ Dunst colors updated"

