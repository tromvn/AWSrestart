---
title: "Lab 270: Selección de datos de una base de datos"
parent: Entrega 5
nav_order: 3
---
# Lab 270: Selección de datos de una base de datos

 
## Situación

El equipo de operaciones de base de datos creó una base de datos relacional llamada world que contiene tres tablas: city, country y countrylanguage. Según los casos prácticos específicos definidos en el ejercicio de laboratorio, escribirá algunas consultas con operadores de base de datos y la instrucción SELECT.
Información general y objetivos del laboratorio

Este laboratorio muestra cómo usar algunas operaciones de bases de datos comunes y el enunciado SELECT.

## Objetivo

Después de completar este laboratorio, podrá realizar lo siguiente:

1. Usar el enunciado SELECT para consultar una base de datos
2. Usar la función COUNT ()
3. Use las siguientes operaciones para consultar una base de datos:
	* <, >, =, WHERE, ORDER BY, AND

### Tarea 1: Conectarse a Command Host

En esta tarea, se conecta a una instancia que contiene un cliente de base de datos, que se usa para conectarse a una base de datos. Esta instancia se conoce como Command Host.

1. Entrando en cliente

	![](src/6-ec2-consola.png)
	
	![](src/7-ec2-consola2.png)
	
	![](src/1-entrar-mysql.png)
 
### Tarea 2: Consultar la base de datos world

En esta tarea, consultará la base de datos world con varios enunciados SELECT y funciones de la base de datos.

1. Mostrar BBDD

	![](src/2-show-databases.png)
	
	![](src/3-select-from-country.png)
	
2. Count()

	![](src/4-count-country.png)
	
	![](src/5-columns-from-country.png)

3. Columnas específicas

	![](src/8-specific-columns.png)
	
4. Alias

	![](src/9-uso-de-AS.png)
	
5. Order by

	![](src/10-uso-de-ORDERBY.png)
	
	* Descendente (order by por defecto es ascendente)
	
		![](src/11-DESC.png)
		
6. Where

	![](src/12-where.png)
	
7. And

	![](src/13-AND.png)
 

#### Desafío

Consulte la tabla country para arrojar un conjunto de registros basado en la siguiente pregunta.
¿Qué país en el Sur de Europa tiene una población de más de 500 000 000?

1. Mirar tabla y columnas

	![](src/14-desafio1.png)
	
2. Buscar la columna Southern Europe

	![](src/15-desafio2.png)
	
3. Seleccionar columnas y filtrar Region

	![](src/16-desafio3.png)
	
4. Filtrar por Region y Population, para el resultado esperado

	![](src/17-desafio4.png)