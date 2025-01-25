/* Ejercicios en clase
 CREATE
 1. Escribe una sentencia SQL para crear una tabla llamada `peliculas` con las columnas:
 pelicula_id (entero, clave primaria, autoincremental),
 titulo (cadena, no nula),
 genero (cadena),
 calificacion (decimal).
 */
CREATE TABLE peliculas (
  pelicula_id SERIAL PRIMARY KEY,
  titulo VARCHAR(255) NOT NULL,
  genero VARCHAR(100),
  calificacion DECIMAL
);

-- 2. Escribe una sentencia SQL para crear una tabla llamada `peliculas` solo si no existe.
CREATE TABLE IF NOT EXISTS peliculas (
  pelicula_id SERIAL PRIMARY KEY,
  titulo VARCHAR(255) NOT NULL,
  genero VARCHAR(100),
  calificacion DECIMAL
);

-- 3. Escribe una sentencia SQL para crear una tabla llamada `peliculas` con las mismas columnas del ejercicio 1, asegurándote de que `pelicula_id` sea un identificador único y que todas las columnas sean obligatorias (no nulas).
CREATE TABLE peliculas (
  pelicula_id SERIAL PRIMARY KEY,
  titulo VARCHAR(255) NOT NULL,
  genero VARCHAR(100) NOT NULL,
  calificacion DECIMAL NOT NULL
);

-- 4. Escribe una sentencia SQL para crear una tabla llamada `peliculas` en la que la combinación de `pelicula_id` y `titulo` sea un identificador único.
CREATE TABLE peliculas (
  pelicula_id SERIAL,
  titulo VARCHAR(255) NOT NULL,
  genero VARCHAR(100),
  calificacion DECIMAL,
  CONSTRAINT unique_pelicula UNIQUE (pelicula_id, titulo)
);

/*
 5. Escribe una sentencia SQL para crear una tabla llamada `empresas` con las columnas:
 empresa_id (entero, clave primaria, autoincremental),
 rubro (cadena, no nula),
 numero_empleados (entero, no nulo, por defecto 0).
 */
CREATE TABLE empresas (
  empresa_id SERIAL PRIMARY KEY,
  rubro VARCHAR(255) NOT NULL,
  numero_empleados INT NOT NULL DEFAULT 0
);

/*
 6. Escribe una sentencia SQL para crear una tabla llamada `ofertas_empleo` con las columnas:
 oferta_id (entero, clave primaria, autoincremental),
 titulo_oferta (cadena, por defecto vacío),
 salario_minimo (decimal, por defecto 5000),
 salario_maximo (decimal, por defecto NULL),
 empresa_id (entero, clave foránea que referencia a empresa_id en la tabla empresas).
 */
CREATE TABLE ofertas_empleo (
  oferta_id SERIAL PRIMARY KEY,
  titulo_oferta VARCHAR(255) DEFAULT '',
  salario_minimo DECIMAL DEFAULT 5000,
  salario_maximo DECIMAL DEFAULT NULL,
  empresa_id INT,
  CONSTRAINT fk_empresa_id FOREIGN KEY (empresa_id) REFERENCES empresas (empresa_id)
);

-- ALTER
-- 1. Escribe una sentencia SQL para renombrar la tabla `peliculas` a `peliculas_renombradas`.
ALTER TABLE
  peliculas RENAME TO peliculas_renombradas;

-- 2. Escribe una sentencia SQL para agregar una columna `director` (varchar(50)) a la tabla `peliculas_renombradas`.
ALTER TABLE
  peliculas_renombradas
ADD
  COLUMN director VARCHAR(255);

-- 3. Escribe una sentencia SQL para cambiar el tipo de dato de la columna `calificacion` a INTEGER.
ALTER TABLE
  peliculas_renombradas
ALTER COLUMN
  calificacion TYPE INTEGER;

-- 4. Escribe una sentencia SQL para eliminar la columna `director` de la tabla `peliculas_renombradas`.
ALTER TABLE
  peliculas_renombradas DROP COLUMN director;

-- 6. Escribe una sentencia SQL para agregar una clave primaria a la columna `pelicula_id` en la tabla `peliculas_renombradas`.
ALTER TABLE
  peliculas_renombradas
ADD
  CONSTRAINT peliculas_renombradas_pkey PRIMARY KEY (pelicula_id);

-- 5. Escribe una sentencia SQL para eliminar la clave primaria existente de la tabla peliculas_renombradas.
ALTER TABLE
  peliculas_renombradas DROP CONSTRAINT peliculas_renombradas_pkey;

-- 7. Elimina la constraint `fk_empresa_id` de la tabla ofertas empleo.
ALTER TABLE
  ofertas_empleo DROP CONSTRAINT fk_empresa_id;

-- 8. Escribe una sentencia SQL para agregar una restricción de clave foránea llamada `fk_empresa_id` en la columna `empresa_id` de la tabla `ofertas_empleo`, haciendo referencia a la clave primaria `empresa_id` de la tabla `empresas`.
ALTER TABLE
  ofertas_empleo
ADD
  CONSTRAINT fk_empresa_id FOREIGN KEY (empresa_id) REFERENCES empresas (empresa_id);

-- RENAME
-- 1. Renombrar tabla `ofertas_empleo` a `empleos`
ALTER TABLE
  ofertas_empleo RENAME TO empleos;

-- 2. Renombrar columna `salario_minimo` a `sueldo_min`
ALTER TABLE
  empleos RENAME COLUMN salario_minimo TO sueldo_min;

-- 3. Renombrar columna `empresa_id` a `id_empresa`
ALTER TABLE
  empleos RENAME COLUMN empresa_id TO id_empresa;

-- 4. Vuelve a renombrar la tabla `empleos` a `ofertas_empleo`
ALTER TABLE
  empleos RENAME TO ofertas_empleo;

-- TRUNCATE
-- 1. Escribe una sentencia SQL para eliminar todos los registros de la tabla `peliculas_renombradas` sin eliminar su estructura.
TRUNCATE TABLE peliculas_renombradas;

-- 2. Escribe una sentencia SQL para eliminar todos los registros de la tabla `ofertas_empleo` y restablecer el contador de autoincremento.
TRUNCATE TABLE ofertas_empleo;

-- DROP
-- 1. Escribe una sentencia SQL para eliminar por completo la tabla `peliculas`.
DROP TABLE peliculas_renombradas;

-- 2. Escribe una sentencia SQL para eliminar la clave foránea llamada `fk_empresa_id` de la tabla `ofertas_empleo`.
ALTER TABLE
  ofertas_empleo DROP CONSTRAINT fk_empresa_id;

-- 3. Escribe una sentencia SQL para eliminar las tablas `ofertas_empleo` y `empresas` en una sola instrucción.
DROP TABLE IF EXISTS ofertas_empleo,
empresas;