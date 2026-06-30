---
title: "Lab 264: Recursos de red para una VPC"
parent: Entrega 3
nav_order: 1
---
Comandos de solución de problemas del protocolo de Internet

Objetivos

Después de completar este módulo, podrá hacer lo siguiente:

    Practicar los comandos de solución de problemas

    Identificar cómo puede usar estos comandos en las situaciones del cliente

Duración

El tiempo estimado para completar este laboratorio es de 30 minutos.
Situación

Es un administrador de red nuevo que soluciona problemas de clientes.
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

Tarea 2: Practicar los comandos de solución de problemas
Recordatorio

Algunas capas tienen comandos relacionados con ellas para ayudar con la resolución de problemas. El siguiente es un ejemplo de cómo fluyen los comandos de solución de problemas con el modelo de interconexión de sistemas abiertos (OSI):

El modelo de interconexión de sistemas abiertos (OSI) y un ejemplo de cómo se relaciona con las capas OSI
Figura: este es un ejemplo de cómo los comandos de solución de problemas tienen similitudes con el modelo de interconexión de sistemas abiertos (OSI).
Capa 3 (red): los comandos ping y traceroute

    El siguiente es un ejemplo de una situación del cliente en la que puede usar el comando ping:

        El cliente lanzó una instancia de EC2. Para probar la conectividad hacia y desde la instancia, ejecute el comando ping. Puede usar este comando para probar la conectividad y asegurarse de que permite las solicitudes del Protocolo de mensajes de control de Internet (ICMP) en el nivel de seguridad, como grupos de seguridad y ACL de red.

    En la terminal de Linux, ejecute el siguiente comando y presione Enter:

    ping 8.8.8.8 -c 5

    Este es el comando ping. Cuando ejecuta este comando, puede ingresar una IP o URL seguida de opciones. En este ejemplo, -c significa conteo y 5 representa cuántas solicitudes está solicitando.

    Después de ejecutar este comando, debería ver un resultado similar al siguiente:

    Los resultados del comando ping, que son respuestas del servidor 8.8.8.8. Está probando la conectividad IP a un servidor web.
    Figura: el comando ping muestra la conectividad IP a un servidor web.

    Puede usar el comando ping por varias razones, pero la razón más común es probar la conectividad a algo como un servidor. El comando ping envía solicitudes de eco ICMP desde la máquina al servidor al que intenta acceder (por ejemplo, amazon.com). El servidor envía una respuesta de eco con un tiempo de ida y vuelta. Utilice el comando ping sobre todo para solucionar problemas de conectividad y accesibilidad a un objetivo específico. También puede usarlo para activar una red específica si el tráfico necesita fluir de manera continua a través de una red. También puede enviar un ping continuo.

    El siguiente es un ejemplo de una situación del cliente en la que puede usar el comando traceroute:

        El cliente tiene problemas de latencia. Dice que su conexión tarda mucho y que pierde paquetes. No está seguro de si está relacionado con AWS o con su proveedor de servicios de Internet (ISP). Para investigar, puede ejecutar el comando traceroute desde su recurso de AWS al servidor al que intentan acceder. Si la pérdida ocurre hacia el servidor, lo más probable es que el problema sea el ISP. Si la pérdida es para AWS, es posible que deba investigar otros factores que pudieran limitar la conectividad de red.

    En la terminal de Linux, ejecute el siguiente comando y presione Enter:

    traceroute 8.8.8.8

    Este es el comando traceroute. Puede ingresar una IP o URL seguida de opciones.

    Después de ejecutar este comando, debería ver un resultado similar al siguiente:

    Los resultados del comando traceroute, que confirma la ruta al servidor web y la latencia
    Figura: el comando traceroute muestra la ruta que se tomó al servidor web y la latencia que tomó.

    La pérdida de paquetes, vista como porcentajes, puede ocurrir en cada salto y esta pérdida por lo general ocurre debido a un problema con la red de área local (LAN) o el ISP del usuario.

    Puede identificar un problema o error cuando fallan los nombres de host y las direcciones IP a ambos lados de un salto. Tres asteriscos (***) indican un salto fallido.

    El comando traceroute informa sobre la ruta y la latencia que toma el paquete para llegar desde la máquina al destino (8.8.8.8). Cada servidor es un salto. Puede haber pérdida de paquetes, vistos como porcentajes, en cada pérdida, que por lo general se debe a la red de área local (LAN) del usuario o al ISP; sin embargo, si la pérdida de paquetes se produce hacia el final de la ruta, lo más probable es que el problema sea la conexión del servidor. Puede identificar un problema o error cuando los nombres de host y las direcciones IP están a ambos lados de un salto fallido, que se ve como tres asteriscos (***).

