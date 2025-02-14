# Taller Práctico de DQL

Este taller tiene como objetivo que practique y refuerce conceptos de DQL (Data Query Language) utilizando la base de datos de ejemplo **Chinook**. 

---

## Objetivos

- Practicar consultas básicas y avanzadas con SQL.
- Aplicar funciones para manipular datos numéricos, fechas y textos.
- Utilizar agrupamientos, ordenamientos y filtros en las consultas.
- Aprender a combinar datos de varias tablas (joins) y estructurar consultas complejas usando CTEs.

---

## 📌 Entrega

El taller debe ser enviado al correo del profesor antes de finalizar el día (Febrero 17 de 2025 - 11:59pm). Los entregables son:
- Documento `pdf` con capturas de pantalla de los resultados, así como algún comentario adicional cuando lo considere pertinente.
- El documento debe incluir una reflexión sobre qué fue lo más fácil y lo más difícil del taller.
- Archivo `.sql` con las consultas generadas. El archivo debe tener comentarios para referenciar a que hace referencia cada consulta. Ver [este archivo como ejemplo](ejemplos%2FClase%20-%20DQL%20b%C3%A1sico%20y%20DML%2FClase%20-%20DQL%20b%C3%A1sico%20y%20DML.sql).

> El documento no es únicamente copiar las capturas de pantalla y pegarlas. Para este taller se tendrá en cuenta la estructura del documento, la calidad de las respuestas y la claridad de las explicaciones. Se deberá explicar como se abordó el problema y como se llegó a la solución, eso es más imporante que las capturas de pantalla. 
Dado que se estás pidiendo un archivo `.sql` con las consultas, no es necesario que se incluyan las consultas en el documento `pdf`, pero se deben incluir los resultados obtenidos.

---

## 📌 Requisitos del Sistema
- Se debe utilizar la base de datos **Chinook**. Siga el proceso visto en clase para restaurar la base de datos en su servidor local o en Neon.Tech. La restauración de la base de datos se puede hacer con el archivo `chinook.sql` que se encuentra en la carpeta `data` de este repositorio. Se debe documentar el proceso que se siguió para la restauración de la base de datos. Se debe documentar este proceso.
- La base de datos **Chinook** es un esquema de ejemplo que modela una tienda de medios digitales (similar a iTunes). Esta base de datos permite explorar conceptos básicos y avanzados de SQL y modelado de datos en un contexto realista. Más información sobre la base de datos [aquí](https://github.com/lerocha/chinook-database).
> Por ejemplo, yo restauré la base de datos en Neon.Tech con el siguiente comando:
```bash
 psql -d "postgresql://neondb_owner:XXXXXX@ep-tight-brook-a5xgpz7i-pooler.us-east-2.aws.neon.tech/chinook?sslmode=require" -f data/chinook.sql 
```

- Se adjunta el diagrama relacional de la base de datos **Chinook** para su referencia.
![Diagrama de la base de datos Chinook](../images/chinook_erd.png)

---

## Ejercicios
1. Genere una consulta para mostrar los clientes `customer` (solo sus nombres completos, ID de cliente y país) que no están en `Brazil`.
2. Genere una consulta que muestra una lista única de países de facturación `billing_country` de la tabla factura `invoice`.
3. Genere una consulta que muestre las facturas asociadas a cada agente de ventas. La tabla resultante debe incluir el nombre completo del agente de ventas.
> Nota: Las facturas se consultan en la tabla `invoice` y los agentes de ventas en la tabla `employee`, sin embargo se tiene que hacer un join con la tabla `customer` por el atributo `support_rep_id`.
4. ¿Cuántas facturas hubo en 2009 y 2011? ¿Cuáles son las ventas totales respectivas para cada uno de esos años? 
> Usar el atributo `invoice_date` de la tabla `invoice` y el atributo `total` de la tabla `invoice`.
5. Genere una consulta que muestre la cantidad total de pistas `playlist_track` en cada lista de reproducción `playlist` ordenado de mayor a menor. El nombre de la lista de reproducción debe incluirse en la tabla resultante.
6. ¿Qué agente de ventas ha generado más ventas a la fecha? Muestre el nombre y apellido del agente de ventas, así como la cantidad de ventas que ha generado ordenado del que más ha vendido al que menos.
> Utilice un CTE para resolver este problema.
7. Proporcione una consulta que muestre la cantidad de clientes asignados a cada agente de ventas. Similar al ejercicio anterior, muestre el nombre y apellido del agente de ventas ordenado de mayor a menor según la cantidad de clientes asignados.
8. Genere una consulta que muestre el nombre de la pista más comprada de 2023.
> En caso de haber más de una pista con la misma cantidad de compras, muestre todas las pistas.
> Tiene que usar las tablas `invoice_line` e `invoice` así como la tablas `track`.

---

😜 Disfrute del taller y recuerde que la práctica es la clave para mejorar en SQL.
