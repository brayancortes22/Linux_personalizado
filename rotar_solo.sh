#!/bin/bash
DIR="/home/brayan-cortes/Imágenes/fondos de pantalla"
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
while true; do
    IMG=$(ls "$DIR"/*.{jpg,jpeg,png} 2>/dev/null | shuf -n 1)
    if [ -n "$IMG" ]; then
        gsettings set org.gnome.desktop.background picture-uri "file://$IMG"
        gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMG"
        gsettings set org.gnome.desktop.background picture-options 'zoom'
    fi
    sleep 60
done
