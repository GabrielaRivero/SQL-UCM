Proyecto SQL - Análisis de Operaciones y Devoluciones

## Objetivo

El objetivo fue diseñar una base de datos relacional con tres tablas (`orders`, `refunds` y `merchants`) y realizar consultas SQL para extraer métricas, generar vistas, y obtener insights de negocio.

## Ejercicios incluidos

### Ejercicio 1
- Creación del modelo entidad-relación.
- Creación de la base de datos `tarea_ucm` y esquema `operaciones_ucm`.
- Creación de las tablas:
  - `orders`
  - `refunds`
  - `merchants`
- Carga de datos desde archivos CSV.

### Ejercicio 2
Consultas para obtener estadísticas de operaciones:
1. Total de operaciones e importe promedio por país y estado.
2. Top 3 países por número de operaciones, importe máximo y mínimo.

### Ejercicio 3
Consultas avanzadas de cruce entre operaciones, comercios y devoluciones:
1. Total de operaciones, promedio, total de devoluciones y si el comercio acepta o no devoluciones.
2. Creación de una vista `orders_view` con toda la información relevante por operación.

### Ejercicio 4
Funcionalidad propia desarrollada para obtener un insight adicional

## Tecnología
- MySQL Workbench 8.x
- Lenguaje: SQL
- Sistema de gestión: InnoDB
- Sistema operativo: Windows
