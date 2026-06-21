---
title: "Lab 262: Direcciones IP estáticas y dinámicas"
parent: Entrega 2
nav_order: 9
---
Protocolos de Internet: direcciones estáticas y dinámicas

Situación

Usted es un ingeniero de soporte en la nube en Amazon Web Services (AWS). Durante su turno, un cliente de una empresa Fortune 500 solicita asistencia por un problema de redes dentro de su infraestructura de AWS. A continuación, se encuentran el correo y un archivo adjunto de su arquitectura:
Ticket del cliente

    ¡Hola, equipo de soporte en la nube!

    Tenemos problemas con una de nuestras instancias EC2. La IP cambia cada vez que iniciamos y detenemos esta instancia, que se llama Instancia pública. Esto hace que nada funcione, ya que se necesita una dirección IP estática. No estamos seguros de por qué la IP cambia en esta instancia a una IP aleatoria cada vez. ¿Podrían investigarlo? Adjunto nuestra arquitectura. Dígame si tiene alguna pregunta.

    Un saludo cordial,
    Bob, administrador de la nube

Diagrama de arquitectura

Arquitectura del cliente de una VPC, una puerta de enlace de Internet, una subred pública y una instancia de EC2.

Imagen: arquitectura de VPC del cliente, que incluye una subred pública y una instancia de EC2

Objetivos

En esta sesión de laboratorio, hará lo siguiente:

    Resumir la situación del cliente

    Analizar la diferencia entre direcciones IP asignadas de manera estática y dinámica mediante las instancias EC2

    Asignar una IP persistente (estática) a una instancia de EC2

    Desarrollar una solución para el problema de los clientes analizado en esta sesión de laboratorio. Después de desarrollar una solución, resumir y describir las conclusiones.

Duración

La duración total de esta sesión de laboratorio es de 60 minutos.

Restricciones del servicio de AWS

En el entorno de este laboratorio, es posible que el acceso a los servicios de AWS y a sus respectivas acciones esté restringido a los servicios que son necesarios para completar las instrucciones del laboratorio. Puede que encuentre errores si intenta acceder a otros servicios o ejecutar acciones aparte de las que se detallan en este laboratorio.

Acceso a la Consola de administración de AWS

    En la parte superior de estas instrucciones, seleccione Start Lab (Iniciar laboratorio) para iniciar el laboratorio.
    Se abrirá el panel Start Lab (Iniciar laboratorio) y se mostrará el estado del laboratorio.

        Sugerencia: Si necesita más tiempo para completar el laboratorio, vuelva a presionar el botón Start Lab (Iniciar laboratorio) para reiniciar el temporizador del entorno.

    Espere hasta que aparezca el mensaje: Lab status: ready (Estado de la sesión de laboratorio: listo) y, a continuación, haga clic en la X para cerrar el panel Start Lab (Iniciar laboratorio).

    En la parte superior de estas instrucciones, elija AWS.
    La consola de administración de AWS se abrirá en una pestaña nueva del navegador. El sistema iniciará sesión de forma automática.

        Sugerencia: si no se abre una pestaña nueva del navegador, suele aparecer un anuncio o un icono en la parte superior de este con un mensaje que indica que el navegador impide que el sitio web abra ventanas emergentes. Elija el anuncio o el icono y, a continuación, seleccione Allow pop-ups (Habilitar ventanas emergentes).

    Ubique la pestaña de la Consola de administración de AWS de modo que aparezca al lado de estas instrucciones. Lo ideal es que pueda ver las dos pestañas del navegador al mismo tiempo para que pueda seguir los pasos del laboratorio con mayor facilidad.

Tarea 1: investigar el entorno del cliente

Recuerde lo que ha aprendido sobre las direcciones IP estáticas y dinámicas. ¿Qué tipo de dirección IP cree que Bob asignó a su instancia de EC2 si cambia de forma constante cuando se detiene y se vuelve a iniciar? Para poner a prueba esta teoría, lanzará una instancia de EC2 en el entorno de la sesión de laboratorio de AWS. Comenzará con la configuración del cliente y solucionará el problema desde allí.

