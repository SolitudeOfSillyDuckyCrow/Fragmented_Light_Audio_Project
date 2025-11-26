/*******************************************************************************
   SCRIPT: 02_transformacion_datamarts.sql
   PROPOSITO: Crear Data Marts analíticos aplicando lógica SQL avanzada (Fase T).
   Este script debe ejecutarse DESPUÉS de cargar el esquema base.
********************************************************************************/

-- 1. DATA MART: Clientes Inactivos (dm_clientes_inactivos)
-- Lógica: Segmentación de clientes que NUNCA han tenido una factura.
-- Criterio clave: Uso de NOT EXISTS (Exclusión Lógica).

CREATE TABLE dm_clientes_inactivos AS
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.country
FROM
    customer c
WHERE
    NOT EXISTS (
        SELECT 1
        FROM invoice i
        WHERE i.customer_id = c.customer_id
    )
ORDER BY
    c.customer_id;

-- -----------------------------------------------------------------------------

-- 2. DATA MART: Ventas Totales por Agente de Soporte (dm_ventas_agentes)
-- Lógica: Cálculo de métricas (KPIs) de ventas agregadas por agente.
-- Criterio clave: Uso de LEFT JOIN (inclusión de agentes sin ventas) y GROUP BY.

CREATE TABLE dm_ventas_agentes AS
SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name AS agente_soporte,
    -- Suma total de las facturas asociadas a los clientes de ese agente.
    COALESCE(SUM(i.total), 0.00) AS ventas_totales_generadas
FROM
    employee e
LEFT JOIN
    customer c ON e.employee_id = c.support_rep_id
LEFT JOIN
    invoice i ON c.customer_id = i.customer_id
WHERE
    e.title = 'Sales Support Agent' -- Filtrar solo a los agentes de soporte relevantes
GROUP BY
    e.employee_id, agente_soporte
ORDER BY
    ventas_totales_generadas DESC;

-- FIN DE LA FASE DE TRANSFORMACIÓN