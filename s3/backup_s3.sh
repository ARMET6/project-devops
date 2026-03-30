#!/bin/bash

# Validar parámetros
if [ "$#" -ne 2 ]; then
    echo "Error: Se requieren 2 parámetros. Uso: $0 <directorio> <bucket>"
    exit 1
fi

DIRECTORIO=$1
BUCKET=$2
FECHA=$(date +%Y%m%d_%H%M%S)
ARCHIVO_ZIP="backup_${FECHA}.tar.gz"
LOG_FILE="logs/backup.log"

# Comprimir archivos
echo "[${FECHA}] Iniciando respaldo del directorio ${DIRECTORIO}" >> $LOG_FILE
tar -czf $ARCHIVO_ZIP $DIRECTORIO 2>> $LOG_FILE
