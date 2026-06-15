Administración de servicios: supervisión

    Nota

    Todas las sesiones de laboratorio dependen del material didáctico y la información de sesiones anteriores.

 
Objetivos

En este laboratorio, hará lo siguiente:

    Verificar el estado del servicio httpd para asegurarse de que se está ejecutando y que puede realizar una conexión http con la dirección IP del host local.

    También aprenderá a supervisar la instancia de EC2 de Amazon Linux 2 

        Utilizando el comando top de Linux

        Utilizando AWS CloudWatch

 
Duración

30 minutos

 
Restricciones de los servicios de AWS

En el entorno de este laboratorio, es posible que el acceso a los productos de AWS y a sus respectivas acciones esté restringido a aquellos que son necesarios para completar las instrucciones del laboratorio. Puede que encuentre errores si intenta acceder a otros productos o ejecutar acciones aparte de las que se detallan en este laboratorio.

 
Acceso a la Consola de administración de AWS

    En la parte superior de estas instrucciones, seleccione Start Lab (Comenzar laboratorio) para iniciar el laboratorio.
    Se abrirá el panel Start Lab (Comenzar laboratorio) y se mostrará el estado del laboratorio.

        Sugerencia: Si necesita más tiempo para completar el laboratorio, vuelva a presionar el botón Start Lab (Comenzar laboratorio) para reiniciar el temporizador del entorno.

    Espere hasta que aparezca el mensaje: Lab status: ready (Estado de la sesión de laboratorio: listo) y, a continuación, haga clic en la X para cerrar el panel Start Lab (Comenzar laboratorio).

    En la parte superior de estas instrucciones, elija AWS.
    La Consola de administración de AWS se abrirá en una pestaña nueva del navegador. El sistema iniciará sesión de forma automática.

        Sugerencia: Si no se abre una pestaña nueva del navegador, suele aparecer un anuncio o un icono en la parte superior de este con un mensaje que indica que el navegador impide que el sitio web abra ventanas emergentes. Elija el anuncio o el icono y, a continuación, seleccione Permitir ventanas emergentes.

    Ubique la pestaña de la Consola de administración de AWS de modo que aparezca al lado de estas instrucciones. Lo ideal es que pueda ver las dos pestañas del navegador al mismo tiempo para que pueda seguir los pasos del laboratorio con mayor facilidad.

 
Tarea 1: conectarse a una instancia de EC2 de Amazon Linux mediante SSH.

En esta tarea, se conectará a una instancia de EC2 de Amazon Linux. Usará una utilidad SSH para llevar a cabo todas estas operaciones. Las siguientes instrucciones varían ligeramente en función de si utiliza Windows, Mac o Linux.
 Usuarios de Windows: uso de SSH para conectarse

 Estas instrucciones son específicamente para usuarios de Windows. Si utiliza macOS o Linux, pase a la siguiente sección.

    Seleccione el menú desplegable Details (Detalles) que se encuentra arriba de estas instrucciones y, luego, seleccione Show (Mostrar). Se abrirá la ventana Credentials (Credenciales).

    Seleccione Download PPK (Descargar PPK) y guarde el archivo labsuser.ppk.
    Por lo general, el navegador lo guarda en el directorio Descargas.

    Anote la dirección PublicIP.

    A continuación, haga clic en la X para salir del panel Details (Detalles).

    Descargue PuTTY a SSH en la instancia de Amazon EC2. Si no tiene PuTTY instalado en su equipo, descárguelo aquí.

    Abra putty.exe.

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

 
Tarea 2: comprobar el estado del servicio httpd.

Httpd es el servicio para el servidor http Apache que está instalado en su host. Se trata de un servidor web ligero, como los que ejecutan los sitios web favoritos (piense, por ejemplo, en amazon.com). En este ejercicio, se comprueba el estado del servicio httpd. Se debe iniciar utilizando el comando systemctl y se verifica que el servicio funciona.

    Sugerencia útil

    Es posible que deba utilizar sudo para realizar este ejercicio si no es un usuario raíz.

    Compruebe el estado del servicio httpd utilizando los comandos systemctl, como se muestra a continuación, y presionando Intro.

    sudo systemctl status httpd.service

    Resultado esperado:

    En el símbolo del sistema, se muestra el resultado después de ingresar sudo systemctl status httpd.service.

    Figura: El comando sudo systemctl status httpd.service y el resultado indican que la sección del servicio httpd está inactiva (muerta).

     

    Esto indica que el servicio httpd está cargado, lo que significa que está instalado y listo para funcionar, pero está inactivo.
    Por lo tanto, el siguiente paso es ponerlo en marcha

    Compruebe el estado del servicio httpd utilizando los comandos systemctl, como se muestra a continuación, y presionando Intro.

    sudo systemctl start httpd.service

    Compruebe de nuevo el estado del servicio httpd utilizando los comandos systemctl, como se muestra a continuación, y presionando Intro.

    sudo systemctl status httpd.service

    Resultado esperado

    En el símbolo del sistema, se muestra el resultado después de ingresar sudo systemctl status httpd.service.

    Figura: El comando sudo systemctl status httpd.service y el resultado indican que la sección del servicio httpd está activa (en ejecución).

     

    Una vez que el httpd se esté ejecutando, debemos comprobar que funciona correctamente. Abra una nueva pestaña en su navegador e ingrese: http://<publicip>. Reemplace <publicip> por la IP pública que recuperó al principio del curso.

    Resultado esperado

    En la imagen, se muestra un navegador con la página de prueba del servidor HTTP Apache abierta.

    Figura: Cuando httpd esté ejecutándose correctamente, aparecerá una página de prueba de Apache con información general sobre la operación correcta del servidor HTTP Apache.

 

    Luego, podrá detener el servicio ingresando el siguiente comando y presionando INTRO

    sudo systemctl stop httpd.service

 
