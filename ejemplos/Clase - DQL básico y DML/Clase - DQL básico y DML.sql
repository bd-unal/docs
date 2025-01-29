--- CLASE DQL - DML
-- CREAR TABLA trabajo
CREATE TABLE trabajo (
  id_trabajo SERIAL PRIMARY KEY,
  nombre_trabajo VARCHAR(100) NOT NULL,
  salario_minimo INT,
  salario_maximo INT
);

-- CREAR TABLA pais
CREATE TABLE pais (
  id_pais SMALLSERIAL PRIMARY KEY,
  nombre_pais VARCHAR(50)
);

-- CREAR TABLA ubicacion
CREATE TABLE ubicacion(
  id_ubicacion SMALLSERIAL PRIMARY KEY,
  direccion VARCHAR(300) NOT NULL,
  codigo_postal INT NOT NULL,
  ciudad VARCHAR(50) NOT NULL,
  estado_provincia VARCHAR(50),
  id_pais SMALLINT NOT NULL,
  CONSTRAINT fk_pais FOREIGN KEY (id_pais) REFERENCES pais (id_pais)
);

-- CREAR TABLA departamento
CREATE TABLE departamento (
  id_departamento SMALLSERIAL PRIMARY KEY,
  nombre_departamento VARCHAR(50) NOT NULL,
  id_ubicacion SMALLINT NOT NULL,
  CONSTRAINT fk_ubicacion FOREIGN KEY (id_ubicacion) REFERENCES ubicacion (id_ubicacion)
);

-- CREAR TABLA empleado
CREATE TABLE empleado (
  id_empleado SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  email VARCHAR(320) NOT NULL UNIQUE,
  telefono VARCHAR(20),
  fecha_contratacion DATE,
  salario INT NOT NULL,
  id_trabajo SMALLINT NOT NULL,
  id_departamento SMALLINT NOT NULL,
  id_manager INT,
  CONSTRAINT fk_trabajo FOREIGN KEY (id_trabajo) REFERENCES trabajo (id_trabajo),
  CONSTRAINT fk_departamento FOREIGN KEY (id_departamento) REFERENCES departamento (id_departamento),
  CONSTRAINT fk_manager FOREIGN KEY (id_manager) REFERENCES empleado (id_empleado)
);

-- AGREGAR valores por defecto
ALTER TABLE
  empleado
ALTER COLUMN
  fecha_contratacion
SET
  DEFAULT NOW();

ALTER TABLE
  trabajo
ALTER COLUMN
  nombre_trabajo
SET
  DEFAULT '';

-- CHECK salarios
ALTER TABLE
  trabajo
ADD
  CONSTRAINT salario_minimo_positivo CHECK (salario_minimo > 0),
ADD
  CONSTRAINT salario_maximo_positivo CHECK (salario_maximo > 0);

ALTER TABLE
  empleado
ADD
  CONSTRAINT salario_positivo CHECK (salario > 0);

-- INSERT
-- UN VALOR
INSERT INTO
  trabajo (nombre_trabajo, salario_minimo, salario_maximo)
VALUES
  ('Desarrollador de Software', 3000000, 12000000);

SELECT
  *
FROM
  trabajo;

-- INSERTAR VARIOS VALORES
INSERT INTO
  trabajo (nombre_trabajo, salario_minimo, salario_maximo)
VALUES
  ('Científico de Datos', 5000000, 15000000),
  ('Director de Operaciones', 4000000, 8000000),
  (DEFAULT, 1300000, 1700000);

-- INSERTAR DATOS DESDE OTRA TABLA
-- PRIMERO CREAMOS LA TABLA historico_trabajo
CREATE TABLE historico_trabajo (LIKE trabajo INCLUDING ALL);

-- LUEGO INSERTAMOS LOS DATOS
INSERT INTO
  historico_trabajo (nombre_trabajo, salario_minimo, salario_maximo)
SELECT
  nombre_trabajo,
  salario_minimo,
  salario_maximo
FROM
  trabajo;

SELECT
  *
FROM
  historico_trabajo;

-- INSERTAR DATOS PARA LAS OTRAS TABLAS
-- INSERTAR DATOS EN LA TABLA pais
INSERT INTO
  pais (nombre_pais)
VALUES
  ('Colombia'),
  ('Estados Unidos'),
  ('México'),
  ('España'),
  ('Argentina');

-- INSERTAR DATOS EN LA TABLA ubicacion
INSERT INTO
  ubicacion (
    direccion,
    codigo_postal,
    ciudad,
    estado_provincia,
    id_pais
  )
