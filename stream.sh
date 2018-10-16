#!/bin/bash
# Grabar archivo a la vez que hacemos multicast y grabar audio también!!!
size="1920x1080"
font="/usr/share/fonts/truetype/ubuntu/Ubuntu-C.ttf"
filename="salida.mp4"
display=":1"
framerate=10
URL="udp://239.0.0.1:1234/"

zenity --info --text "Preparate para grabar!"

if [ -f $tempfile ] ; then
    rm $tempfile
fi
now=$(date +"%m_%d_%Y")
ffmpeg -f x11grab -s $size -framerate $framerate -i $display -f pulse -i default -acodec libmp3lame -tune zerolatency -c:v libx264 -x264-params keyint=10:min_keyint=1 -pix_fmt yuv420p -s 1280x800 -threads 0 -f tee -map 0:v -map 1:a "${filename}|[f=mpegts]${URL}"
