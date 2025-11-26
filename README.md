# 🌊 Proyecto Final: Fragmented Light Audio - Ingeniería de Datos

## 📄 Resumen de Participación (Abstract)

Esta documentación presenta la implementación y validación de una solución integral de **Ingeniería de Datos**, centrada en la transformación y persistencia de estructuras analíticas sobre una plataforma **DBaaS** (**PostgreSQL/Neon**). El estudio tiene como propósito demostrar la capacidad de diseñar y ejecutar el ciclo completo **ELT (Extract, Load, Transform)** en un entorno de nube moderno.

Se inició con la carga y el modelado del esquema transaccional Chinook, para luego proceder a la **Fase de Transformación (T)**. En esta fase, se aplicó **SQL Avanzado** para generar valor analítico, resultando en la creación de dos **Data Marts** estratégicos. Específicamente, se utilizó la sentencia **`NOT EXISTS`** para la segmentación de clientes inactivos y la lógica de **`LEFT JOIN`** y agregación para el cálculo de métricas de rendimiento de ventas.

El resultado final certifica la **persistencia** de un esquema robusto de **13 tablas** (11 originales más 2 Data Marts). El artefacto de entrega es un **archivo SQL curado** que encapsula el **DDL y DML** de estas 13 estructuras, validando el dominio en la **Administración de Bases de Datos** y la gestión de *schemas* en la nube.

***

## 🔑 Palabras Clave

**Ingeniería de Datos**, **PostgreSQL**, **Neon (DBaaS)**, **Arquitectura ELT**, **Transformación SQL Avanzada**, **Data Marts**, **Persistencia**, **`NOT EXISTS` / `LEFT JOIN`**, **13 Tablas**, **Administración de Bases de Datos**.

---

## 🚀 Instrucciones de Despliegue y Uso

| Rúbrica: Instrucciones de instalación o uso |
| :--- |

El proyecto se despliega en una instancia de PostgreSQL (demostrado en **Neon**).

1.  **Conexión:** Obtener la cadena de conexión de la instancia de Neon.
2.  **Paso 1: Carga del Esquema Base:** Ejecutar el script **`sql/01_esquema_base_chinook.sql`** para crear las 11 tablas transaccionales.
3.  **Paso 2: Transformación (Fase T):** Ejecutar el script **`sql/02_transformacion_datamarts.sql`** para crear y poblar las dos tablas de Data Marts analíticos.
4.  **Verificación Final:** La base de datos estará correctamente construida y lista para consultas, contando con un total de **13 tablas**.

---

## ✅ Matriz de Cumplimiento Técnico

| Rúbrica: Cumplimiento técnico (Aplicar todos los temas del curso) |
| :--- |

| Tema del Curso | Evidencia en el Proyecto |
| :--- | :--- |
| **Administradores y manejadores de bases de datos** | Uso de **PostgreSQL** y la plataforma **Neon** como servicio DBaaS. |
| **Administración de espacios lógicos y físicos** | Gestión del esquema **`public`** con **13 tablas** y definición de `PRIMARY KEY`. |
| **Técnicas de respaldo y recuperación** | Archivo **`sql/03_dump_final_persistido.sql`** (Respaldo técnico de la base de datos completa con 13 tablas). |
| **Monitoreo y seguridad** | Uso de la conexión **SSL** (requerida por Neon) y gestión de privilegios del usuario. |
| **Afinación de una base de datos** | Creación de **Data Marts** para optimizar consultas analíticas, evitando escaneos complejos en las tablas transaccionales. |
| **Scripts y consultas funcionales** | Archivos **`.sql`** organizados que son ejecutables en secuencia. |
| **Base de datos correctamente construida** | El esquema final contiene **13 tablas** con sus restricciones de integridad. |
