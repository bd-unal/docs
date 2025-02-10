-- Ejercicios en clase
-- 1. Muestra las películas que tienen una duración (length) mayor a 100 minutos y una clasificación (rating) de 'R'. ¿Cuántas películas cumplen esta condición?
SELECT
  COUNT(*)
FROM
  film
WHERE
  length > 100
  AND rating = 'R';

-- 2. Muestra las películas cuyo precio de alquiler (rental_rate) sea superior al precio medio de todas las películas.
SELECT
  title,
  rental_rate
FROM
  film
WHERE
  rental_rate > (
    SELECT
      AVG(rental_rate)
    FROM
      film
  );

-- 3. Agrupa las películas por duración (length) y muestra cuántas películas existen para cada duración única.
SELECT
  length,
  COUNT(*) AS "Número de Películas"
FROM
  film
GROUP BY
  length;

-- 4. Muestra el precio de alquiler (rental_rate) de las películas con un descuento del 20%, renombrado como "Precio con Descuento". Usa el title de la pelicula.
SELECT
  title,
  rental_rate,
  rental_rate * 0.8 AS "Precio con Descuento"
FROM
  film;

-- 5. Muestra las películas cuyo costo de reemplazo (replacement_cost) sea mayor al costo promedio de todas las películas.
SELECT
  title,
  replacement_cost
FROM
  film
WHERE
  replacement_cost > (
    SELECT
      AVG(replacement_cost)
    FROM
      film
  );

-- 6. Muestra los títulos de las películas (title) donde el costo de reemplazo (replacement_cost) es un múltiplo de 5.
SELECT
  title,
  replacement_cost
FROM
  film
WHERE
  MOD(replacement_cost, 5) = 0;

-- 7. Muestra las películas cuya duración (length) no esté entre 90 y 120 minutos.
SELECT
  title,
  length
FROM
  film
WHERE
  length NOT BETWEEN 90
  AND 120;

-- 8. Muestra el total del costo de reemplazo (replacement_cost) por cada clasificación (rating) de película.
SELECT
  rating,
  SUM(replacement_cost) AS "Costo Total de Reemplazo"
FROM
  film
GROUP BY
  rating;

-- 9. Cuenta cuántas películas hay en cada clasificación (rating), pero excluyendo aquellas con clasificación 'PG' y 'R'.
SELECT
  rating,
  COUNT(*) AS "Número de Películas"
FROM
  film
WHERE
  rating NOT IN ('PG', 'R')
GROUP BY
  rating;

-- 10. Muestra los títulos de las películas (title) donde el costo de alquiler (rental_rate) es más de tres veces el costo de reemplazo (replacement_cost).
SELECT
  title,
  rental_rate,
  replacement_cost
FROM
  film
WHERE
  rental_rate > 3 * replacement_cost;

-- 11. Ordena las películas por su duración de mayor a menor y muestra solo las 10 primeras.
SELECT
  title,
  length
FROM
  film
ORDER BY
  length DESC
LIMIT
  10;

-- 12. Muestra el título (title) de las películas junto con la diferencia entre su tarifa de alquiler (rental_rate) y su costo de reemplazo (replacement_cost).
SELECT
  title,
  rental_rate,
  replacement_cost,
  rental_rate - replacement_cost AS "Diferencia"
FROM
  film;

-- 13. Muestra los títulos (title) de las películas que tienen el mismo costo de reemplazo (replacement_cost) que la película más barata.
SELECT
  title
FROM
  film
WHERE
  replacement_cost = (
    SELECT
      MIN(replacement_cost)
    FROM
      film
  );

-- 14. Agrupa las películas por su duración total (length) y muestra el precio promedio de alquiler (rental_rate) por cada grupo de duración.
SELECT
  length,
  AVG(rental_rate) AS "Promedio de Alquiler"
FROM
  film
GROUP BY
  length;

-- 15. Muestra las películas cuya duración (length) sea igual a la de la película más larga o más corta.
SELECT
  title,
  length
FROM
  film
WHERE
  length = (
    SELECT
      MAX(length)
    FROM
      film
  )
  OR length = (
    SELECT
      MIN(length)
    FROM
      film
  );

-- 16. Muestra las películas que tienen un costo de reemplazo (replacement_cost) superior al promedio y cuya duración (length) sea menor a 90 minutos.
SELECT
  title,
  replacement_cost,
  length
FROM
  film
WHERE
  replacement_cost > (
    SELECT
      AVG(replacement_cost)
    FROM
      film
  )
  AND length < 90;

-- 17. Muestra las películas que han sido alquiladas más recientemente según la fecha de alquiler.
SELECT
  title
FROM
  film
WHERE
  film_id IN (
    SELECT
      film_id
    FROM
      inventory
    WHERE
      inventory_id IN (
        SELECT
          inventory_id
        FROM
          rental
        ORDER BY
          rental_date DESC
        LIMIT
          1
      )
  );

-- 18. Muestra las películas de las clasificaciones (rating) más populares, ordenadas por la cantidad de películas en cada clasificación.
SELECT
  rating,
  COUNT(*) AS "Cantidad de Películas"
FROM
  film
GROUP BY
  rating
ORDER BY
  COUNT(*) DESC
LIMIT
  1;

-- 19. Muestra los títulos de las películas cuyo costo de reemplazo es menor que el costo promedio de alquiler.
SELECT
  title,
  replacement_cost,
  rental_rate
FROM
  film
WHERE
  replacement_cost < (
    SELECT
      AVG(rental_rate)
    FROM
      film
  );

-- 20. Cuenta cuántas películas hay en cada clasificación (rating) y muestra solo las clasificaciones con más de 50 películas.
SELECT
  rating,
  COUNT(*) AS "Número de Películas"
FROM
  film
GROUP BY
  rating
HAVING
  COUNT(*) > 50;