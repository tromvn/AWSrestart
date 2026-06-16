---
title: "Lab 235: Trabajo con archivos"
parent: Entrega 1
nav_order: 8
---
# Trabajo con archivos

## Objetivos

En este laboratorio, hará lo siguiente:

1. Usar tar para crear un archivo de respaldo de toda la estructura de carpetas.
2. Registrar la creación del archivo de respaldo en un archivo con fecha, hora y nombre.
3. Transferir el archivo de respaldo a otra carpeta.

### Tarea 1: conectarse a una instancia de EC2 de Amazon Linux mediante SSH.

1. Creando directorios del lab.
   ![](src/1-preparar-directorio.png)

2. Obtener credenciales. Copio la IP y, como estoy en Linux, descargo el archivo .pem.
   ![](src/2-credenciales.png)

**nota: por defecto el nombre del archivo es labsuser.pem y yo lo cambio a lab-[n°-de-lab].pem para guardarlo en su respectiva carpeta**

2. Aquí detallo la conexión por SSH:
   ![](src/3-acceso-ssh.png)

### Tarea 2: crear un respaldo

En esta tarea, creará un respaldo de una estructura de archivos completa. 

El entorno de trabajo tiene la siguiente estructura de carpetas:
![](src/folder_structure.png)

1. Revisar directorios.
   ![](src/4-revisar-directorios.png)

2. Comprimir y revisar
   ![](src/5-comprimir-y-revisar.png)

### Tarea 3: registrar el respaldo

En esta tarea, creará un archivo para registrar la fecha, la hora y el nombre del archivo de respaldo tar que creó. Este archivo indica cuándo se crearon los respaldos y podría ser útil para evitar crear respaldos innecesarios en el futuro.

1. Crear log y revisar
   ![](src/6-crear-log-y-revisar-png.png)

### Tarea 4: Trasladar el archivo de respaldo

En esta tarea, se transfiere el archivo de respaldo a la carpeta IA (Acceso poco frecuente). En una situación real, podría seguir estos pasos para que otro usuario o equipo que no tenga acceso a la carpeta donde creó el archivo de respaldo pueda acceder al archivo.

1. Mover backup
   ![](src/7-mover-backup.png)



#### Impresiones

Debería hacer más backups en algún servidor local y no confiar tanto en las nubes de almacenamiento. Quién sabe.
