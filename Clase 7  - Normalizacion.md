# **Normalización**

Incluso con un buen diseño de base de datos, a veces no se puede evitar la entrada de datos incorrectos. Por ejemplo:

| Año  | Campeón           |
|------|--------------------|
| 2015 | Novak Djokovic    |
| 2016 | Albert Einstein (x) |
| 2017 | Roger Federer     |
| 2018 | Novak Djokovic    |

Sin embargo, hay ocasiones donde un mal diseño de base de datos permite errores de integridad que no deberían ocurrir, como en el siguiente caso:

| id_cliente | fecha_de_nacimiento |
|------------|---------------------|
| 1001       | 17-Feb-1994         |
| 1001       | 06-Ago-1998         |

En este ejemplo, un cliente tiene **dos fechas de nacimiento diferentes**, lo cual es lógicamente imposible. Este problema no solo refleja un error en los datos, sino un mal diseño de la base de datos, y sucede cuando la base de datos **no está normalizada**.

---

## **¿Qué es la Normalización?**

La normalización de una tabla de base de datos consiste en estructurarla de tal forma que no permita almacenar información redundante o inconsistente.

Por ejemplo:
- Una tabla normalizada **no permitiría** que un cliente tenga dos fechas de nacimiento, ya que eliminaría la posibilidad de redundancia.

### **Ventajas de Tablas Normalizadas**
- Son más fáciles de entender.
- Son más fáciles de mantener y extender.
- Están protegidas contra:
  - **Anomalías de inserción:** Problemas al agregar nuevos datos.
  - **Anomalías de actualización:** Conflictos al modificar datos existentes.
  - **Anomalías de eliminación:** Pérdida accidental de información al borrar datos.

---

## **Formas Normales**
Las **formas normales** son un conjunto de criterios para evaluar el nivel de normalización de una base de datos. Estos niveles ayudan a garantizar que la estructura de las tablas sea lógica, eficiente y libre de redundancias.

### **Niveles de Normalización**
1. **Primera Forma Normal (1FN):** Garantía mínima de seguridad.
2. **Segunda Forma Normal (2FN):** Mejor garantía de seguridad.
3. **Tercera Forma Normal (3FN):** Mayor consistencia y eliminación de dependencias transitivas.
4. **Cuarta Forma Normal (4FN):** Elimina problemas de relaciones multivaloradas.
5. **Quinta Forma Normal (5FN):** Garantiza la ausencia de redundancias incluso en relaciones complejas.

### **Analogía: Evaluación de Seguridad**
Podemos comparar las formas normales con la evaluación de seguridad de un puente:
- **Primera Forma Normal:** Garantiza que los peatones puedan cruzar el puente de forma segura.
- **Segunda Forma Normal:** Asegura, además, que los vehículos también puedan utilizar el puente.
- **Formas Normales Superiores:** Ofrecen garantías más completas y robustas para diferentes niveles de uso y carga.

---

La normalización es fundamental para diseñar bases de datos consistentes y eficientes. A través de las formas normales, se asegura que la base de datos cumpla con estándares altos de integridad y evite problemas comunes derivados de un mal diseño.

# **Primera Forma Normal (1FN)**

La Primera Forma Normal establece cuatro reglas básicas para garantizar que una tabla esté bien estructurada y elimine redundancias y ambigüedades. A continuación, cada regla se explica con un ejemplo sencillo.

---

## **1. No usar el orden de las filas para transmitir información**
El orden de las filas no debe ser significativo ni utilizado para representar datos.

### **Ejemplo Incorrecto:**
Supongamos que queremos responder a la siguiente pregunta: **¿Cómo ordenar a los miembros de The Beatles del más alto al más bajo?** Podríamos representar esto de la siguiente manera en una tabla:

| **nombre**         |
|--------------------|
| Paul McCartney     |
| John Lennon        |
| George Harrison    |
| Ringo Starr        |

