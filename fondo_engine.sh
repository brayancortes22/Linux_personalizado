#!/bin/bash
DIR="/home/brayan-cortes/Imágenes/fondos de pantalla"
LOG="/home/brayan-cortes/Imágenes/scripts_fondo/engine.log"
DL_SCRIPT="/home/brayan-cortes/Imágenes/scripts_fondo/descargar_fondos.sh"

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

while true; do
    # 1. Download in background
    bash "$DL_SCRIPT" &
    
    # 2. Rotate 2 times (20s)
    for i in {1..2}; do
        IMG=$(find "$DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)
        if [ -n "$IMG" ]; then
            /usr/bin/gsettings set org.gnome.desktop.background picture-uri "file://$IMG"
            /usr/bin/gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMG"
            /usr/bin/gsettings set org.gnome.desktop.background picture-options 'zoom'
            echo "$(date): SET $(basename "$IMG")" >> "$LOG"
        fi
        sleep 10
    done
done
