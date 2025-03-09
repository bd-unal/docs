-- CREACIÓN DE BASE DE DATOS
CREATE DATABASE tienda_libros;

-- CREACIÓN DE TABLAS

CREATE TABLE autor (
    id_autor SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50)
);

CREATE TABLE libro (
    id_libro SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL UNIQUE,
    fecha_publicacion DATE,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    id_autor INT NOT NULL,
    CONSTRAINT fk_autor FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
);

CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE CHECK (correo LIKE '%@%'),
    telefono VARCHAR(15)
);

CREATE TABLE pedido (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) DEFAULT 0,
    CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE detalle_pedido (
    id_pedido INT NOT NULL,
    id_libro INT NOT NULL,
    cantidad SMALLINT NOT NULL CHECK (cantidad > 0),
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal > 0),
    PRIMARY KEY (id_pedido, id_libro),
    CONSTRAINT fk_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    CONSTRAINT fk_libro FOREIGN KEY (id_libro) REFERENCES libro(id_libro)
);

-- INSERCIÓN DE DATOS - 1 punto

INSERT INTO autor (nombre, nacionalidad) VALUES 
('Gabriel García Márquez', 'Colombiana'),
('J.K. Rowling', 'Británica'),
('Haruki Murakami', 'Japonesa'),
('Isabel Allende', 'Chilena'),
('George Orwell', 'Británica');

INSERT INTO libro (titulo, fecha_publicacion, precio, id_autor) VALUES 
('Cien años de soledad', '1967-06-05', 45000, 1),
('Harry Potter y la piedra filosofal', '1997-06-26', 32000, 2),
('1984', '1949-06-08', 28000, 5),
('El amor en los tiempos del cólera', '1985-10-15', 40000, 1);

INSERT INTO cliente (nombre, correo, telefono) VALUES 
('Carlos Pérez', 'carlos.perez@email.com', '3001234567'),
('Laura Rodríguez', 'laura.rodriguez@email.com', '3019876543'),
('Fernando Gutiérrez', 'fernando.gutierrez@email.com', '3205678912'),
('Sofía Ramírez', 'sofia.ramirez@email.com', '3157896541');

INSERT INTO pedido (id_cliente, total) VALUES 
(1, 87000),
(2, 32000),
(3, 45000),
(4, 28000);

INSERT INTO detalle_pedido (id_pedido, id_libro, cantidad, subtotal) VALUES 
(1, 1, 1, 45000),
(1, 3, 1, 28000),
(1, 4, 1, 40000),
(2, 2, 1, 32000),
(3, 1, 1, 45000),
(4, 3, 1, 28000);

-- CONSULTAS SQL

-- 1. Listar todos los libros con su nombre de autor y precio.
SELECT l.titulo, a.nombre AS autor, l.precio
FROM libro l
JOIN autor a ON l.id_autor = a.id_autor;

-- 2. Obtener los libros publicados después del año 2000.
SELECT titulo, fecha_publicacion
FROM libro
WHERE fecha_publicacion > '2000-01-01';

-- 3. Mostrar los clientes que han realizado pedidos.
SELECT DISTINCT c.nombre, c.correo
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente;

-- 4. Obtener el total de ventas realizadas en la tienda.
SELECT SUM(total) AS total_ventas FROM pedido;

-- 5. Listar los libros más vendidos, ordenados por cantidad.
SELECT l.titulo, SUM(dp.cantidad) AS total_vendido
FROM detalle_pedido dp
JOIN libro l ON dp.id_libro = l.id_libro
GROUP BY l.titulo
ORDER BY total_vendido DESC;

-- 6. Mostrar el número de pedidos realizados por cada cliente.
SELECT c.nombre, COUNT(p.id_pedido) AS total_pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente
ORDER BY total_pedidos DESC;

-- FUNCIÓN PARA CALCULAR EL TOTAL DE UN PEDIDO
CREATE FUNCTION calcular_total_pedido(pedido_id INT) RETURNS DECIMAL(10,2) AS $$
DECLARE total_pedido DECIMAL(10,2);
BEGIN
    SELECT SUM(subtotal) INTO total_pedido
    FROM detalle_pedido
    WHERE id_pedido = pedido_id;
    
    RETURN total_pedido;
END;
$$ LANGUAGE plpgsql;

-- PRUEBA DE LA FUNCIÓN
SELECT calcular_total_pedido(1);
