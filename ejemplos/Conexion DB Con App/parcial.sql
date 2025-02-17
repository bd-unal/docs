-- Tabla de profesor
CREATE TABLE profesor (
  id SMALLSERIAL PRIMARY KEY,
  -- Identificador único del profesor
  nombre VARCHAR(100) NOT NULL,
  -- Nombre completo del profesor
  correo VARCHAR(320) UNIQUE NOT NULL,
  -- Correo electrónico (único)
  usuario VARCHAR(50) UNIQUE NOT NULL,
  -- Nombre de usuario para autenticación
  contrasena VARCHAR(255) NOT NULL,
  -- Contraseña almacenada de forma segura (como hash)
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Fecha de creación del registro
);

-- Tabla de estudiantes
CREATE TABLE estudiante (
  id SMALLSERIAL PRIMARY KEY,
  -- Identificador único del estudiante
  nombre VARCHAR(100) NOT NULL,
  -- Nombre del estudiante
  email VARCHAR(320) UNIQUE NOT NULL,
  -- Correo electrónico (único)
  codigo_parcial VARCHAR(50) UNIQUE NOT NULL -- Código único para cada estudiante
);

-- Tabla de parciales
CREATE TABLE parcial (
  id SMALLSERIAL PRIMARY KEY,
  -- Identificador único del parcial
  nombre VARCHAR(100) NOT NULL,
  -- Nombre del parcial
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Fecha de creación
);

-- Tabla de preguntas
CREATE TABLE pregunta (
  id SMALLSERIAL PRIMARY KEY,
  -- Identificador único de la pregunta
  parcial_id SMALLINT NOT NULL,
  -- Referencia al parcial al que pertenece
  tipo VARCHAR(50) NOT NULL CHECK (
    tipo IN ('abierta', 'seleccionUnica', 'seleccionMultiple')
  ),
  -- Tipo de la pregunta
  pregunta TEXT NOT NULL,
  -- Enunciado de la pregunta
  CONSTRAINT fk_pregunta_parcial FOREIGN KEY (parcial_id) REFERENCES parcial(id) ON DELETE CASCADE
);

-- Tabla de opciones (aplica para pregutnas de seleccionUnica o seleccionMultiple)
CREATE TABLE opcion (
  id SMALLSERIAL PRIMARY KEY,
  -- Identificador único de la opción
  pregunta_id SMALLINT NOT NULL,
  -- Referencia a la pregunta
  opcion TEXT NOT NULL,
  -- Opción de respuesta
  CONSTRAINT fk_opcion_pregunta FOREIGN KEY (pregunta_id) REFERENCES pregunta(id) ON DELETE CASCADE
);

-- Tabla de Respuestas Correctas para Selección Múltiple (única y múltiple respuesta)
CREATE TABLE respuesta_correcta (
  id SMALLSERIAL PRIMARY KEY,
  -- Identificador único de la respuesta correcta
  pregunta_id SMALLINT NOT NULL,
  -- Referencia a la pregunta
  opcion_id SMALLINT NOT NULL,
  -- Referencia a la opción correcta
  CONSTRAINT fk_respuesta_correcta_pregunta FOREIGN KEY (pregunta_id) REFERENCES pregunta(id) ON DELETE CASCADE,
  CONSTRAINT fk_respuesta_correcta_opcion FOREIGN KEY (opcion_id) REFERENCES opcion(id) ON DELETE CASCADE
);

-- Tabla de respuestas de los estudiantes
CREATE TABLE respuesta (
  id SERIAL PRIMARY KEY,
  -- Identificador único de la respuesta
  estudiante_id INT NOT NULL,
  -- Referencia al estudiante
  pregunta_id INT NOT NULL,
  -- Referencia a la pregunta
  respuesta TEXT,
  -- Respuesta del estudiante en caso de ser una pregunta tipo abierta
  respuesta_opcion_id SMALLINT,
  -- Respuesta del estudiante en caso de ser una pregunta de selección
  CONSTRAINT fk_respuesta_estudiante FOREIGN KEY (estudiante_id) REFERENCES estudiante(id) ON DELETE CASCADE,
  CONSTRAINT fk_respuesta_pregunta FOREIGN KEY (pregunta_id) REFERENCES pregunta(id) ON DELETE CASCADE,
  CONSTRAINT fk_respuesta_opcion FOREIGN KEY (respuesta_opcion_id) REFERENCES opcion(id) ON DELETE CASCADE
);

-- Insertar algunos datos de prueba
INSERT INTO
  profesor (nombre, correo, usuario, contrasena)
VALUES
  (
    'David Obregón',
    'dobregon@unal.edu.co',
    'dobregon',
    '$2a$12$3HuL5a2Fic1rrVq4qEcNnujcNzhzvc4ReFJkFRTgVTi3/ku4QFKG2' -- 123456
  );

INSERT INTO
  estudiante (nombre, email, codigo_parcial)
VALUES
  (
    'Pedro Perez',
    'pedrito@unal.edu.co',
    'ABD156'
  );

INSERT INTO
  parcial (nombre)
VALUES
  ('Parcial de prueba');

INSERT INTO
  pregunta (parcial_id, tipo, pregunta)
VALUES
  (
    1,
    'seleccionUnica',
    '¿Cuál es la capital de Colombia?'
  );

INSERT INTO
  opcion (pregunta_id, opcion)
VALUES
  (1, 'Medellin'),
  (1, 'Bogotá'),
  (1, 'Cali'),
  (1, 'Barranquilla');

INSERT INTO
  respuesta_correcta (pregunta_id, opcion_id)
VALUES
  (1, 2);

INSERT INTO
  respuesta (estudiante_id, pregunta_id, respuesta_opcion_id)
VALUES
  (1, 1, 2);