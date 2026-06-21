---
title: "Lab 263: Creaciones de redes en una VPC"
parent: Entrega 2
nav_order: 10
---
Creación de subredes y asignación de direcciones IP en una Amazon Virtual Private Cloud (Amazon VPC)

 
Objetivos

En esta sesión de laboratorio, hará lo siguiente:

    Resumir la situación del cliente

    Crear una Amazon Virtual Private Cloud (Amazon VPC) y aprender a crear subredes y asignar direcciones IP

    Familiarizarse con la Consola de administración de Amazon Web Services (AWS)

    Desarrollar una solución al problema del cliente planteado en este laboratorio

    Resumir y describir los hallazgos (actividad grupal)

Duración

El tiempo estimado para completar este laboratorio es de 1 hora.

 
Situación

El rol es el de un ingeniero de soporte en AWS. Durante su turno, un cliente de una empresa emergente solicita asistencia con respecto a un problema de redes que tiene en su infraestructura de AWS. A continuación, figuran el correo y un archivo adjunto de su arquitectura:

 
Ticket del cliente

    ¡Hola, equipo de soporte en la nube!

    Soy nuevo en AWS y necesito ayuda para configurar una VPC. ¿Me pueden ayudar con el proceso de configuración? Me gustaría crear solo la parte de la VPC y que se pareciera a la de la siguiente imagen. ¿Me pueden ayudar a garantizar que tenga alrededor de 15,000 direcciones IP privadas en esta VPC disponible?  También me gustaría que el bloque de CIDR IPv4 de la VPC sea 192.x.x.x. Sin embargo, no recuerdo cuál es el rango privado. ¿Podrían confirmarme eso? También me gustaría asignar, al menos, 50 direcciones IP para la subred pública.

    Un saludo cordial,
    Paulo Santos
    Propietario de la empresa emergente

 
Diagrama del cliente

La arquitectura de VPC del cliente consta de una VPC que requiere 15,000 direcciones IP, una puerta de enlace de Internet y una subred pública que requiere 50 direcciones IP

Imagen: en la arquitectura de VPC del cliente, el cliente necesita alrededor de 15,000 direcciones IP para la sede central de Seattle, y 50 direcciones IP para el departamento de operaciones, que estarán en la subred pública.

 
Restricciones del servicio de AWS

En este entorno de laboratorio, es posible que el acceso a los servicios de AWS y a las acciones del servicio esté restringido a los que usted necesita para completar las instrucciones del laboratorio. Es posible que encuentre errores si intenta acceder a otros servicios o si ejecuta acciones que no se detallan en este laboratorio.

 
Acceso a la consola de administración de AWS

    En la parte superior de estas instrucciones, seleccione Start Lab (Iniciar laboratorio) para iniciar el laboratorio.
    Se abrirá el panel Start Lab (Iniciar laboratorio) y se mostrará el estado del laboratorio.

        Sugerencia: Si necesita más tiempo para completar el laboratorio, vuelva a presionar el botón Start Lab (Iniciar laboratorio) para reiniciar el temporizador del entorno.

    Espere hasta que aparezca el mensaje: Lab status: ready (Estado de la sesión de laboratorio: listo) y, a continuación, haga clic en la X para cerrar el panel Start Lab (Iniciar laboratorio).

    En la parte superior de estas instrucciones, elija AWS.
    La consola de administración de AWS se abrirá en una pestaña nueva del navegador. El sistema iniciará sesión de forma automática.

        Sugerencia: si no se abre una pestaña nueva del navegador, suele aparecer un anuncio o un icono en la parte superior de este con un mensaje que indica que el navegador impide que el sitio web abra ventanas emergentes. Elija el anuncio o el icono y, a continuación, seleccione Allow pop-ups (Habilitar ventanas emergentes).

    Ubique la pestaña de la Consola de administración de AWS de modo que aparezca al lado de estas instrucciones. Lo ideal es que pueda ver las dos pestañas del navegador a la vez para seguir los pasos del laboratorio con mayor facilidad.

 
Tarea 1: investigar el entorno del cliente

En cursos anteriores, abordó la finalidad de las subredes IP y el uso notaciones de enrutamiento interdominio sin clase (CIDR). A medida que avance en esta sesión, piense qué notación de CIDR debe usar el cliente para la VPC y la subred.

Antes de comenzar, repase con rapidez qué es una VPC:

    Una VPC es como un centro de datos, pero en la nube. Está aislada de forma lógica de otras redes virtuales y puede usar VPC para activar y lanzar los recursos de AWS en cuestión de minutos.

    Los recursos dentro de una VPC se comunican entre sí a través de direcciones IP privadas. Una instancia necesita una dirección IP pública para comunicarse por fuera de la VPC. La VPC necesita recursos de red, como una puerta de enlace de Internet y una tabla de enrutamiento, para que la instancia llegue a Internet.

    Un bloque de CIDR es un rango de direcciones IP privadas que se utiliza dentro de la VPC (por ejemplo, el número /16 que se encuentra junto a una dirección IP).

    Una subred es un rango de direcciones IP que se encuentra dentro de la VPC.

    Para determinar el rango de CIDR, puede usar la siguiente calculadora de terceros: https:/www.subnet-calculator.com/

    Para determinar el rango recomendado de direcciones IP privadas que puede usar, puede consultar la siguiente guía: https:/datatracker.ietf.org/doc/html/rfc918.

Para la tarea 1, investigará las necesidades del cliente y creará un entorno de VPC basado en los requisitos de este. Luego, creará un recorrido corto y simple para el cliente.

En esta situación, Paulo, que es el cliente que solicita asistencia, pasó a usar AWS y desea recibir asistencia para lanzar su primera VPC. Tiene ciertos conocimientos sobre redes, pero es nuevo en AWS. Sabe que necesita alrededor de 15,000 direcciones IP en el rango privado dentro de la VPC y le gustaría tener una subred pública. También quisiera asignar, al menos, 50 direcciones IP a la subred pública.   

