---
title: "Lab 261: Direcciones IP públicas y privadas"
parent: Entrega 2
nav_order: 8
---
Protocolos de Internet: Direcciones IP públicas y privadas

 
Objetivos

En este laboratorio, realizará lo siguiente:

    Resumir e investigar la situación del cliente

    Analizar las diferencias entre una dirección de IP pública y una privada

    Desarrollar una solución al problema del cliente planteado en este laboratorio

    Resumir y describir los hallazgos (actividad grupal)

Duración

El tiempo estimado para completar este laboratorio es de 1 hora.

 
Situación

Usted es un ingeniero de soporte en la nube en Amazon Web Services (AWS). Durante su turno, un cliente de una empresa Fortune 500 solicita asistencia por un problema de redes dentro de su infraestructura de AWS. A continuación, figuran el correo y un archivo adjunto de su arquitectura:
Ticket del cliente

    ¡Hola, equipo de soporte en la nube!

            En la actualidad, tenemos una nube virtual privada (VPC) con un intervalo de CIDR de 10.0.0.0/16. En esta VPC, tenemos dos instancias de Amazon Elastic Compute Cloud (Amazon EC2): la instancia A y la instancia B. Aunque ambas están en la misma subred y tienen las mismas configuraciones con los recursos de AWS, la instancia A no puede acceder a Internet y la instancia B sí. Creo que está relacionado con las instancias de EC2, pero no estoy segura. También tenía una pregunta sobre el uso de un rango público de direcciones IP como 12.0.0.0/16 para una VPC que me gustaría lanzar. ¿Causaría algún problema? Adjunto nuestra arquitectura como referencia.

    Gracias.
    Jess
    Administrador de la nube

 

La arquitectura del cliente, que consta de una VPC, una puerta de enlace de Internet, una subred pública con la instancia A y una subred pública con la instancia B

Imagen: la arquitectura del cliente, que consta de una VPC, una puerta de enlace de Internet, una subred pública con la instancia A y una subred pública con la instancia B.

 
Restricciones del servicio de AWS

En este entorno de laboratorio, es posible que el acceso a los servicios de AWS y a las acciones del servicio esté restringido a los que usted necesita para completar las instrucciones del laboratorio. Es posible que encuentre errores si intenta acceder a otros servicios o si ejecuta acciones que no se detallan en este laboratorio.
Acceso a la Consola de administración de AWS

    En la parte superior de estas instrucciones, seleccione Start Lab (Comenzar laboratorio) para iniciar el laboratorio.
    Se abrirá el panel Start Lab (Comenzar laboratorio) y se mostrará el estado del laboratorio.

        Sugerencia: Si necesita más tiempo para completar el laboratorio, vuelva a presionar el botón Start Lab (Comenzar laboratorio) para reiniciar el temporizador del entorno.

    Espere hasta que aparezca el mensaje: Lab status: ready (Estado de la sesión de laboratorio: listo) y, a continuación, haga clic en la X para cerrar el panel Start Lab (Comenzar laboratorio).

    En la parte superior de estas instrucciones, seleccione AWS.
    La Consola de administración de AWS se abrirá en una pestaña nueva del navegador. El sistema iniciará sesión de forma automática.

        Sugerencia: si no se abre una pestaña nueva del navegador, suele aparecer un anuncio o un icono en la parte superior de este con un mensaje que indica que el navegador impide que el sitio web abra ventanas emergentes. Elija el anuncio o el icono y, a continuación, seleccione Permitir ventanas emergentes.

    Ubique la pestaña de la Consola de administración de AWS de modo que aparezca al lado de estas instrucciones. Lo ideal es que pueda ver las dos pestañas del navegador al mismo tiempo para que pueda seguir los pasos del laboratorio con mayor facilidad.

 
Tarea 1: Investigar el entorno del cliente

Recuerde que antes estudió las direcciones IP públicas y privadas y los CIDR. A medida que avance en este laboratorio, piense en las diferencias entre las direcciones IP públicas y las privadas para la tarea 1. Para la tarea 2, piense en la importancia de usar rangos de IP privados en lugar de rangos de IP públicos.

    Nota

    Para este laboratorio, ya verificó la arquitectura de AWS y todo está enrutado y conectado de manera correcta. En este laboratorio, no se cubre ninguna arquitectura de AWS.  

En la situación, Jess, que es la clienta que solicita asistencia, tiene dos instancias de EC2 en una VPC. La instancia A no puede conectarse a Internet y la instancia B sí puede hacerlo, aunque están configuradas de la misma manera dentro de la VPC. En el momento la arquitectura de AWS del cliente parece en buen estado porque una de sus instancias trabaja. Jess sospecha que el problema puede ser la configuración de la instancia.

También tiene una pregunta sobre el uso de un rango público de direcciones IP para la VPC nueva y preguntó si podría proporcionar más información al respecto.

