---
title: "Lab 264: Recursos de red para una VPC"
parent: Entrega 2
nav_order: 11
---

# Lab 264: Creación de recursos de redes en una Amazon Virtual Private Cloud (VPC)

## Objetivos

En este laboratorio, realizará lo siguiente:

1. Resumir la situación del cliente

2. Crear una VPC, una puerta de enlace de Internet, una tabla de enrutamiento, un grupo de seguridad, una lista de acceso de redes y una instancia de EC2 para generar un red enrutable dentro de la VPC.

3. Familiarizarse con la consola

4. Desarrollar una solución para el problema del cliente presentado en esta sesión de laboratorio
* La sesión de laboratorio se completará una vez que pueda utilizar con éxito el comando ping por fuera de la VPC.

## Situación

Usted es un ingeniero de soporte en la nube en Amazon Web Services (AWS). Durante su turno, un cliente de una startup solicita asistencia con respecto a un problema de redes que tiene en su infraestructura de AWS. A continuación, se encuentran el correo y un archivo adjunto de su arquitectura.
Correo del cliente

    ¡Hola, equipo de soporte en la nube!
    
    Hace unos días, me puse en contacto con ustedes para solicitar ayuda, a fin de configurar 
    mi VPC. Pensé que sabía adjuntar todos los recursos para establecer una conexión a 
    Internet, pero ni siquiera puedo hacer ping por fuera de la VPC. ¡Todo lo que necesito 
    es hacer ping! ¿Me pueden ayudar a configurar mi VPC donde tenga conectividad de red 
    y pueda hacer ping? A continuación, se encuentra la arquitectura. Gracias.
    
    Brock, propietario de la startup

* Arquitectura
  
    ![](src/1-arquitectura.png)

### Tarea 1: investigar las necesidades del cliente

1. Crear recursos: La arquitectura del cliente consiste en una VPC con IGW, que aloja una subred pública, es decir, tiene una Tabla de Enrutamiento que se dirige a internet con target en IGW. Esta subred tiene una instancia que ha de tener una IP pública y un SG configurado para permitir nuestro acceso
   
   1. Entrando a VPC, para crear una.
      
       ![](src/2-entrando-a-vpc.png)
      
       ![](src/3-sus-vpc.png)
      
       ![](src/4-crear-vpc.png)
      
      * Configuración
        
          ![](src/5-configurar-vpc.png)
      
      * VPC creada
        
          ![](src/6-vpc-creada.png)
   
   2. Crear subred
      
       ![](src/7-subredes.png)
      
       ![](src/9-test-vpc.png)
      
       ![](src/10-subnet-settings-crear.png)
      
       ![](src/11-subnet-creada.png)
   
   3. Crear tabla de enrutamiento
      
       ![](src/12-route-table.png)
      
       ![](src/13-crear-route-table.png)
      
       ![](src/14-route-table-settings.png)
      
       ![](src/15-tabla-creada.png)
   
   4. Internet Gateway
      
       ![](src/16-IGW.png)
      
       ![](src/17-crear-IGW.png)
      
       ![](src/18-IGW-settings.png)
      
       ![](src/19-IGW-creada.png)

2. Conectar recursos
   
   1. Conectar IGW a VPC
      
       ![](src/20-conectar-a-vpc.png)
      
       ![](src/21-connection-settings.png)
      
       ![](src/22-conexion-exitosa.png)
   
   2. Configurar Route Table
      
       ![](src/23-editar-route-table.png)
      
       ![](src/24-agregar-ruta.png)
      
       ![](src/25-route-settings.png)
      
       ![](src/26-ruta-agregada.png)
      
       ![](src/27-editar-asociaciones-de-subredes.png)
      
       ![](src/28-asociando.png)

3. Crear también NACL
   
    ![](src/29-acl-de-red.png)
   
    ![](src/30-crear-acl-de-red.png)
   
    ![](src/31-NACL-settings.png)
   
    ![](src/32-nacl-creada.png)
   
   * Editar reglas de entrada
     
       ![](src/33-editar-reglas-de-entrada.png)
     
       ![](src/34-editando.png)
     
       ![](src/35-regla-de-entrada-agregada.png)
   
   * Duda con la regla de salida por defecto. Me pregunto si esta regla permitirá la respuesta del ping que haga a una EC2
     
       ![](src/36-dudas-conreglas-de-salida.png)
   
   * Efectivamente, había que crear una regla de salida, igual a la de entrada
     
       ![](src/37-agregar-regla-de-salida.png)
     
       ![](src/38-ahora-se-ve-como-la-guia.png)

4. Ahora, configuramos lo necesario para la instancia EC2 que vivirá dentro de la subred, a la que haremos ping
   
   1. Crear y configurar grupo de seguridad (SG)
      
       ![](src/39-crear-grupo-de-seguridad.png)
      
       ![](src/40-SG-settings.png)
      
       ![](src/41-SG-entrada.png)
      
       ![](src/42-SG-salida.png)
      
       ![](src/43-crear-SG.png)
      
       ![](src/44-SG-creado.png)

### Tarea 2: lanzar la instancia de EC2 y establecer una conexión SSH con la instancia

1. Lanzar instancia EC2 y anotar IP pública. No está demás enfatizar que la instancia se asocia al SG configurado previamente.21
   
    ![](src/45-ec2-lanzando.png)
   
    ![](src/46-ip-de-instancia.png)

2. Acceso ssh: descargué el archivo .pem en vocaerum, y usé la IP pública detallada en el dashboard de la instancia, en la consola de AWS. 
   
    ![](src/47-acceso-ssh-a-instancia-logrado.png)
   
    ![](src/48-ping-logrado.png)

#### Impresiones

Me pareció muy divertido este laboratorio. Fue una especie de síntesis de los anteriores. Pese a que lo hice sin muchos problemas siguiendo el paso a paso, no entendí sino hasta que hice la documentación, ya que me dediqué a investigar a fondo los detalles y aclarando las dudas. Quedé bastante conforme con lo aprendido hasta aquí.