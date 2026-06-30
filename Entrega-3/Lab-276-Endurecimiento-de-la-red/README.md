---
title: "Lab 276: Endurecimiento de la red"
parent: Entrega 3
nav_order: 4
---
Using Amazon Inspector for vulnerability assesment and remediation

Información general sobre el laboratorio

En este laboratorio, utilizará Amazon Inspector para buscar vulnerabilidades en sus recursos de AWS, específicamente en las funciones de AWS Lambda. Aprenderá a activar Amazon Inspector, interpretar los informes de vulnerabilidad y corregir los hallazgos.

Los desarrolladores de Una Empresa se encuentran en las fases iniciales de creación de una aplicación que utiliza principalmente AWS Lambda. Durante todo el proceso de desarrollo, necesitan una herramienta de seguridad automatizada que no solo analice en busca de paquetes de software vulnerables, sino que también analice el código en sí. Decide utilizar Amazon Inspector para cubrir esta necesidad.

Amazon Inspector cumple los requisitos de poder analizar las funciones de AWS Lambda respondiendo rápidamente a las nuevas implementaciones. También analiza automáticamente los recursos adicionales, como las instancias de EC2 y los ECR de Amazon, dentro de la cuenta de AWS de Una Empresa.
Objetivos

Después de completar este laboratorio, podrá realizar lo siguiente:

    Activar Amazon Inspector.

    Analizar e interpretar los hallazgos de vulnerabilidades.

    Corregir las vulnerabilidades encontradas por Amazon Inspector.

Duración

El tiempo estimado para completar este laboratorio es de 30 minutos.
Entorno del laboratorio

El entorno tiene funciones de Lambda con vulnerabilidades que, posteriormente, Amazon Inspector analizará y notificará según su gravedad.

Acceso a la Consola de administración de AWS

    En la esquina superior derecha de estas instrucciones, elija  Start Lab (Comenzar laboratorio)

    Sugerencia para la solución de problemas: Si aparece un error Access Denied (Acceso denegado), cierre el aviso de error y elija  Vuelva a seleccionar Start Lab (Comenzar laboratorio).

    La siguiente información indica el estado del laboratorio:

        Un círculo rojo junto a AWS  en la esquina superior izquierda de esta página indica que el laboratorio no se ha iniciado.

        Un círculo amarillo junto a AWS  en la esquina superior izquierda de esta página indica que el laboratorio se está iniciando.

        Un círculo verde junto a AWS  en la esquina superior izquierda de esta página indica que el laboratorio está listo.

    Espere a que el laboratorio se encuentre listo antes de continuar.

    En la parte superior de estas instrucciones, elija el círculo verde junto a AWS 

    Esta opción abrirá la Consola de administración de AWS en una pestaña nueva del navegador. El sistema iniciará la sesión de forma automática.

    Sugerencia: Si no se abre una pestaña nueva del navegador, suele aparecer un anuncio o un ícono en la parte superior de este con un mensaje donde se indica que el navegador impide que el sitio web abra ventanas emergentes. Seleccione el anuncio o ícono y elija Permitir ventanas emergentes.

    Si ve un cuadro de diálogo que le indica que debe cambiar al inicio de la nueva consola, haga clic en Switch to the new Console Home (Cambiar al inicio de la nueva consola).

    Ajuste la pestaña de la Consola de administración de AWS para que aparezca junto a estas instrucciones. Idealmente, debería poder ver ambas pestañas del navegador al mismo tiempo para seguir los pasos del laboratorio.

     No cambie la región del laboratorio a menos que se le indique específicamente.

Tarea 1: activar Amazon Inspector

En esta tarea, activará y ejecutará el servicio Amazon Inspector para analizar continuamente las funciones de Lambda.

    En la Consola de administración de AWS, en la barra de búsqueda de la parte superior, escriba y elija Inspector.

    Abra el panel de la izquierda y elija Activar Inspector para activarlo en su cuenta.

    En Activar Inspector, seleccione el botón Activar Inspector.

    Nota: Esto solo es necesario la primera vez.
    Tras la activación, verá un mensaje en la parte superior Welcome to Inspector. Your first scan is underway. (Le damos la bienvenida a Inspector. Su primer análisis está en marcha)

    Si se le pide que responda a una encuesta titulada Feedback for Amazon Inspector (Comentarios para Amazon Inspector), seleccione cancelar.

        Cierre todos los anuncios en la parte superior de la página.

    Actualice la página periódicamente hasta que vea Panel > Resumen > Cobertura del entorno > Funciones de Lambda al 100 %

    El panel muestra el número de cuenta y el estado de activación de AWS Lambda. De forma predeterminada, el análisis estándar está activado para Amazon EC2, Amazon ECR y AWS Lambda.

Tarea 2: revisión de los recursos inspeccionados

