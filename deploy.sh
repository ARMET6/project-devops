#!/bin/bash

# Cargar variables de configuración
source config/config.env

ACCION=$1

if [ -z "$ACCION" ]; then
    echo "Uso: ./deploy.sh [iniciar|detener]"
    exit 1
fi

LOG_FILE="logs/deploy.log"
FECHA=$(date +%Y-%m-%d\ %H:%M:%S)

echo "[$FECHA] Iniciando pipeline CI/CD simulado..." | tee -a $LOG_FILE

# 1. Ejecutar script Python (Gestión EC2)
echo "[$FECHA] Ejecutando gestión EC2: $ACCION en $INSTANCE_ID" | tee -a $LOG_FILE
python3 ec2/gestionar_ec2.py $ACCION $INSTANCE_ID | tee -a $LOG_FILE

# 2. Ejecutar script Bash (Respaldo S3)
echo "[$FECHA] Ejecutando respaldo en S3 del directorio $DIRECTORY al bucket $BUCKET_NAME" | tee -a $LOG_FILE
bash s3/backup_s3.sh $DIRECTORY $BUCKET_NAME

echo "[$FECHA] Pipeline finalizado." | tee -a $LOG_FILE
