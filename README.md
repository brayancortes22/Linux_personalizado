# Linux Wallpaper Engine

Automatic wallpaper rotation and downloader for GNOME.

## Features
- **Rotation**: Changes wallpaper every 10 seconds.
- **Downloader**: Fetches high-quality themed images (Anime, Cars, Tech) from Wallhaven every 30-60 seconds.
- **Auto-Cleanup**: Keeps only the 20 most recent images to save space.

## Files
- `rotar_solo.sh`: Handles the wallpaper rotation logic.
- `descargar_solo.sh`: Handles the fetching of new images.
- `master.sh`: Controller script.

## Setup
1. Move scripts to `~/Imágenes/scripts_fondo`.
2. Run `nohup bash rotar_solo.sh &` and `nohup bash descargar_solo.sh &`.
