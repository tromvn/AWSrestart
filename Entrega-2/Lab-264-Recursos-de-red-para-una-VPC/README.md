---
title: "Lab 264: Recursos de red para una VPC"
parent: Entrega 2
nav_order: 11
---
Creación de recursos de redes en una Amazon Virtual Private Cloud (VPC)

 
Objetivos

En este laboratorio, realizará lo siguiente:

    Resumir la situación del cliente

    Crear una VPC, una puerta de enlace de Internet, una tabla de enrutamiento, un grupo de seguridad, una lista de acceso de redes y una instancia de EC2 para generar un red enrutable dentro de la VPC.

    Familiarizarse con la consola

    Desarrollar una solución para el problema del cliente presentado en esta sesión de laboratorio

La sesión de laboratorio se completará una vez que pueda utilizar con éxito el comando ping por fuera de la VPC.

 
Duración

La duración total de esta sesión de laboratorio es de 60 minutos.

 
Situación

Usted es un ingeniero de soporte en la nube en Amazon Web Services (AWS). Durante su turno, un cliente de una startup solicita asistencia con respecto a un problema de redes que tiene en su infraestructura de AWS. A continuación, se encuentran el correo y un archivo adjunto de su arquitectura.
Correo del cliente

    ¡Hola, equipo de soporte en la nube!

    Hace unos días, me puse en contacto con ustedes para solicitar ayuda, a fin de configurar mi VPC. Pensé que sabía adjuntar todos los recursos para establecer una conexión a Internet, pero ni siquiera puedo hacer ping por fuera de la VPC. ¡Todo lo que necesito es hacer ping! ¿Me pueden ayudar a configurar mi VPC donde tenga conectividad de red y pueda hacer ping? A continuación, se encuentra la arquitectura. Gracias.

    Brock, propietario de la startup

Una imagen de la arquitectura de VPC del cliente, que consta de una VPC con un rango de CIDR de 192.168.0.0/18, una puerta de enlace de Internet, una subred pública con un rango de CIDR de 192.168.1.0/26 y un grupo de seguridad que se encuentra alrededor de una instancia de EC2
									Arquitectura de VPC del cliente

 
Restricciones del servicio de AWS

En el entorno de este laboratorio, es posible que el acceso a los productos de AWS y a sus respectivas acciones esté restringido a aquellos que son necesarios para completar las instrucciones del laboratorio. Puede que encuentre errores si intenta acceder a otros productos o ejecutar acciones aparte de las que se detallan en este laboratorio.

 
Acceso a la Consola de administración de AWS

    En la parte superior de estas instrucciones, seleccione Start Lab (Comenzar laboratorio) para iniciar el laboratorio.
    Se abrirá el panel Start Lab (Comenzar laboratorio) y se mostrará el estado del laboratorio.

        Sugerencia: Si necesita más tiempo para completar el laboratorio, vuelva a presionar el botón Start Lab (Comenzar laboratorio) para reiniciar el temporizador del entorno.

    Espere hasta que aparezca el mensaje: Lab status: ready (Estado de la sesión de laboratorio: listo) y, a continuación, haga clic en la X para cerrar el panel Start Lab (Comenzar laboratorio).

    En la parte superior de estas instrucciones, seleccione AWS.
    La Consola de administración de AWS se abrirá en una pestaña nueva del navegador. El sistema iniciará sesión de forma automática.

        Sugerencia: si no se abre una pestaña nueva del navegador, suele aparecer un anuncio o un icono en la parte superior de este con un mensaje que indica que el navegador impide que el sitio web abra ventanas emergentes. Elija el anuncio o el icono y, a continuación, seleccione Permitir ventanas emergentes.

    Ubique la pestaña de la Consola de administración de AWS de modo que aparezca al lado de estas instrucciones. Lo ideal es que pueda ver las dos pestañas del navegador al mismo tiempo para que pueda seguir los pasos del laboratorio con mayor facilidad.

 
Tarea 1: investigar las necesidades del cliente
Recordatorio

Para la tarea 1, analizará la solicitud del cliente y creará una VPC que tenga conectividad de red. La sesión de laboratorio estará completa cuando pueda hacer ping con éxito desde la instancia de EC2 hasta Internet, lo que demuestra que la VPC tiene conectividad de red.

En esta situación, Brock, el cliente que solicita asistencia, pidió ayuda para crear los recursos de su VPC a fin de que se puedan enrutar a Internet. Mantenga el CIDR de la VPC en 192.168.0.0/18 y el CIDR de la subred pública en 192.168.1.0/26.

