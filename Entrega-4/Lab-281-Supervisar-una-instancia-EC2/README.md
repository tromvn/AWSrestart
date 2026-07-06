---
title: "Lab 281: Supervisar una instancia de EC2"
parent: Entrega 4
nav_order: 3
---
# Lab 281: Supervisar una instancia de EC2

## Información general sobre el laboratorio

El registro y la supervisión son técnicas implementadas para lograr un objetivo común. Trabajan juntos para ayudar a asegurar que los valores de referencia de rendimiento de un sistema y sus pautas de seguridad siempre se cumplan. 

Registro se refiere al registro y almacenamiento de eventos de datos como archivos de registro. Los registros contienen detalles de bajo nivel que pueden darle visibilidad con respecto a cómo funcionan sus aplicaciones o sistemas en determinadas circunstancias. Desde un punto de vista de seguridad, los registros ayudan a los administradores de seguridad a identificar banderas rojas que se pueden omitir fácilmente en su sistema.

Supervisión es el proceso de analizar y recopilar datos para ayudar a asegurar un rendimiento óptimo. La supervisión ayuda a detectar el acceso no autorizado y a alinear el uso de sus servicios con la seguridad de la organización.

En este laboratorio, creará una alarma de Amazon CloudWatch que se inicia cuando una instancia de Amazon Elastic Compute Cloud (Amazon EC2) supera un umbral específico de utilización de la unidad de procesamiento central (CPU). Creará una suscripción usando Amazon Simple Notification Service (Amazon SNS), la que le envía un correo electrónico si esta alarma se activa. Iniciará sesión en la instancia de EC2 y ejecutará un comando de prueba de estrés que causa que la utilización de la CPU de la instancia de EC2 alcance el 100 %.

Esta prueba simula que un actor malicioso obtenga el control de la instancia de EC2 y haga aumentar la utilización de la CPU. El aumento de la CPU tiene varias posibles causas, entre ellas el malware.
Objetivos

**Después de completar este laboratorio, podrá realizar lo siguiente:**

1. Crear una notificación de Amazon SNS
2. Configurar una alarma de CloudWatch
3. Realizar una prueba de estrés a una instancia de EC2
4. Confirmar que se envió un correo electrónico de Amazon SNS
5. Crear un panel de CloudWatch


## Entorno de laboratorio

El entorno de laboratorio incluye una instancia de EC2 preconfigurada llamada Stress Test (Prueba de estrés) con un rol de AWS Identity and Access Management (IAM) adjunto que puede usar para conectarse mediante AWS Systems Manager Session Manager.

Todos los componentes de backend, como Amazon EC2, los roles de IAM y algunos servicios de AWS, ya están construidos en el laboratorio. 

### Tarea 1: Configurar Amazon SNS

En esta tarea, crea un tema de SNS y luego se suscribe a él con una dirección de correo electrónico.

Amazon SNS es un servicio de mensajería completamente administrado para la comunicación de aplicación a aplicación (A2A) y de aplicación a persona (A2P).

1. Crear topic

	![](src/1-crear-topic.png)
	
	![](src/2-topic-creado.png)
	
2. Crear suscripción

	![](src/3-crear-suscripcion.png)
	
	![](src/4-suscripcion-config.png)
	
3. Estado pendiente, previo a recepción del correo

	![](src/5-pending.png)
	
4. Correo

	![](src/6-correo.png)
	
	![](src/7-link-listo.png)
	
5. Confirmado

	![](src/8-confirmada.png)

 
#### Resumen de la Tarea 1

En esta tarea, creó un tema SNS y luego creó una suscripción para el tema usando una dirección de correo electrónico. Este tema ahora puede enviar alertas a la dirección de correo electrónico que asoció con la suscripción de Amazon SNS.

### Tarea 2: Crear una alarma de CloudWatch

En esta tarea, verá algunas métricas y registros almacenados en CloudWatch. Luego creará una alarma de CloudWatch para iniciar y enviar un correo electrónico a su tema SNS si la instancia Stress Test (Prueba de estrés) de EC2 aumenta a más de 60 % de utilización de la CPU. 

