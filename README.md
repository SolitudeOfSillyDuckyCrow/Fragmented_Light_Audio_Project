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

1.  **Inicialización de la Infraestructura:** Asegúrese de tener Docker instalado y el archivo .env configurado. En la terminal, desde la carpeta raíz, ejecute:  
   docker-compose up \-d

2.  **Paso 1: Carga del Esquema Base (Fase L):** Al iniciar Docker, el script **sql/01\_esquema\_base\_chinook.sql** se ejecuta automáticamente en PostgreSQL.  
3.  **Paso 2: Transformación (Fase T) con Airflow:** Orqueste la transformación que crea las tablas de reporte (12 y 13).  
   * **Acceder a Airflow:** Navegue a http://localhost:8080.  
   * **Ejecutar DAG:** Active el DAG chinook\_elt\_pipeline y ejecútelo (Trigger DAG). El DAG ejecuta **sql/02\_transformacion\_reporting.sql**.  
   * **Verificación:** El DAG finalizará con éxito (verde), confirmando las 13 tablas.  
4.  **Paso 3: Visualización (Grafana):** Acceda a los datos transformados.  
   * **Acceder a Grafana:** Navegue a http://localhost:3000.  
   * **Creación de Dashboards:** Utilice la fuente de datos **'Chinook PostgreSQL'** y las tablas de reporte (12 y 13\) para construir paneles analíticos.  
5.  **Técnica de Respaldo:** El archivo **sql/03\_dump\_final\_persistido.sql** contiene el *dump* completo del esquema final, cumpliendo con las técnicas de respaldo.

## **✅ Matriz de Cumplimiento Técnico**

| Rúbrica: Cumplimiento técnico (Aplicar todos los temas del curso) |
| :---- |

| Tema del Curso | Evidencia en el Proyecto |
| :---- | :---- |
| **Administradores y manejadores de bases de datos** | Uso de **PostgreSQL** (en contenedor) y **Grafana** (para análisis BI). |
| **Administración de espacios lógicos y físicos** | Gestión del esquema **public** con **13 tablas** y definición de PRIMARY KEY. |
| **Monitoreo y seguridad** | Variables de entorno (.env) segregadas y Airflow/Grafana protegidos con autenticación. |
| **Afinación de una base de datos** | Creación de **Tablas de Reporte (Agregación)** para optimizar consultas analíticas. |
| **Scripts y consultas funcionales** | Archivos **.sql** y el DAG de Python (orquestador) que son ejecutables a través de Airflow. |
| **Base de datos correctamente construida** | El esquema final contiene **13 tablas** y el pipeline ELT está orquestado por Airflow. |