En esta tarea, mientras espera a que finalice el análisis, revise el entorno del laboratorio actual (la instancia de EC2 y las funciones de Lambda) para saber qué recursos específicos está analizando Amazon Inspector.
Tarea 2.1: revisión de las funciones de Lambda

    En los hallazgos de la izquierda, seleccione Todos los hallazgos.

    Se muestran tres filas, una para cada vulnerabilidad dentro de la función Lambda. Debería poder ver los siguientes detalles clave:

        Gravedad: media

        El Recurso afectado muestra la función de Lambda afectada.

        El Título muestra el motivo del hallazgo.

    Elija el botón de opción para seleccionar el hallazgo búsqueda CVE-2023-32681 - requests. Se abre un panel que contiene la información sobre la vulnerabilidad.

    En el panel de información, en la sección Detalles de vulnerabilidades, seleccione el enlace externo situado junto al ID de vulnerabilidad.

    El enlace abre una nueva pestaña del navegador que lleva a la página web de detalles de vulnerabilidades de la Base de Datos Nacional de Vulnerabilidades (National Vulnerability Database, NVD), que es un repositorio de datos estandarizados de administración de vulnerabilidades mantenido por el Instituto Nacional de Estándares y Tecnología (NIST). Esta página ofrece información más detallada sobre la vulnerabilidad.

    En el panel de información, busque la sección Corrección.

    El problema es que el paquete requests es vulnerable y está desactualizado, y la recomendación es actualizar el paquete. A continuación, aplique la corrección a la función de Lambda.

Tarea 3: corrección de los hallazgos de vulnerabilidades

En esta tarea, analizará los hallazgos informados por Amazon Inspector e interpretará los detalles de las vulnerabilidades. Actualiza las funciones de Lambda para corregir las vulnerabilidades. Tras actualizar las funciones, revisará los hallazgos de Amazon Inspector para confirmar que se corrigió la vulnerabilidad.
Tarea 3.1: corrección de las vulnerabilidades de los paquetes de la función de Lambda

    En la Consola de administración de AWS, en la barra de búsqueda, busque y elija Lambda

    En la lista de funciones de Lambda, elija la función get-request.

    En el explorador de archivos del editor de código de funciones de Lambda, elija requirements.txt.

    Elimine el número de versión y los signos iguales de requests==2.20.0 para que la línea pase a ser solo requests.

    El archivo requirements.txt le indica a AWS Lambda qué paquetes de Python son necesarios para ejecutar la función. Si no se especifica ningún número de versión, se instalará la última versión del paquete de forma predeterminada. Esto garantiza que la función de Lambda utilice la versión más reciente del paquete.

    Presione el botón Deploy (Implementar) para implementar la función.

    Aparece un anuncio con el mensaje Successfully updated the function get-request (Se actualizó correctamente la función get-request.

    Esta implementación más reciente de la función de Lambda hará que Amazon Inspector inicie un nuevo análisis de la función.

    En la Consola de administración de AWS, en la barra de búsqueda, busque y elija Amazon Inspector.

    En el panel de navegación de la izquierda de la página, en Hallazgos, elija Todos los hallazgos.

     Nota: Si el panel de navegación está contraído, seleccione el ícono del menú.

    En el panel de hallazgos, en Estado del resultado, cambie la selección de Active (Activo) a Closed (Cerrado).

    En la lista de hallazgos cerrados, verá CVE-2023-32681 - requests. Esto confirma que la vulnerabilidad se corrigió correctamente.

    Nota: Es posible que el análisis tarde unos minutos en iniciarse y finalizar. Puede elegir el botón de actualización para ver el estado más reciente de los recursos analizados.

    En el panel de navegación de la izquierda de la página, en Cobertura de los recursos, elija Funciones de Lambda.

    Si es necesario, expanda el ancho de la columna Último análisis para mostrar la marca temporal completa.

    Verá que la función de Lambda analizada más recientemente tiene una marca temporal actualizada.

Conclusión

 ¡Felicitaciones! Aprendió a realizar correctamente las siguientes tareas:

    Activó y configuró Amazon Inspector.

    Analizó e interpretó hallazgos de vulnerabilidades.

    Corrigió las vulnerabilidades encontradas por Amazon Inspector.

Laboratorio completado

    Elija  End Lab (Finalizar laboratorio) en la parte superior de esta página y, a continuación, elija Yes (Sí) para confirmar que desea finalizar el laboratorio.

    Aparece brevemente el mensaje Ended AWS Lab Successfully (El laboratorio de AWS finalizó correctamente), que indica que concluyó el laboratorio.

    Para obtener más información sobre AWS Training and Certification, consulte AWS Training and Certification.

    Sus comentarios son bienvenidos y valorados.

    Si desea compartir alguna sugerencia o corrección, proporcione los detalles en nuestro Formulario de contacto de AWS Training and Certification.

© 2025, Amazon Web Services, Inc. y sus filiales. Todos los derechos reservados. Este contenido no puede reproducirse ni redistribuirse, de forma total ni parcial, sin el permiso previo por escrito de Amazon Web Services, Inc. Queda prohibida la copia, el préstamo o la venta de carácter comercial.
