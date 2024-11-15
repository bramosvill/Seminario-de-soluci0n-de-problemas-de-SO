#!/bin/bash

# Función para listar 
listar_contenido() {
    echo "Introduce la ruta absoluta del directorio:"
    read ruta
    if [ -d "$ruta" ]; then
        echo "Contenido del directorio $ruta:"
        ls -l "$ruta"
    else
        echo "Error: $ruta no es un directorio válido."
    fi
}

# Función archivo de texto 
crear_archivo() {
    echo "Introduce el texto que deseas almacenar en el archivo:"
    read texto
    echo "$texto" > archivo.txt
    echo "Archivo creado con el siguiente contenido: $texto"
}

# Función para comparar 
comparar_archivos() {
    echo "Introduce la ruta del primer archivo para comparar:"
    read archivo1
    echo "Introduce la ruta del segundo archivo para comparar:"
    read archivo2
    if [ -f "$archivo1" ] && [ -f "$archivo2" ]; then
        diff "$archivo1" "$archivo2"
    else
        echo "Error: Uno o ambos archivos no existen."
    fi
}

# Función  awk
usar_awk() {
    echo "Introduce el nombre de un archivo para procesarlo con AWK:"
    read archivo
    if [ -f "$archivo" ]; then
        echo "Ejecutando AWK en el archivo $archivo..."
        awk '{ print $0 }' "$archivo"
    else
        echo "Error: El archivo $archivo no existe."
    fi
}

# Función grep
usar_grep() {
    echo "Introduce el nombre de un archivo para buscar con GREP:"
    read archivo
    echo "Introduce el patrón a buscar en el archivo:"
    read patron
    if [ -f "$archivo" ]; then
        echo "Buscando '$patron' en el archivo $archivo..."
        grep "$patron" "$archivo"
    else
        echo "Error: El archivo $archivo no existe."
    fi
}

# Menú principal
while true; do
    clear
    echo "Seleccione una opción:"
    echo "1) Listar contenido de un directorio"
    echo "2) Crear un archivo de texto con una línea de texto"
    echo "3) Comparar dos archivos de texto"
    echo "4) Mostrar uso de AWK"
    echo "5) Mostrar uso de GREP"
    echo "6) Salir"
    read -p "Opción: " opcion

    case $opcion in
        1) listar_contenido ;;
        2) crear_archivo ;;
        3) comparar_archivos ;;
        4) usar_awk ;;
        5) usar_grep ;;
        6) echo "Saliendo del script..."; break ;;
        *) echo "Opción no válida. Por favor, seleccione una opción del 1 al 6." ;;
    esac

    # Pausar antes de mostrar nuevamente el menú
    read -p "Presione Enter para continuar..."
done
