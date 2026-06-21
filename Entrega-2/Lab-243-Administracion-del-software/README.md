---
title: "Lab 243: Administración de software"
parent: Entrega 2
nav_order: 2
---

# Lab 243: Administración de software

## Objetivos

En este laboratorio, hará lo siguiente:

1. Actualizar la máquina de Linux mediante el administrador de paquetes.
2. Recuperar o revertir a una versión anterior un paquete previamente actualizado mediante el administrador de paquetes.
3. Instalar la Interfaz de la línea de comandos de AWS (AWS CLI)

### Tarea 1: conectarse a una instancia de EC2 de Amazon Linux mediante SSH.

Como en labs anteriores, descargo desde "details" la ip y el archivo .pem, le coloco el nombre del lab: labxxx.pem y accedo por SSH con el comando: 

```bash
$ chmod 400 labxxx.pem
$ ssh -i labxxx.pem ec2-user@ip-from-details 

# Responder 'yes' en la 1ra conexión.
```

### Tarea 2: actualizar la máquina de Linux

1. Consulta de paquetes
   
    ![](src/2-consulta-paquetes.png)

2. Actualizar repositorios de seguridad
   
    ![](src/3-actualizaciones-seguridad.png)

3. Actualizar paquetes
   
    ![](src/4-upgrade.png)

4. Instalación de httpd
   
    ![](src/5-httpd.png)
   
    ![](src/6-httpd2.png)
   
    ![](src/7-httpd3.png)

### Tarea 3: restaurar un paquete

1. Historial de yum
   
    ![](src/8-yum-history.png)

2. Detalle de paquete en historial de yum
   
    ![](src/9-yum-history-detail.png)

3. Deshacer instalación del paquete con ID 1 en el historial
   
    ![](src/10-yum-undo.png)
   
    ![](src/11-yum-undo2.png)
   
    ![](src/12-yum-undo3.png)

### Tarea 4: instalar la AWS CLI en Red Hat Linux

1. Revisar versión de python. Aquí entendí que python refiere a python2, entonces especifico python3
   
    ![](src/13-versiones-python.png)

2. Descargar paquete con curl
   
    ![](src/14-curl.png)

3. Descomprimir con unzip
   
    ![](src/16-unzip.png)

4. Ejecutar script de instalación
   
    ![](src/15-instalar-aws-cli.png)

### Tarea 5: configurar la AWS CLI para conectarse a la cuenta de AWS

1. help de aws cli
   
    ![](src/17-aws-help.png)

2. Mostrar credenciales
   
    ![](src/18-show-aws.png)
   
    ![](src/19-aws-credentials.png)

3. Crear archivo credentials. Desde aquí cometí un error por crear el directorio .aws dentro de companyA
   
    ![](src/20-touch-credentials.png)

4. Pegar credenciales en .aws/credentials
   
    ![](src/21-nano-credentials.png)

5. Cargar credenciales en aws cli (vista de cómo llenar los cuatro campos)
   
    ![](src/22-aws-configure.png)
   
   * Aquí, credenciales inválidas
     
        ![](src/23-credenciales-invalidas.png) 
     
     Entendí que creé el directorio y archivo .aws/credentials dentro de companyA/ 
     Procedí del siguiente modo: 
     
     ```
     [ec2-user@ip-10-0-10-45 companyA]$ mv .aws/ ..   
     mv: cannot move '.aws/' to '../.aws': File exists # Es decir, ya existía el directorio desde la instalación y no lo noté.  
     [ec2-user@ip-10-0-10-45 companyA]$ rm -r .aws/ # Simplementé eliminé el directorio  
     [ec2-user@ip-10-0-10-45 companyA]$ cd ../.aws # Para dirigirme a $HOME/.aws y desde ahí repetir los pasos 3 a 5.
     ```

6. Entrar en consola AWS y buscar EC2
   
    ![](src/25-ec2-recursos.png)

7. Copiar ID de la instancia
   
    ![](src/26-id-instancia.png)

8. ID copiada
   
    ![](src/27-guardar-id.png)

9. Configurar tipo de la instancia en JSON
   
    ![](src/28-instancia-json.png)