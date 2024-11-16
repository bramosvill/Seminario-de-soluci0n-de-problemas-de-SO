#!/bin/bash

# Verificar  VBoxManage 
if ! command -v VBoxManage &> /dev/null
then
    echo "Error: VBoxManage no está instalado o no está en el PATH."
    exit 1
fi

# Verificar argumentos
if [ "$#" -ne 8 ]; then
    echo "Uso: $0 <Nombre_VM> <Tipo_OS> <Num_CPUs> <Memoria_RAM_GB> <VRAM_MB> <Tam_Disco_GB> <Nombre_Controlador_SATA> <Nombre_Controlador_IDE>"
    echo "Ejemplo: $0 MiVM Linux_64 2 4 128 50 SATA_Controller IDE_Controller"
    exit 1
fi

# argumentos a variables
NOMBRE_VM="$1"
TIPO_OS="$2"
NUM_CPUS="$3"
MEM_RAM_GB="$4"
VRAM_MB="$5"
TAM_DISCO_GB="$6"
NOMBRE_SATA="$7"
NOMBRE_IDE="$8"

# Crear la máquina virtual
echo "Creando la máquina virtual '$NOMBRE_VM' con sistema operativo '$TIPO_OS'..."
VBoxManage createvm --name "$NOMBRE_VM" --ostype "$TIPO_OS" --register
if [ $? -ne 0 ]; then
    echo "Error: No se pudo crear la máquina virtual."
    exit 1
fi
echo "Máquina virtual '$NOMBRE_VM' creada exitosamente."

# CPUs
echo "Configurando el número de CPUs a $NUM_CPUS..."
VBoxManage modifyvm "$NOMBRE_VM" --cpus "$NUM_CPUS"
if [ $? -ne 0 ]; then
    echo "Error: No se pudo configurar el número de CPUs."
    exit 1
fi
echo "Número de CPUs configurado a $NUM_CPUS."

#RAM
MEM_RAM_MB=$((MEM_RAM_GB * 1024))
echo "Configurando la memoria RAM a $MEM_RAM_GB GB ($MEM_RAM_MB MB)..."
VBoxManage modifyvm "$NOMBRE_VM" --memory "$MEM_RAM_MB"
if [ $? -ne 0 ]; then
    echo "Error: No se pudo configurar la memoria RAM."
    exit 1
fi
echo "Memoria RAM configurada a $MEM_RAM_GB GB."

# memoria de video (VRAM)
echo "Configurando la memoria de video a $VRAM_MB MB..."
VBoxManage modifyvm "$NOMBRE_VM" --vram "$VRAM_MB"
if [ $? -ne 0 ]; then
    echo "Error: No se pudo configurar la memoria de video."
    exit 1
fi
echo "Memoria de video configurada a $VRAM_MB MB."

# Crear disco duro virtual
DISCO_VDI="$NOMBRE_VM.vdi"
TAM_DISCO_MB=$((TAM_DISCO_GB * 1024))
echo "Creando disco duro virtual de $TAM_DISCO_GB GB ($TAM_DISCO_MB MB)..."
VBoxManage createhd --filename "$DISCO_VDI" --size "$TAM_DISCO_MB" --format VDI
if [ $? -ne 0 ]; then
    echo "Error: No se pudo crear el disco duro virtual."
    exit 1
fi
echo "Disco duro virtual creado: $DISCO_VDI."

#controlador SATA
echo "Creando controlador SATA '$NOMBRE_SATA'..."
VBoxManage storagectl "$NOMBRE_VM" --name "$NOMBRE_SATA" --add sata --controller IntelAHCI
if [ $? -ne 0 ]; then
    echo "Error: No se pudo crear el controlador SATA."
    exit 1
fi
echo "Controlador SATA '$NOMBRE_SATA' creado."

# Adjuntar el disco duro al controlador SATA
echo "Adjuntando el disco duro al controlador SATA '$NOMBRE_SATA'..."
VBoxManage storageattach "$NOMBRE_VM" --storagectl "$NOMBRE_SATA" --port 0 --device 0 --type hdd --medium "$DISCO_VDI"
if [ $? -ne 0 ]; then
    echo "Error: No se pudo adjuntar el disco duro al controlador SATA."
    exit 1
fi
echo "Disco duro adjuntado al controlador SATA '$NOMBRE_SATA'."

# Crear el controlador IDE
echo "Creando controlador IDE '$NOMBRE_IDE'..."
VBoxManage storagectl "$NOMBRE_VM" --name "$NOMBRE_IDE" --add ide
if [ $? -ne 0 ]; then
    echo "Error: No se pudo crear el controlador IDE."
    exit 1
fi
echo "Controlador IDE '$NOMBRE_IDE' creado."

# Adjuntar un dispositivo CD/DVD al controlador IDE (vacío)
echo "Adjuntando dispositivo CD/DVD al controlador IDE '$NOMBRE_IDE'..."
VBoxManage storageattach "$NOMBRE_VM" --storagectl "$NOMBRE_IDE" --port 0 --device 0 --type dvddrive --medium emptydrive
if [ $? -ne 0 ]; then
    echo "Error: No se pudo adjuntar el dispositivo CD/DVD al controlador IDE."
    exit 1
fi
echo "Dispositivo CD/DVD adjuntado al controlador IDE '$NOMBRE_IDE'."

# configuración de la VM
echo ""
echo "Configuración de la Máquina Virtual '$NOMBRE_VM':"
VBoxManage showvminfo "$NOMBRE_VM"

exit 0