VALUES
  (
    'Calle 123 #45-67',
    110111,
    'Bogotá',
    'Cundinamarca',
    1
  ),
  (
    '123 Main St',
    90210,
    'Los Ángeles',
    'California',
    2
  ),
  (
    'Avenida Reforma 456',
    77500,
    'Cancún',
    'Quintana Roo',
    3
  ),
  ('Calle Mayor 10', 28013, 'Madrid', NULL, 4),
  ('Avenida Córdoba 789', 5000, 'Córdoba', NULL, 5);

-- INSERTAR DATOS EN LA TABLA departamento
INSERT INTO
  departamento (nombre_departamento, id_ubicacion)
VALUES
  ('Desarrollo de Software', 1),
  ('Recursos Humanos', 2),
  ('Marketing', 3),
  ('Atención al Cliente', 4),
  ('Operaciones', 5);

-- INSERTAR DATOS EN LA TABLA empleado
INSERT INTO
  empleado (
    nombre,
    apellido,
    email,
    telefono,
    fecha_contratacion,
    salario,
    id_trabajo,
    id_departamento,
    id_manager
  )
VALUES
  (
    'Juan',
    'Pérez',
    'juan.perez@email.com',
    '3001234567',
    DEFAULT,
    4000000,
    1,
    1,
    NULL
  ),
  (
    'Ana',
    'Martínez',
    'ana.martinez@email.com',
    '3009876543',
    DEFAULT,
    5000000,
    2,
    2,
    1
  ),
  (
    'Carlos',
    'Gómez',
    'carlos.gomez@email.com',
    '3004567890',
    DEFAULT,
    4500000,
    3,
    3,
    1
  ),
  (
    'Luisa',
    'Fernández',
    'luisa.fernandez@email.com',
    '3008765432',
    DEFAULT,
    6000000,
    1,
    4,
    2
  ),
  (
    'Sofía',
    'López',
    'sofia.lopez@email.com',
    '3005432198',
    DEFAULT,
    3500000,
    2,
    5,
    3
  );

-- CONSULTAR LOS DATOS INSERTADOS
SELECT
  *
FROM
  pais;

SELECT
  *
FROM
  ubicacion;

SELECT
  *
FROM
  departamento;

SELECT
  *
FROM
  empleado;

-- Actualizar empleado con id_empleado = 1
-- Consultar el nombre actual
SELECT
  *
FROM
  empleado
WHERE
  id_empleado = 1;

-- Actualizar el nombre a Pedro
UPDATE
  empleado
SET
  nombre = 'Pedro'
WHERE
  id_empleado = 1;

-- Actualizar fecha_contratacion ayer
UPDATE
  empleado
SET
  fecha_contratacion = '2025-01-26'
WHERE
  id_manager = 1;

-- Aumentar 5% el salario de los empleados cuyo departamento es 'Recursos Humanos`
UPDATE
  empleado
SET
  salario = salario * 1.05 -- Aumentar en un 5%
WHERE
  id_departamento = (
    SELECT
      id_departamento
    FROM
      departamento
    WHERE
      nombre_departamento = 'Recursos Humanos'
  );

-- DELETE
-- Borrar la fila  con id_empleado = 4 en la tabla `empleado`
DELETE FROM
  empleado
WHERE
  id_empleado = 4;

-- Borrar multiples empleados
DELETE FROM
  empleado
WHERE
  id_empleado IN (3, 5, 7);

-- Borrar registros relacionados
-- Primero elimina las filas relacionadas de la tabla empleado
DELETE FROM
  empleado
WHERE
  id_departamento = 2;

-- Luego elimina el departamento correspondiente
DELETE FROM
  departamento
WHERE
  id_departamento = 2;

-- Uso de ON DELETE CASCADE
-- Configuración de la clave foránea con ON DELETE CASCADE
-- Primero borramos la constraint actual
ALTER TABLE
  empleado DROP CONSTRAINT fk_departamento;

-- Luego la volvemos a agregar con la configuración de ON DELETE CASCADE
ALTER TABLE
  empleado
ADD
  CONSTRAINT fk_departamento FOREIGN KEY (id_departamento) REFERENCES departamento (id_departamento) ON DELETE CASCADE;

-- Ahora, al eliminar un departamento, los empleados relacionados se eliminan automáticamente
DELETE FROM
  departamento
WHERE
  id_departamento = 2;

-- Limpiar y volver a insertar
TRUNCATE TABLE empleado RESTART IDENTITY;

