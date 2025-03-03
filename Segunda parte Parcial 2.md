# Segunda Parte del Parcial - SQL Práctico
## Instrucciones Generales
A continuación, se presenta el esquema de una base de datos para gestionar una tienda de libros en línea. Debes realizar las siguientes actividades:

1. Crear las tablas necesarias con los tipos de datos adecuados (1.5 puntos).
2. Insertar datos en las tablas utilizando INSERT INTO (1 punto)
3. Ejecutar consultas DQL para extraer información relevante (1.5 puntos)
4. Crear una función que resuelva un problema planteado (1 punto).

Al final la nota máxima son 5 puntos. 

CUANDO TERMINE POR FAVOR ENVIAR UN SOLO ARCHIVO SQL AL CORREO DEL PROFESOR.

## Modelo relacional
El modelo relacional de la base de datos es el siguiente:

### Entidad: `autor`

- `id_autor` (PK, SERIAL)
- `nombre` (VARCHAR(100), NOT NULL)
- `nacionalidad` (VARCHAR(50), NULL)

### Entidad: `libro`

- `id_libro` (PK, SERIAL)
- `titulo` (VARCHAR(255), NOT NULL, UNIQUE)
- `fecha_publicacion` (DATE, NULL)
- `precio` (DECIMAL(10,2), NOT NULL, CHECK(precio > 0))
- `id_autor` (FK, INT, NOT NULL, REFERENCES autor(id_autor))

### Entidad: `cliente`

- `id_cliente` (PK, SERIAL)
- `nombre` (VARCHAR(100), NOT NULL)
- `correo` (VARCHAR(150), NOT NULL, UNIQUE, CHECK(correo LIKE '%@%'))
- `telefono` (VARCHAR(15), NULL)

### Entidad: `pedido`

- `id_pedido` (PK, SERIAL)
- `id_cliente` (FK, INT, NOT NULL, REFERENCES cliente(id_cliente))
- `fecha_pedido` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- `total` (DECIMAL(10,2), DEFAULT 0)

### Entidad: `detalle_pedido`

- `id_pedido` (FK, INT, NOT NULL, REFERENCES pedido(id_pedido))
- `id_libro` (FK, INT, NOT NULL, REFERENCES libro(id_libro))
- `cantidad` (SMALLINT, NOT NULL, CHECK(cantidad > 0))
- `subtotal` (DECIMAL(10,2), NOT NULL, CHECK(subtotal > 0))
- (PK compuesta: id_pedido, id_libro)

## PRIMER PUNTO: CREACION DE LAS TABLAS
Escribe los comandos `CREATE TABLE` para cada una de las entidades mencionadas anteriormente. </br>

💡 Puntos a evaluar:
- Definir correctamente claves primarias y foráneas.
- Asignar tipos de datos adecuados.
- Implementar restricciones (`NOT NULL`, `UNIQUE`, `CHECK`, `DEFAULT`).

## SEGUNDO PUNTO: INSERTAR DATOS
Suministramos algunos INSERTS y usted debe insertar al menos 2 datos más para las tablas `autor`, `libro` y `cliente` y 3 datos para las tablas `pedido` y `detalle_pedido`.
```sql
INSERT INTO autor (nombre, nacionalidad) VALUES 
('Gabriel García Márquez', 'Colombiana'),
('J.K. Rowling', 'Británica'),
('Haruki Murakami', 'Japonesa');

INSERT INTO libro (titulo, fecha_publicacion, precio, id_autor) VALUES 
('Cien años de soledad', '1967-06-05', 45000, 1),
('Harry Potter y la piedra filosofal', '1997-06-26', 32000, 2);

INSERT INTO cliente (nombre, correo, telefono) VALUES 
('Carlos Pérez', 'carlos.perez@email.com', '3001234567'),
('Laura Rodríguez', 'laura.rodriguez@email.com', '3019876543');
```

## TERCER PUNTO: CONSULTAS SQL
1. Listar todos los libros con su nombre de autor y precio.
2. Obtener los libros publicados después del año 2000.
3. Mostrar los clientes que han realizado pedidos.
4. btener el total de ventas realizadas en la tienda.
5. Listar los libros más vendidos, ordenados por cantidad.
6. Mostrar el número de pedidos realizados por cada cliente.

## CUARTO PUNTO: FUNCION
Escribe una función que reciba el `id_pedido` y devuelva el total de ese pedido sumando los subtotales de cada libro.
```sql
SELECT calcular_total_pedido(1);
```

📌 ¡Buena suerte! 🚀