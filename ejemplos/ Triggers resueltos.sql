-- Ejercicio 1
CREATE TABLE customer_audit (
    audit_id SERIAL PRIMARY KEY,
    customer_id INTEGER,
    first_name TEXT,
    last_name TEXT,
    deleted_at TIMESTAMP DEFAULT now()
);

CREATE OR REPLACE FUNCTION log_customer_delete()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO customer_audit (customer_id, first_name, last_name, deleted_at)
    VALUES (OLD.customer_id, OLD.first_name, OLD.last_name, now());
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER customer_delete_trigger
AFTER DELETE ON customer
FOR EACH ROW
EXECUTE FUNCTION log_customer_delete();

-- Ejercicio 2:
CREATE OR REPLACE FUNCTION prevent_inventory_update()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.store_id <> OLD.store_id THEN
        RAISE EXCEPTION 'No se puede cambiar el store_id';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER inventory_update_trigger
BEFORE UPDATE ON inventory
FOR EACH ROW
EXECUTE FUNCTION prevent_inventory_update();

-- Ejercicio 3:
CREATE OR REPLACE FUNCTION set_return_date()
RETURNS TRIGGER AS $$
BEGIN
    NEW.return_date := NEW.rental_date + INTERVAL '7 days';
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER rental_return_trigger
BEFORE INSERT ON rental
FOR EACH ROW
EXECUTE FUNCTION set_return_date();

-- Ejercicio 4:
CREATE TABLE film_price_log (
    log_id SERIAL PRIMARY KEY,
    film_id INTEGER,
    old_rental_rate NUMERIC,
    new_rental_rate NUMERIC,
    change_date TIMESTAMP DEFAULT now()
);

CREATE OR REPLACE FUNCTION log_film_price_change()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO film_price_log (film_id, old_rental_rate, new_rental_rate, change_date)
    VALUES (OLD.film_id, OLD.rental_rate, NEW.rental_rate, now());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER film_price_trigger
AFTER UPDATE OF rental_rate ON film
FOR EACH ROW
EXECUTE FUNCTION log_film_price_change();