Aquí, el **orden de las filas** sugiere que Paul McCartney es el más alto y Ringo Starr el más bajo. Sin embargo, **esto es incorrecto** porque el orden de las filas no debe transmitir información, ya que no es un atributo explícito ni forma parte del diseño de la tabla.

### **Corrección:**
Para cumplir con 1FN, la estatura debe almacenarse como un atributo claro, y el orden de las filas no debe importar:

| **nombre**         | **estatura_en_cm** |
|--------------------|--------------------|
| George Harrison    | 178                |
| Ringo Starr        | 170                |
| Paul McCartney     | 180                |
| John Lennon        | 179                |

Posteriormente por medio de una consulta se puede resolver la pregunta. Ejemplo:
```SQL
Select nombre from miembro order by estatura_en_cm desc
```

---

## **2. No mezclar tipos de datos en la misma columna**
Cada columna debe almacenar un solo tipo de dato.

### **Ejemplo Incorrecto:**
En esta tabla, la columna `estatura_en_cm` contiene tanto números como cadenas de texto:

| **nombre**         | **estatura_en_cm**     |
|--------------------|-----------------------|
| Paul McCartney     | 180                   |
| John Lennon        | 179                   |
| George Harrison    | Entre 178 y 180       |
| Ringo Starr        | 170                   |

Aquí, `estatura_en_cm` mezcla números y una cadena de texto (`Entre 178 y 180`), lo que genera ambigüedad y dificulta las consultas.

### **Corrección:**
Se establece el tipo de dato `integer` para la columna `estatura_en_cm`:

| **nombre**         | **estatura_en_cm** |
|--------------------|--------------------|
| Paul McCartney     | 180                |
| John Lennon        | 179                |
| George Harrison    | 178                |
| Ringo Starr        | 170                |

---

## **3. No permitir tablas sin clave primaria**
Cada tabla debe tener una clave primaria que identifique de manera única a cada fila.

### **Ejemplo Incorrecto:**
La siguiente tabla carece de una clave primaria:

| **nombre**         | **estatura_en_cm** |
|--------------------|--------------------|
| Paul McCartney     | 180                |
| John Lennon        | 179                |
| John Lennon        | 180                |
| George Harrison    | 178                |
| Ringo Starr        | 170                |

En esta tabla, no hay forma de identificar de manera única cada fila porque `John Lennon` aparece dos veces.

### **Corrección:**
Agregar una clave primaria única, como un identificador de miembro (`id_miembro`):

| **id_miembro** | **nombre**         | **estatura_en_cm** |
|----------------|--------------------|--------------------|
| 1              | Paul McCartney     | 180                |
| 2              | John Lennon        | 179                |
| 3              | George Harrison    | 178                |
| 4              | Ringo Starr        | 170                |

---

## **4. No permitir grupos repetidos**
No debe haber múltiples columnas para almacenar valores relacionados del mismo tipo.

### **Ejemplo Incorrecto:**
En esta tabla, cada instrumento se almacena en columnas separadas:

| **nombre**           | **instrumento1** | **instrumento2** | **Instrumento3** |
|------------------|--------------|--------------|--------------|
| Paul McCartney   | Bajo         | Piano        | Guitarra     |
| John Lennon      | Guitarra     | Piano        |              |
| George Harrison  | Guitarra     |              |              |

Esto genera problemas al manejar nuevos instrumentos o al realizar consultas.

### **Corrección:**
Se utiliza una tabla normalizada donde cada instrumento se almacena en filas separadas:

Tabla: `Miembro_Instrumento`:

| **id_miembro**           | **instrumento** |
|------------------|-------------|
| 1   | Bajo        |
| 1   | Piano       |
| 1   | Guitarra    |
| 2      | Guitarra    |
| 2      | Piano       |
| 3  | Guitarra    |

Dado que no queremos tener información redudante de miembros e instrumentos, la llave primaria de la tabla `Miembro_Instrumento` es una llave compuesta (`id_miembro`, `instrumento`).

# **Segunda Forma Normal (2FN)**