Para la tarea 2, investigará el entorno del cliente y replicará su problema.

En esta situación, Bob, que es el cliente que solicita asistencia, tiene problemas con su instancia de EC2 que cambia de forma constante las direcciones IP cada vez que detiene e inicia su instancia. No puede dejar la instancia encendida porque le resulta muy costoso y, además, necesita que esta dirección IP se establezca en una dirección IP estática o, de lo contrario, sus otros recursos adjuntos dejan de funcionar.

    En la parte superior derecha de estas instrucciones, elija AWS. La Consola de administración de AWS se abrirá en una pestaña nueva del navegador.

    Una vez que esté en la consola de AWS, escriba y busque EC2 en la barra de búsqueda en la parte superior. Seleccione EC2 en la lista.

    Sugerencia: Como alternativa, también puede buscar EC2 en Services (Servicios) - Compute (Cómputo), en la esquina superior izquierda.

    La barra de búsqueda se puede utilizar para encontrar el servicio Amazon EC2. Una vez que encuentre el servicio, selecciónelo.

    Imagen: barra de búsqueda de la Consola de administración de AWS.

    Ahora, se encuentra en el panel de Amazon EC2. En el menú de navegación izquierdo, seleccione Instances (Instancias). Esta opción lo lleva a las instancias EC2 actuales. Por el momento, debería ver una instancia de EC2, que puede ignorarla por ahora. No usaremos esa instancia, ya que lanzaremos la nuestra para la tarea 1.

        En la esquina superior derecha, seleccione Launch instances (Iniciar instancias). Así es como lanzará las instancias EC2 desde la consola.

   Iniciar instancia de EC2

   Imagen: seleccione el botón ubicado en la esquina superior derecha para iniciar instancias de EC2.

    Siga los pasos a continuación para completar la creación de una instancia de Amazon EC2:

    Paso 1: establecer el nombre

        En la sección Name and tags (Nombre y etiquetas), escriba test instance en el campo Name (Nombre).

    Paso 2: elegir una Imagen de máquina de Amazon (AMI)

        En la sección Application and OS Images (Amazon machine Image) (Imágenes de la aplicación y el sistema operativo [Imagen de máquina de Amazon]), seleccione Amazon Linux en la pestaña Quick Start.

        Asegúrese de seleccionar Amazon Linux 2023 AMI en el menú desplegable.
        Una AMI es una plantilla que contiene el sistema operativo (SO) y la configuración de la instancia de EC2.

    Paso 3: elegir un tipo de instancia

        En la sección Instance type (Tipo de instancia), seleccione t2.micro si está disponible; en caso contrario, seleccione t3.micro.

    Paso 4: seleccionar un par de claves

    En la sección Par de claves (inicio de sesión), en la lista desplegable, seleccione el par clave vockey.

        Paso 5: configurar los valores de red

            En la parte superior de Network Settings (Configuración de red), seleccione Edit (Editar) y configure las siguientes opciones.

            VPC: obligatoria, seleccione vpc-xxxxxxxx | VPC del laboratorio

            Subred: elija subnet-xxxxxx | Subred pública 1

            Autoasignación de IP pública: seleccione “Habilitada”

            En Firewall (security groups) (Firewall [Grupos de seguridad]), seleccione el botón de opción Select an existing security group (Seleccionar un grupo de seguridad existente) y el grupo de seguridad con el nombre Linux Instance SG (Instancia SG de Linux).

        Paso 6: iniciar una instancia

            En la esquina inferior derecha del panel Summary (Resumen), seleccione Launch Instance (Iniciar instancia).

            En l a parte inferior de la página Next Steps - preview (Próximos pasos: vista previa), seleccione View all instances (Ver todas las instancias).

    Volverá al panel de EC2 y verá la instancia de EC2 que acaba de crear. Seleccione test instance(instancia de prueba). En el estado de la instancia, verá el estado Initializing (Inicializando). Espere hasta que lea 2/2 antes de continuar.

    En esta imagen, se muestra el estado actual de la instancia. Cuando se inicia la instancia, antes de usarla, debe tener el estado “ready” (listo).

    Imagen: las instancias pasan por distintos estados, al igual que una computadora cuando se enciende. Cuando esté lista para usar, el estado será “running” (en ejecución) y podrá usarla en servicios, como SSH.

    Seleccione la casilla de verificación de la instancia de prueba. En la parte inferior, seleccione la pestaña Networking (Redes). En esta pestaña, observe y anote la dirección IPv4 pública y la dirección IPv4 privada. Una vez anotadas, navegue hasta la parte superior derecha de la ventana, seleccione el botón desplegable Instance state (Estado de la instancia) y, luego, seleccione Stop instance (Detener instancia). Una vez que el Instance state (Estado de la instancia) cambie a Stopped (Detenido), navegue hacia abajo, hasta las pestañas, y observe la dirección IPv4 pública y privada.

    En esta imagen, se muestra la pestaña de redes de la instancia. Aquí puede ver direcciones IPv4 públicas y privadas, DNS IPv4 públicas y privadas, ID de VPC, ID de subred y zonas de disponibilidad.

    Imagen: esta es la pestaña de redes para las instancias. Aquí se muestran todas las configuraciones de red relacionadas con la instancia, como las direcciones IPv4 pública y privada, y DNS IPv4 pública y privada.

     

    Cuando detenga una instancia, navegue hasta la parte superior del panel de EC2 y seleccione el botón “Instance state” (Estado de la instancia) y, luego, “Stop instance” (Detener instancia).

    Imagen: para iniciar, detener o finalizar una instancia, navegue hasta la parte superior del panel de EC2 y seleccione el botón “Instance state” (Estado de la instancia).

    Ahora, reinicie la instancia de prueba. Para ello, navegue hasta la ventana superior y seleccione Instance state (Estado de la instancia) y Start instance (Iniciar instancia). Espere hasta que el Instance state (Estado de la instancia) cambie a Running (En ejecución). Tome nota de las direcciones IPv4 pública y privada. ¿Qué observó entre las direcciones IP pública y privada cuando detuvo e inició la instancia de EC2? ¿Consideraría que esta IP pública es una dirección IP estática o dinámica? ¿Cuál consideraría que es la dirección IP privada de la instancia de EC2? ¿Cree que hemos replicado el problema del cliente?

    Cuando se reinició la instancia, en la imagen, se volvió a visitar la pestaña “networking” (redes).

    Imagen: al iniciar la instancia, puede ver cómo se completan los detalles de la pestaña “Networking” (Redes).

    Todavía no hemos resuelto el problema del cliente. Bob necesita una dirección IP pública permanente que no cambie cuando detiene y reinicia su instancia. AWS tiene una solución que asigna una dirección IP pública persistente a una instancia de EC2, llamada IP elástica (EIP).

    Desde el panel de EC2, vaya a Network and Security (Red y seguridad) en el menú de navegación izquierdo y seleccione Elastic IPs (IP elásticas). Observe que no hay EIP (IP elásticas). Seleccione el botón Allocate Elastic IP address (Asignar dirección IP elástica) en la parte superior derecha para crear una. Mantenga todos los parámetros como predeterminados y presione Allocate (Asignar). Tome nota de la dirección EIP.

    En esta imagen, se muestra la página de inicio de EIP cuando se selecciona “Elastic IP addresses” (Direcciones IP elásticas). Aquí es donde asignará una EIP al navegar hasta el botón superior derecho y al seleccionar “Allocate Elastic IP” (Asignar dirección IP elástica).
    Imagen: seleccione el botón “Allocate Elastic IP address” (Asignar dirección IP elástica) para asignar una EIP.

    Marque la casilla de verificación para seleccionar la EIP que acaba de crear. Ahora, adjunte esta dirección IP pública permanente a la instancia dinámica. Para ello, navegue hasta la esquina superior derecha, luego hasta Actions (Acciones) y, después, hasta Associate Elastic IP address (Asociar dirección IP elástica).

    En esta imagen, se muestra que se seleccionó la EIP creada y, ahora, la asociará a una instancia. Para ello, navegue hasta el menú desplegable “Actions” (Acciones), ubicado en la parte superior, y seleccione “Associate Elastic IP address” (Asociar dirección IP elástica).

    Imagen: la EIP creada ahora la asociará a la instancia de EC2. Para ello, navegue hasta el menú de acciones y seleccione “Associate Elastic IP address” (Asociar dirección IP elástica).

    Deje el tipo de recurso como “Instance” (Instancia) y seleccione la instancia de prueba desde el menú desplegable Choose an Instance (Elegir una instancia). En Private IP address (Dirección IP privada), seleccione la casilla vacía. De esta forma, se selecciona la IP privada asociada a la instancia. Haga clic en el botón Associate (Asociar).

    En esta imagen, se muestra la asociación de la EIP al tipo de recurso, que es una instancia, al elegir la instancia que creó en la sesión de laboratorio y al seleccionar “Associate” (Asociar).

    Imagen: asociar la EIP a la instancia de prueba.

    Regrese a la página Instances (Instancias) mediante el panel de navegación izquierdo. Seleccione la casilla de verificación de la instancia de prueba y navegue hasta la pestaña Networking (Redes). Tome nota de la dirección IPv4 pública. ¿Notó que la dirección EIP ahora es la dirección IP pública? Ahora, detenga e inicie la instancia y observe las diferencias. ¿Qué observó? ¿Es esta una dirección IP estática o dinámica? ¿Resolvió el problema del cliente? ¿Por qué sí o por qué no?

