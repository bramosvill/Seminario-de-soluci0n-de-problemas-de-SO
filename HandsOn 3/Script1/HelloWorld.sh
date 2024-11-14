#!/bin/bash

# Imprimir "Hello World" en pantalla
echo "Hello World"

# Listar el contenido del directorio actual
echo "Listando contenido del directorio actual:"
ls

# Crear un directorio llamado Test
echo "Creando directorio Test..."
mkdir Test

# Cambiarse al directorio Test
cd Test

# Listar el contenido del directorio Test (estará vacío al principio)
echo "Listando contenido del directorio Test:"
ls

# Volver al directorio anterior
cd ..
