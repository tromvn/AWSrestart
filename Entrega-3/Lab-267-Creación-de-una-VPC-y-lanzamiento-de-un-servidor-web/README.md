---
title: "Lab 264: Recursos de red para una VPC"
parent: Entrega 3
nav_order: 3
---
Creación de una VPC y lanzamiento de un servidor web

Objetivos

Después de completar este módulo, podrá hacer lo siguiente:

    Crear una nube virtual privada (VPC)

    Crear subredes

    Configurar un grupo de seguridad

    Lanzar una instancia de Amazon Elastic Compute Cloud (Amazon EC2) en la VPC

Duración

El tiempo estimado para completar este laboratorio es de 45 minutos.
Situación

En este laboratorio, deberá utilizar Amazon Virtual Private Cloud (VPC) para crear su propia VPC y agregar componentes adicionales con el fin de producir una red personalizada para una gran empresa. Además, creará grupos de seguridad para la instancia de EC2. Deberá configurar y personalizar una instancia de EC2 para ejecutar un servidor web y lanzarla en la VPC que se parece al siguiente diagrama del cliente:

Diagrama del cliente

Una imagen de lo que solicita el cliente: una VPC, subredes (públicas y privadas), un grupo de seguridad y una instancia de EC2 en la que ejecutar un servidor web

Imagen: el cliente solicita la creación de esta arquitectura para iniciar correctamente su servidor web.
Restricciones del servicio de AWS

En este entorno de laboratorio, es posible que el acceso a los servicios de AWS y a las acciones del servicio esté restringido a los que usted necesita para completar las instrucciones del laboratorio. Es posible que encuentre errores si intenta acceder a otros servicios o si ejecuta acciones que no se detallan en este laboratorio.

Acceso a la Consola de administración de AWS

    En la parte superior de estas instrucciones, elija Start Lab (Comenzar laboratorio) para iniciar el laboratorio.

    Se abre el panel Start Lab (Iniciar laboratorio) y se muestra el estado del laboratorio.

     Sugerencia: Si necesitas más tiempo para completar el laboratorio, vuelve a pulsar el botón Start Lab (Iniciar laboratorio) para reiniciar el temporizador del entorno.

    Espere hasta que aparezca el mensaje Lab status: ready (Estado de la sesión de laboratorio: listo) y, a continuación, elija la X para cerrar el panel Start Lab (Iniciar laboratorio).

    En la parte superior de estas instrucciones, elija AWS.

    Esta opción abrirá la Consola de administración de AWS en una pestaña nueva del navegador. El sistema iniciará la sesión de forma automática.

     Consejo: Si no se abre una pestaña nueva del navegador, suele aparecer un anuncio o un ícono en la parte superior de este con un mensaje que indica que el navegador impide que el sitio web abra ventanas emergentes. Seleccione el anuncio o el ícono, y elija Allow pop ups (Permitir ventanas emergentes).

Tarea 1: Crear una VPC

En esta tarea, utilizará el asistente de la VPC para crear una VPC, una puerta de enlace de Internet y dos subredes en una única zona de disponibilidad. Una puerta de enlace de Internet es un componente de la VPC que permite la comunicación entre las instancias de la VPC e Internet.

Después de crear una VPC, puede agregar subredes. Cada subred reside por completo en una zona de disponibilidad y no puede abarcar otras zonas. Si el tráfico de una subred se dirige a una puerta de enlace de Internet, la subred recibe el nombre de subred pública. Si una subred no dispone de una ruta a la puerta de enlace de Internet, la subred recibe el nombre de subred privada.

El asistente también creará una puerta de enlace de NAT, que se utiliza para brindar conectividad a Internet a instancias EC2 en las subredes privadas.

    En la parte superior derecha de estas instrucciones, elija AWS. La Consola de administración de AWS se abrirá en una pestaña nueva del navegador.

    Una vez que esté en la consola de AWS, escriba y busque VPC en la barra de búsqueda en la parte superior. Seleccione VPC desde la lista.

    Ahora se encuentra en el panel de Amazon VPC. Utilice el servicio Amazon Virtual Private Cloud (Amazon VPC) para crear la VPC.

    Elija Create VPC (Crear VPC) y configure las siguientes opciones:

        Resources to create (Recursos a crear): elija VPC and more (VPC y más).

        En Name tag auto-generation (Generación automática de etiqueta de nombre): desmarque Auto-generate (Auto generar).

        IPv4 CIDR: ingrese 10.0.0.0/16.

        IPv6 CIDR block (Bloque de CIDR IPv6): seleccione No IPv6 CIDR block (sin bloque de CIDR IPv6).

        Tenancy (Tenencia): seleccione Default (Predeterminado).

        Number of availability Zones (AZs) (Número de zonas de disponibilidad): 1.

        Number of public subnets (Número de subredes públicas): 1.

        Number of private subnets (Número de subredes privadas): 1.

        Expanda Customize subnets CIDR blocks (Personalizar bloques de CIDR de las subredes).

            Public subnet CIDR block in us-west-2a (Bloque de CIDR de la subred pública en us-west-2a): 10.0.0.0/24

            Private subnet CIDR block in us-west-2a (Bloque de CIDR de la subred privada en us-west-2a): 10.0.1.0/24

        Puertas de enlace NAT: elija In 1 AZ (En 1 zona de disponibilidad).

        VPC endpoints (Puntos de enlace de la VPC): elija None (Ninguno).

    En el panel de vista previa, asigne los siguientes nombres a los recursos:

        VPC: Lab VPC

        Subredes (2)

            Primera casilla, subred pública uno sin etiqueta de nombre: Public Subnet 1

            Segunda casilla, subred privada uno sin etiqueta de nombre: Private Subnet 1

        Tablas de enrutamiento (2)

            Primera casilla, tabla de enrutamiento pública sin etiqueta de nombre: Public Route Table

            Segunda casilla, tabla de enrutamiento privada sin etiqueta de nombre: Private Route Table

    Elija Create VPC (Crear VPC).

    En la siguiente pantalla, se mostrará el mensaje Success (Éxito) con los detalles del VPC. 

    Seleccione View VPC (Ver VPC). 

    Los detalles de Lab VPC (VPC de laboratorio) se muestran según la configuración.

