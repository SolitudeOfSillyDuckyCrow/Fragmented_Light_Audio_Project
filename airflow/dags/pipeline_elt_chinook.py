from __future__ import annotations

import pendulum

from airflow.decorators import dag, task
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.providers.postgres.operators.postgres import PostgresOperator

# Definición de la conexión a PostgreSQL configurada en Airflow.
# El DAG usará esta conexión para ejecutar los scripts SQL.
POSTGRES_CONN_ID = "postgres_chinook_connection"

@dag(
    dag_id="chinook_elt_pipeline",
    start_date=pendulum.datetime(2023, 1, 1, tz="UTC"),
    schedule=None,  # Se ejecuta manualmente o bajo un trigger
    catchup=False,
    tags=["elt", "postgres", "chinook", "reporting"],
    doc_md=__doc__,
)
def chinook_elt_pipeline():
    """
    DAG de Airflow que orquesta el pipeline ELT.
    
    1.  Carga Inicial: Asumimos que la carga de las 11 tablas transaccionales (E/L)
        se maneja al inicio por el script '01_esquema_base_chinook.sql' 
        ejecutado por Docker Compose.
    2.  Transformación (T): Ejecuta el script SQL '02_transformacion_reporting.sql'
        para crear las 2 tablas agregadas de reporting (Tablas 12 y 13).
    3.  Verificación: Confirma que las 13 tablas existen.
    """

    # --- Tarea 1: Ejecución de la Transformación (T) ---
    # Esta tarea ejecuta el script SQL que crea las dos tablas de agregación.
    transformacion_reporting = PostgresOperator(
        task_id="ejecutar_transformacion_reporting",
        postgres_conn_id=POSTGRES_CONN_ID,
        sql="./sql/02_transformacion_reporting.sql", # Ruta del archivo DML/DDL
        # El hook se encarga de leer el archivo .sql y ejecutarlo
        # Esto crea 'Ventas_Agregadas_x_Cliente' y 'Ventas_Diarias_Globales'
    )

    # --- Tarea 2: Verificación de la Base de Datos (13 Tablas) ---
    # Confirma que las 11 tablas base + las 2 tablas de reporting existen.
    @task
    def verificar_conteo_tablas():
        """
        Consulta la base de datos para contar el número total de tablas en el esquema 'public'.
        Debe ser 13 para cumplir con el requisito de la rúbrica (11 base + 2 de reporting).
        """
        hook = PostgresHook(postgres_conn_id=POSTGRES_CONN_ID)
        
        # Consulta para contar todas las tablas en el esquema 'public'
        sql_query = """
        SELECT count(*)
        FROM information_schema.tables
        WHERE table_schema = 'public'
          AND table_type = 'BASE TABLE';
        """
        
        # Ejecuta la consulta y obtiene el resultado (una tupla)
        result = hook.get_first(sql_query)
        
        table_count = result[0]
        expected_count = 13
        
        if table_count != expected_count:
            raise ValueError(
                f"ERROR: Se encontraron {table_count} tablas. Se esperaban {expected_count} (11 base + 2 de reporting)."
            )
        print(f"ÉXITO: Conteo de tablas verificado. Se encontraron exactamente {table_count} tablas (cumplimiento de rúbrica).")

    verificacion_final = verificar_conteo_tablas()


    # --- Definición del Orden del Pipeline (Flujo) ---
    # El proceso es secuencial: Transformación -> Verificación
    transformacion_reporting >> verificacion_final

# Instancia el DAG
chinook_elt_pipeline()