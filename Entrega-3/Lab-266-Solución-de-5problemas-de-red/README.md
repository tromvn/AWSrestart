---
title: "Lab 266: Solución de problemas de red"
parent: Entrega 3
nav_order: 2
---
Solución de problemas de red
Objetivos

Después de completar este módulo, podrá hacer lo siguiente:

    Analizar la situación del cliente

    Solucionar el problema

Duración

El tiempo estimado para completar este laboratorio es de 1 hora.
Situación

Usted es un ingeniero de soporte en la nube en Amazon Web Services (AWS). Durante su turno, una empresa de consultoría tiene un problema de red dentro de su infraestructura de AWS. El siguiente es el correo y un archivo adjunto con respecto a su arquitectura:
Correo del cliente

    ¡Hola, equipo de soporte en la nube!

    Cuando creo un servidor Apache a través de la línea de comandos, no puedo hacerle ping. También recibo un error cuando ingreso la dirección IP en el navegador. ¿Pueden ayudarme a averiguar qué está bloqueando mi conexión?

    Gracias.

    Ana
    Contratista

Diagrama del cliente

La arquitectura de nube virtual privada (VPC) del cliente, que consta de una VPC, una puerta de enlace de internet, una subred pública y una instancia de Amazon Elastic Compute Cloud (Amazon EC2).
Imagen: la arquitectura de nube virtual privada (VPC) del cliente.

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

Tarea 1: Conectarse a una instancia de EC2 de Amazon Linux mediante SSH.

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

    Anote la dirección PublicIP.

    A continuación, haga clic en la X para salir del panel Details (Detalles).

    Abra una ventana del terminal y cambie el directorio cd por el directorio donde se descargó el archivo labsuser.pem. Por ejemplo, si el archivo labuser.pem se guardó en el directorio Descargas, ejecute este comando:

    cd ~/Downloads

    Ejecute este comando para cambiar los permisos de la clave a fin de que sean de solo lectura:

    chmod 400 labsuser.pem

    Ejecute el siguiente comando (reemplace <public-ip> por la dirección PublicIP que copió antes).
    De manera alternativa, regrese a la consola de EC2 y seleccione Instancias. Marque la casilla junto a la instancia a la que desea conectarse y, en la pestaña Descripción, copie el valor de la dirección IPv4 pública.

    ssh -i labsuser.pem ec2-user@<public-ip>

    Escriba yes cuando se le pregunte si quiere permitir la primera conexión a este servidor SSH remoto.
    Como utiliza un par de claves para la autenticación, no se le pedirá una contraseña.

Tarea 2: Instalar httpd

Para esta tarea, instale httpd antes de verificar los recursos del cliente.

En la situación, Ana, la clienta que solicita asistencia, no puede acceder a su servidor Apache ni conseguir que se cargue de manera correcta en una página web desde su nube virtual privada (VPC).

Usted tiene una réplica exacta de la VPC y sus recursos para solucionar el problema.

    Sugerencia útil

    Es posible que deba utilizar sudo para realizar este ejercicio si no es un usuario raíz.

    Para verificar el estado del servicio httpd, ingrese el siguiente comando systemctl en la ventana del terminal y luego presione Enter:

    sudo systemctl status httpd.service

    Después de ejecutar este comando, debería ver un resultado similar al siguiente, que indica que el servicio está inactivo:

    En el resultado del comando sudo systemctl status httpd.service, se muestra que el servicio está inactivo porque aún no se inicia.

    Figura: el estado muestra que el servicio httpd está inactivo porque aún no se ha iniciado. Esta salida indica que el servicio httpd está cargado (ya se instaló), pero actualmente está inactivo.

    Para iniciar el servicio httpd, ingrese el siguiente comando y presione Enter.

    sudo systemctl start httpd.service

    Para verificar el estado del servicio httpd, ingrese el siguiente comando systemctl y luego presione Enter:

    sudo systemctl status httpd.service

    Después de ejecutar este comando, debería ver un resultado similar al siguiente, que indica que el servicio está activo:

    El estado de la salida que indica que el servicio httpd está activo 
    Figura: el servidor HTTP Apache debe tener el estado activo.

    El servicio httpd está en ejecución ahora. Verifique si funciona. En la siguiente URL, reemplace  con la IP pública de su instancia que se ubica en el botón de detalles del entorno de Vocareum. Abra una pestaña nueva del navegador e ingrese la IP pública de la instancia con el siguiente formato:

    http://<PUBLIC IP OF INSTANCE>

    En la siguiente imagen, se muestra la salida que se espera; sin embargo, la página no se cargará en este punto del laboratorio:

    La página de prueba del servidor HTTP Apache cuando Apache se instala correctamente
    Figura: la página de prueba del servidor HTTP Apache cuando Apache se instala correctamente