En el panel de navegación izquierdo de la página principal de VPC, verá un patrón para crear una VPC. Comience por “Your VPCs” (Sus VPC) y avance hacia abajo.
Imagen: una forma ideal de crear una VPC es seguir el panel de navegación izquierdo, comenzando por “Your VPCs” (Sus VPC) y siguiendo hacia abajo.

Antes de comenzar, revisemos la VPC y sus componentes para que sea compatible con la red.

    Una nube virtual privada (VPC) es como un centro de datos, pero en la nube. Está aislada de forma lógica de otras redes virtuales desde las que puede activar y lanzar los recursos de AWS en cuestión de minutos.

    Las direcciones de protocolo de Internet privado (IP) son la forma en que se comunican entre sí los recursos dentro de la VPC. Una instancia necesita una dirección IP pública para comunicarse por fuera de la VPC. La VPC necesita recursos de red, como una puerta de enlace de Internet (IGW) y una tabla de enrutamiento, para que la instancia llegue a Internet.

    La puerta de enlace de Internet (IGW) es lo que hace posible que la VPC tenga conectividad a Internet. Tiene dos funciones: realizar la traducción de las direcciones de red (NAT) y ser el objetivo para dirigir el tráfico a Internet para la VPC. La ruta de una IGW en una tabla de enrutamiento siempre es 0.0.0.0/0.

    Una subred es un rango de direcciones IP que se encuentra dentro de la VPC.

    Una tabla de enrutamiento contiene rutas para la subred y dirige el tráfico mediante las reglas definidas dentro de la tabla de enrutamiento. Asocie la tabla de enrutamiento a una subred. Si una IGW estuviera en una tabla de enrutamiento, el destino sería 0.0.0.0/0 y, el objetivo, IGW.

    Los grupos de seguridad y las listas de control de acceso a la red (NACL) funcionan como el firewall dentro de la VPC. Los grupos de seguridad funcionan al nivel de la instancia y tienen estado, lo que significa que bloquean todo de forma predeterminada. Las NACL funcionan al nivel de la subred y no tienen estado, lo que significa que no bloquean nada de forma predeterminada.

Pasos

    Seleccione el botón AWS que se ubica en la parte superior derecha del entorno de inicio de Vocareum. De esta forma, se abrirá la consola de AWS en una nueva pestaña.

    Una vez que se encuentre en la consola de AWS, haga clic en VPC, en Servicios visitados recientemente. Si no está allí, navegue hasta la esquina superior izquierda y seleccione VPC (VPC) en Networking and Content Delivery (Redes y entrega de contenido), en el panel de navegación Services (Servicios).

    Una imagen en la que se muestra la consola de administración de AWS y los servicios que se visitaron recientemente. En “Recently visited services” (Servicios visitados recientemente), debe haber un servicio de VPC que pueda seleccionar. Si no, tendrá que ir al menú desplegable de servicios.
    Figura: servicios visitados recientemente) en la consola de AWS

     

    Una imagen en la que se muestra el menú desplegable de servicios y cómo buscar el servicio de VPC desde la barra de búsqueda ubicada en la parte superior o al desplazarse hasta la parte inferior de la sección “Networking and Content Delivery” (Redes y entrega de contenido) y al seleccionar la VPC.
    Imagen: menú desplegable de navegación de servicios

 
Creación de la VPC
Recordatorio

    Comience por la parte superior del panel de navegación izquierdo, en Sus VPC, y avance hacia abajo. Seleccione Your VPCs (Sus VPC), navegue hasta la esquina superior derecha, y seleccione Crear VPC.

        Nota

        Nota: Utilizará una teoría de arriba hacia abajo y la parte superior será la VPC.

     

    En esta imagen, se muestra la página de inicio de VPC cuando se hace clic en “Your VPCs” (Sus VPC). Desde aquí, navegará hasta el botón superior derecho y seleccionará “Create VPC” (Crear VPC).
           Figura: navegue hasta “Sus VPC” y seleccione Crear VPC.

    Asigne un nombre a la VPC: Test VPC

    Bloque de CIDR IPv4: 192.168.0.0/18

    Deje el resto de los parámetros con los valores predeterminados y seleccione Crear VPC.

    En esta imagen, se muestra cómo se debería configurar. La etiqueta de nombre debería leer: “Test VPC, IPv4 CIDR block: 192.168.0.0/18” (VPC de prueba, bloque de CIDR IPv4: 192.168.0.0/18) y deje todos los demás parámetros como predeterminados.
        Imagen: configuración de ajustes de la VPC

 
