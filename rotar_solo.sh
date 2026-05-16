#!/bin/bash
DIR="/home/brayan-cortes/Imágenes/fondos de pantalla"
LOG="/home/brayan-cortes/Imágenes/scripts_fondo/engine.log"

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

while true; do
    IMG=$(find "$DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)
    if [ -n "$IMG" ]; then
        gsettings set org.gnome.desktop.background picture-uri "file://$IMG"
        gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMG"
        gsettings set org.gnome.desktop.background picture-options 'zoom'
        echo "$(date): ROTATE $IMG" >> "$LOG"
    fi
    sleep 10
done
