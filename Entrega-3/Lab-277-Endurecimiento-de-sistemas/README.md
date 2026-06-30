---
title: "Lab 277: Endurecimiento de sistemas"
parent: Entrega 3
nav_order: 5
---
Reforzamiento de sistemas con gerente de parches mediante AWS Systems Manager

Información general sobre el laboratorio

En organizaciones con cientos e incluso miles de estaciones de trabajo, puede ser logísticamente difícil mantener todo el software de sistemas operativos (SO) y de aplicaciones actualizado. En la mayoría de los casos, las actualizaciones de SO en las estaciones de trabajo se pueden aplicar automáticamente mediante la red. Sin embargo, los administradores deben tener una política de seguridad clara y un plan de referencia para asegurarse de que todas las estaciones de trabajo esté funcionando en una versión mínima del software.

En este laboratorio, usará gerente de parches, una funcionalidad de AWS Systems Manager, para crear una línea de base de revisiones. A continuación, usará la línea de base de revisiones para escanear las instancias de Amazon Elastic Compute Cloud (Amazon EC2) para Windows que se crearon previamente para este laboratorio. También utilizará la línea de base de revisiones predeterminada para aplicar parches a las instancias de EC2 de Linux.

Objetivos

Después de completar este laboratorio, podrá realizar lo siguiente:

    Aplicar parches a instancias de Linux usando la línea de base predeterminada

    Crear una línea de base de revisiones personalizada 

    Utilizar grupos de parches para aplicar parches a las instancias de Windows mediante una línea de base de revisiones personalizada 

    Verificar el cumplimiento de los parches

Duración

El tiempo estimado para completar este laboratorio es de 60 minutos.
Entorno del laboratorio

El entorno actual tiene seis instancias de EC2: tres instancias con el SO Linux y tres con el SO Windows.

Todos los componentes de backend, como las instancias de EC2, los roles de AWS Identity and Access Management (AWS IAM) y algunos servicios de AWS, ya están construidos en su laboratorio.

Cómo acceder a la Consola de administración de AWS

    En la esquina superior derecha de estas instrucciones, seleccione  Start Lab (Iniciar laboratorio). 

    Consejo para la solución de problemas: Si aparece el error Access Denied (Acceso denegado), cierre el aviso de error y vuelva a seleccionar  Start Lab (Iniciar laboratorio).

    La siguiente información indica el estado del laboratorio: 

        Un círculo rojo junto a AWS  en la esquina superior izquierda de esta página indica que el laboratorio no se ha iniciado.

        Un círculo amarillo junto a AWS  en la esquina superior izquierda de esta página indica que el laboratorio se está iniciando.

        Un círculo verde junto a AWS  en la esquina superior izquierda de esta página indica que el laboratorio está listo.

    Espere a que el laboratorio se encuentre listo antes de continuar.

    En la parte superior de estas instrucciones, seleccione el círculo verde junto a AWS 

    La Consola de administración de AWS se abrirá en una pestaña nueva del navegador. El sistema iniciará la sesión de forma automática.

    Sugerencia: Si no se abre una pestaña nueva del navegador, suele aparecer un anuncio o un ícono en la parte superior de este con un mensaje donde se indica que el navegador impide que el sitio web abra ventanas emergentes. Seleccione el banner o el ícono, y elija Allow pop ups (Permitir ventanas emergentes).

    Si ve un cuadro de diálogo que le indica que debe cambiar al inicio de la nueva consola, seleccione Switch to the new Console Home (Cambiar al inicio de la nueva consola).

    Ajuste la pestaña de la Consola de administración de AWS para que aparezca junto a estas instrucciones. Idealmente, debería poder ver ambas pestañas del navegador al mismo tiempo para seguir los pasos del laboratorio.

     No cambie la región del laboratorio a menos que se le indique específicamente.

Tarea 1: Aplicar parches a instancias de Linux usando la línea de base predeterminada

En esta tarea, aplicará parches a las instancias de EC2 de Linux utilizando las líneas de base predeterminadas disponibles para el sistema operativo.

