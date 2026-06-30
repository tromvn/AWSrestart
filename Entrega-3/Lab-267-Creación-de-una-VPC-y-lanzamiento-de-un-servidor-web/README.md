---
title: "Lab 267: Creación de una VPC y lanzamiento de un servidor web"
parent: Entrega 3
nav_order: 3
---
# Lab 267: Creación de una VPC y lanzamiento de un servidor web

## Objetivos

Después de completar este módulo, podrá hacer lo siguiente:

1. Crear una nube virtual privada (VPC)
2. Crear subredes
3. Configurar un grupo de seguridad
4. Lanzar una instancia de Amazon Elastic Compute Cloud (Amazon EC2) en la VPC

## Situación

En este laboratorio, deberá utilizar Amazon Virtual Private Cloud (VPC) para crear su propia VPC y agregar componentes adicionales con el fin de producir una red personalizada para una gran empresa. Además, creará grupos de seguridad para la instancia de EC2. Deberá configurar y personalizar una instancia de EC2 para ejecutar un servidor web y lanzarla en la VPC que se parece al siguiente diagrama del cliente:

* Arquitectura

	![](src/1-arquitectura.png)

### Tarea 1: Crear una VPC

1. Consola VPC con dos subnets: Public Subnet 1 y Private Subnet 1

	![](src/2-crear-vpc.png)
	
2. Configurar VPC a crear

	![](src/3-config-vpc.png)
	
	![](src/4-config-vpc2.png)
	
	![](src/5-config-vpc3.png)
	
	![](src/6-etiquetar-preview-vpc.png)
	
	![](src/7-crear-vpc.png)
	
3. Ver VPC

	![](src/8-ver-vpc.png)
	
	![](src/9-dashboard-vpc.png)
	
### Tarea 2: Crear subredes adicionales

	
4. Crear Subredes Public 2 y Private 2

	* Public Subnet 2
	
		![](src/10-crear-subred.png)
	
		![](src/11-subred-vpc.png)
	
		![](src/12-subred-publica-vpc2.png)
	
	* Private Subnet 2
	
		![](src/13-subred-privada-vpc.png)
	
		![](src/14-subred-privada-vpc2.png)
		
### Tarea 3: asociar las subredes y agregar rutas
	
5. Tablas de enrutamiento

	* Asociar Public Route Table a las subredes públicas

		![](src/15-route-table.png)
	
		![](src/16-route-table2.png)
	
	* Asociar Private Route Table a las subredes privadas
	
		![](src/17-route-table3.png)
		
		![](src/18-route-table4.png)
		
### Tarea 4: crear un grupo de seguridad de VPC
		
6. Crear SG

	![](src/19-SG.png)	

	![](src/20-SG2.png)
	
	![](src/21-SG2.png)
	
### Tarea 5: lanzar una instancia de servidor web
	
7. Lanzar instancia. Aquí la idea era lanzarla en una subred pública, pero me equivoqué

	![](src/22-instancia.png)
	
	![](src/23-instancia2.png)
	
	![](src/24-instancia3.png)
	
	![](src/25-instancia4.png)
	
	* Aquí está el error que no vi, asocié Private Subnet 1, en lugar de Public
	
		![](src/26-instancia5.png)
		
	* Aquí hay otro error, pero por la desactualización del laboratorio, porque su script no funciona para Amazon Linux 3
	
		![](src/27-instancia6.png)
		
		![](src/28-instancia7.png)
		
	* Sin darme cuenta de estos dos factores, continué
	
	![](src/29-instancia8.png)
	
	![](src/30-instancia9.png)


* Problema. Una vez obtuve la DNS pública de la instancia, probé a entrar en el navegador y no funcionaba. No podía acceder con el DNS ni con la IP pública. En navegador: conexión caduca; por terminal con ping: escuchando eternamente.
	Entonces, revisé nuevamente las configuraciones y también me conecté por SSH a la instancia. Entonces, di con los descubrimientos que mostré más arriba. Terminé la instancia y creé otra con la configuración correcta. El paquete mysql ya no existía en los repositorios. Investigué y llegué a un nuevo script:

```
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

```

* Aquí parte del proceso. 

	![](src/31-problema-instancia.png)
	
	![](src/32-problema-instancia.png)
	
	![](src/33-problema-instancia.png)
	
	![](src/34-problema-instancia-solucionado.png)