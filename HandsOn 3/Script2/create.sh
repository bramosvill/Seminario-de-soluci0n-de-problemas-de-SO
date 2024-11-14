#!/bin/bash

# Crear el archivo mytext y agregar la cadena "Hola Mundo"
echo "Hola Mundo" > mytext

# Desplegar el contenido del archivo mytext
echo "Desplegando el contenido de mytext:"
cat mytext

# Crear un directorio llamado backup
echo "Creando directorio backup..."
mkdir backup

# Mover el archivo mytext al directorio backup
echo "Moviendo mytext al directorio backup..."
mv mytext backup/

# Listar el contenido del directorio backup
echo "Listando contenido del directorio backup:"
ls backup

# Eliminar el archivo mytext del directorio backup
echo "Eliminando mytext del directorio backup..."
rm backup/mytext

# Eliminar el directorio backup
echo "Eliminando el directorio backup..."
rmdir backup