Capa 4 (transporte): los comandos netstat y telnet

    El siguiente es un ejemplo de una situación del cliente en la que puede usar el comando netstat:

        La empresa ejecuta un análisis de seguridad de rutina y descubre que se puso en riesgo uno de los puertos de una determinada subred. Para confirmar, ejecute el comando netstat en un host local en esa subred para confirmar si el puerto escucha cuando no debería hacerlo.    

    En la terminal de Linux, ejecute el siguiente comando y presione Enter:

    netstat -tp

    Este es el comando netstat. Puede utilizar las siguientes opciones:

        netstat -tp: Confirma las conexiones establecidas.

    netstat -tp: Resultados de servicios de escucha.

        netstat -tp: Genera servicios de escucha, pero no resuelve los números de puerto.

    Después de ejecutar este comando, debería ver un resultado similar al siguiente:

     

    El resultado de netstat con la opción -tp, que confirma las conexiones establecidas
    Figura: el resultado de netstat -tp confirma las conexiones establecidas.

    El comando netstat muestra las conexiones TCP establecidas en la actualidad desde las que el host está escuchando. Cuando se solucionan problemas de red a partir de la máquina que aloja y trabajar hacia afuera, puede ejecutar este comando para comprender qué puertos escuchan y cuáles no. Debido a que este comando le brinda una instantánea de su conectividad de capa 4, el uso de este comando lo ayudará a ganar tiempo cuando intente resolver un problema de red importante.

     

    El siguiente es un ejemplo de una situación del cliente en la que puede usar el comando telnet:

        El cliente tiene un servidor web seguro y tiene configuradas reglas de grupo de seguridad personalizadas y reglas de ACL de red. Sin embargo, les preocupa que el puerto 80 esté abierto a pesar de que muestra que su configuración de seguridad indica que su grupo de seguridad bloque este puerto, puede ejecutar el comando telnet 192.168.10.5 80 para asegurarse de que se rechace la conexión.

    En la terminal de Linux, ejecute el siguiente comando y presione Enter para instalar telnet:

    sudo yum install telnet -y

    En la terminal de Linux, ejecute el siguiente comando y presione Enter:

    telnet www.google.com 80

    Este es el comando telnet. Puede ingresar una IP o URL seguida del número de puerto para conectarse a ese puerto.

    Después de ejecutar este comando, debería ver un resultado similar al siguiente:

    El resultado del comando telnet, que confirma la conexión TCP a un servidor web. Una solicitud HTTP se realiza mediante el comando telnet.
    Figura: el comando telnet confirma la conexión TCP a un servidor web. Realiza las solicitudes HTTP mediante el comando telnet.

    El comando telnet confirma la conexión TCP a un servidor web que realiza una solicitud HTTP si usa el puerto 80 para el comando telnet. También puede utilizar este comando en la capa 7. Si puede conectarse con éxito al servidor web, entonces no hay nada que le impida a usted o al servidor conectarse. Si la conexión falla con un mensaje como “conexión rechazada”, es probable que algo bloquee la conexión, como un firewall o un grupo de seguridad. Si la conexión falla con un mensaje como “tiempo de conexión agotado”, entonces el problema puede ser que no haya ruta de red o conectividad.  

Capa 7 (aplicación): el comando curl

    El siguiente es un ejemplo de una situación del cliente en la que puede usar el comando curl:

        El cliente tiene un servidor Apache ejecutándose y quiere probar si está recibiendo una solicitud exitosa (200 OK), lo que indica que su sitio web se está ejecutando de manera correcta. Puede ejecutar una solicitud del comando curl para ver si el servidor Apache del cliente devuelve una respuesta 200 OK.   

    En la terminal de Linux, ejecute el siguiente comando y presione Enter:

    curl -vLo /dev/null https://aws.com

    Este es el comando curl. Puede utilizar las siguientes opciones de comando:

    -I: Esta opción proporciona información de encabezado y especifica que el método de solicitud es Head.
    -i: Esta opción especifica que el método de solicitud es GET.
    -k: Esta opción le dice al comando que ignore los errores de SSL.
    -v: Estas opciones son detalladas. Muestra lo que hace el equipo o lo que está cargando el software durante el inicio.
    -o /dev/null: Esta opción enviará HTML y CSS en respuesta a nulo.

    Después de ejecutar este comando, debería ver un resultado similar al siguiente:

    Los resultados de curl: en este ejemplo, la salida prueba la conexión a un servicio web, como AWS, y envía la solicitud HTTP.
    Figura: los resultados del comando curl: la salida prueba la conexión a un servicio web, como AWS, y envía la solicitud HTTP.

    Puede usar el comando curl para transferir datos entre usted y el servidor. El comando curl puede usar muchos protocolos diferentes, pero los más comunes son HTTP y HTTPS. Puede usar el comando curl para solucionar problemas de comunicación desde el dispositivo local a un servidor.  

     

Laboratorio completado

 ¡Felicitaciones! Completó el laboratorio.

    Seleccione End Lab (Finalizar laboratorio) en la parte superior de esta página y luego Yes (Sí) para confirmar que desea finalizar la sesión.
    Aparecerá un panel en el que se indica: “DELETE has been initiated… You may close this message box now” (Se ha iniciado la ELIMINACIÓN… Ya puede cerrar este cuadro de mensaje).

    Seleccione la X que se encuentra en la esquina superior derecha para cerrar el panel.

Resumen
En este laboratorio

Recursos adicionales

    ping

    telnet

    traceroute

Para obtener más información sobre AWS Training and Certification, consulte AWS Training and Certification.

Sus comentarios son bienvenidos y valorados.

Si desea compartir alguna sugerencia o corrección, proporcione los detalles en nuestro Formulario de contacto de AWS Training and Certification.

© 2024, Amazon Web Services, Inc. y sus filiales. Todos los derechos reservados. Este contenido no puede reproducirse ni redistribuirse, de forma total ni parcial, sin el permiso previo por escrito de Amazon Web Services, Inc. Queda prohibida la copia, el préstamo o la venta de carácter comercial.