Para el cliente, creará una VPC y una guía sobre cómo lanzar una.

    En la parte superior derecha de estas instrucciones, elija AWS. La Consola de administración de AWS se abrirá en una pestaña nueva del navegador.

    Una vez que esté en la consola de AWS, escriba y busque VPC en la barra de búsqueda en la parte superior. Seleccione VPC desde la lista.

    Sugerencia: Como alternativa, también puede buscar VPC en Services (Servicios) - Networking & Content Delivery (Redes y entrega de contenido) en la esquina superior izquierda.

    La barra de búsqueda se puede utilizar para buscar el servicio Amazon VPC. Una vez que encuentre el servicio, selecciónelo.

    Imagen: barra de búsqueda de la Consola de administración de AWS.

    Ahora se encuentra en el panel de Amazon VPC. Utilice el servicio Amazon Virtual Private Cloud (Amazon VPC) para crear la VPC.

    Elija Create VPC (Crear VPC) y configure las siguientes opciones:

        Resources to create (Recursos a crear): elija VPC and more (VPC y más).

        En Name tag auto-generation (Generación automática de etiqueta de nombre): ingrese First.

        IPv4 CIDR: ingrese 192.168.0.0/18.

        Utilice la siguiente calculadora de direcciones IP: https://www.subnet-calculator.com/.

        IPv6 CIDR block (Bloque de CIDR IPv6): seleccione No IPv6 CIDR block (sin bloque de CIDR IPv6).

        Tenancy (Tenencia): seleccione Default (Predeterminado).

        Number of availability Zones (AZs) (Número de zonas de disponibilidad): 1

        Number of public subnets (Número de subredes públicas): 1

        Number of private subnets (Número de subredes privadas): 0

        Expanda Customize subnets CIDR blocks (Personalizar bloques de CIDR de las subredes)

            Public subnet CIDR block in us-west-2a (Bloque de CIDR de la subred pública en us-west-2a): 192.168.1.0/26

        VPC endpoints (Puntos de enlace de la VPC): elija None (Ninguno).

        Elija Create VPC (Crear VPC).

        En la siguiente pantalla, se mostrará el mensaje Success (Éxito) con los detalles del VPC. 

        Seleccione View VPC (Ver VPC). 

        Los detalles de First-vpc se muestran según la configuración.

Pregunta: ¿Qué configuraciones de VPC cree que se han utilizado en sesiones de laboratorio anteriores?

Si pensó que se han utilizado VPC con una subred, la respuesta es correcta. Según las necesidades del cliente, es posible que solo utilice varias subredes públicas o subredes públicas y privadas. Esto depende de lo que necesite hacer.
Para esta tarea, Brock quiere usar una VPC with a Single Public Subnet (VPC con una subred pública única) según su diagrama.

Pregunta: ¿Por qué cree que hay subredes públicas y privadas?

Las subredes públicas son instancias a las que se puede acceder a través de Internet y que acceden a Internet con una IP pública y una puerta de enlace de Internet. Las subredes privadas mantienen las instancias privadas y no se pueden abordar desde Internet. En el caso de las instancias dentro de una subred privada para conectarse a Internet, necesitará lo que se llama puerta de enlace de traducción de direcciones de red (NAT), que se trata en mayor detalle en una sección posterior.

Pregunta: ¿por qué cree que se utilizan las direcciones IP privadas dentro de la VPC?

No se puede acceder a las direcciones IP privadas a través de Internet. Esto mantiene los recursos y la comunicación entre sí privados dentro de la VPC.

 
Tarea 2: enviar la respuesta al cliente (actividad grupal)

En grupos de dos, envíen los hallazgos.

La persona 1 actúa como Brock, el cliente y la persona 2 como ingeniero de soporte en la nube. La persona 2 explica cómo crearía la VPC con la persona 1.

    Nota

    Esta tarea solo debería tomar unos 30 minutos. Si no es posible realizar una actividad grupal, haga que un estudiante analice sus conclusiones con la clase.

 
Laboratorio completo 

 ¡Felicitaciones! Ha completado el laboratorio.

    Seleccione End Lab (Finalizar laboratorio) en la parte superior de esta página y, luego, Yes (Sí) para confirmar que desea finalizar la sesión.
    Aparecerá un panel en el que se indica: “DELETE has been initiated… You may close this message box now.” (Se ha iniciado la ELIMINACIÓN… Ya puede cerrar este cuadro de mensajes).

    Seleccione la X que se encuentra en la esquina superior derecha para cerrar el panel.

 
Recapitulación

En esta sesión de laboratorio, investigó el entorno del cliente y analizó su solicitud para crear un recorrido exitoso por su entorno. A través de esta experiencia, aprendió a lanzar una VPC, qué bloque y rango de CIDR brindar al cliente y a mostrarle cómo crear una VPC.

 
Recursos adicionales

    ¿Qué es Amazon VPC?

    Direccionamiento IP en su VPC

    RFC 1918

    CIDR DE VPC

    Calculadora de subredes

Para obtener más información sobre AWS Training and Certification, consulta https://aws.amazon.com/training/.

Sus comentarios son bienvenidos y valorados.
Si desea compartir sugerencias o correcciones, proporcione los detalles en nuestro formulario de contacto de AWS Training and Certification.

© 2023, Amazon Web Services, Inc. y sus empresas afiliadas. Todos los derechos reservados. Este contenido no puede reproducirse ni redistribuirse, total ni parcialmente, sin el permiso previo por escrito de Amazon Web Services, Inc. Queda prohibida la copia, el préstamo o la venta de carácter comercial.