Tarea 2: Crear subredes adicionales

En esta tarea, creará dos subredes adicionales en una segunda zona de disponibilidad. Esto resulta útil para crear recursos en varias zonas de disponibilidad a fin de proporcionar alta disponibilidad.

    En el panel de navegación izquierdo, elija Subnets (Subredes).

    Para configurar la segunda subred pública, elija Create subnet (Crear subred) y configure las siguientes opciones:

        VPC ID (ID de la VPC): en la lista desplegable, elija Lab VPC (VPC de laboratorio).

        Subnet name (Nombre de la subred): ingrese Public Subnet 2.    

        Availability Zone (Zona de disponibilidad): seleccione Sin preferencias.

        Bloque de CIDR de IPv4: escriba 10.0.2.0/24.

    Seleccione Create Subnet (Crear subred).

    La subred tendrá todas las direcciones IP que comiencen con 10.0.2.x.

    Para configurar la segunda subred privada, seleccione Create subnet (Crear subred) y configure las siguientes opciones:

        VPC ID (ID de la VPC): en la lista desplegable, elija Lab VPC (VPC de laboratorio).

        Subnet name (Nombre de la subred): ingrese Private Subnet 2.

        Availability Zone (Zona de disponibilidad): seleccione Sin preferencias.

        Bloque de CIDR de IPv4: escriba 10.0.3.0/24.

    Seleccione Create Subnet (Crear subred).

    La subred tendrá todas las direcciones IP que comiencen con 10.0.3.x.

Tarea 3: asociar las subredes y agregar rutas

    En el panel de navegación izquierdo, seleccione Route Tables (Tablas de enrutamiento).

    Seleccione Public Route Table (Tabla de enrutamiento pública).

    En el panel inferior, haga clic en la pestaña Subnet associations (Asociaciones de subredes).

    En Subnets without explicit associations (Subredes sin asociaciones explícitas), elija Edit subnet associations (Editar asociaciones de subredes).

    Marque las casillas de Public Subnet 2 (Subred pública 2).

    Seleccione Save associations (Guardar asociaciones).

     Ahora configurará la tabla de enrutamiento que utilizan las subredes privadas.

    Seleccione Private route table (Tabla de enrutamiento privada).

    En el panel inferior, haga clic en la pestaña Subnet associations (Asociaciones de subredes).

    En Subnets without explicit associations (Subredes sin asociaciones explícitas), elija Edit subnet associations (Editar asociaciones de subredes).

    Marque las casillas de Private Subnet 2 (Subred privada 2).

    Seleccione Save associations (Guardar asociaciones).

 Ahora la VPC tiene subredes públicas y privadas configuradas en dos zonas de disponibilidad:

 La creación de los componentes de redes y de enrutamiento
 Imagen: la creación de recursos de redes y componentes de enrutamiento, y cómo adjuntar estos recursos que hacen que la VPC sea funcional como una red.
Tarea 4: crear un grupo de seguridad de VPC

En esta tarea, creará un grupo de seguridad de la VPC, que actúa como un firewall virtual para la instancia. Cuando se lanza una instancia, se asocian a ella uno o varios grupos de seguridad. Puede agregar reglas a cada grupo de seguridad que permitan el tráfico hacia las instancias asociadas o desde ellas.

    En el panel de navegación izquierdo, elija los Grupos de seguridad.

    Elija Crear grupo de seguridad.

    Configure el grupo de seguridad con las siguientes opciones:

        Security group name (Nombre del grupo de seguridad): ingrese Web Security Group.

        Description (Descripción): ingrese Enable HTTP access.

        VPC: seleccione Lab VPC (VPC de laboratorio).

    En Inbound rules (Reglas de entrada), seleccione Add rule (Agregar regla).

    Configure las siguientes opciones:

        Tipo: seleccione HTTP.

        Source (Fuente): seleccione Anywhere IPv4 (IPv4 en cualquier lugar).

        Description (Descripción): ingrese Permit web requests.

    Elija Crear grupo de seguridad.