Creación de subredes
Recordatorio

    Ahora que la VPC está completa, observe el panel de navegación izquierdo y seleccione Subredes. En la esquina superior derecha, seleccione Create subnet (Crear subred).

        Nota

        Tenga en cuenta que, aunque se puede crear casi todo en cualquier orden, es más fácil si se hace con un enfoque determinado. Seguir un flujo o un enfoque le servirá para solucionar problemas y garantizar que no se olvide un recurso.

      En esta imagen, se muestra la página de inicio de la subred cuando se hace clic en “Subnets” (Subredes). Desde aquí, navegará hasta el botón superior derecho y seleccionará “Create subnet” (Crear subred).
      Imagen: seleccione Crear subred

    Establezca la configuración según la siguiente imagen:

     En esta imagen, se muestra cómo se debería configurar. El ID de la VPC será “Test VPC” (VPC de prueba); en la configuración de la subred, el nombre de la subred será “Public subnet” (Subred pública); la zona de disponibilidad será “No preference” (Sin preferencias); y el bloque de CIDR IPv4 será “192.168.1.0/28”. Una vez que se complete, presione “Launch” (Iniciar).
           Imagen: configuración de la subred

 
Creación de una tabla de enrutamiento
Recordatorio

    Navegue hasta el panel de navegación izquierdo y seleccione Tablas de enrutamiento. En la esquina superior derecha, seleccione Create route table (Crear tabla de enrutamiento).

    En esta imagen, se muestra la página de inicio de la tabla de enrutamiento cuando se hace clic en “Route Tables” (Tablas de enrutamiento). Desde aquí, navegue hasta el botón superior derecho y seleccione “Create route table” (Crear tabla de enrutamiento).
       Figura: seleccione Crear tabla de enrutamiento.

    Establezca la configuración según la siguiente imagen:

       La tabla de enrutamiento se debe configurar de la siguiente manera: el nombre será “Public route table” (Tabla de enrutamiento pública), la VPC será “Test VPC” (VPC de prueba), y todos los demás parámetros se dejan como predeterminados. Por último, seleccione “Create route table” (Crear tabla de enrutamiento).
       Imagen: configuración de la tabla de enrutamiento

 
Creación de una puerta de enlace de internet y proceso para adjuntarla
En este laboratorio

    En el panel de navegación izquierdo, seleccione Gateways de Internet. Seleccione Create internet gateway (Crear puerta de enlace de Internet) en la esquina superior derecha para crear una puerta de enlace de Internet (IGW).

    En esta imagen, se muestra la página de inicio de las puertas de enlace de Internet cuando se hace clic en “Internet Gateways” (Puertas de enlace de Internet). Desde aquí, navegará hasta el botón superior derecho y seleccionará “Create internet gateway” (Crear puerta de enlace de Internet).
        Figura: seleccione Crear una gateway de Internet

    Establezca la configuración según la siguiente imagen:

    La puerta de enlace de Internet se configura de la siguiente manera: el nombre será “IGW test VPC” (VPC de prueba de la IGW), y todos los demás parámetros se dejan como predeterminados. Seleccione “Create internet gateway” (Crear puerta de enlace de Internet).
        Figura: configuración de una puerta de enlace de internet

    Una vez creada, adjunte la puerta de enlace de internet a la VPC. Para ello, seleccione Acciones en la esquina superior derecha y haga clic en Conectar a la VPC.

    En esta imagen, se muestra que lo lleva de regreso a la IGW que creó y que debe navegar hasta el botón de acciones ubicado en la parte superior y seleccionar “Attach to VPC” (Adjuntar a VPC).
         Imagen: adjuntar la IGW que acaba de crear.

    ¡Ya se adjuntó la IGW! Ahora debe agregar su ruta a la tabla de enrutamiento y asociar la subred que creó a la tabla de enrutamiento.

 
