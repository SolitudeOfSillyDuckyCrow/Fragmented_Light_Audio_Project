/*******************************************************************************
  SCRIPT: 02_transformacion_reporting.sql
  PROPOSITO: Crear tablas de agregación y resumen para Reporting (Fase T).
  Estas tablas (12 y 13) optimizan las consultas para Grafana.
  Este script debe ejecutarse DESPUÉS de que el esquema base de Chinook haya sido cargado.
********************************************************************************/

-- 1. LIMPIEZA INICIAL: Asegurar que las tablas se pueden recrear
DROP TABLE IF EXISTS "Ventas_Agregadas_x_Cliente";
DROP TABLE IF EXISTS "Ventas_Diarias_Globales";

-- ==============================================================================
-- 2. CREACIÓN DE TABLA 12: Ventas Agregadas por Cliente
-- Lógica: Agregación simple de facturas para calcular el gasto total por cliente.
-- Criterio clave: Uso de JOIN y GROUP BY.
-- ==============================================================================
CREATE TABLE "Ventas_Agregadas_x_Cliente" AS
SELECT
    C."CustomerId",
    C."FirstName" || ' ' || C."LastName" AS "Nombre_Completo", -- Concatenación para reporting
    C."Country" AS "Pais",
    SUM(I."Total") AS "Gasto_Total",        -- KPI 1: Total gastado por el cliente
    COUNT(DISTINCT I."InvoiceId") AS "Numero_Facturas", -- KPI 2: Cuantas veces ha comprado
    MAX(I."InvoiceDate") AS "Fecha_Ultima_Compra" -- Métrica de frescura
FROM
    "Customer" AS C
JOIN
    "Invoice" AS I ON C."CustomerId" = I."CustomerId"
GROUP BY
    C."CustomerId", C."FirstName", C."LastName", C."Country"
ORDER BY
    "Gasto_Total" DESC;

-- Aplicar restricción de integridad (Clave Primaria)
ALTER TABLE "Ventas_Agregadas_x_Cliente" ADD CONSTRAINT pk_ventas_x_cliente PRIMARY KEY ("CustomerId");

-- ==============================================================================
-- 3. CREACIÓN DE TABLA 13: Ventas Diarias Globales
-- Lógica: Resumen de ventas a nivel de día para optimizar gráficos de series de tiempo.
-- Criterio clave: Uso de la función DATE() y GROUP BY por fecha.
-- ==============================================================================
CREATE TABLE "Ventas_Diarias_Globales" AS
SELECT
    DATE(I."InvoiceDate") AS "Fecha_Venta", -- Función DATE para truncar a nivel de día
    SUM(I."Total") AS "Total_Ventas_Dia",
    SUM(IL."Quantity") AS "Total_Unidades_Vendidas"
FROM
    "Invoice" AS I
JOIN
    "InvoiceLine" AS IL ON I."InvoiceId" = IL."InvoiceId"
GROUP BY
    DATE(I."InvoiceDate")
ORDER BY
    "Fecha_Venta" ASC;

-- Aplicar restricción de integridad (Clave Primaria)
ALTER TABLE "Ventas_Diarias_Globales" ADD CONSTRAINT pk_ventas_diarias PRIMARY KEY ("Fecha_Venta");

/*******************************************************************************
  FIN DEL SCRIPT: 02_transformacion_reporting.sql
  Resultado: La base de datos ahora contiene 13 tablas.
********************************************************************************/