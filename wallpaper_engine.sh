#!/bin/bash
# EXPERT LINUX WALLPAPER ENGINE V2
DIR_FONDOS="/home/brayan-cortes/Imágenes/fondos de pantalla"
DIR_SCRIPTS="/home/brayan-cortes/Imágenes/scripts_fondo"
LOG="$DIR_SCRIPTS/engine.log"
TEMAS=("black clover anime" "toyota supra anime" "subaru wrx anime" "nissan gtr anime" "jdm anime art" "mazda rx7 anime" "mitsubishi evo anime")

# GNOME Env
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

echo "$(date): --- ENGINE START V2 ---" >> "$LOG"

download() {
    TEMA=${TEMAS[$RANDOM % ${#TEMAS[@]}]}
    echo "$(date): [DL] Fetching $TEMA" >> "$LOG"
    LINKS=$(python3 -c "import urllib.request, json, sys; 
req = urllib.request.Request(f'https://wallhaven.cc/api/v1/search?q={sys.argv[1]}&categories=010&purity=100&sorting=random', headers={'User-Agent': 'Mozilla/5.0'});
try:
    with urllib.request.urlopen(req, timeout=10) as resp:
        data = json.loads(resp.read());
        for x in data['data'][:5]: print(x['path'])
except: pass" "$TEMA")
    if [ -n "$LINKS" ]; then
        for URL in $LINKS; do
            wget -q -T 10 -t 1 "$URL" -P "$DIR_FONDOS/"
        done
        echo "$(date): [DL] Success" >> "$LOG"
    else
        echo "$(date): [DL] Fail" >> "$LOG"
    fi
    ls -t "$DIR_FONDOS"/*.{jpg,jpeg,png} 2>/dev/null | tail -n +21 | xargs -I {} rm "{}" 2>/dev/null
}

COUNT=0
while true; do
    # Rotate every 120s
    IMG=$(ls "$DIR_FONDOS"/*.{jpg,jpeg,png} 2>/dev/null | shuf -n 1)
    if [ -n "$IMG" ]; then
        gsettings set org.gnome.desktop.background picture-uri "file://$IMG"
        gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMG"
        gsettings set org.gnome.desktop.background picture-options 'zoom'
        echo "$(date): [ROTATE] $(basename "$IMG")" >> "$LOG"
    fi

    # Every 20 rotations (10 min), download
    ((COUNT++))
    if [ $((COUNT % 20)) -eq 0 ]; then
        download &
    fi

    sleep 30
done
