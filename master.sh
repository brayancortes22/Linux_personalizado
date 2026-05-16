#!/bin/bash
# MASTER SCRIPT
DIR="/home/brayan-cortes/Imágenes/scripts_fondo"
bash "$DIR/rotar_solo.sh" &
bash "$DIR/descargar_solo.sh" &
wait
