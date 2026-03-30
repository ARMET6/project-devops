import boto3
import sys

def main():
    if len(sys.argv) < 2:
        print("Error: Faltan parámetros. Uso: python3 gestionar_ec2.py [listar|iniciar|detener] [instance_id]")
        sys.exit(1)

    accion = sys.argv[1]
    ec2 = boto3.client('ec2', region_name='us-east-1')

    try:
        if accion == "listar":
            response = ec2.describe_instances()
            for reservation in response['Reservations']:
                for instance in reservation['Instances']:
                    print(f"ID: {instance['InstanceId']} - Estado: {instance['State']['Name']}")