Cómo agregar la ruta a la tabla de enrutamiento y asociar la subred a la tabla de enrutamiento.

    Navegue hasta la sección Tabla de enrutamiento, que se ubica en el panel de navegación izquierdo. Seleccione Public Route Tables (Tablas de enrutamiento públicas), desplácese hasta la parte inferior y seleccione la pestaña Routes (Rutas). Seleccione el botón “Edit routes” (Editar rutas), ubicado en la casilla de rutas.

    En la página “Edit routes” (Editar rutas), la primera dirección IP es la ruta local, que no se puede modificar.

    Seleccione Add route (Agregar ruta).

        En la sección Destination (Destino), escriba 0.0.0.0/0 en la casilla de búsqueda. Esta es la ruta a la IGW. Se le indica a la tabla de enrutamiento que cualquier tráfico que necesite conectarse a Internet usará 0.0.0.0/0 para llegar a la IGW y a Internet.

        Haga clic en la sección Target (Destino) y seleccione Internet Gateway (Puerta de enlace de Internet), ya que está dirigiendo todo el tráfico que necesita ir a Internet a la IGW. Una vez que seleccione la IGW, aparecerá su TEST VPC IGW (IGW DE LA VPC DE PRUEBA). Seleccione esa IGW, navegue hasta la parte inferior derecha y seleccione Save changes (Guardar cambios).

    En esta imagen, se agrega la ruta de la IGW como 0.0.0.0/0 en la sección de destino de la tabla de enrutamiento, e IGW (VPC de prueba de IGW) como destino y se guardan los cambios.
    Imagen: agregar la IGW a la tabla de enrutamiento (0.0.0.0/0 como destino e IGW como objetivo).

    Ahora, el tráfico tiene una ruta a internet a través de la IGW.

    En el panel Tabla de enrutamiento pública, seleccione la pestaña Asociaciones de subredes. Seleccione el botón Edit subnet associations (Editar asociaciones de subred).

    Cuando seleccione la subred que quiere asociar, seleccione también la subred pública y presione “Save” (Guardar).
    Figura: asocie la subred pública y seleccione Guardar asociaciones.

    Seleccione Guardar asociaciones.

        Nota: Todas las tablas de enrutamiento deben estar asociadas a una subred. Ahora, está asociando esta tabla de enrutamiento a esta subred. Como habrá notado, la convención de nomenclatura se mantiene igual (tabla de enrutamiento pública, subred pública, etc.) para asociar los mismos recursos en conjunto. Tenga en cuenta esto cuando aumenten la red y los recursos. Puede haber varios recursos iguales y, por ende, generarse confusión sobre adónde pertenece cada uno.

     

Creación de una ACL de red
Recordatorio

    En el panel de navegación izquierdo, seleccione ACL de red. Navegue hasta la esquina superior derecha y seleccione Create network ACL (Crear ACL de red) para crear una lista de control de acceso a la red (NACL).

    En esta imagen, se muestra la página de inicio de las ACL de red cuando se selecciona “Network ACLs” (ACL de red). Desde aquí, navegará hasta el botón superior derecho y seleccionará “Create network ACL” (Crear ACL de red).
      Figura: seleccione Crear ACL de red

    En Crear ACL de red, configure lo siguiente:

        Nombre: Public Subnet NACL.

        VPC: seleccione Test VPC en el menú desplegable.

        Seleccione Crear ACL de red

    En la opción ACL de red, seleccione Public Subnet ACL (ACL de subred pública) de la lista de ACL.

    En las pestañas siguientes, seleccione Reglas de entrada y, a continuación, elija Editar reglas de entrada

    En Editar reglas de entrada, elija Agregar nueva regla y configure:

        Número de regla: ingrese 100.

        Tipo: seleccione Todo el tráfico del menú desplegable

    Elija Guardar cambios

    En la opción ACL de red, asegúrese de que esté seleccionada la opción Public Subnet ACL (ACL de subred pública)

    Elija Reglas de salida y luego Editar reglas de salida

    En Editar reglas de salida, elija Agregar nueva regla y configure:

        Número de regla: ingrese 100.

        Tipo: seleccione Todo el tráfico del menú desplegable

    Elija Guardar cambios
    ​ 
    Entrada Después de crear la NACL, debería tener el siguiente aspecto. Esto indica que hay un solo número de regla, que es 100 y que establece que todo el tráfico, todos los protocolos y todos los rangos de puerto desde cualquier fuente (0.0.0.0/0) pueden ingresar (entrar) a la subred. El asterisco * indica que se rechaza todo lo que no coincida con esta regla.

    En esta imagen, se muestran las reglas de entrada para la NACL. El número de regla es 100, lo que permite todo el tráfico de todos los protocolos, de cualquier rango, de cualquier fuente que entre a la subred. Rechazará todo lo que no coincida con esta regla.
    Imagen: configuración de regla de entrada predeterminada para NACL. Esto permitirá todo el tráfico desde cualquier lugar y rechazará todo lo demás que no coincida con esta regla en el nivel de subred.

    Salida ¿Qué cree que dice esta regla?
    En esta imagen, se muestran las reglas de salida para la NACL. El número de regla es 100, lo que permite todo el tráfico de todos los protocolos, de cualquier rango, de cualquier fuente que salga de la subred. Rechazará todo lo que no coincida con esta regla.
    Imagen: configuración de la regla de salida predeterminada para NACL. Esto permitirá todo el tráfico desde cualquier lugar y rechazará todo lo demás que no coincida con esta regla en el nivel de subred.

 
