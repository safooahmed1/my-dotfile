#!/bin/bash

CONFIG_DIR="$HOME/.config"
GTK3_CONF="$CONFIG_DIR/gtk-3.0/settings.ini"
GTK4_CONF="$CONFIG_DIR/gtk-4.0/settings.ini"
KVANTUM_CONF="$CONFIG_DIR/Kvantum/kvantum.kvconfig"
HYPR_CONF="$CONFIG_DIR/hypr/hyprland.conf"

# var themes
GTK_THEME="Adwaita"
ICON_THEME="Adwaita"
LIGHT_KVANTUM="KvArc"
DARK_KVANTUM="KvArcDark"

get_current_mode() {
    local state
    state=$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null)
    if [[ "$state" == "'prefer-dark'" ]]; then
        echo "dark"
    else
        echo "light"
    fi
}

apply_theme() {
    local mode="$1"

    if [[ "$mode" == "dark" ]]; then
        gtk_variant=""
        gtk_dark_theme=1
        color_scheme="prefer-dark"
        kvantum_theme="$DARK_KVANTUM"
        gtk_env="Adwaita:dark"
        mode_name="Dark"
    else
        gtk_variant=""
        gtk_dark_theme=0
        color_scheme="default"
        kvantum_theme="$LIGHT_KVANTUM"
        gtk_env="Adwaita"
        mode_name="Light"
    fi

    gsettings set org.gnome.desktop.interface color-scheme "$color_scheme"
    gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"
    gsettings set org.gnome.desktop.interface icon-theme "$ICON_THEME"

    for conf in "$GTK3_CONF" "$GTK4_CONF"; do
        if [[ -f "$conf" ]]; then
            sed -i "s/^gtk-theme-name=.*/gtk-theme-name=$GTK_THEME/" "$conf"
            sed -i "s/^gtk-icon-theme-name=.*/gtk-icon-theme-name=$ICON_THEME/" "$conf"
            sed -i "s/^gtk-application-prefer-dark-theme=.*/gtk-application-prefer-dark-theme=$gtk_dark_theme/" "$conf"
        fi
    done

    if command -v kvantummanager &>/dev/null; then
        kvantummanager --set "$kvantum_theme" 2>/dev/null
    fi

    if [[ -f "$HYPR_CONF" ]]; then
        sed -i "s/^env = GTK_THEME,.*/env = GTK_THEME,$gtk_env/" "$HYPR_CONF"
        sed -i "s/^env = GTK_APPLICATION_PREFER_DARK_THEME,.*/env = GTK_APPLICATION_PREFER_DARK_THEME,$gtk_dark_theme/" "$HYPR_CONF"
    fi

    if command -v hyprctl &>/dev/null; then
        hyprctl keyword env GTK_THEME "$gtk_env" 2>/dev/null
        hyprctl keyword env GTK_APPLICATION_PREFER_DARK_THEME "$gtk_dark_theme" 2>/dev/null
    fi

    if command -v dunstify &>/dev/null; then
        dunstify -t 2000 "Theme: $mode_name Mode" "Switched to $mode_name theme"
    fi

    echo "Switched to $mode_name mode"
}

case "${1:-toggle}" in
    light|Light)
        apply_theme "light"
        ;;
    dark|Dark)
        apply_theme "dark"
        ;;
    toggle)
        current=$(get_current_mode)
        if [[ "$current" == "dark" ]]; then
            apply_theme "light"
        else
            apply_theme "dark"
        fi
        ;;
    *)
        echo "Usage: $0 {light|dark|toggle}"
        exit 1
        ;;
esac