En la siguiente tarea, utilizará este grupo de seguridad cuando lance una instancia de EC2.
Tarea 5: lanzar una instancia de servidor web

En esta tarea, lanzará una instancia de EC2 en la VPC nueva. Configurará la instancia para que actúe como un servidor web.

    En la Consola de administración de AWS, en la barra de búsqueda, ingrese y seleccione EC2 para ir a la Consola de administración de EC2.

    En el panel de navegación izquierdo, elija Instances (Instancias).

    Elija Launch Instances (Iniciar instancias) y configure las siguientes opciones:

    En la sección Name and tags (Nombre y etiquetas), Name (Nombre): Web Server 1.

    En la sección Application and OS Images (Amazon machine Image) (Imágenes de la aplicación y el sistema operativo [Imagen de máquina de Amazon]), configure las siguientes opciones:

        Quick Start: seleccione Amazon Linux.

        Imagen de máquina de Amazon (AMI): en el menú desplegable, seleccione Amazon Linux 2 AMI (HVM).

    En la sección Instance type (Tipo de instancia), elija t3.micro.

    En la sección Key pair (login) (Par de claves [inicio de sesión]), elija vockey.

    En la sección Network Settings (Configuración de red), seleccione Edit (Editar) y configure las siguientes opciones:

    VPC - required (VPC: obligatoria): elija Lab VPC (VPC de laboratorio).

    Subnet (Subred): elija Public Subnet (Subred pública).

    Auto-assign Public IP (Asignar automáticamente IP pública): elija Enable (Habilitar).

    Firewall (grupos de seguridad): seleccione Select existing security group (Seleccionar un grupo de seguridad existente).

        Seleccione Web Security Group (Grupo de seguridad web).

    Expanda Detalles avanzados.

    En User data (Datos de usuario), copie y pegue el siguiente código.

    #!/bin/bash

    #Install Apache Web Server and PHP

    yum install -y httpd mysql php

    #Download Lab files

    wget https://aws-tc-largeobjects.s3.us-west-2.amazonaws.com/CUR-TF-100-RESTRT-1/267-lab-NF-build-vpc-web-server/s3/lab-app.zip

    unzip lab-app.zip -d /var/www/html/

    #Turn on web server

    chkconfig httpd on

    service httpd start

    Elija Launch instance (Iniciar instancia)

    Para ver las instancias iniciadas, elija View all instances (Ver todas las instancias).

    Espere a que Web Server 1 (Servidor web 1) muestre el mensaje 2/2 checks passed (2/2 comprobaciones aprobadas) en la columna Status Checks (Comprobaciones de estado).

     Es posible que esto tarde unos minutos. Para actualizar la página, elija actualizar  en la parte superior de la página.

    Ahora se conectará al servidor web que se ejecuta en la instancia de EC2.

    Seleccione la casilla de verificación de la instancia y elija la pestaña Details (Detalles).

    Copie el valor de Public IPv4 DNS (DNS público de IPv4).

    Abra una pestaña nueva del navegador web, pegue el valor de Public IPv4 DNS (DNS público de IPv4) y presione Enter.

    La página debería verse de la siguiente manera:

    La página de éxito de cuando se lanza el servidor web

    Imagen: la página de éxito cuando se inicia el servidor web.

    La siguiente es la arquitectura completa que implementó:

    Una imagen del producto final, que es lo que solicitó el cliente: una VPC completamente funcional con tablas de enrutamiento públicas y privadas, sus recursos y un servidor web.

    Imagen: una imagen del producto final, que es la entrega de la solicitud exacta del cliente: una VPC completamente funcional con sus recursos (red y seguridad) y un servidor web.

Recapitulación
En este laboratorio

Recursos adicionales

    ¿Qué es Amazon VPC?

Laboratorio completo

 ¡Felicitaciones! Ha completado el laboratorio.

    En la parte superior de esta página, elija  End Lab (Finalizar laboratorio) y luego seleccione Yes (Sí) para confirmar que desea finalizar el laboratorio.

Aparecerá un panel que indica You may close this message box now. Lab resources are terminating (Ya puede cerrar este cuadro de mensajes. Los recursos del laboratorio se están cerrando).

    Elija la X en la esquina superior derecha para cerrar el panel End Lab (Finalizar laboratorio).

Para obtener más información sobre AWS Training and Certification, consulte AWS Training and Certification.

Sus comentarios son bienvenidos y valorados.

Si desea compartir alguna sugerencia o corrección, proporcione los detalles en nuestro Formulario de contacto de AWS Training and Certification.

© 2022 Amazon Web Services, Inc. y sus empresas afiliadas. Todos los derechos reservados. Este contenido no puede reproducirse ni redistribuirse, total ni parcialmente, sin el permiso previo por escrito de Amazon Web Services, Inc. Queda prohibida la copia, el préstamo o la venta de carácter comercial.
