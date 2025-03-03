-- Archivo: ejercicios_pagila.sql
-- Soluciones para ejercicios de TCL, funciones, procedimientos almacenados y DCL en la base de datos Pagila
-- Cada ejercicio incluye comentarios explicativos.

------------------------------------------------------------
-- Ejercicio 1: Procedimiento para Actualizar Tarifas de Alquiler
-- por Categoría.
-- Este procedimiento recibe un id de categoría (p_category_id) y un
-- multiplicador (p_multiplier), y actualiza la columna rental_rate de
-- todas las películas que pertenecen a esa categoría.
------------------------------------------------------------
DROP PROCEDURE IF EXISTS adjust_rental_rate_by_category(INT, NUMERIC);
CREATE OR REPLACE PROCEDURE adjust_rental_rate_by_category(
    p_category_id INT,
    p_multiplier NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE film
    SET rental_rate = rental_rate * p_multiplier
    WHERE film_id IN (
        SELECT fc.film_id
        FROM film_category fc
        WHERE fc.category_id = p_category_id
    );
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;

------------------------------------------------------------
-- Ejercicio 2: Función para Calcular Ingresos Totales de una Película.
-- La función calculate_film_revenue recibe un film_id y calcula la suma
-- de los pagos asociados a esa película, utilizando las tablas film,
-- inventory, rental y payment.
------------------------------------------------------------
DROP FUNCTION IF EXISTS calculate_film_revenue(INT);
CREATE OR REPLACE FUNCTION calculate_film_revenue(p_film_id INT)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    total_revenue NUMERIC;
BEGIN
    -- Verificar que la película exista.
    IF NOT EXISTS (SELECT 1 FROM film WHERE film_id = p_film_id) THEN
        RAISE EXCEPTION 'Film with id % does not exist', p_film_id;
    END IF;

    SELECT COALESCE(SUM(p.amount), 0) INTO total_revenue
    FROM film f
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN payment p ON r.rental_id = p.rental_id
    WHERE f.film_id = p_film_id;

    RETURN total_revenue;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;

------------------------------------------------------------
-- Ejercicio 3: Procedimiento para Reasignar Inventario entre Tiendas.
-- Este procedimiento mueve un número específico de copias (p_quantity)
-- de una película (p_film_id) desde la tienda de origen (p_store_origin)
-- a la tienda destino (p_store_destination).
------------------------------------------------------------
DROP PROCEDURE IF EXISTS reassign_inventory_between_stores(INT, INT, INT, INT);
CREATE OR REPLACE PROCEDURE reassign_inventory_between_stores(
    p_film_id INT,
    p_store_origin INT,
    p_store_destination INT,
    p_quantity INT)
LANGUAGE plpgsql
AS $$
DECLARE
    available INT;
BEGIN
    -- Contar las copias disponibles en la tienda de origen.
    SELECT COUNT(*) INTO available
    FROM inventory
    WHERE film_id = p_film_id AND store_id = p_store_origin;

    IF available < p_quantity THEN
        RAISE EXCEPTION 'Not enough inventory in store % for film %: available %, required %', 
                        p_store_origin, p_film_id, available, p_quantity;
    END IF;

    -- Actualizar el store_id para p_quantity copias disponibles.
    WITH cte AS (
        SELECT inventory_id
        FROM inventory
        WHERE film_id = p_film_id AND store_id = p_store_origin
        LIMIT p_quantity
    )
    UPDATE inventory
    SET store_id = p_store_destination
    WHERE inventory_id IN (SELECT inventory_id FROM cte);
END;
$$;

------------------------------------------------------------
-- Ejercicio 4: Gestión de Permisos con DCL para Operaciones de Alquiler.
-- Se crea el rol rental_manager, se otorgan permisos sobre las tablas
-- rental, payment, inventory y film, y se revoca el permiso de UPDATE sobre film.
------------------------------------------------------------
-- Crear el rol rental_manager si no existe.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'rental_manager') THEN
        CREATE ROLE rental_manager;
    END IF;
END;
$$;

-- Otorgar permisos en las tablas relacionadas.
GRANT SELECT, INSERT, UPDATE ON rental, payment, inventory, film TO rental_manager;

-- Revocar el permiso de UPDATE sobre la tabla film.
REVOKE UPDATE ON film FROM rental_manager;