CloudWatch es un servicio de supervisión y observabilidad creado para ingenieros de DevOps, desarrolladores, ingenieros de fiabilidad del sitio (SRE), administradores de TI y propietarios de productos. CloudWatch le ofrece datos e información útil para supervisar sus aplicaciones, responder a los cambios en el rendimiento de todo el sistema y optimizar el uso de recursos. CloudWatch recopila datos de supervisión y operativos a mmodo de registros, métricas y eventos. Obtendrá una vista unificada del estado operativo y visibilidad de sus recursos, aplicaciones y servicios de AWS que se ejecutan en AWS y en las instalaciones.

1. Cloudwatch

	![](src/9-cloudwatch-metricas.png)
	
	![](src/10-ec2.png)
	
	![](src/11-por-instancia.png)
	
2. Alarma

	![](src/12-crear-alarma.png)
	
	![](src/13-alarm-config.png)
	
	![](src/14-alarm-config2.png)
	
	![](src/15-alarm-config3.png)
	
	![](src/16-alarm-config4.png)
	
	![](src/17-alarm-config5.png)
	
	![](src/18-alarm-config6.png)
	
	
#### Resumen de la Tarea 2

En esta tarea, vio algunas métricas de Amazon EC2 dentro de CloudWatch. Luego, creó una alarma de CloudWatch que inicia un estado de In alarm (Alarmado) cuando el umbral de utilización de la CPU supera el 60 %. 

### Tarea 3: Probar la alarma de Cloudwatch

En esta tarea, iniciará sesión en la instancia Stress Test (Prueba de estrés) de EC2 y ejecutará un comando que estresa la carga de CPU al 100 %. Este aumento en la utilización de CPU activa la alarma de CloudWatch, lo que causa que Amazon SNS envíe una notificación de correo electrónico a la dirección de correo electrónico asociada con el tema SNS.

1. Instancia Stress Test en EC2

	![](src/19-instancia-stress-test.png)
	
2. Abrir la misma instancia en otra terminal, para ejecutar top

	![](src/20-instancia-top.png)
	
3. Alarma activada

	![](src/21-alarma-activada.png)
	
4. Correo

	![](src/22-correo.png)
	
	![](src/23-correo2.png)

#### Resumen de la Tarea 3

En esta tarea, ejecutó un comando para cargar la instancia de EC2 al 100 % por 400 segundos. Este aumento en la utilización de la CPU activó la alarma para ir al estado In alarm (Alarmado), y confirmó el aumento en la utilización de la CPU al observar el gráfico de CloudWatch. También recibió una notificación de correo electrónico que le alertó del estado In alarm (Alarmado).

### Tarea 4: Crear un panel de CloudWatch

En esta tarea, creará un panel de CloudWatch usando las mismas métricas de utilización de CPU que usó durante este laboratorio.

Los paneles de CloudWatch son páginas de inicio personalizables en la consola de CloudWatch que puede utilizar para supervisar sus recursos en una sola vista. Con los paneles de CloudWatch incluso puede monitorear recursos que están dispersos entre distintas regiones. Puede usar los paneles de CloudWatch para crear vistas personalizadas de las métricas y alarmas para sus recursos de AWS.

1. Crear panel

	![](src/24-crear-panel.png)
	
	![](src/25-crear-panel2.png)
	
	![](src/25-panel3.png)
	
	![](src/26-panel4.png)
	
	![](src/27-panel5.png)

#### Resumen del laboratorio

En este laboratorio, creó una alarma de CloudWatch que se activó cuando la instancia Stress Test (Prueba de estrés) superó un umbral de CPU específico. Creó una suscripción usando Amazon SNS le envía un correo electrónico si esta alarma se activa. Inició sesión en la instancia de EC2 y ejecutó un comando de prueba de estrés que causó que la utilización de la CPU de la instancia de EC2 alcanzara el 100 %.

Esta prueba simuló lo que podría pasar si un actor malicioso obtuviera el control de una instancia de EC2 y aumentara la utilización de la CPU. El aumento de la CPU tiene varias posibles causas, entre ellas el malware.

