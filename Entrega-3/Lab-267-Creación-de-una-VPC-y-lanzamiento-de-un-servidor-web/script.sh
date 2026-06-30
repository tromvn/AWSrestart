#!/bin/bash

# 1. Actualizar repositorios e instalar Apache, PHP y el motor de Base de Datos (MariaDB)
yum update -y
yum install -y httpd php mariadb105-server

# 2. Descargar archivos del laboratorio
wget https://aws-tc-largeobjects.s3.us-west-2.amazonaws.com/CUR-TF-100-RESTRT-1/267-lab-NF-build-vpc-web-server/s3/lab-app.zip
unzip lab-app.zip -d /var/www/html/

# 3. Habilitar y encender el servidor web (Apache)
systemctl enable httpd
systemctl start httpd

# 4. Habilitar y encender el motor de base de datos (MariaDB/MySQL)
systemctl enable mariadb
systemctl start mariadb