------------------------------------------------------------
-- Ejercicio 5: Función para Validar la Disponibilidad de Inventario.
-- La función available_inventory recibe un film_id y un store_id, y
-- devuelve el número de copias disponibles (no alquiladas) en esa tienda.
------------------------------------------------------------
DROP FUNCTION IF EXISTS available_inventory(INT, INT);
CREATE OR REPLACE FUNCTION available_inventory(
    p_film_id INT,
    p_store_id INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total_copies INT;
    rented_copies INT;
    available INT;
BEGIN
    -- Validar que la película exista.
    IF NOT EXISTS (SELECT 1 FROM film WHERE film_id = p_film_id) THEN
        RAISE EXCEPTION 'Film with id % does not exist', p_film_id;
    END IF;
    -- Validar que la tienda exista.
    IF NOT EXISTS (SELECT 1 FROM store WHERE store_id = p_store_id) THEN
        RAISE EXCEPTION 'Store with id % does not exist', p_store_id;
    END IF;

    SELECT COUNT(*) INTO total_copies
    FROM inventory
    WHERE film_id = p_film_id AND store_id = p_store_id;

    SELECT COUNT(DISTINCT r.inventory_id) INTO rented_copies
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    WHERE i.film_id = p_film_id 
      AND i.store_id = p_store_id
      AND r.return_date IS NULL;

    available := total_copies - rented_copies;
    RETURN available;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;

------------------------------------------------------------
-- Ejercicio 6: Procedimiento para Procesar el Alquiler de una Película.
-- Este procedimiento simula el proceso de alquiler:
--   1. Recibe p_customer_id y p_film_id.
--   2. Obtiene la tienda asociada al cliente.
--   3. Busca un inventory_id disponible para la película en esa tienda.
--   4. Selecciona un staff de la tienda (por ejemplo, el de menor id).
--   5. Inserta un registro en la tabla rental.
------------------------------------------------------------
DROP PROCEDURE IF EXISTS process_film_rental(INT, INT);
CREATE OR REPLACE PROCEDURE process_film_rental(
    p_customer_id INT,
    p_film_id INT)
LANGUAGE plpgsql
AS $$
DECLARE
    v_inventory_id INT;
    v_store_id INT;
    v_staff_id INT;
BEGIN
    -- Obtener la tienda asociada al cliente.
    SELECT store_id INTO v_store_id FROM customer WHERE customer_id = p_customer_id;
    IF v_store_id IS NULL THEN
        RAISE EXCEPTION 'Customer % does not have an associated store', p_customer_id;
    END IF;

    -- Buscar una copia disponible para el film en la tienda del cliente.
    SELECT i.inventory_id INTO v_inventory_id
    FROM inventory i
    WHERE i.film_id = p_film_id
      AND i.store_id = v_store_id
      AND i.inventory_id NOT IN (
          SELECT r.inventory_id
          FROM rental r
          WHERE r.return_date IS NULL
      )
    LIMIT 1;

    IF v_inventory_id IS NULL THEN
        RAISE EXCEPTION 'No available inventory for film % in store %', p_film_id, v_store_id;
    END IF;

    -- Seleccionar un staff de la tienda (por ejemplo, el de menor id).
    SELECT staff_id INTO v_staff_id
    FROM staff
    WHERE store_id = v_store_id
    ORDER BY staff_id
    LIMIT 1;

    -- Insertar el registro de alquiler.
    INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
    VALUES (NOW(), v_inventory_id, p_customer_id, v_staff_id);
END;
$$;

------------------------------------------------------------
-- Ejercicio 7: Integración de DCL en Funciones y Procedimientos.
-- Se crea el procedimiento recalc_rental_rate para recalcular la tarifa
-- de alquiler de una película, y se otorga permiso de ejecución solo al rol admin_rental.
------------------------------------------------------------
DROP PROCEDURE IF EXISTS recalc_rental_rate(INT, NUMERIC);
CREATE OR REPLACE PROCEDURE recalc_rental_rate(
    p_film_id INT,
    p_adjustment NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE film
    SET rental_rate = rental_rate + p_adjustment
    WHERE film_id = p_film_id;
END;
$$;

-- Crear el rol admin_rental si no existe.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'admin_rental') THEN
        CREATE ROLE admin_rental;
    END IF;
END;
$$;

-- Otorgar permiso de ejecución al rol admin_rental para el procedimiento recalc_rental_rate.
GRANT EXECUTE ON PROCEDURE recalc_rental_rate(INT, NUMERIC) TO admin_rental;


-- USAGE
-- Usage Examples for Procedures and Functions Created in the Solution

------------------------------------------------------------
-- Exercise 1: Usage of Procedure adjust_rental_rate_by_category
-- Adjust the rental rate for all films in category 3 by a multiplier of 1.15.
CALL adjust_rental_rate_by_category(3, 1.15);

------------------------------------------------------------
-- Exercise 2: Usage of Function calculate_film_revenue
-- Calculate and display the total revenue for the film with id 5.
SELECT calculate_film_revenue(5) AS revenue;

------------------------------------------------------------
-- Exercise 3: Usage of Procedure reassign_inventory_between_stores
-- Reassign 3 copies of the film with id 10 from store 1 to store 2.
CALL reassign_inventory_between_stores(10, 1, 2, 3);

------------------------------------------------------------
-- Exercise 5: Usage of Function available_inventory
-- Check the available inventory (non-rented copies) for the film with id 7 in store 1.
SELECT available_inventory(7, 1) AS available_copies;

------------------------------------------------------------
-- Exercise 6: Usage of Procedure process_film_rental
-- Process a rental for customer with id 15 renting the film with id 8.
CALL process_film_rental(15, 8);

------------------------------------------------------------
-- Exercise 7: Usage of Procedure recalc_rental_rate
-- Recalculate the rental rate for the film with id 12 by adding an adjustment of 0.50.
CALL recalc_rental_rate(12, 0.50);

------------------------------------------------------------
-- Fin del archivo: ejercicios_pagila.sql
------------------------------------------------------------