La **Segunda Forma Normal (2FN)** establece que:
- Cada atributo no clave debe depender de la **clave primaria completa**, no solo de una parte de ella.
- Esto es especialmente importante cuando la clave primaria es compuesta (formada por más de un atributo).

---

## **Ejemplo: Forma Incorrecta**

Supongamos que tenemos una tabla `inventario_jugador` que almacena información sobre los jugadores y los artículos de su inventario en un juego:

| **id_jugador** | **tipo_articulo** | **cantidad_articulo** | **nivel_jugador** |
|----------------|-------------------|-----------------------|-------------------|
| james123              | espada            | 2                     | avanzado          |
| james123              | escudo            | 1                     | avanzado          |
| bob45              | arco              | 3                     | intermedio        |
| bob45             | flecha            | 10                    | intermedio        |

### **Problema: Dependencia Parcial**
En esta tabla:
- La clave primaria es compuesta: **(id_jugador, tipo_articulo)**.
- **cantidad_articulo** depende de la clave compuesta **(id_jugador, tipo_articulo)**.
- **nivel_jugador** depende únicamente de **id_jugador**, no de la clave compuesta completa.

#### **Representación de Dependencias:**
```plaintext
{id_jugador, tipo_articulo} -------> {cantidad_articulo}
{id_jugador} -----------------------> {nivel_jugador}
```

Esto viola la 2FN porque nivel_jugador no depende de (`id_jugador`, `tipo_articulo`), sino únicamente de `id_jugador`.

## **Corrección: Forma Normalizada**

Para cumplir con la Segunda Forma Normal, dividimos la tabla en dos tablas separadas, eliminando la dependencia parcial:

### **Tabla 1: jugador**
| **id_jugador** | **nivel_jugador** |
|----------------|-------------------|
| james123              | avanzado          |
| bob45              | intermedio        |

### **Tabla 2: inventario**
| **id_jugador** | **tipo_articulo** | **cantidad_articulo** |
|----------------|-------------------|-----------------------|
| james123              | espada            | 2                     |
| james123              | escudo            | 1                     |
| bob45              | arco              | 3                     |
| bob45              | flecha            | 10                    |

#### **Representación de Dependencias:**
```plaintext
{id_jugador} -----------------------> {nivel_jugador}
{id_jugador, tipo_articulo} -------> {cantidad_articulo}
```

## **Anomalías en la Forma Incorrecta**

### **1. Anomalía de Eliminación**
Si eliminamos un artículo del inventario de un jugador, podríamos perder información importante sobre el jugador.

#### **Ejemplo:**
Si eliminamos todos los artículos del inventario del jugador con `id_jugador = james123`, también perderíamos el valor de su **nivel_jugador**.

| **id_jugador** | **tipo_articulo** | **cantidad_articulo** | **nivel_jugador** |
|----------------|-------------------|-----------------------|-------------------|
| bob45              | arco              | 3                     | intermedio        |
| bob45             | flecha            | 10                    | intermedio        |

---

### **2. Anomalía de Actualización**
Si cambia el nivel de un jugador, tendríamos que actualizar múltiples filas en la tabla.

#### **Ejemplo:**
Supongamos que el nivel del jugador con `id_jugador = james123` cambia de **avanzado** a **intermedio**. En la tabla incorrecta, tendríamos que actualizar todas las filas relacionadas con ese jugador:

| **id_jugador** | **tipo_articulo** | **cantidad_articulo** | **nivel_jugador** |
|----------------|-------------------|-----------------------|-------------------|
| james123              | espada            | 2                     | intermedio        |
| james12              | escudo            | 1                     | intermedio        |
| bob45              | arco              | 3                     | intermedio        |
| bob45              | flecha            | 10                    | intermedio        |

Si olvidamos actualizar alguna fila, los niveles quedarían inconsistentes.

---

### **3. Anomalía de Inserción**
No es posible insertar información parcial si ciertos datos no están disponibles.

