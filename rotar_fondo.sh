#!/bin/bash
DIR="/home/brayan-cortes/Imágenes/fondos de pantalla"
LOG="/home/brayan-cortes/Imágenes/scripts_fondo/rotar_fondo.log"

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

while true; do
    IMG=$(find "$DIR" -type f | shuf -n 1)
    if [ -n "$IMG" ]; then
        echo "$(date): Intentando $IMG" >> "$LOG"
        /usr/bin/gsettings set org.gnome.desktop.background picture-uri "file://$IMG" 2>> "$LOG"
        /usr/bin/gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMG" 2>> "$LOG"
        echo "$(date): Comando completado" >> "$LOG"
    fi
    sleep 10
done
