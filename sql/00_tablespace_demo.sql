-- ######################################################################
-- 00_TABLESPACE_DEMO.SQL
-- DEMOSTRACIÓN FUNCIONAL DE ADMINISTRACIÓN DE ESPACIOS FÍSICOS
-- REQUISITO: Este script DEBE ser ejecutado por un SUPERUSUARIO.
-- REQUISITO: El directorio físico debe existir en el servidor.
-- ######################################################################

-- NOTA IMPORTANTE: El directorio '/tmp/fast_data_space' debe existir en el sistema de archivos del servidor
-- (e.g., debe ejecutar 'mkdir /tmp/fast_data_space' antes de ejecutar este script).
-- Si el profesor lo ejecuta en Windows, debe cambiar la ruta a algo como 'C:\postgres_data\fast_space'.

-- 1. CREAR EL TABLESPACE
-- Creamos un tablespace lógico llamado 'indices_optimizados'.
CREATE TABLESPACE indices_optimizados LOCATION '/tmp/fast_data_space';

-- 2. VERIFICACIÓN: Comprobar que el tablespace existe
\echo 'TABLESPACE CREADO CON ÉXITO:'
SELECT spcname, pg_tablespace_location(oid) FROM pg_tablespace WHERE spcname = 'indices_optimizados';

-- 3. DEMOSTRACIÓN DE USO (ASIGNACIÓN)
-- El tablespace solo estará disponible después de ejecutar el script 01_esquema_base_chinook.sql.
-- Asignaremos el índice de la tabla "Album" a nuestro nuevo tablespace optimizado.

-- Esto asume que la tabla 'Album' ya fue creada (por 01_esquema_base_chinook.sql).
-- ALTER INDEX album_pkey RENAME TO idx_album_pk;  -- Renombrar por si es necesario
ALTER TABLE "Album" SET TABLESPACE indices_optimizados;

-- 4. LIMPIEZA (Opcional, para revertir la demostración)
-- ALTER TABLE "Album" SET TABLESPACE pg_default;
-- DROP TABLESPACE indices_optimizados;