#### **Ejemplo:**
No podríamos registrar un nuevo jugador (`id_jugador = david27`) sin agregar artículos a su inventario, ya que la clave primaria compuesta **(id_jugador, tipo_articulo)** requiere ambos valores.

| **id_jugador** | **tipo_articulo** | **cantidad_articulo** | **nivel_jugador** |
|----------------|-------------------|-----------------------|-------------------|
| (No se puede registrar el jugador sin artículos en su inventario) |

---

## **Cómo la Normalización Corrige las Anomalías**

En la forma normalizada, estas anomalías desaparecen porque la información se organiza correctamente:

1. **Anomalía de Eliminación:**
   - Si eliminamos un artículo (por ejemplo, `espada`), la información del jugador permanece en la tabla `jugador`.

2. **Anomalía de Actualización:**
   - Cambiar el nivel de un jugador requiere actualizar solo una fila en la tabla `jugador`.

3. **Anomalía de Inserción:**
   - Podemos registrar un jugador sin artículos en su inventario añadiendo una fila en la tabla `jugador`:

| **id_jugador** | **nivel_jugador** |
|----------------|-------------------|
| james123              | principiante      |

---

# **Tercera Forma Normal (3FN)**

La **Tercera Forma Normal (3FN)** prohíbe que un **atributo no clave** dependa de otro **atributo no clave**. En otras palabras, todos los atributos no clave deben depender **directamente** de la clave primaria.

---

## **Ejemplo: Forma Incorrecta**

Supongamos que añadimos una columna llamada `nivel_habilidad` a nuestra tabla `jugador`. Esta columna almacena valores del 1 al 9, donde:

- **1, 2, 3** → principiante
- **4, 5, 6** → intermedio
- **7, 8, 9** → avanzado

La tabla quedaría así:

| **id_jugador** | **nivel_jugador** | **nivel_habilidad** |
|----------------|-------------------|---------------------|
| james123       | avanzado          | 7                   |
| bob45          | intermedio        | 6                   |

### **Problema: Dependencia Transitiva**
Si el `nivel_habilidad` de un jugador cambia (por ejemplo, aumenta de **6** a **7** para el jugador `bob45`), también debemos actualizar su `nivel_jugador` a **avanzado**. Si olvidamos hacerlo, podríamos terminar con datos inconsistentes, como que el `nivel_habilidad` sea **7** (avanzado) pero el `nivel_jugador` siga siendo **intermedio**. Esto es incorrecto.

#### **Dependencias en la Tabla Incorrecta:**
```plaintext
{id_jugador} -----------------------> {nivel_habilidad}
{nivel_habilidad} ------------------> {nivel_jugador}
```

En este caso:
1. `nivel_jugador` depende indirectamente de `id_jugador`, a través de `nivel_habilidad`.
2. Esto se llama dependencia transitiva, porque:
   ```plaintext
   {id_jugador} -> {nivel_habilidad} -> {nivel_jugador}
   ```

Dado que `nivel_jugador` depende de `nivel_habilida`d (que es un **atributo no clave**), esta tabla no está en 3FN.

## **Corrección: Forma Normalizada**

Para cumplir con la **Tercera Forma Normal (3FN)**, eliminamos la dependencia transitiva separando los datos en dos tablas:

### **Tabla 1: jugador**: (eliminamos la columna `nivel_jugador`)
| **id_jugador** | **nivel_habilidad** |
|----------------|---------------------|
| james123       | 7                   |
| bob45          | 6                   |

### **Tabla 2: niveles_habilidad**
| **nivel_habilidad** | **nivel_jugador** |
|---------------------|-------------------|
| 1                   | principiante      |
| 2                   | principiante      |
| 3                   | principiante      |
| 4                   | intermedio        |
| 5                   | intermedio        |
| 6                   | intermedio        |
| 7                   | avanzado          |
| 8                   | avanzado          |
| 9                   | avanzado          |

#### **Dependencias en la Tabla Normalizada:**
1. En la tabla `jugador`:
   ```plaintext
   {id_jugador} -----------------------> {nivel_habilidad}
   ```
