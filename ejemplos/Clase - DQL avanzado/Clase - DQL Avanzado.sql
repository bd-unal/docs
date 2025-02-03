-- DQL Avanzado
-- Esta consulta muestra todas las categorías asignadas a las películas, incluyendo duplicados
SELECT
  category_id
FROM
  film_category;

-- Si queremos ver solo las categorías únicas de películas
SELECT
  DISTINCT category_id
FROM
  film_category;

-- Todos los nombres diferentes de clientes sin duplicados:
SELECT
  DISTINCT first_name
FROM
  customer;

-- RENAME
-- En la base de datos Pagila, podemos cambiar el nombre de `rental_rate` a "Tarifa de Renta" en la salida de la consulta:
SELECT
  title,
  rental_rate AS "Tarifa de Renta"
FROM
  film;

-- Podemos asignar un alias a la tabla `film` para escribir consultas más concisas
SELECT
  f.title,
  f.rental_duration
FROM
  film AS f;

-- Funciones Matemáticas en SQL
-- Consultar el doble del precio de renta de cada película en la tabla `film`
SELECT
  title,
  rental_rate,
  rental_rate * 2 AS doble_renta
FROM
  film;

-- Mostrar si el rental_duration de una película es par o impar: 
SELECT
  title,
  rental_duration,
  rental_duration % 2 AS es_impar
FROM
  film;

-- Obtener el valor absoluto de la diferencia entre la tarifa de alquiler (`rental_rate`) y el costo de reemplazo (`replacement_cost`) de una película:
SELECT
  title,
  rental_rate,
  replacement_cost,
  ABS(rental_rate - replacement_cost) AS diferencia_absoluta
FROM
  film;

-- Evaluar si la diferencia entre `rental_rate` y `replacement_cost` es positiva o negativa:
SELECT
  title,
  rental_rate,
  replacement_cost,
  SIGN(rental_rate - replacement_cost) AS signo_diferencia
FROM
  film;

-- Determinar si la duración de alquiler (`rental_duration`) de una película es múltiplo de 3
SELECT
  title,
  rental_duration,
  MOD(rental_duration, 3) AS residuo_modulo
FROM
  film;

-- Obtener el costo de reemplazo redondeado hacia abajo:
SELECT
  title,
  replacement_cost,
  FLOOR(replacement_cost) AS costo_redondeado_abajo
FROM
  film;

-- Redondear el `replacement_cost` hacia arriba:
SELECT
  title,
  replacement_cost,
  CEILING(replacement_cost) AS costo_redondeado_arriba
FROM
  film;

-- Elevar la tarifa de renta al cuadrado (`rental_rate²`):
SELECT
  title,
  rental_rate,
  POWER(rental_rate, 2) AS renta_al_cuadrado
FROM
  film;

-- Redondear el costo de reemplazo (`replacement_cost`):
SELECT
  title,
  replacement_cost,
  ROUND(replacement_cost) AS costo_redondeado
FROM
  film;

-- Costo redondeado con un decimal
SELECT
  title,
  replacement_cost,
  ROUND(replacement_cost, 1) AS costo_redondeado_2decimales
FROM
  film;

-- Obtener la raíz cuadrada del costo de reemplazo:
SELECT
  title,
  replacement_cost,
  SQRT(replacement_cost) AS raiz_cuadrada_costo
FROM
  film;

-- FUNCIONES DE AGREGACION Y GROUP BY
-- Contar el total de películas en la tabla film
SELECT
  COUNT(*)
FROM
  film;

-- Obtener el precio máximo de renta en la tabla film
SELECT
  MAX(rental_rate)
FROM
  film;

-- Calcular el promedio de duración de las películas
SELECT
  AVG(length)
FROM
  film;

-- Calcular el promedio de duración de las películas por cada rating
SELECT
  rating,
  AVG(length)
FROM
  film
GROUP BY
  rating;

-- Calcular la duración mínima, máxima, total y promedio por rating
SELECT
  rating,
  MIN(length) AS duracion_minima,
  MAX(length) AS duracion_maxima,
  SUM(length) AS duracion_total,
  AVG(length) AS duracion_promedio
FROM
  film
GROUP BY
  rating;

-- HAVING
SELECT
  rating,
  COUNT(*)
FROM
  film
GROUP BY
  rating;

-- Filtrar clasificaciones con más de 200 películas
SELECT
  rating,
  COUNT(*)
FROM
  film
GROUP BY
  rating
HAVING
  COUNT(*) > 200;

-- Filtrar películas con duración > 60 min y contar solo las clasificaciones con más de 150 películas
SELECT
  rating,
  COUNT(*)
FROM
  film
WHERE
  length > 60
GROUP BY
  rating
HAVING
  COUNT(*) > 150;

-- ORDER BY
-- Obtener todas las películas ordenadas por su duración (`length`) en orden ascendente:
SELECT
  title,
  length
FROM
  film
ORDER BY
  length ASC;

SELECT
  title,
  length
FROM
  film
ORDER BY
  length;

-- Obtener las películas más largas primero
SELECT
  title,
  length
FROM
  film
ORDER BY
  length DESC;

-- Ordenar las películas por clasificación (`rating`) y, dentro de cada clasificación, ordenarlas por duración (`length`)
SELECT
  title,
  rating,
  length
FROM
  film
ORDER BY
  rating ASC,
  length DESC;

-- Contar cuántas películas hay por clasificación (`rating`) y ordenarlas de mayor a menor cantidad
SELECT
  rating,
  COUNT(*)
FROM
  film
GROUP BY
  rating
ORDER BY
  COUNT(*) DESC;

-- AND / OR
-- Películas con duración mayor a 120 minutos y con clasificación 'PG-13'
SELECT
  title,
  length,
  rating
FROM
  film
WHERE
  length > 120
  AND rating = 'PG-13';

-- Películas con clasificación 'G' o 'PG'
SELECT
  title,
  rating
FROM
  film
WHERE
  rating = 'G'
  OR rating = 'PG';

-- Películas con clasificación 'G', 'PG' o 'PG-13'
SELECT
  title,
  rating
FROM
  film
WHERE
  rating IN ('G', 'PG', 'PG-13');

-- Películas que no son 'G', 'PG' o 'PG-13'
SELECT
  title,
  rating
FROM
  film
WHERE
  rating NOT IN ('G', 'PG', 'PG-13');

-- Películas con duración entre 90 y 150 minutos
SELECT
  title,
  rating
FROM
  film
WHERE
  rating NOT IN ('G', 'PG', 'PG-13');

-- Películas con duración menor a 90 o mayor a 150 minutos
SELECT
  title,
  length
FROM
  film
WHERE
  length NOT BETWEEN 90
  AND 150;

-- Películas que tienen la misma duración que la película más larga
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
  );

-- Películas alquiladas por al menos un cliente específico
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
        WHERE
          customer_id = 1
      )
  );