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