El gerente de parches proporciona líneas de base de revisiones predefinidas para cada uno de los sistemas operativos que admite. Puede usar estas líneas de base de revisiones como están configuradas actualmente (no puede personalizarlas) o puede crear sus propias líneas de base de revisiones. Puede usar líneas de base de revisiones para tener un mayor control sobre cuáles parches se aprueban o rechazan para su entorno.

    En la Consola de administración de AWS, en el cuadro de búsqueda , ingrese Systems Manager y selecciónelo. Esta opción lo lleva a la página de la consola de Systems Manager.

    En el panel de navegación izquierdo, en Administrador de nodos, elija Administrador de flotas.
    Estas son las instancias de EC2 preconfiguradas. Hay tres instancias de Linux y tres instancias de Windows. Estas instancias de EC2 tienen un rol de IAM específico asociado que le permite administrarlas mediante Systems Manager, que es por lo que puede consultarlas en la sección Administrador de flotas. Esto también es parte de la preparación del laboratorio.

    Marque la casilla situada junto a Linux-1. Luego seleccione la lista desplegable Node actions  (Acciones de nodos) y seleccione View details (Ver detalles).
    Aquí puede ver detalles sobre la instancia específica, como Tipo de plataforma, Tipo de nodo, Nombre del sistema operativo y Rol de IAM que le permite usar Systems Manager para administrar esta instancia.

    En la parte superior de la página, seleccione AWS Systems Manager para volver a la página inicial de Systems Manager.

    En el panel de navegación izquierdo, en Administrador de nodos, elija gerente de parches.

    Seleccione Comience por la información general (vaya al paso siguiente si esta opción no aparece).

    Elija Aplicar parches ahora para aplicar parches a las instancias de Linux con AWS-AmazonLinux2DefaultPatchBaseline.

    En Configuración básica, configure lo siguiente:

        Operación de aplicación de parches: Analizar e instalar.

        Opción de reinicio: Reiniciar en caso de ser necesario.

        Instancias a las que se aplicarán parches: Aplicar parches únicamente a las instancias de destino que especifique.

        Selección de destino: Especificar etiquetas de instancia.

            Clave de etiqueta: Patch Group.

            Valor de etiqueta: LinuxProd.

        Elija Agregar.

    Seleccione, Aplicar parches ahora.

    Observe el estado de la aplicación de parches.

     Se mostrará una página nueva. En el panel AWS-PatchNowAssociation, hay un campo de estado que mostrará que tres instancias se verán afectadas y el progreso realizado.

     Un panel de resumen de las operaciones de Scan/Install también muestra visualmente el estado de las instancias de EC2 afectadas. Supervise esta página hasta que finalice la operación de aplicación del parche en las tres instancias.

Tarea 2: Crear una línea de base de revisiones personalizada para las instancias de Windows

En esta tarea, creará una línea de base de revisiones personalizada para las instancias de Windows. Aunque Windows tiene líneas de base de revisiones predeterminadas que puede usar, para este caso práctico, establecerá una línea de base para las actualizaciones de seguridad de Windows.

    Vuelva a la consola de Systems Manager. En la barra de búsqueda en la parte superior, ingrese Systems Manager y, luego, selecciónelo.

    En el panel de navegación izquierdo, en Administrador de nodos, elija gerente de parches. 

    Seleccione Comience por la información general (vaya al paso siguiente si esta opción no aparece).

    Seleccione la pestaña Bases de referencia de parches.

    Seleccione el botón Cree una base de referencia para parches. 

    En Detalles de base de referencia de parches, configure las opciones siguientes:

        En Nombre, escriba WindowsServerSecurityUpdates.

        En Description - optional, ingrese Windows security baseline patch.

        En Sistema operativo, seleccione Windows.

        Deje la casilla de Base de referencia de parches predeterminada sin seleccionar.

    En la sección Reglas de aprobación para sistemas operativos, configure las siguientes opciones:

        Productos: en la lista desplegable, elija WindowsServer2019. Además, anule la selección de Todos para que ya no aparezca en Productos.

        Gravedad: esta opción indica el valor de severidad de los parches a los que se aplica la regla. Para asegurarse de que todos los paquetes de servicio estén incluidos en la regla, seleccione Crítica en la lista desplegable.

        Clasificación: en la lista desplegable, elija SecurityUpdates.

        Aprobación automática: ingrese 3 días.

        Informes de conformidad - opcional: en la lista desplegable, seleccione Crítica.

    Seleccione Agregar regla para agregar una segunda regla a esta línea de base de revisiones y configure las siguientes opciones:

        Productos: en la lista desplegable, elija WindowsServer2019. Además, anule la selección de Todos para que ya no aparezca en Productos.

        Gravedad: en la lista desplegable, elija Importante.

        Clasificación: en la lista desplegable, elija SecurityUpdates.

        Aprobación automática: ingrese 3 días.

        Informes de conformidad - opcional: en la lista desplegable, seleccione Alta.

    Seleccione Crear una base de referencia de parches.

    A continuación, modifique un grupo de parches para la línea de base de revisiones de Windows que acaba de crear.

    En la sección Base de referencia de parches, seleccione el botón para la línea de base de revisiones WindowsServerSecurityUpdates que acaba de crear.
    Nota: La línea de base de revisiones que creó puede estar en la segunda página de la lista de líneas de base. También puede usar la barra de búsqueda para localizarla y luego seleccionarla.

    Seleccione la lista desplegable Acciones y, luego, seleccione Modificar grupos de parches.

    En la sección Modificar grupos de parches, en Grupos de parches, ingrese WindowsProd. 

    Seleccione el botón Agregar y, luego, seleccione Cerrar. 

Tarea 3: Aplicar parches a las instancias de Windows

En esta tarea, se aplican parches a las instancias de Windows mediante la característica Aplicar parches ahora según la etiqueta asociada a ellas.

Después de la configuración, el gerente de parches usa Ejecutar comando para llamar al documento RunPatchBaseline para evaluar cuáles parches se deben instalar en las instancias de destino, según el tipo de sistema operativo de cada instancia, de forma directa o durante el programa definido (periodo de mantenimiento).
Tarea 3.1: Etiquetar instancias de Windows

