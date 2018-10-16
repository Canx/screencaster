#!/bin/bash
# $1: titulo para la cabecera

imagefile="cabecera.png"
tempfile="/tmp/cabecera.mp4"
outputfile="cabecera.mp4"
title=$1
size="1920x1080" # tenemos que obtener la resolución del video ($1)
#font="/usr/share/fonts/truetype/ubuntu/Ubuntu-C.ttf"
font="/usr/share/fonts/truetype/freefont/FreeSans.ttf"
fontsize=48
fontcolor="white"
framerate=10 # tenemos que obtener el framerate del video ($1)

if [ -f $outputfile ] ; then
    rm $outputfile
fi
if [ -f $tempfile ] ; then
    rm $tempfile
fi
# Añadimos cabecera de inicio
ffmpeg -loop 1 -i $imagefile -c:v libx264 -r $framerate -t 3 -pix_fmt yuv420p -vf scale=$size $tempfile

# Añadimos el texto
ffmpeg -i $tempfile -vf drawtext="fontfile=$font: \
text='$title': fontcolor=$fontcolor: fontsize=$fontsize: box=1: boxcolor=black@0.5: \
boxborderw=10: x=(w-text_w)/2: y=(h-text_h)/2" -codec:a copy $outputfile
