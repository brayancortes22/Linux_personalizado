#!/bin/bash
# MASTER SETUP SCRIPT
DIR_FONDOS="/home/brayan-cortes/Imágenes/fondos de pantalla"
DIR_SCRIPTS="/home/brayan-cortes/Imágenes/scripts_fondo"
mkdir -p "$DIR_FONDOS"

# 1. Download images properly
echo "Downloading fresh wallpapers..."
LINKS=$(python3 -c "import urllib.request, json; 
req = urllib.request.Request('https://wallhaven.cc/api/v1/search?q=black+clover&categories=010&purity=100&sorting=random', headers={'User-Agent': 'Mozilla/5.0'});
try:
    with urllib.request.urlopen(req) as resp:
        data = json.loads(resp.read());
        for x in data['data'][:10]: print(x['path'])
except: pass")

for URL in $LINKS; do
    FILE=$(basename "$URL")
    wget -q "$URL" -O "$DIR_FONDOS/$FILE"
done

# 2. Update Scripts
cat << 'EOF' > "$DIR_SCRIPTS/rotar_solo.sh"
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
EOF

cat << 'EOF' > "$DIR_SCRIPTS/descargar_solo.sh"
#!/bin/bash
DIR="/home/brayan-cortes/Imágenes/fondos de pantalla"
TEMAS=("black clover anime" "toyota supra anime" "nissan gtr art" "samurai anime")
while true; do
    TEMA=${TEMAS[$RANDOM % ${#TEMAS[@]}]}
    LINKS=$(python3 -c "import urllib.request, json, sys; 
req = urllib.request.Request(f'https://wallhaven.cc/api/v1/search?q={sys.argv[1]}&categories=010&purity=100&sorting=random', headers={'User-Agent': 'Mozilla/5.0'});
try:
    with urllib.request.urlopen(req) as resp:
        data = json.loads(resp.read());
        for x in data['data'][:5]: print(x['path'])
except: pass" "$TEMA")
    for URL in $LINKS; do
        wget -q "$URL" -P "$DIR/"
    done
    ls -t "$DIR" | tail -n +21 | xargs -I {} rm "$DIR/{}" 2>/dev/null
    sleep 600
done
EOF

chmod +x "$DIR_SCRIPTS"/*.sh

# 3. Kill and Restart
pkill -9 -f rotar_solo.sh
pkill -9 -f descargar_solo.sh
nohup bash "$DIR_SCRIPTS/rotar_solo.sh" > /dev/null 2>&1 &
nohup bash "$DIR_SCRIPTS/descargar_solo.sh" > /dev/null 2>&1 &

echo "Setup Finished. Images in folder: $(ls "$DIR_FONDOS" | wc -l)"