Tarea 3: investigar la configuración de la VPC del cliente

Para esta tarea, investigará la VPC del cliente y sus recursos.

En la situación, Ana, la clienta que solicita asistencia, no puede comunicarse con su servidor Apache a pesar de que está activo. Tiene una réplica exacta de la VPC y sus recursos. Tenga en cuenta el error que recibió cuando intentó cargar Apache en el navegador web mientras soluciona este problema.

    En la parte superior derecha de estas instrucciones, elija AWS. La Consola de administración de AWS se abrirá en una pestaña nueva del navegador.

    Una vez que esté en la consola de AWS, en la sección Servicios visitados recientemente, es posible que vea la VPC. Si la ve, elija VPC. Si no lo hace, navegue hacia la esquina superior izquierda y elija el menú desplegable Servicios. En los servicios Redes y entrega de contenido, elija VPC.

    La consola de administración de AWS y los servicios visitados recientemente: en Servicios visitados recientemente debería poder elegir el servicio Amazon VPC. De lo contrario, puede utilizar la lista desplegable Servicios. 

    Figura: servicios visitados recientemente en la consola de AWS.

    La lista desplegable de servicios y cómo encontrar el servicio Amazon VPC con la barra de búsqueda o al desplazarse hasta la parte inferior de la sección Redes y entrega de contenido y elegir el servicio Amazon VPC 

    Figura: lista desplegable de navegación de servicios.

    Utilice el panel de navegación izquierdo y verifique cada servicio dentro de la VPC para confirmar que cada recurso esté configurado de manera correcta.

    El panel de navegación izquierdo de la VPC y sus servicios, entre los que se encuentran, entre otros, las VPC, las subredes, las tablas de enrutamiento, las puertas de enlace de internet, las puertas de enlace de internet de solo salida, las puertas de enlace de operador, las direcciones IP elásticas, los puntos de conexión, las puertas de enlace de NAT y las interconexiones. 

    Figura: el panel de navegación izquierdo de la VPC y sus servicios.

        Subredes: ¿las tablas de enrutamiento están asociadas a las subredes correctas?

        Tablas de enrutamiento: ¿las tablas de enrutamiento tienen las rutas correctas?

        Puerta de enlace de Internet: ¿hay una puerta de enlace de Internet? Si la hay, ¿está conectada?

        Grupos de seguridad y ACL de red: ¿están configuradas las reglas correctas?

    Sugerencias

        ¿Puede hacer ping a sitios web como www.amazon.com? Si es así, puede acceder a Internet (la puerta de enlace de Internet y la tabla de enrutamiento deberían funcionar).

        Apache es un servidor que comúnmente usa HTTP/S como puertos.

    Una vez que pase por cada opción en el paso anterior, como enrutamiento, seguridad y recursos, confirme que el servidor HTTP Apache esté funcionando. Para ello, pruebe la siguiente URL en un navegador y reemplace  con la IP pública de su instancia, que se puede encontrar en el menú desplegable de detalles en Vocareum.

    http://<PUBLIC IP OF INSTANCE>

    Si Apache se instaló de manera correcta, se espera la siguiente salida:

    La página de prueba del servidor HTTP Apache cuando Apache se instala correctamente 

    Figura: la página de prueba del servidor HTTP Apache cuando Apache se instala correctamente.

Resumen
En este laboratorio

En este laboratorio, solucionó el problema de redes del cliente. Descubrió que el cliente tenía un problema con los puertos de seguridad en el grupo de seguridad. Después de arreglar el problema, fue capaz de cargar el servidor Apache correctamente.

Recursos adicionales

    ¿Qué es Amazon VPC?

Laboratorio completado

 ¡Felicitaciones! Completó el laboratorio.

    Seleccione End Lab (Finalizar laboratorio) en la parte superior de esta página y luego Yes (Sí) para confirmar que desea finalizar la sesión.
    Aparecerá un panel en el que se indica: “DELETE has been initiated… You may close this message box now” (Se ha iniciado la ELIMINACIÓN… Ya puede cerrar este cuadro de mensaje).

    Seleccione la X que se encuentra en la esquina superior derecha para cerrar el panel.

Si desea compartir alguna sugerencia o corrección, proporcione los detalles en nuestro Formulario de contacto de AWS Training and Certification.

© 2024, Amazon Web Services, Inc. y sus filiales. Todos los derechos reservados. Este contenido no puede reproducirse ni redistribuirse, de forma total ni parcial, sin el permiso previo por escrito de Amazon Web Services, Inc. Queda prohibida la copia, el préstamo o la venta de carácter comercial.
