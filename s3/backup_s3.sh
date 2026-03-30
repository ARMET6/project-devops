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

# Subir a S3
echo "[${FECHA}] Subiendo ${ARCHIVO_ZIP} a s3://${BUCKET}/" >> $LOG_FILE
aws s3 cp $ARCHIVO_ZIP s3://${BUCKET}/ >> $LOG_FILE 2>&1

if [ $? -eq 0 ]; then
    echo "[${FECHA}] Respaldo exitoso." >> $LOG_FILE
    rm $ARCHIVO_ZIP # Limpiar archivo local
else
    echo "[${FECHA}] Error en la subida a S3." >> $LOG_FILE
fi
