#!/bin/bash
# Grabar archivo a la vez que hacemos multicast y grabar audio también!!!
size=$(xwininfo -root | grep "geometry" | tr -s ' ' | cut -d ' ' -f 3 | cut -d '+' -f1)
font="/usr/share/fonts/truetype/ubuntu/Ubuntu-C.ttf"
filename="salida.mp4"
name="salida"
ext="mp4"
framerate=10
URL="udp://239.0.0.1:1234/"

i=1
filename="${name}.${ext}"
while [ -f $filename ] ; do
    let i+=1
    filename="${name}-${i}.${ext}"
done

zenity --info --text "Preparate para grabar!"

now=$(date +"%m_%d_%Y")
ffmpeg -f x11grab -video_size $size -framerate $framerate -thread_queue_size 512 -i $DISPLAY -f pulse -i default -acodec libmp3lame -tune zerolatency -c:v libx264 -x264-params keyint=10:min_keyint=1 -pix_fmt yuv420p -threads 0 -f tee -map 0:v -map 1:a "${filename}|[f=mpegts]${URL}"
