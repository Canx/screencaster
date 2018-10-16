#!/bin/bash

# $1: archivo a editar
cp $1 "$1.backup"
titulo=$(zenity --entry --title="Grabación" --text="Introduce el titulo del video:")

# Aquí tenemos que recortar los últimos segundos
./recortar.sh 4 $1

# Añadimos cabecera de inicio
./cabecera.sh "$titulo"

# Concatenamos cabecera
mv $1 "$1.temp"
./concatenar.sh "cabecera.mp4" "$1.temp" $1