-- SELECT LIKE
SELECT
  id_empleado,
  nombre,
  apellido,
  email,
  telefono,
  fecha_contratacion,
  salario
FROM
  empleado
WHERE
  apellido LIKE '%ez';

-- Ejercicios en clase
-- **1. INSERT**
-- Inserta 3 países adicionales en la tabla `pais`.
INSERT INTO
  pais (nombre_pais)
VALUES
  ('Brasil'),
  ('Chile'),
  ('Perú');

-- Agrega nuevas ubicaciones asociadas a los países que acabas de insertar.
INSERT INTO
  ubicacion (
    direccion,
    codigo_postal,
    ciudad,
    estado_provincia,
    id_pais
  )
VALUES
  (
    'Av. Paulista 1000',
    01310,
    'São Paulo',
    'São Paulo',
    6
  ),
  (
    'Av. Apoquindo 3000',
    7550000,
    'Santiago',
    'Región Metropolitana',
    7
  ),
  ('Jr. de la Unión 250', 15001, 'Lima', NULL, 8);

-- Añade un departamento nuevo en una de las ubicaciones creadas.
INSERT INTO
  departamento (nombre_departamento, id_ubicacion)
VALUES
  ('Investigación y Desarrollo', 6);

-- Agrega dos nuevos empleados al departamento recién creado.
INSERT INTO
  empleado (
    nombre,
    apellido,
    email,
    telefono,
    fecha_contratacion,
    salario,
    id_trabajo,
    id_departamento,
    id_manager
  )
VALUES
  (
    'Gabriel',
    'Santos',
    'gabriel.santos@email.com',
    '3009871111',
    DEFAULT,
    4500000,
    2,
    6,
    NULL
  ),
  (
    'Fernanda',
    'Rojas',
    'fernanda.rojas@email.com',
    '3005552222',
    DEFAULT,
    4800000,
    3,
    6,
    1
  );

-- **2. UPDATE**
-- Aumenta el salario de `Fernanda Rojas` en un 10%.
UPDATE
  empleado
SET
  salario = salario * 1.10
WHERE
  email = 'fernanda.rojas@email.com';

-- Cambia la ubicación del departamento `Investigación y Desarrollo` a la nueva sede en Perú.
UPDATE
  departamento
SET
  id_ubicacion = 8
WHERE
  nombre_departamento = 'Investigación y Desarrollo';

-- Cambia el cargo de `Gabriel Santos` a "Jefe de Desarrollo" con un aumento de 15%.
UPDATE
  empleado
SET
  id_trabajo = 4,
  salario = salario * 1.15
WHERE
  email = 'gabriel.santos@email.com';

-- **3. DELETE**
-- Elimina a `Gabriel Santos` de la base de datos.
DELETE FROM
  empleado
WHERE
  email = 'gabriel.santos@email.com';

-- Elimina a todos los empleados del departamento `Investigación y Desarrollo`.
DELETE FROM
  empleado
WHERE
  id_departamento = (
    SELECT
      id_departamento
    FROM
      departamento
    WHERE
      nombre_departamento = 'Investigación y Desarrollo'
  );

--  Intenta eliminar el departamento `Investigación y Desarrollo`, si no hay empleados en él.
DELETE FROM
  departamento
WHERE
  nombre_departamento = 'Investigación y Desarrollo';

-- **4. SELECT**
-- Consulta todos los empleados de la empresa.
SELECT
  *
FROM
  empleado;

-- Muestra los empleados del departamento de `Marketing`.
SELECT
  nombre,
  apellido,
  email
FROM
  empleado
WHERE
  id_departamento = (
    SELECT
      id_departamento
    FROM
      departamento
    WHERE
      nombre_departamento = 'Marketing'
  );

--  Consulta los empleados con salario mayor a 5,000,000.
SELECT
  nombre,
  apellido,
  salario
FROM
  empleado
WHERE
  salario > 5000000;

--  Busca empleados cuyo apellido contenga "pe".
SELECT
  nombre,
  apellido
FROM
  empleado
WHERE
  apellido LIKE '%pe%';

--  Obtén la información de empleados sin manager.
SELECT
  nombre,
  apellido
FROM
  empleado
WHERE
  id_manager IS NULL;

-- **5. Desafío adicional**
-- Crea una consulta que muestre el `nombre`, `apellido`, `salario` y el `nombre del departamento` de cada empleado.
SELECT
  e.nombre,
  e.apellido,
  e.salario,
  d.nombre_departamento
FROM
  empleado e
  JOIN departamento d ON e.id_departamento = d.id_departamento;