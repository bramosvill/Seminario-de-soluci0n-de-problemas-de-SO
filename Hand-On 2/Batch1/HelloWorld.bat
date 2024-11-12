@echo off
echo Hello World
echo.
echo Listado del contenido del directorio actual:
dir
echo.
echo Creando el subdirectorio 'Test'...
mkdir Test
echo.
echo Cambiando al subdirectorio 'Test'...
cd Test
echo.
echo Listado del contenido en el subdirectorio 'Test':
dir
cd ..
echo.
pause