2. En la tabla `niveles_habilidad`:
   ```plaintext
   {nivel_habilidad} ------------------> {nivel_jugador}
   ```

## **Ventajas de Cumplir con 3FN**
1. **Eliminación de Redundancia:**
   - Ahora no es necesario repetir la lógica que asocia el `nivel_habilidad` con el `nivel_jugador`.
2. **Integridad de los Datos:**
   - Si cambian las reglas para asignar niveles de habilidad, solo debemos actualizar la tabla `niveles_habilidad`.
3. **Evitar Inconsistencias:**
   - La separación elimina la posibilidad de que `nivel_habilidad` y `nivel_jugador` tengan valores incompatibles.

> **Todos los atributos no-clave en una tabla deben depender de la clave, de toda la clave y de nada más que la clave.**

# **Boyce-Codd Normal Form (BCNF)**

La **Forma Normal de Boyce-Codd (BCNF)** establece que:
- **Todos los atributos en una tabla deben depender de la clave, de toda la clave y de nada más que la clave.**

Es una extensión de la **Tercera Forma Normal (3FN)** que resuelve casos específicos donde:
- Una tabla cumple con 3FN, pero aún tiene dependencias funcionales en atributos que no forman parte de la clave primaria.

---

## **Diferencia Clave con 3FN**
Mientras que 3FN permite que los atributos no clave dependan de **superclaves** (conjunto de claves candidatas), BCNF no lo permite:
- BCNF exige que todos los atributos dependan exclusivamente de la **clave candidata completa**.

---

## **Ejemplo: Sistema de Préstamos de Libros**

### **Tablas iniciales en 3FN**

1. **Tabla de libros**
   | **id_libro** (PK) | **titulo**                   | **autor**          | **genero**    |
   |-------------------|-----------------------------|--------------------|---------------|
   | 1                 | Matar a un ruiseñor         | Harper Lee         | Ficción       |
   | 2                 | El Señor de los Anillos     | J. R. R. Tolkien   | Fantasía      |
   | 3                 | Harry Potter y la piedra... | J.K. Rowling       | Fantasía      |

2. **Tabla de prestatarios**
   | **id_prestatario** (PK) | **nombre**       | **id_libro** (FK) |
   |-------------------------|------------------|-------------------|
   | 1                       | John Doe         | 1                 |
   | 2                       | Jane Doe         | 1                 |
   | 3                       | James Brown      | 1                 |
   | 4                       | Emily García     | 2                 |
   | 5                       | David Lee        | 2                 |
   | 6                       | Michael Chen     | 3                 |

3. **Tabla de préstamos**
   | **id_prestamo** (PK) | **id_libro** (FK) | **id_prestatario** (FK) | **fecha_prestamo** | **fecha_devolucion** |
   |----------------------|-------------------|-------------------------|--------------------|-----------------------|
   | 1                    | 1                 | 1                       | 2024-05-04         | 2024-05-20            |
   | 2                    | 2                 | 4                       | 2024-05-04         | 2024-05-18            |
   | 3                    | 3                 | 6                       | 2024-05-04         | 2024-05-10            |

---

### **Problema: Dependencia Oculta**

En la tabla `préstamos`, suponemos que:
- Un prestatario **no puede tomar prestado el mismo libro dos veces al mismo tiempo**.
- Esto implica que la combinación de `id_libro` y `id_prestatario` identifica de manera única un registro de préstamo.

Dependencia funcional:
```plaintext
{id_libro, id_prestatario} -> {id_prestamo}
```

Sin embargo, esto viola BCNF porque:
- La combinación {`id_libro`, `id_prestatario`} actúa como una clave candidata, pero `id_prestamo` es la clave primaria.

### **Solución**

Para cumplir con BCNF, podemos aplicar dos enfoques:

#### **Enfoque 1: Descomposición de la Tabla**
Dividimos la tabla de `préstamos` en dos tablas:

