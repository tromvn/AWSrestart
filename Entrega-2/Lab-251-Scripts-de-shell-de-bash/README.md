---
title: "Lab 251: Scripts de BASH shell"
parent: Entrega 2
nav_order: 6
---

# Lab 251: Scripts del intérprete de comandos bash

## Objetivos

En este laboratorio, hará lo siguiente:

* Crear un script de bash que automatizará el respaldo de una carpeta.

### Tarea 1: conectarse a una instancia de EC2 de Amazon Linux mediante SSH.

Como en labs anteriores, descargo desde "details" la ip y el archivo .pem, le coloco el nombre del lab: labxxx.pem y accedo por SSH con el comando: 

```bash
$ chmod 400 labxxx.pem
$ ssh -i labxxx.pem ec2-user@ip-from-details 

# Responder 'yes' en la 1ra conexión.
```

### Tarea 2: escribir un script del intérprete de comandos

1. Crear archivo 'backup' y darle permisos (755)
   
    ![](src/1-crear-backup.png)

2. Editar script en vi
   
    ![](src/2-editar-script.png)

3. Tuve un error en el output
   
    ![](src/4-error-output.png)

4. Descubrí el error y corregí
   
    ![](src/3-error-en-script.png)

5. Output esperado
   
    ![](src/5-output-esperado.png)

6. Se creó el backup
   
    ![](src/6-se-creo-backup.png)