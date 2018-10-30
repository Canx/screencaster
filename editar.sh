#!/bin/bash
if [ -z "$1" ]
  then
    echo "Debes indicar el nombre del archivo de video!"
    exit 1
fi

if [ ! -f $1 ]; then
    echo "Archivo no encontrado!"
    exit 1
fi

filename=$(basename -- "$1")
extension="${filename##*.}"
filename="${filename%.*}"

# $1: archivo a editar
titulo=$(zenity --entry --title="Grabación" --text="Introduce el titulo del video:")

# Aquí tenemos que recortar los últimos segundos
#echo "Recortando archivo..."
#./recortar.sh 4 $1

# Añadimos cabecera de inicio
echo "Creando cabecera..."
./cabecera.sh "$titulo"

# Concatenamos cabecera
echo "Concatenando cabecera..."
./concatenar.sh "cabecera.mp4" "$1" "${filename}_editado.${extension}"
