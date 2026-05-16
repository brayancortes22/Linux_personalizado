#!/bin/bash
# SIMPLIFIED DOWNLOADER
DIR_FONDOS="/home/brayan-cortes/Imágenes/fondos de pantalla"
LOG="/home/brayan-cortes/Imágenes/scripts_fondo/fondo_engine.log"
TEMAS=("black clover" "supercars" "samurai" "cyberpunk" "technology")
TEMA=${TEMAS[$RANDOM % ${#TEMAS[@]}]}

echo "$(date): DL START $TEMA" >> "$LOG"

# Timeout python to prevent hanging
LINKS=$(timeout 15s python3 -c "import urllib.request, json, sys; 
req = urllib.request.Request(f'https://wallhaven.cc/api/v1/search?q={sys.argv[1]}&categories=111&purity=100&sorting=random', headers={'User-Agent': 'Mozilla/5.0'});
try:
    with urllib.request.urlopen(req, timeout=10) as resp:
        data = json.loads(resp.read());
        for x in data['data'][:3]: print(x['path'])
except: pass" "$TEMA")

if [ -n "$LINKS" ]; then
    for URL in $LINKS; do
        wget -q -T 10 -t 1 "$URL" -P "$DIR_FONDOS/"
    done
fi

# Clean old images
ls -t "$DIR_FONDOS"/*.{jpg,jpeg,png} 2>/dev/null | tail -n +16 | xargs -I {} rm "{}" 2>/dev/null
echo "$(date): DL END" >> "$LOG"