en la actualidad tiene una VPC con el mismo CIDR de 10.0.0.0/16 con dos instancias, instancia A y la instancia B, con las mismas configuraciones que el cliente. Cuando se solucionan problemas de redes y AWS, puede aplicar un método de solución de problemas en el que comienza desde arriba y avanza hacia el fondo o viceversa. Comience a solucionar problemas desde el fondo y avance hacia arriba en capas y use un ejemplo como el modelo de interconexión de sistemas abiertos (OSI). La instancia de EC2 se encuentra en el fondo de esta arquitectura. Aunque la arquitectura de la nube no es de manera directa comparable con el modelo de interconexión de sistemas abiertos (OSI), el siguiente es un ejemplo de cómo se relacionan el modelo de interconexión de sistemas abiertos (OSI) y la nube.
 	Modelo de interconexión de sistemas abiertos (OSI)	Infraestructura de AWS
Capa 7	Aplicación (cómo lo ve el usuario final)	Aplicación
Capa 6	Presentación (traductor entre capas)	Servidores web, servidores de aplicación
Capa 5	Sesión (establecimiento de sesión, seguridad)	Instancias de EC2
Capa 4	Transporte (TCP, control de flujo)	Grupo de seguridad. NACL
Capa 3	Red (paquetes que contienen direcciones IP)	Tablas de enrutamiento, IGW, subredes
Capa 2	Enlace de datos (marcos que contienen direcciones MAC físicas)	Tablas de enrutamiento, IGW, subredes
Capa 1	Físico (cables, bits y voltios de transmisión física)	Regiones, zonas de disponibilidad

Tabla: Este es un ejemplo de cómo la infraestructura de AWS y sus recursos tienen similitudes con el modelo de interconexión de sistemas abiertos (OSI). Esta información puede ser beneficiosa para la resolución de problemas.

		En la tarea 1, deberá comprender el entorno del cliente y reproducir el problema.

    En la parte superior derecha de estas instrucciones, elija AWS. La Consola de administración de AWS se abrirá en una pestaña nueva del navegador.

    Una vez que esté en la consola de AWS, escriba y busque EC2 en la barra de búsqueda en la esquina superior izquierda. Seleccione EC2 en la lista.

    Sugerencia: Como alternativa, también puede buscar EC2 en Services (Servicios) - Compute (Cómputo), en la esquina superior izquierda.

    La barra de búsqueda se puede utilizar para encontrar el servicio Amazon EC2. Una vez que encuentre el servicio, selecciónelo.

    Imagen: La barra de búsqueda se puede utilizar para encontrar el servicio Amazon EC2. Una vez que encuentre el servicio, selecciónelo.

    Ahora se encuentra en el panel de Amazon EC2. En el menú de navegación izquierdo, seleccione Instances (Instancias). Esta opción lo lleva a las instancias de EC2 actuales. en la actualidad, debería ver dos instancias de EC2. 

    El panel de control de Amazon EC2: desde esta página, puede elegir la instancia A o la B, y ver las características de cada una. También puede iniciar instancias desde aquí.

    Figura: panel de Amazon EC2

    Copie y pegue los nombres y las direcciones IP de ambas instancias en un editor de texto para referencia futura. 
    Marque la casilla situada junto a instance A. En la parte inferior de la página, elija la pestaña Networking (Redes) y anote las direcciones IPv4 públicas y privadas. Una vez que haya copiado y pegado el nombre y las direcciones IP, anule la selección de la instancia; luego, seleccione la instancia B y haga lo mismo. ¿Notó alguna diferencia? Si lo hizo, anótelas.

    Puede seleccionar la instancia A y sus configuraciones de red seleccionando la casilla de verificación junto al nombre de la instancia y navegando hacia abajo hasta la pestaña Networking (Redes). Allí encontrará las direcciones IPv4 asociadas, la VPC y la información de la subred.

    Imagen: Información de red de la instancia A de Amazon EC2. Los valores de la dirección IP pueden variar.

 

   Puede seleccionar la instancia B y sus configuraciones de red seleccionando la casilla de verificación junto al nombre de la instancia y navegando hacia abajo hasta la pestaña Networking (Redes). Allí encontrará las direcciones IPv4 asociadas, la VPC y la información de la subred.

   Imagen: Información de red de la instancia B de Amazon EC2. Los valores de la dirección IP pueden variar.

 
Tarea 2: conectarse a una instancia de EC2 de Amazon Linux mediante SSH.

En esta tarea, se conectará a una instancia de EC2 de Amazon Linux. Usará una utilidad SSH para llevar a cabo todas estas operaciones. Las siguientes instrucciones varían ligeramente en función de si utiliza Windows, Mac o Linux.
 Usuarios de Windows: uso de SSH para conectarse

 Estas instrucciones son específicamente para usuarios de Windows. Si utiliza macOS o Linux, pase a la siguiente sección.

    Seleccione el menú desplegable Details (Detalles) que se encuentra arriba de estas instrucciones y, luego, seleccione Show (Mostrar). Se abrirá la ventana Credentials (Credenciales).

    Seleccione Download PPK (Descargar PPK) y guarde el archivo labsuser.ppk.
    Por lo general, el navegador lo guarda en el directorio Descargas.

    Anote la dirección PublicIP.

    A continuación, haga clic en la X para salir del panel Details (Detalles).

    Descargue PuTTY a SSH en la instancia de Amazon EC2. Si no tiene PuTTY instalado en su equipo, descárguelo aquí.

    Abra putty.exe

    Configure su sesión de PuTTY siguiendo las instrucciones del siguiente enlace: Connect to your Linux instance using PuTTY (Conéctese a su instancia de Linux mediante PuTTY)

    Usuarios de Windows: haga clic aquí para pasar a la siguiente tarea.

 
