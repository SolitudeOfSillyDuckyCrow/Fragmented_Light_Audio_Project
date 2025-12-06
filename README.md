# **🌊 Proyecto Final: Fragmented Light Audio \- Ingeniería de Datos**

## **📄 Resumen de Participación (Abstract)**

Esta documentación presenta la implementación y validación de una solución integral de **Ingeniería de Datos**, centrada en la transformación y visualización de estructuras analíticas sobre una plataforma **Dockerizada** y orquestada por **Airflow**. El estudio tiene como propósito demostrar la capacidad de diseñar y ejecutar el ciclo completo **ELT (Extract, Load, Transform)** en un entorno reproducible y moderno.

Se inició con la definición de la infraestructura mediante docker-compose.yml, que levanta PostgreSQL, Apache Airflow y Grafana. La **Fase de Transformación (T)** se orquesta con **Airflow** para aplicar **SQL Avanzado**, generando valor analítico en dos **Tablas de Reporte** estratégicas. Específicamente, se utilizan agregaciones (SUM, GROUP BY) y joins para el cálculo de métricas de ventas y rendimiento de clientes.

El resultado final es un **pipeline ELT funcional** donde el esquema persistido contiene un total de **13 tablas** (11 originales más 2 de reporte). El artefacto de entrega es un repositorio con código 100% reproducible que valida el dominio en la **Orquestación**, **Administración de Bases de Datos** y **Visualización (BI)**.

## **🔑 Palabras Clave**

**Ingeniería de Datos**, **Docker Compose**, **PostgreSQL**, **Apache Airflow (DAGs)**, **Grafana**, **Arquitectura ELT**, **Transformación SQL Avanzada**, **Tablas de Reporte**, **13 Tablas**, **Orquestación de Pipelines**.

## **🚀 Instrucciones de Despliegue y Uso**

| Rúbrica: Instrucciones de instalación o uso |
| :---- |

El proyecto se despliega de forma local y reproducible usando Docker Compose.

...
## ✅ Matriz de Cumplimiento Técnico

| Tema del Curso | Evidencia en el Proyecto |
| :--- | :--- |
| **Administradores y manejadores de bases de datos** | Uso de **PostgreSQL** (en contenedor) y **Grafana** (para análisis BI). |
| **Administración de espacios lógicos y físicos** | Gestión del esquema **`public`** con **13 tablas** y definición de `PRIMARY KEY`. |
| **Técnicas de respaldo y recuperación** | Archivo **`sql/03_dump_final_persistido.sql`** (Respaldo técnico del esquema final). |
| **Monitoreo y seguridad** | Variables de entorno (`.env`) segregadas y Airflow/Grafana protegidos con autenticación. |
| **Afinación de una base de datos** | Creación de **Tablas de Reporte (Agregación)** para optimizar consultas analíticas. |
| **Scripts y consultas funcionales** | Archivos **`.sql`** y el DAG de Python (orquestador) que son ejecutables a través de Airflow. |
| **Base de datos correctamente construida** | El esquema final contiene **13 tablas** y el pipeline ELT está orquestado por Airflow. |
...