1. **Tabla de préstamos básicos**
   | **id_prestamo** (PK) | **fecha_prestamo** | **fecha_devolucion** |
   |----------------------|--------------------|-----------------------|
   | 1                    | 2024-05-04         | 2024-05-20            |
   | 2                    | 2024-05-04         | 2024-05-18            |
   | 3                    | 2024-05-04         | 2024-05-10            |

2. **Tabla de relaciones préstamo-libro-prestatario**
   | **id_libro** (FK) | **id_prestatario** (FK) | **id_prestamo** (FK) |
   |-------------------|-------------------------|----------------------|
   | 1                 | 1                       | 1                    |
   | 2                 | 4                       | 2                    |
   | 3                 | 6                       | 3                    |

---

#### **Enfoque 2: Clave Primaria Compuesta**
Podemos hacer que la clave primaria de la tabla `préstamos` sea la combinación `{id_libro, id_prestatario}`:

| **id_libro** (PK) | **id_prestatario** (PK) | **fecha_prestamo** | **fecha_devolucion** |
|-------------------|-------------------------|--------------------|-----------------------|
| 1                 | 1                       | 2024-05-04         | 2024-05-20            |
| 2                 | 4                       | 2024-05-04         | 2024-05-18            |
| 3                 | 6                       | 2024-05-04         | 2024-05-10            |

> Nota: Este enfoque no funciona si un prestatario puede tomar prestado el mismo libro varias veces, ya que cada combinación debe ser única.

---
## **Resumen**
- **Tercera Forma Normal (3FN):** Los atributos no clave deben depender de la clave, la clave completa y nada más que la clave.
- **BCNF:** Extiende esta regla para garantizar que incluso las claves candidatas no introduzcan dependencias funcionales no deseadas.

---

En la mayoría de los casos, cuando una tabla está en 3FN, puedes decir que está completamente normalizada, ya que no existen anomalías relacionadas con dependencias funcionales.

---

# **Cuarta Forma Normal (4FN)**

La **Cuarta Forma Normal (4FN)** se asegura de eliminar las **dependencias multivaluadas** en una tabla. Esto significa que si tienes atributos que dependen de la clave primaria pero son **independientes entre sí**, debes separarlos en tablas diferentes.

---

## **Definición de Dependencias Multivaluadas**

Una **dependencia multivaluada** ocurre cuando un atributo en una tabla tiene múltiples valores posibles que dependen de la clave primaria, pero estos valores no están relacionados con otros atributos de la tabla.

Se representa con `->>`:
- Si `A ->> B`, significa que para un valor de `A`, puede haber múltiples valores de `B`.

---

## **Ejemplo: Forma Incorrecta**

Supongamos que estamos diseñando una base de datos para una escuela de idiomas. Queremos registrar:
1. Los **idiomas** que habla cada estudiante.
2. Las **actividades extracurriculares** en las que participa cada estudiante.

Podríamos estructurar la tabla como esta:

| **id_estudiante** | **idioma**      | **actividad**      |
|-------------------|----------------|-------------------|
| 1                 | inglés         | baloncesto        |
| 1                 | francés        | baloncesto        |
| 1                 | inglés         | ajedrez           |
| 1                 | francés        | ajedrez           |
| 2                 | español        | fútbol            |
| 2                 | alemán         | fútbol            |

### **Dependencias Multivaluadas**
En esta tabla:
- Cada `id_estudiante` tiene una lista de **idiomas** y una lista de **actividades**.
- Los idiomas y las actividades son **independientes entre sí**.

Representación de dependencias multivaluadas:
```plaintext
id_estudiante ->> idioma
id_estudiante ->> actividad
```

## **Problemas en la Forma Incorrecta**

1. **Redundancia:**
   - El estudiante con `id_estudiante = 1` repite `baloncesto` para cada idioma (`inglés` y `francés`).
   - Lo mismo ocurre con `ajedrez`.

