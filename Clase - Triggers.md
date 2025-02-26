# Triggers en PostgreSQL

## Introducción
Los **triggers** en PostgreSQL son funciones que se ejecutan automáticamente en respuesta a eventos específicos en una tabla, como inserciones, actualizaciones o eliminaciones. Son útiles para mantener la integridad de los datos, realizar auditorías y automatizar tareas dentro de la base de datos.

## Sintaxis de un Trigger
Para crear un trigger en PostgreSQL, se necesita:
1. Una **función** que se ejecutará cuando el trigger sea activado.
2. La **creación del trigger**, que asocia la función con una tabla y un evento.

### 1. Creación de la función del Trigger
```sql
CREATE OR REPLACE FUNCTION nombre_funcion()
RETURNS TRIGGER AS $$
BEGIN
    -- Lógica del trigger
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

### 2. Creación del Trigger
```sql
CREATE TRIGGER nombre_trigger
{ BEFORE | AFTER | INSTEAD OF } { INSERT | UPDATE | DELETE }
ON nombre_tabla
FOR EACH { ROW | STATEMENT }
EXECUTE FUNCTION nombre_funcion();
```

## Tipos de Triggers
Los triggers pueden ser clasificados según:
- **Momento de ejecución**:
  - `BEFORE`: Se ejecuta antes de que el evento ocurra.
  - `AFTER`: Se ejecuta después de que el evento ocurra.
  - `INSTEAD OF`: Se usa en vistas para reemplazar la operación estándar.
- **Nivel de ejecución**:
  - `FOR EACH ROW`: Se ejecuta una vez por cada fila afectada.
  - `FOR EACH STATEMENT`: Se ejecuta una vez por cada sentencia SQL ejecutada.

## Ejemplo de Uso
### 1. Auditoría de Inserciones
Este trigger registrará en una tabla los cambios realizados a otra tabla.

#### Creación de la tabla de auditoría
```sql
CREATE TABLE auditoria (
    id SERIAL PRIMARY KEY,
    usuario TEXT,
    accion TEXT,
    fecha TIMESTAMP DEFAULT now()
);
```

#### Creación de la función del trigger
```sql
CREATE OR REPLACE FUNCTION registrar_insercion()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO auditoria (usuario, accion, fecha)
    VALUES (current_user, 'INSERT en tabla_principal', now());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

#### Creación del trigger
```sql
CREATE TRIGGER trigger_auditoria
AFTER INSERT ON city
FOR EACH ROW
EXECUTE FUNCTION registrar_insercion();
```

#### Comprobación del trigger
Insertar una nueva fila en city:
```sql
INSERT INTO city (city, country_id, population)
VALUES ('Cali', 24, 3400000);
```

Consultar la tabla auditoria:
```sql
SELECT * FROM auditoria;
```

## Consideraciones y Buenas Prácticas
- **Evitar lógica compleja dentro de triggers**, ya que pueden afectar el rendimiento.
- **Usar triggers solo cuando sea necesario**, ya que pueden hacer que las operaciones sean menos predecibles.
- **Probar exhaustivamente los triggers** antes de usarlos en producción.
- **Usar triggers con moderación en bases de datos con alta concurrencia** para evitar bloqueos o sobrecarga.

## Otros ejemplos en pagila

### Trigger `FOR EACH ROW`
Este trigger registra cada nueva renta realizada en la tabla `rental_audit`.
```sql
CREATE TABLE rental_audit (
    audit_id SERIAL PRIMARY KEY,
    rental_id INTEGER,
    staff_id INTEGER,
    action TEXT,
    action_date TIMESTAMP DEFAULT now()
);

CREATE OR REPLACE FUNCTION log_rental()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO rental_audit (rental_id, staff_id, action, action_date)
    VALUES (NEW.rental_id, NEW.staff_id, 'INSERT', now());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER rental_trigger
AFTER INSERT ON rental
FOR EACH ROW
EXECUTE FUNCTION log_rental();
```

### Trigger `FOR EACH STATEMENT`
Este trigger registra un evento cada vez que se realiza una actualización masiva en la tabla `rental`.
```sql
CREATE TABLE rental_update_log (
    log_id SERIAL PRIMARY KEY,
    action TEXT,
    affected_rows INTEGER,
    action_date TIMESTAMP DEFAULT now()
);

CREATE OR REPLACE FUNCTION log_rental_update()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO rental_update_log (action, affected_rows, action_date)
    VALUES ('UPDATE', (SELECT COUNT(*) FROM rental WHERE last_update = now()), now());
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER rental_update_trigger
AFTER UPDATE ON rental
FOR EACH STATEMENT
EXECUTE FUNCTION log_rental_update();
```

## Conclusión
Los triggers en PostgreSQL son una herramienta poderosa para la automatización y el control de la base de datos. Sin embargo, deben usarse con precaución para evitar problemas de rendimiento y depuración.

# Ejercicios

1. Registro de Eliminaciones en la Tabla customer
  - Crea un trigger que registre en una tabla `customer_audit` cada vez que se elimine un cliente.
  - Guarda el `customer_id`, `first_name`, `last_name` y la fecha de eliminación.

2. Restricción de Actualización en la Tabla inventory
  - Implementa un trigger que impida actualizar el `store_id` en la tabla inventory si el nuevo valor es distinto al original.
  - Si se intenta cambiar, lanza un error con un mensaje adecuado.

3. Cálculo Automático de la Fecha de Devolución en rental
  - Crea un trigger que, después de insertar un nuevo registro en `rental`, actualice automáticamente la fecha de devolución (`return_date`) sumando 7 días a la `rental_date`.
  - Registro de Cambios en la Tarifa de Películas (`film` Table)

4. Crea un trigger que registre cada cambio en la columna `rental_rate` de la tabla `film`.
  - Guarda en una tabla `film_price_log` el `film_id`, el `old_rental_rate`, el `new_rental_rate` y la fecha del cambio.
---

**Referencias:**
- [Documentación Oficial de PostgreSQL sobre Triggers](https://www.postgresql.org/docs/current/triggers.html)