Tarea 2: enviar la respuesta al cliente (actividad grupal)

Desde el grupo, envíe las conclusiones.

La persona 1 actuará como Bob, el cliente, mientras que la persona 2 como el ingeniero de soporte en la nube. La persona 2 hablará sobre sus conclusiones con la persona 1.

    Nota

    Esta tarea solo debería tomar de 5 a 10 minutos. Explique las conclusiones a la clase.

Laboratorio completo

 ¡Felicitaciones! Ha completado el laboratorio.

    Seleccione End Lab (Finalizar laboratorio) en la parte superior de esta página y, luego, Yes (Sí) para confirmar que desea finalizar la sesión.
    Aparecerá un panel en el que se indica: “DELETE has been initiated… You may close this message box now.” (Se ha iniciado la ELIMINACIÓN… Ya puede cerrar este cuadro de mensajes).

    Seleccione la X que se encuentra en la esquina superior derecha para cerrar el panel.

Recapitulación

En esta sesión de laboratorio, investigó el entorno del cliente y aplicó técnicas de solución de problemas con las que pudo resolver el problema del cliente. En esta situación, descubrió que la instancia de Amazon EC2 del cliente (una instancia pública) tenía una dirección IP dinámica que hacía que cambiara de forma constante de IP cuando la instancia se detenía e iniciaba. Para solucionar este problema, sugirió adjuntar una EIP para que la IP se vuelva persistente (estática). Esto se probó mediante SSH en la instancia de prueba y al iniciarla y detenerla con una dirección IP dinámica.

Recursos adicionales

Direccionamiento IP público de la instancia Amazon EC2

EIP

Para obtener más información sobre AWS Training and Certification, consulta <https://aws.amazon.com/training/>.

Sus comentarios son bienvenidos y valorados.
Si desea compartir sugerencias o correcciones, proporcione los detalles en nuestro formulario de contacto de AWS Training and Certification.

© 2023, Amazon Web Services, Inc. y sus empresas afiliadas. Todos los derechos reservados. Este contenido no puede reproducirse ni redistribuirse, total ni parcialmente, sin el permiso previo por escrito de Amazon Web Services, Inc. Queda prohibida la copia, el préstamo o la venta de carácter comercial.