2. **Dificultad de Mantenimiento:**
   - Si el estudiante `1` aprende un nuevo idioma o participa en una nueva actividad, se deben agregar múltiples filas, lo que incrementa el riesgo de inconsistencias.

---

## **Corrección: Forma Normalizada**

Para cumplir con la **Cuarta Forma Normal**, dividimos la tabla en dos tablas separadas, porque las dependencias multivaluadas (`idioma` y `actividad`) son independientes y no deberían estar en la misma tabla.

### **Tabla 1: idiomas_estudiante**
| **id_estudiante** | **idioma**      |
|-------------------|----------------|
| 1                 | inglés         |
| 1                 | francés        |
| 2                 | español        |
| 2                 | alemán         |

Representación de dependencia:
```plaintext
id_estudiante ->> idioma
```

### **Tabla 2: actividades_estudiante**
| **id_estudiante** | **actividad**   |
|-------------------|----------------|
| 1                 | baloncesto     |
| 1                 | ajedrez        |
| 2                 | fútbol         |

Representación de dependencia:
```plaintext
id_estudiante ->> actividad
```
## **Ventajas de Cumplir con 4FN**

1. **Eliminación de Redundancia:**
   - Ya no hay combinaciones duplicadas entre idiomas y actividades.

2. **Facilidad de Mantenimiento:**
   - Si el estudiante `1` aprende un nuevo idioma, como `alemán`, solo se agrega a la tabla `idiomas_estudiante`.
   - Si el estudiante `1` comienza una nueva actividad, como `natación`, solo se agrega a la tabla `actividades_estudiante`.

3. **Integridad de los Datos:**
   - Se eliminan las posibilidades de inconsistencias al separar las dependencias independientes.

# **Quinta Forma Normal (5FN)**
La 5FN asegura que una tabla no pueda dividirse en tablas más pequeñas (usando atributos relacionados) y luego combinarse (con un join) para producir redundancias o inconsistencias.

### **Ejemplo Sencillo: Estudiantes, Cursos y Profesores**

Imagina una universidad que registra:
1. Qué **estudiantes** están inscritos en qué **cursos**.
2. Qué **profesores** enseñan qué **cursos**.
3. Qué **estudiantes** tienen clases con qué **profesores**.

Tenemos la siguiente tabla:

| **id_estudiante** | **id_curso** | **id_profesor** |
|-------------------|-------------|-----------------|
| 1                 | matemáticas | López           |
| 1                 | matemáticas | Pérez           |
| 2                 | física      | López           |
| 2                 | física      | García          |

---

### **Dependencia de Unión**

En esta tabla:
- Cada **estudiante** está relacionado con un **curso**.
- Cada **curso** está relacionado con varios **profesores**.
- Sin embargo, no hay una relación directa entre **estudiantes y profesores**, solo están relacionados a través del curso.

Esto genera redundancia, porque:
- `López` y `Pérez` están repetidos en las filas relacionadas con `matemáticas`.
- `López` y `García` están repetidos en las filas relacionadas con `física`.

---

### **Problema de Redundancia**

Si el profesor **Pérez** deja de enseñar **matemáticas**, tendrías que eliminar varias filas relacionadas con estudiantes. Si olvidas alguna fila, los datos quedarán inconsistentes.

---

### **Corrección: Forma Normalizada**

Para cumplir con **5FN**, dividimos la tabla en tres tablas más pequeñas, eliminando la redundancia:

#### **Tabla 1: estudiantes_cursos**
| **id_estudiante** | **id_curso** |
|-------------------|-------------|
| 1                 | matemáticas |
| 2                 | física      |

#### **Tabla 2: cursos_profesores**
| **id_curso** | **id_profesor** |
|-------------|-----------------|
| matemáticas | López           |
| matemáticas | Pérez           |
| física      | López           |
| física      | García          |

#### **Tabla 3: estudiantes_profesores**
No es necesaria porque la relación entre **estudiantes y profesores** se define a través de los cursos.

---

### **¿Qué Logramos con 5FN?**

