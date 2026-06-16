---
title: "Lab 229: Usuarios y grupos de Linux"
parent: Entrega 1
nav_order: 5
---
# Administración de usuarios y grupos

## Objetivos

En este laboratorio, hará lo siguiente:

1. Crear usuarios nuevos con una contraseña predeterminada.
2. Crear grupos y asignar los usuarios correspondientes.
3. Iniciar sesión con diferentes usuarios.

### Tarea 1: conectarse a una instancia de EC2 de Amazon Linux mediante SSH.

Obtener credenciales. Copio la IP y, como estoy en Linux, descargo el archivo .pem.

![](src/1-credenciales.png)

**nota: por defecto el nombre del archivo es labsuser.pem y yo lo cambio a lab-[n°-de-lab].pem para guardarlo en su respectiva carpeta**

![](src/2-permisos-y-acceso.png)

Aquí detallo la conexión por SSH:

![](src/4-conectar-por-ssh.png)

### Tarea 2: crear usuarios

![](src/3-tabla-usuarios.png)
![](src/4-crear-primer-usuario.png)

Después me di cuenta que podría haber hecho alias más cortos.
![](src/6-agregando-usuarios.png)

Lo mismo aquí

![](src/7-agregando-contraseñas.png)

crear un alias. 

```
$ alias u='sudo useradd'  
$ alias p='sudo passwd'
```

Luego, simplemente creaba todos los usuarios con: `$ u [username]`

Y después sus claves: `$ p [username`, pegando con ctrl+shift+v la sugerida en la guía, previamente copiada con ctrl+shift+c
![](src/5-listar-usuarios-en-passwd.png)

### Tarea 3: crear grupos

En esta sección, creará grupos de usuarios y agregará usuarios a los grupos.

    Sales (Ventas)
    
    HR (RR. HH.)
    
    Finance (Finanzas)
    
    Personnel (Personal)
    
    CEO (Director ejecutivo)
    
    Shipping (Envíos)
    
    Managers (Gerentes)

1. Crear Sales

![](src/10-crear-Sales-y-listar.png)

2. En lugar de cat, prefería usar tail, para tener mejor visual de la terminal

![](src/11-tail-a-Sales.png)

3. Agregando el resto de grupos

![](src/12-agregando-grupos.png)

4. Comprobando grupos

![](src/13-comprobando-grupos.png)

5. Agregar usuario a un grupo

![](src/14-agregar-usuario-a-grupo.png)

6. Agregando y comprobando

![](src/15-agregando-y-comprobando.png)

### Tarea 4: Iniciar sesión con los nuevos usuarios

1. Cambiando de usuario y permisos denegados

![](src/16-log-user-permisos-denegados.png)

2. Comprobando que este usuario no está registrado en sudoers, es decir, no tiene permiso para elevar o escalar privilegios

![](src/17-sudoers-problema.png)

3. Mirar el log que reporta sudo

![](src/18-mirar-log.png)

#### Impresiones

Me gustó mucho este lab, ya que mi experiencia de usuario en Linux es de uso individual y doméstico, por lo que nunca tuve la necesidad de administrar usuarios y grupos. Fue muy entretenido.