Tarea 3: supervisar una instancia de EC2 de Linux

En este ejercicio, utilizará los comandos de Linux para supervisar la instancia de EC2 de Amazon Linux2. También abrirá la consola de AWS e iniciará sesión en CloudWatch para ver cómo este servicio puede proporcionarle datos para supervisar la instancia.

    Sugerencia útil

    Es posible que deba utilizar sudo para realizar este ejercicio si no es un usuario raíz.

    Muestre la lista de procesos en ejecución ingresando el siguiente comando y presionando Intro.

    top

    Resultado esperado

    En la imagen, se muestra el resultado del comando top con un uso normal de la CPU.

    Figura: Cuando se ejecuta el comando top, el resultado mostrará los procesos en ejecución actuales y los usos de recursos.

    Top muestra los procesos que se están ejecutando en el momento y el uso de recursos, como el uso de la CPU y la memoria. Presione Q para salir y volver al intérprete de comandos.
    En el siguiente paso, se ejecutará un script que simula una carga de trabajo en la CPU.

    Ejecute el script stress.sh que simula una carga de trabajo pesada en la instancia de EC2 ingresando el siguiente comando y presionando Intro.

    ./stress.sh & top

    Al igual que en el paso 1, muestre la lista de procesos en ejecución ingresando el comando top y presionando Intro.

    Resultado esperado

    En la imagen, se muestra el resultado del comando top con una alta carga de CPU.

    Figura: En el símbolo del sistema, se muestra un alto uso de la CPU después de ejecutar un script. Muestra al usuario como ec2-user, el porcentaje de CPU a 14-14,3 y el comando utilizado fue stress.

     

    Puede ver que el proceso que acaba de ejecutar tiene un alto uso de la CPU. El script está diseñado para ejecutarse durante 6 minutos antes de detenerse.

    En los siguientes pasos, abrirá la Consola de administración de AWS y comenzará a utilizar la aplicación AWS CloudWatch, que le permitirá conocer mejor su instancia de EC2.

    En la parte superior derecha de la pantalla, seleccione el botón AWS. Esto muestra la Consola de administración de AWS en una nueva pestaña.

    En la barra de búsqueda en la parte superior de la pantalla, ingrese CloudWatch y presione Intro.

    Resultado esperado

    La barra de búsqueda en la consola de AWS con la palabra CloudWatch ingresada.

    La consola de AWS incluye una barra de búsqueda que puede usar para buscar servicios.

 

    En la sección de la izquierda del panel de navegación, seleccione Panel y, luego, Paneles automáticos. En la lista de Paneles automáticos, seleccione EC2.

    Resultado esperado

    En la imagen, se muestran los paneles de AWS CloudWatch.

    Figura: En los paneles de CloudWatch, Eventos de CloudWatch, Registros de CloudWatch y EC2 aparecen como los tres paneles principales.

     

    Esto abre el panel de EC2 que AWS creó para usted.   

    Resultado esperado

    En la imagen, se muestra el panel de EC2 de CloudWatch y los gráficos de informes de las instancias de EC2 de la cuenta.

    Figura: Los gráficos que se muestran son CPU Utilization, DiskReadBytes, DiskReadOps, DiskWriteBytes, DiskWriteOps y NetworkIn para las instancias de EC2 de la cuenta.

     

    Puede ver que, de forma predeterminada, el panel de EC2 de CloudWatch muestra varias métricas, como la utilización de la CPU, lecturas y escrituras de disco… 

    Puede ver un pico en la utilización de la CPU que coincide con el momento en que comenzó el script de stress con anterioridad.

        Nota

        Los paneles son personalizables, por lo que puede agregar o eliminar widgets, 
        reorganizarlos, personalizar los colores… AWS CloudWatch ofrece muchas 
        más funciones, como las alarmas o los desencadenadores de eventos, que descubrirá 
        más adelante y que lo convierte en un servicio de AWS clave para supervisar sus aplicaciones
        en tiempo real. Actualice el promedio de 5 minutos a 1 segundo para revisar 
        las actualizaciones con más rapidez. 

    Espere 5 minutos y vuelva al panel de AWS CloudWatch. Se puede observar que la utilización de la CPU ha bajado

    Resultado esperado

    En la imagen, se muestra la utilización promedio de la CPU de AWS CloudWatch. En el gráfico, se muestra el pico inicial de utilización de la CPU y, luego, un descenso.

    Figura: En el gráfico, se muestra la utilización promedio de la CPU. En este promedio, el porcentaje más alto que alcanza es del 62,6 por ciento cerca del minuto 8 y se mantiene alrededor del 33 por ciento para volver a bajar justo después de la marca del minuto 9.  

        Nota

        De forma predeterminada, AWS CloudWatch acumula datos durante 5 minutos antes de procesarlos. Esta es la configuración que se puede cambiar. 