1. **Eliminación de Redundancia:**
   - Ahora no repetimos combinaciones innecesarias de datos.
   
2. **Facilidad de Mantenimiento:**
   - Si el profesor **Pérez** deja de enseñar **matemáticas**, solo se elimina una fila en `cursos_profesores`.

3. **Integridad de los Datos:**
   - Al eliminar redundancia, no hay riesgo de inconsistencias.

---

### **Representación de Dependencias de Unión**

En la tabla original:
```plaintext
id_estudiante ->> id_curso
id_curso ->> id_profesor
```

Al dividir en tablas más pequeñas:
1. `id_estudiante ->> id_curso` en `estudiantes_cursos`.
2. `id_curso ->> id_profesor` en `cursos_profesores`.

## **En resumen: Checklist de Validación de Formas Normales**

Utiliza este checklist para verificar si una tabla está en cada una de las formas normales. Si cumples con las reglas de una forma normal, puedes avanzar a la siguiente.

---

### **Primera Forma Normal (1FN):**
1. ¿Cada celda contiene un único valor (sin listas o conjuntos dentro de una celda)?
2. ¿Todas las columnas tienen valores del mismo tipo de dato?
3. ¿Cada fila es única (existe una clave primaria que identifica cada fila)?
4. ¿El orden de las filas no transmite información?

✅ Si respondes **sí** a todas las preguntas, la tabla está en **1FN**.

---

### **Segunda Forma Normal (2FN):**
1. ¿La tabla ya está en 1FN?
2. Si la clave primaria es compuesta, ¿cada atributo no clave depende de la clave completa (no solo de una parte de ella)?
3. ¿No hay dependencias parciales de atributos no clave?

✅ Si respondes **sí** a todas las preguntas, la tabla está en **2FN**.

---

### **Tercera Forma Normal (3FN):**
1. ¿La tabla ya está en 2FN?
2. ¿Cada atributo no clave depende únicamente de la clave primaria (sin dependencias transitivas entre atributos no clave)?

✅ Si respondes **sí** a todas las preguntas, la tabla está en **3FN**.

---

### **Boyce-Codd Normal Form (BCNF):**
1. ¿La tabla ya está en 3FN?
2. ¿Cada atributo depende exclusivamente de las claves candidatas y no de otras claves?

✅ Si respondes **sí** a ambas preguntas, la tabla cumple con **BCNF**.

---

### **Cuarta Forma Normal (4FN):**
1. ¿La tabla ya está en BCNF?
2. ¿No hay dependencias multivaluadas independientes en la tabla (es decir, ningún atributo tiene listas independientes de valores asociados con la clave primaria)?

✅ Si respondes **sí** a ambas preguntas, la tabla cumple con **4FN**.

---

### **Quinta Forma Normal (5FN):**
1. ¿La tabla ya está en 4FN?
2. ¿No hay dependencias de unión (es decir, los datos no pueden dividirse en tablas más pequeñas y combinarse sin redundancia o pérdida de información)?

✅ Si respondes **sí** a ambas preguntas, la tabla cumple con **5FN**.

---

## **Cómo Usar el Checklist**
1. Verifica cada nivel de normalización en orden.
2. Si una tabla no cumple con una forma normal, identifica el problema (dependencias parciales, transitivas, multivaluadas, etc.).
3. Refactoriza la tabla para cumplir con las reglas de esa forma normal antes de avanzar al siguiente nivel.

**Nota:** En la mayoría de los casos prácticos, alcanzar **3FN** o **BCNF** es suficiente para garantizar un diseño eficiente y libre de redundancias.

# Bibliografia

- Avi Silberschatz, Henry F. Korth, S. Sudarshan (2019) - Database System Concepts, Seventh Edition, McGraw-Hill.
- https://www.geeksforgeeks.org/normal-forms-in-dbms/
- https://www.youtube.com/watch?v=GFQaEYEc8_8
- https://dbs.academy.lv/lection/dbs_LS07ENa_normalization.pdf