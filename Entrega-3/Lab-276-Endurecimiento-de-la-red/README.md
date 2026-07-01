---
title: "Lab 276: Endurecimiento de la red"
parent: Entrega 3
nav_order: 4
---

# Lab 276: Endurecimiento de la red

## Información general sobre el laboratorio

En este laboratorio, utilizará Amazon Inspector para buscar vulnerabilidades en sus recursos de AWS, específicamente en las funciones de AWS Lambda. Aprenderá a activar Amazon Inspector, interpretar los informes de vulnerabilidad y corregir los hallazgos.

## Situación

Los desarrolladores de Una Empresa se encuentran en las fases iniciales de creación de una aplicación que utiliza principalmente AWS Lambda. Durante todo el proceso de desarrollo, necesitan una herramienta de seguridad automatizada que no solo analice en busca de paquetes de software vulnerables, sino que también analice el código en sí. Decide utilizar Amazon Inspector para cubrir esta necesidad.

Amazon Inspector cumple los requisitos de poder analizar las funciones de AWS Lambda respondiendo rápidamente a las nuevas implementaciones. También analiza automáticamente los recursos adicionales, como las instancias de EC2 y los ECR de Amazon, dentro de la cuenta de AWS de Una Empresa.
Objetivos

Después de completar este laboratorio, podrá realizar lo siguiente:

1. Activar Amazon Inspector.
2. Analizar e interpretar los hallazgos de vulnerabilidades.
3. Corregir las vulnerabilidades encontradas por Amazon Inspector.

## Entorno del laboratorio

El entorno tiene funciones de Lambda con vulnerabilidades que, posteriormente, Amazon Inspector analizará y notificará según su gravedad.

### Tarea 1: activar Amazon Inspector

1. Consola Inspector
   
    ![](src/1-Activar-inspector.png)

2. Activar
   
    ![](src/2-activar.png)

3. Funciones de lambda
   
    ![](src/3-dashboard.png)

### Tarea 2: revisión de los recursos inspeccionados

4. Hallazgos en Inspector
   
    ![](src/4-hallazgos.png)
   
    ![](src/5-dashboard-hallazgos.png)
   
    ![](src/5-detalles.png)
   
   * Revisión de las funciones de lambda
     
       ![](src/6-National-Vulnerability-Database.png)
   
   * Correción propuesta por Inspector
     
       ![](src/7-correcion.png)

5. Consola Lambda
   
    ![](src/8-lambda.png)

### Tarea 3: corrección de los hallazgos de vulnerabilidades

6. Revisar archivo requirements.txt en el código, y corregir
   
    ![](src/9-requirements.png)
   
   * Luego de la correción, hacer click en Deploy
     
       ![](src/10-requirements-listo.png)

7. Revisar con el filtro "closed"
   
    ![](src/11-closed.png)
   
    ![](src/12-resources.png)
