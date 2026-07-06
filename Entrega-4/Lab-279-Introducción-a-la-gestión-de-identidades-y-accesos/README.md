---
title: "Lab 279: Introducción a AWS Identity and Access Management"
parent: Entrega 4
nav_order: 2
---
# Lab 279: Introducción a AWS Identity and Access Management (IAM)

En muchos entornos de negocios, el acceso involucra un inicio de sesión único en un equipo o una red de sistemas que proporciona al usuario acceso a todos los recursos de la red. Este acceso incluye los derechos a los archivos personales y compartidos en un servidor de red, intranet de empresas, impresoras y otros recursos y dispositivos de red. Los usuarios no autorizados pueden explotar rápidamente estos mismos recursos si el control de acceso y los procedimientos de autenticación asociados no están configurados correctamente.

En este laboratorio, explorará los usuarios, grupos de usuarios y políticas en el servicio AWS Identity and Access Management (IAM).
Objetivos

**Después de completar este laboratorio, podrá realizar lo siguiente:**

1. Crear y aplicar una política de contraseñas de IAM
2. Analizar usuarios y grupos de usuarios de IAM creados previamente
3. Inspeccionar políticas de IAM según se apliquen a los grupos de usuarios creados previamente
4. Agregar usuarios a grupos de usuario con capacidades específicas activas
5. Ubicar y usar la URL de inicio de sesión de la IAM
6. Probar los efectos de las políticas en el acceso a los servicios

* Este es un diagrama del entorno actual con los usuarios de IAM y los grupos de IAM.

	![](src/1-diagrama-usuarios-grupos.png)

IAM

* **IAM se puede usar para lo siguiente:**


```
Administrar usuarios de IAM y su acceso: puede crear usuarios y asignarles credenciales de seguridad individuales (claves de acceso, contraseñas y dispositivos con Multi-Factor Authentication). Puede administrar los permisos para controlar qué operaciones puede realizar cada usuario.
    Administrar roles de IAM y sus permisos: un rol de IAM es similar a un usuario, ya que un rol es una identidad de AWS con políticas de permisos que establecen qué puede hacer o no la identidad en Amazon Web Services (AWS). Sin embargo, en lugar de estar asociado únicamente a una persona, el objetivo es que cualquiera que necesite el rol pueda asumirlo.

  Administrar usuarios federados y sus permisos: puede activar la identidad federada a fin de permitir que los usuarios existentes de su empresa puedan acceder a la Consola de administración de AWS, llamar a las interfaces de programación de aplicaciones (API) de AWS y acceder a los recursos sin necesidad de crear un usuario de IAM para cada identidad.
```


### Tarea 1: Crear una política de contraseña de cuenta

En esta tarea, creará una política de contraseña personalizada para su cuenta de AWS. Esta política afecta a todos los usuarios asociados con la cuenta.

1. Panel de IAM

	![](src/2-iam.png)
	
2. Editar política de contraseña

	![](src/3-editar-politica-contraseña.png)
	
	![](src/4-password-config.png)
	
#### Resumen de la Tarea 1

En esta tarea, fortaleció los requisitos de la contraseña al crear una política de contraseñas predeterminada. Las varias opciones de contraseña que seleccionó ahora han hecho que las contraseñas que los usuarios crearán sean mucho más difíciles de vulnerar.


### Tarea 2: Analizar los usuarios y los grupos de usuarios

En esta tarea, analizará los usuarios y grupos de usuarios que ya se crearon para usted en IAM.

3. Usuarios de IAM, revisando políticas asociadas (aún ninguna)

	![](src/5-user1.png)
	
	![](src/6-user1-summary.png)
	
	![](src/7-user1-groups.png)
	
	![](src/8-user1-credential.png)
	

4. Revisando grupos de IAM

	![](src/9-groups.png)
	
	![](src/10-ec2support-permisions.png)
	
	![](src/11-ec2support-permisions2.png)
	
	![](src/12-s3support.png)
	
	![](src/13-s3support-summary.png)
	
	![](src/14-ec2admin.png)
	
	![](src/15-ec2admin-permissions.png)
	
	![](src/16-ec2admin-permissions2.png)

#### Resumen de la Tarea 2

En esta tarea, pudo ver usuarios creados previamente, junto con los grupos de usuarios creados previamente. Aprendió acerca de las políticas adjuntos a los grupos de usuarios y cuáles son las diferencias entre los grupos de usuarios y sus permisos.

##### Situación empresarial

Durante el resto del laboratorio, trabajará con estos usuarios y grupos de usuarios para activar los permisos que admiten el siguiente caso empresarial:

Nuestra empresa está ampliando el uso de AWS y utiliza muchas instancias de EC2 y un gran volumen de almacenamiento de Amazon S3. Usted desea otorgar acceso a los nuevos miembros del personal según su función laboral:
Usuario	En un grupo	Permisos
user-1	S3-Support	Read-only access to Amazon S3 (Acceso de solo lectura a Amazon S3)
user-2	EC2-Support	Read-only access to Amazon S3 (Acceso de solo lectura a Amazon EC2)
user-3	EC2-Admin	Ver, iniciar y detener instancias EC2


### Tarea 3: Agregar usuarios a los grupos de usuarios

Recientemente contrató a user-1 para un rol que brindará soporte a Amazon S3. Lo agregará al grupo S3-Support para que pueda heredar los permisos necesarios mediante la política AmazonS3ReadOnlyAccess adjunta.

5. Agregar usuarios

	![](src/17-add-users.png)
	
	![](src/18-add-user1.png)

6. Agregar a user-2 al grupo EC2-Support.

	![](src/19-add-users-2.png)
	
	![](src/20-add-user2.png)
	
7. Agregar a user-3 al grupo EC2-Admin

	![](src/21-add-users-3.png)
	
	![](src/22-add-user3.png)
	
	
8. Usuarios agregados

	![](src/23-usuarios-agregados.png)


#### Resumen de la Tarea 3

En esta tarea, agregó todos los usuarios asociados a los grupos de usuarios. 


### Tarea 4: Iniciar sesión y probar permisos de usuarios

En esta tarea, probará los permisos de cada usuario de IAM.

9. URL de inicio de sesión

	![](src/24-url-inicio-sesion.png)
	
10. Login de user-1, autorizado para S3

	![](src/25-login1.png)
	
	![](src/25-s3-dashboard.png)
	
	* No autorizado a manipular EC2

		![](src/26-user1-ec2-not-authorized.png)
		
	![](src/27-logout.png)

11. Login de user-2, en principio no visible por región

	![](src/28-user2-ec2-no-visible.png)
	
	![](src/29-detener-instancia.png)
	
	* Tampoco autorizado a detener la instancia, sólo observarla
	
		![](src/30-not-authorized.png)
	
12. Login de user-3, admin

	![](src/31-user3-detener-instancia.png)
	
	![](src/32-instancia-detenida.png)


#### Resumen de la Tarea 4

En esta tarea, pudo iniciar sesión como los tres usuarios. Comprobó que user-1 pudo ver los buckets S3 pero no pudo ver las instancias de EC2. Luego inició sesión como user-2 y comprobó que pudo ver las instancias de EC2 pero no pudo realizar la acción de detención de instancia. user-2 tampoco pudo ver los buckets S3. Después de iniciar sesión como user-3, pudo ver las instancias de EC2 y realizar la acción de detención de instancia.

