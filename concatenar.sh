#/bin/bash
# $1: archivo 1
# $2: archivo 2
# $3: archivo concatenado
temp1="/tmp/parte1.ts"
temp2="/tmp/parte2.ts"
if [ -f $temp1 ] ; then
    rm $temp1
fi

if [ -f $temp2 ] ; then
    rm $temp2
fi

ffmpeg -i $1 -c copy -bsf:v h264_mp4toannexb -f mpegts $temp1
ffmpeg -i $2 -c copy -bsf:v h264_mp4toannexb -f mpegts $temp2
ffmpeg -i "concat:$temp1|$temp2" -c:v copy -c:a copy $3