En esta tarea, etiquetará sus instancias de Windows. Más adelante en el laboratorio, creará un grupo de parches y lo asociará con estas etiquetas.

 Las instancias de Linux se preconfiguraron durante la preparación del laboratorio con etiquetas LinuxProd y no es necesario agregar más etiquetas.

    En la Consola de administración de AWS, en la barra de búsqueda , ingrese EC2 y selecciónelo.

    Elija Instancias, seleccione la casilla de verificación junto a la instancia de Windows-1 y, luego, seleccione la pestaña Etiquetas.

    Seleccione el botón Administrar etiquetas, seleccione Agregar nueva etiqueta y configure las siguientes opciones:

        Clave: ingrese Patch Group

        Valor: ingrese WindowsProd

    Seleccione Guardar.

    Repita los pasos anteriores para etiquetar las instancias de Windows-2 y Windows-3 con las mismas etiquetas.

Tarea 3.2: Aplicar parches a las instancias de Windows

    Vuelva a la consola de Systems Manager. En la barra de búsqueda en la parte superior, ingrese Systems Manager y, luego, selecciónelo.

    Para aplicar parches a las instancias de Windows:

        Seleccione gerente de parches. 

        Seleccione Comience por la información general (vaya al paso siguiente si esta opción no aparece).

        Seleccione, Aplicar parches ahora.

        Operación de aplicación de parches: Analizar e instalar.

        Opción de reinicio: Reiniciar en caso de ser necesario.

        Instancias a las que se aplicarán parches: Aplicar parches únicamente a las instancias de destino que especifique.

        Selección de destino: Especificar etiquetas de instancia.

            Clave de etiqueta: Patch Group.

            Valor de etiqueta: WindowsProd.

        Elija Agregar.

        Seleccione, Aplicar parches ahora.

    Se mostrará una página nueva. Cuando esté disponible, elija el enlace al ID de ejecución.

    Se abre una página en la sección administrador de estados de Systems Manager.

    Elija el enlace de resultados para una de las instancias administradas que muestre el estado de InProgress.

    Se abrirá una página en la sección del comando Run de Systems Manager.

    Amplíe el panel de resultados para observar los detalles.

     Tras bambalinas, el gerente de parches usa el comando Run para ejecutar PatchBaselineOperations.  Si se desplaza por el resultado, podrá ver los detalles de PatchGroup: WindowsProd.

    Un documento de Systems Manager (documento de SSM) define las acciones que realiza Systems Manager en sus instancias administradas.

Tarea 4: Verificar el cumplimiento

    En el panel de navegación izquierdo, en Administrador de nodos, elija gerente de parches.

    Seleccione la pestaña Panel. En Resumen de conformidad, ahora podrá ver Conforme: 6, que verifica que todas las instancias de Windows y Linux están en conformidad.

    Seleccione la pestaña Informes de conformidad. 
     Este laboratorio proporciona información general de todas las instancias en ejecución de SSM. Podrá comprobar que el Estado de conformidad de todas las instancias de Linux y Windows es  Conforme.

        Las seis instancias (tres de Linux y tres de Windows) deberían mostrarse como compatibles.

        Desplácese hacia la derecha en el panel Detalles de revisiones en nodos para encontrar cada instancia:

            Recuento de incumplimientos críticos

            Recuento de incumplimientos de seguridad

            Otros recuentos de incumplimiento

            Fecha de la última operación 

            ID de la línea base 

        Elija el ID de nodo de uno de los nodos de Windows.

        En la página ID de nodo que se abrirá, seleccione la pestaña Parche.

        Desplácese hacia abajo y observe qué parches se aplicaron a esta instancia, además de la hora de instalación.

Conclusión

 Felicitaciones. Aprendió a realizar correctamente lo siguiente:

    Instancias Linux con parches usando la línea de base predeterminada.

    Creó una línea de base de revisiones personalizada.

    Usó grupos de parches para aplicar parches a instancias de Windows mediante una línea de base de revisiones personalizada.

    Verificó el cumplimiento de los parches.

Laboratorio completado

    Seleccione  End Lab (Finalizar laboratorio) en la parte superior de esta página y, a continuación, seleccione Yes (Sí) para confirmar que desea finalizar el laboratorio.

    Aparece de manera breve el mensaje Ended AWS Lab Successfully (El laboratorio de AWS finalizó correctamente), que indica que concluyó el laboratorio.

Para más información sobre AWS Training and Certification, consulte AWS Training and Certification (Capacitación y certificación de AWS).

Sus comentarios son bienvenidos y valorados.

Si desea compartir alguna sugerencia o corrección, proporcione los detalles en nuestro Formulario de contacto de AWS Training and Certification.

© 2024 Amazon Web Services, Inc. y sus filiales. Todos los derechos reservados. Este contenido no puede reproducirse ni redistribuirse, total ni parcialmente, sin el permiso previo por escrito de Amazon Web Services, Inc. Queda prohibida la copia, el préstamo o la venta de carácter comercial.
