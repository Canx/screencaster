#!/bin/bash
# Grabar video y audio de la pantalla
size=$(xwininfo -root | grep "geometry" | tr -s ' ' | cut -d ' ' -f 3 | cut -d '+' -f1)
font="/usr/share/fonts/truetype/ubuntu/Ubuntu-C.ttf"
name="salida"
ext="mp4"
framerate=24

i=1
filename="${name}.${ext}"
while [ -f $filename ] ; do
    let i+=1
    filename="${name}-${i}.${ext}"
done

zenity --info --text "Preparate para grabar!"

/usr/bin/ffmpeg -f x11grab -s "1920x1080" -i ${DISPLAY} -r ${framerate} -f pulse -ac 2 -i default ${filename}
