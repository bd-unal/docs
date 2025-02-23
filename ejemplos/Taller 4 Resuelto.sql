-- 1. Genere una consulta para mostrar los clientes `customer` (solo sus nombres completos, ID de cliente y país) que no están en `Brazil`.
SELECT customer_id, first_name, last_name, country
FROM customer
WHERE country != 'Brazil';

-- 2. Genere una consulta que muestra una lista única de países de facturación `billing_country` de la tabla factura `invoice`.
SELECT DISTINCT billing_country FROM invoice;

-- 3. Genere una consulta que muestre las facturas asociadas a cada agente de ventas. La tabla resultante debe incluir el nombre completo del agente de ventas.
SELECT e.first_name, e.last_name, i.invoice_id, i.customer_id, i.invoice_date, i.billing_address, i.billing_country, i.billing_postal_code, i.total
FROM customer AS c 
JOIN invoice AS i ON c.customer_id = i.customer_id
JOIN employee AS e ON e.employee_id = c.support_rep_id
ORDER BY e.employee_id;

-- 4. ¿Cuántas facturas hubo en 2009 y 2011? ¿Cuáles son las ventas totales respectivas para cada uno de esos años? 
SELECT COUNT(i.invoice_id), SUM(i.total)
FROM invoice AS i
WHERE i.invoice_date BETWEEN CAST('2021-01-01 00:00:00' AS DATE) AND CAST('2023-12-31 00:00:00' AS DATE);

-- 5. Genere una consulta que muestre la cantidad total de pistas `playlisttrack` en cada lista de reproducción `playlist`. El nombre de la lista de reproducción debe incluirse en la tabla resultante.
SELECT COUNT(track_id), playlist.name
FROM playlist_track JOIN playlist
ON playlist_track.playlist_id = playlist.playlist_id
GROUP BY playlist.name
ORDER BY count(track_id) DESC;

-- 6. ¿Qué agente de ventas ha generado más ventas a la fecha? Muestre el nombre y apellido del agente de ventas, así como la cantidad de ventas que ha generado ordenado de mayor a menor.

WITH cte_total_ventas_agente AS (
	SELECT e.employee_id, e.first_name || ' ' || e.last_name AS employee_full_name, SUM(i.total) AS total
	FROM employee AS e 
	JOIN customer AS c ON e.employee_id = c.support_rep_id
	JOIN invoice AS i on i.customer_id = c.customer_id
	GROUP BY e.employee_id, employee_full_name
)
SELECT employee_full_name, MAX(total) 
FROM cte_total_ventas_agente
GROUP BY employee_full_name
ORDER BY MAX(total) DESC;

-- 7. Proporcione una consulta que muestre la cantidad de clientes asignados a cada agente de ventas.
SELECT e.first_name || ' ' || e.last_name AS employee_full_name, COUNT(c.customer_id) AS total_customers
FROM employee AS e
JOIN customer AS c ON e.employee_id = c.support_rep_id
GROUP BY employee_full_name
ORDER BY total_customers DESC;

-- 8. Genere una consulta que muestre la pista más comprada de 2023.
SELECT t.name, count(t.track_id) AS count
FROM invoice_line AS il
	JOIN invoice AS i ON i.invoice_id = il.invoice_id
	JOIN track AS t ON t.track_id = il.track_id
WHERE EXTRACT(YEAR FROM i.invoice_date) = 2023
GROUP BY t.name
ORDER BY count desc
