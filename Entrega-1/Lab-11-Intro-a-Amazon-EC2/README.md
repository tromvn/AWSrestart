# Introducción a Amazon EC2

## Tarea 1: Lanzar una instancia de Amazon EC2

 ![](<src/Entrando a la consola.png>)

### Paso 1: Nombre, etiquetas y elegir una imagen de Amazon Machine (AMI)

![](src/SecciónInstancias.png)

![](src/Nombre-y-AMI.png)

### Paso 2: Elegir el tipo de instancia y par de claves (sin par de claves)

![](src/Tipo-y-PardeClaves.png)

### Paso 3: Configurar los detalles de la instancia y crear grupo de seguridad

![](src/ConfiguracionesdeRed.png)

![](src/ConfigAvanzada1.png)

![](src/Configavanzada2.png)

### Paso 4: Agregar almacenamiento

![](<src/Nada que hacer en Almacenamiento.png>)

### Paso 5: Revisar resumen de instancia y lanzar

![](src/LanzarInstancia.png)

## Tarea 2: Monitorear la instancia

### Paso 1: Explorando la pantalla principal

#### Entrando a la sección Instancias:

![](src/VerTodasLasInstancias.png)

___

#### Ver detalles de instancia:

![](src/VerDetallesdeInstancia.png)

___

#### Status Checks:

![](src/StatusChecks.png)

___

#### Monitoring:

![](src/Monitoring.png)

___

#### System Log: Aquí comprobé que se instaló httpd, es decir, el script inicial funcionó

![](src/SystemLog.png)
![](src/InstallingHTTPD.png)

___

#### Obtener captura de la instancia:

![](src/ObtenerCapturadePantalladlaInstancia.png)
![](src/InstanceScreenshot.png)

___

## Tarea 3: Actualizar el grupo de seguridad y editar reglas de entrada, para habilitar el acceso por http y acceder al servidor web

*Antes de hacer esto, no podía acceder al servidor desde el navegador. Entonces, esto es necesario para que la ip sea pública.

![](src/Consola-securitygroups.png)
![](src/Editarreglasdeentrada.png)
![](src/TypeHTTP.png)
![](src/2026-06-02_14-22.png)
![](src/WebSiteVisible.png)

___

## Tarea 4: Modificar el tamaño de la instancia (tipo de instancia y volumen de EBS)

#### Primero, detener la instancia y comprobar

![](<src/Detener instancia.png>)
![](src/2026-06-02_14-25.png)
![](src/2026-06-02_14-26.png)

___

#### Luego, modificar tipo de instancia

![](src/2026-06-02_14-26_1.png)

___

#### Ir a Volúmenes y modificar

![](src/2026-06-02_14-27.png)
![](src/2026-06-02_14-28.png)
![](src/2026-06-02_14-28_1.png)
![](src/2026-06-02_14-28_2.png)

___

#### Relanzar la instancia

![](src/RelanzarInstancia.png)

___

#### Cambiar la protección de terminación

![](src/2026-06-02_14-33_1.png)

___

#### Y terminarla.

![](src/2026-06-02_14-33.png)
