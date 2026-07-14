---
title: "Lab 162: Desafío. Crear un servidor de base de datos e interactuar con la base de datos"
parent: Entrega 5
nav_order: 9
---
# Lab 162: Desafío. Crear un servidor de base de datos e interactuar con la base de datos

  

Este laboratorio se ha diseñado para reforzar el concepto del uso de instancias de base de datos administradas por AWS con el objetivo de satisfacer las necesidades de las bases de datos relacionales.

Amazon Relational Database Service (Amazon RDS) facilita la configuración, operación y escalado de una base de datos relacional en la nube. Proporciona una capacidad rentable y de tamaño ajustable y, al mismo tiempo, permite gestionar las tareas de administración de base de datos que consumen mucho tiempo, lo que permite centrarse en las aplicaciones y el negocio. Amazon RDS ofrece seis motores de base de datos familiares entre los que elegir: Amazon Aurora, Oracle, Microsoft SQL Server, PostgreSQL, MySQL y MariaDB.

 

Después de completar este laboratorio, podrá hacer lo siguiente:

    Crear una instancia de RDS
    Utilice el editor de consultas de Amazon RDS para consultar datos.

Duración

El tiempo estimado de este laboratorio es de 45 minutos.
Acceso a la Consola de administración de AWS

    En la parte superior de estas instrucciones, haga clic en Iniciar laboratorio para comenzar la sesión.

    Se abrirá el panel Iniciar laboratorio, donde se muestra el estado del laboratorio.

    Espere hasta que aparezca el mensaje “Estado de la sesión de laboratorio: listo” y, a continuación, seleccione la X para cerrar el panel Iniciar laboratorio.

    En la parte superior de estas instrucciones, haga clic en AWS

    La Consola de administración de AWS se abrirá en una pestaña nueva del navegador. El sistema iniciará sesión de forma automática.

    Consejo: Si no se abre una pestaña nueva del navegador, generalmente aparece un anuncio o un ícono en la parte superior del navegador que indica que el navegador no permite que se abran ventanas emergentes en el sitio. Haga clic en el anuncio o en el ícono y elija “Allow pop ups” (Permitir ventanas emergentes).

    Ubique la pestaña de la Consola de administración de AWS de modo que aparezca al lado de estas instrucciones. Idealmente, debería poder ver ambas pestañas del navegador a la vez para que sea más sencillo seguir los pasos del laboratorio.    

El desafío

Para finalizar el desafío, realice lo siguiente:

    Lance una instancia de base de datos de Amazon RDS mediante motores de base de datos de una base de datos aprovisionada de Amazon Aurora o MySQL. Tome nota de las credenciales de la base de datos, ya que las necesitará en los siguientes pasos. Tenga en cuenta las siguientes restricciones del laboratorio:
        Motor de base de datos: los motores admitidos son Amazon Aurora o MySQL. Amazon Aurora sin servidor no se encuentra disponible.
        Plantilla: elija Dev/Test (Desarrollo/pruebas) o Free tier (Nivel gratuito).
        Disponibilidad y durabilidad: evite crear una instancia en espera.
        Tamaño de la instancia de base de datos: elija Clases ampliables: instancias db.t2 y db.t3 del tipo db.t*.micro to db.t*.medium.
        Almacenamiento: elija SSD de uso general (gp2) de un tamaño de hasta 100 GB. El acceso a IOPS provisionadas se encuentra restringido.
        Amazon VPC: utilice VPC de laboratorio.
        Grupo de seguridad: incluye un grupo de seguridad que le permitirá a LinuxServer conectarse a la instancia de RDS.
        En MySQL, en Configuración adicional - Habilite Supervisión mejorada - Desactive la opción
        Opciones de compra: se permiten instancias bajo demanda. Las demás opciones de compra no se encuentran activadas.

    Haga clic en Detalles y luego, en Mostrar.

    Haga clic en Descargar PEM, para Linux o macOS, o Descargar PPK, para Windows, según su sistema operativo local.

    Tome nota de la dirección del LinuxServer.

    Realice la conexión (SSH) al ​​LinuxServer con los detalles que anotó.

    Instale un cliente MySQL y utilícelo para conectarse a la base de datos. Puede encontrar información útil aquí.

    Cree una tabla RESTART con las siguientes columnas – Tome una captura de pantalla para su envío
        ID de estudiante (número),
        Nombre del estudiante,
        Reiniciar ciudad,
        Fecha de graduación (día y hora)

    Inserte 10 filas de muestra en esta tabla – Tome una captura de pantalla para su envío

    Seleccione todas las filas de esta tabla – Tome una captura de pantalla para su envío

    Cree una tabla CLOUD_PRACTITIONER con las siguientes columnas – Tome una captura de pantalla para su envío
        ID de estudiante (número)
        Fecha de certificación (día y hora)

    Inserte 5 filas de muestra en esta tabla – Tome una captura de pantalla para su envío

    Seleccione todas las filas de esta tabla – Tome una captura de pantalla para su envío

    Realice una unión interna entre las dos tablas creadas anteriormente y muestre el ID de estudiante, el nombre del estudiante, la fecha de certificación – Tome una captura de pantalla para su envío    

Laboratorio completo

¡Felicitaciones! Ha completado la actividad.  Cuando haya terminado con el laboratorio:

    Haga clic en el botón Finalizar laboratorio, situado en la parte superior de esta página, y luego en Sí para confirmar que desea completar la actividad.

    Se mostrará un panel con el siguiente mensaje: “DELETE has been initiated… You may close this message box now” (Se ha iniciado la ELIMINACIÓN… ya puede cerrar este cuadro de mensaje).

    Para cerrar el panel, haga clic en la X que aparece en la esquina superior derecha.    

Recursos adicionales

Para obtener más información sobre AWS Training and Certification, consulte https://aws.amazon.com/training/.

Sus comentarios son bienvenidos y valorados.

Si desea compartir alguna sugerencia o corrección, proporcione los detalles en nuestro Formulario de contacto de AWS Training and Certification.

© 2022 Amazon Web Services, Inc. y sus filiales. Todos los derechos reservados. Este contenido no puede reproducirse ni redistribuirse, total ni parcialmente, sin el permiso previo por escrito de Amazon Web Services, Inc. Queda prohibida la copia, el préstamo o la venta de carácter comercial.