Creación de un grupo de seguridad
Recordatorio

    En el panel de navegación izquierdo, seleccione Grupos de seguridad. Navegue hasta la esquina superior derecha y seleccione Create security group (Crear grupo de seguridad) para crear uno.

    En esta imagen, se muestra la página de inicio de los grupos de seguridad cuando se selecciona “Security Groups” (Grupos de seguridad). Desde aquí, navegará hasta el botón superior derecho y seleccionará “Create security group” (Crear grupo de seguridad).
    	
    Imagen: seleccionar “Create security group” (Crear grupo de seguridad)

    Establezca la configuración según la siguiente imagen de la página “Basic details” (Detalles básicos):

    Nota: En la parte de la VPC, elimine la VPC actual y seleccione Test VPC (VPC de prueba).

    Esta es la configuración de los detalles básicos del grupo de seguridad. El nombre del grupo de seguridad es “public security group” (Grupo de seguridad público), la descripción es “allows public access” (Permite acceso público) y la VPC es la “test public VPC” (VPC pública de prueba).
          Imagen: configurar la página “Basic details” (detalles básicos)

    A continuación, se muestra el grupo de seguridad completo. Esto indica que, para las reglas de entrada, está permitiendo los tipos de tráfico SSH, HTTP y HTTPS, cada uno con sus propios protocolos y rango de puertos. La fuente desde la que este tráfico llega a la instancia se puede originar desde cualquier lugar. En el caso de las reglas de salida, está permitiendo todo el tráfico desde afuera de su instancia.

    En esta imagen, se muestra la configuración de las reglas de entrada y salida del grupo de seguridad. En esta imagen, figuran las reglas de entrada que permiten el tráfico de SSH, HTTP y HTTPS desde cualquier lugar y todo el tráfico de salida desde cualquier lugar.
    Imagen: detalles de configuración de las reglas de entrada y salida para el grupo de seguridad

Ahora tiene una VPC funcional. La siguiente tarea es lanzar una instancia de EC2 para verificar que todo funcione.

 
Tarea 2: lanzar la instancia de EC2 y establecer una conexión SSH con la instancia

En la tarea 2, iniciará una instancia de EC2 desde la subred pública y probará la conectividad mediante la ejecución del comando ping. De esta forma, verificará si la infraestructura es correcta, como los grupos de seguridad y las ACL de red, para asegurarse de que no bloqueen nada de tráfico de la instancia a Internet y viceversa. Así, verificará si tiene una ruta a la IGW a través de la tabla de enrutamiento y si la IGW está adjunta.

    En la Consola de administración de AWS, en la barra de búsqueda, ingrese y seleccione EC2 para ir a la Consola de administración de EC2.

    En el panel de navegación izquierdo, elija Instancias.

    Elija Lanzar instancias y configure las siguientes opciones:

    En la sección Name and tags (Nombre y etiquetas), deje la casilla Nombre en blanco.

    En la sección Application and OS Images (Amazon machine Image) (Imágenes de la aplicación y el sistema operativo [Imagen de máquina de Amazon]), configure las siguientes opciones:

        Quick Start: seleccione Amazon Linux.

        Imagen de máquina de Amazon (AMI): seleccione Amazon Linux 2023 AMI.

    En la sección Instance type (Tipo de instancia), elija t3.micro.

    En la sección Par de claves (inicio de sesión), elija vockey.

    En la sección Configuraciones de red, seleccione Editar y configure lo siguiente:

    VPC - required (VPC: obligatoria): elija Test VPC (VPC de prueba).

    Subnet (Subred): elija Public Subnet (Subred pública).

    Auto-assign Public IP (Asignar automáticamente IP pública): elija Enable (Habilitar).

    Firewall (grupos de seguridad): seleccione Select existing security group (Seleccionar un grupo de seguridad existente).

        Seleccione el grupo de seguridad público.

    Elija Lanzar instancia.

    Para consultar las instancias que se lanzaron, elija Ver todas las instancias.

     La instancia de EC2 denominada servidor bastión se encuentra inicialmente en estado Pending (pendiente). Después, el estado de la instancia cambiará a  En ejecución para indicar que la instancia finalizó el arranque.

     

    
Conectarse a una instancia de EC2 de Amazon Linux mediante SSH
Formas de conectarse a Amazon Linux EC2

    ssh utilizando una terminal

    Cuando ejecuta el comando ping google.com, verá respuestas que indican que tiene conectividad a internet.