Usuarios de macOS  y Linux 

Estas instrucciones son específicamente para usuarios de Mac o Linux. Si es un usuario de Windows, pase directamente a la siguiente tarea.

    Seleccione el menú desplegable Details (Detalles) que se encuentra arriba de estas instrucciones y, luego, seleccione Show (Mostrar). Se abrirá la ventana Credentials (Credenciales).

    Seleccione Download PEM (Descargar PEM) y guarde el archivo labsuser.pem.

    A continuación, haga clic en la X para salir del panel Details (Detalles).

    Abra una ventana del terminal y cambie el directorio cd por el directorio donde se descargó el archivo labsuser.pem. Por ejemplo, si el archivo labuser.pem se guardó en el directorio Descargas, ejecute este comando:

    cd ~/Downloads

    Ejecute este comando para cambiar los permisos de la clave a fin de que sean de solo lectura:

    chmod 400 labsuser.pem

    Ejecute el siguiente comando *(reemplace <ip-address> con la dirección IPv4 de la instancia A que anotó antes). Nota: ¿Debería utilizar una dirección IP pública o privada para conectarse?

    ssh -i labsuser.pem ec2-user@<ip-address>

    Escriba yes cuando se le pregunte si quiere permitir la primera conexión a este servidor SSH remoto.
    Como utiliza un par de claves para la autenticación, no se le pedirá una contraseña.

    Pregunta: ¿Pudo usar SSH para conectarse a ambas instancias? ¿Por qué sí o por qué no?

    Respuesta: Si no pudo conectarse a la instancia A, es porque a esta instancia solo se le asignó una dirección IP privada. No se puede acceder a las direcciones IP privadas desde fuera de la VPC. Es por eso que solo puede conectarse a la instancia B. La instancia B tiene una dirección IP pública asignada que permite el acceso desde fuera de la VPC, lo que le permite usar la utilidad SSH para conectarse a la instancia.
    La clienta solicitó su opinión sobre el uso de un CIDR público para una VPC nueva que le gustaría lanzar. Consulte el módulo 4, recopile algunas pruebas y haga un resumen de los hallazgos para explicarle al cliente por qué o por qué no recomienda este enfoque.

 
Tarea 3: enviar la respuesta al cliente (actividad grupal)

En grupos de dos, envíen los hallazgos.

La persona 2 interpretará a Jess, la clienta y la persona 1 interpretará al ingeniero de soporte en la nube. La persona 1 explicará sus hallazgos a la persona 2.

    Nota

    Esta tarea debería tomar entre 5 y 10 minutos solamente. Si no es posible realizar una actividad de grupo debido al COVID, haga que un estudiante le explique sus hallazgos a la clase.

 
Laboratorio completado 

 ¡Felicitaciones! Completó el laboratorio.

    Seleccione End Lab (Finalizar laboratorio) en la parte superior de esta página y luego Yes (Sí) para confirmar que desea finalizar la sesión.
    Aparecerá un panel en el que se indica: “DELETE has been initiated… You may close this message box now” (Se ha iniciado la ELIMINACIÓN… Ya puede cerrar este cuadro de mensaje).

    Seleccione la X que se encuentra en la esquina superior derecha para cerrar el panel.

 
Resumen

En esta sesión de laboratorio, investigó el entorno del cliente y aplicó técnicas de solución de problemas que le permitieron resolver el problema del cliente. Dentro de la situación, descubrió que la instancia de EC2 del cliente (instancia A) necesitaba una dirección IP pública para conectarse a Internet. Esto se probó usar una utilidad SSH para conectarse a la instancia. Las direcciones IP privadas se utilizan dentro de la VPC y no pueden establecer una conexión a Internet. Como se explica en el módulo 4, descubrió que el uso de un rango público de direcciones IP para una VPC puede generar complicaciones cuando se reciben respuestas de otros recursos no relacionados.

 
Recursos adicionales

    Direccionamiento IP público de la instancia de Amazon EC2

    CIDR DE LA VPC

    RFC1918

Para obtener más información sobre AWS Training and Certification, consulte https://aws.amazon.com/training/.

Sus comentarios son bienvenidos y valorados.
Si desea compartir alguna sugerencia o corrección, proporcione los detalles en nuestro Formulario de contacto de AWS Training and Certification.

© 2024, Amazon Web Services, Inc. y sus filiales. Todos los derechos reservados. Este contenido no puede reproducirse ni redistribuirse, de forma total ni parcial, sin el permiso previo por escrito de Amazon Web Services, Inc. Queda prohibida la copia, el préstamo o la venta de carácter comercial.
