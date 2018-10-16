#!/bin/bash
# $1: tiempo a recortar
# $2: archivo a recortar

trim_start=0
trim_end=$1
file=$2


duration=$(ffmpeg -i "${file}" 2>&1 | grep "Duration"| cut -d ' ' -f 4 | sed s/,//)
length=$(echo "$duration" | awk '{ split($1, A, ":"); print 3600*A[1] + 60*A[2] + A[3] }' )
trim_end=$(echo "$length" - $trim_end - $trim_start | bc)

mv $file "$file.temp"
ffmpeg -ss "$trim_start" -i "${$file}.temp" -c copy -map 0 -t "$trim_end" "${file}"
rm "$file.temp"
