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
   | **id_prestatario** (PK) | **nombre**       | 
   |-------------------------|------------------|
   | 1                       | John Doe         | 
   | 2                       | Jane Doe         |
   | 3                       | James Brown      | 
   | 4                       | Emily García     |
   | 5                       | David Lee        |
   | 6                       | Michael Chen     |

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

## **Ejemplo**
Imagina una base de datos que almacena información sobre publicaciones. Vamos a considerar una tabla llamada **Publicaciones** con las columnas `título`, `autor`, `año_publicación` y `palabras clave`.

---

### **Tabla Inicial: Publicaciones**
| **publication_id** (PK) | **title**               | **autor**          | **publication_year** | **palabras_clave**          |
|-------------------------|------------------------|--------------------|----------------------|-----------------------------|
| 1                       | Matar a un ruiseñor     | Harper Lee         | 1960                 | Mayoría de edad, Legal      |
| 2                       | El Señor de los Anillos | J. R. R. Tolkien   | 1954                 | Fantasía, Épica, Aventura   |
| 3                       | Orgullo y prejuicio     | Jane Austen        | 1813                 | Romance, Comentario social  |

---

## **Problema**
La tabla anterior viola la **4FN** debido a la dependencia multivaluada en la columna `palabras_clave`:
- Una publicación puede tener múltiples palabras clave (`Mayoría de edad`, `Legal`, etc.).
- Estas palabras clave son independientes unas de otras, pero dependen de `publication_id`.

Este diseño introduce redundancia y dificulta las consultas y el mantenimiento.

---

## **Solución**
Para cumplir con la **4FN**, descomponemos la tabla original en dos tablas relacionadas. Creamos una nueva tabla para manejar las palabras clave de forma separada.

### **Tabla de Publicaciones**
| **publication_id** (PK) | **title**               | **autor**          | **publication_year** |
|-------------------------|------------------------|--------------------|----------------------|
| 1                       | Matar a un ruiseñor     | Harper Lee         | 1960                 |
| 2                       | El Señor de los Anillos | J. R. R. Tolkien   | 1954                 |
| 3                       | Orgullo y prejuicio     | Jane Austen        | 1813                 |

### **Tabla de Palabras Clave por Publicación**
| **publication_id** (FK) | **palabra_clave**       |
|-------------------------|------------------------|
| 1                       | Mayoría de edad        |
| 1                       | Legal                 |
| 2                       | Fantasía              |
| 2                       | Épica                 |
| 2                       | Aventura              |
| 3                       | Romance               |
| 3                       | Comentario social     |

---

## **Ventajas de la Solución**
1. **Reducción de Redundancia:**
   - Cada palabra clave se almacena una sola vez y está relacionada únicamente con su publicación.

2. **Facilidad de Mantenimiento:**
   - Si una publicación adquiere nuevas palabras clave, se pueden agregar fácilmente nuevas filas sin alterar la estructura.

3. **Mejor Consistencia:**
   - Eliminar dependencias multivaluadas garantiza que cada palabra clave sea independiente.

---

## **Resumen**
La nueva tabla **Palabras Clave por Publicación** establece una relación de muchos a muchos entre publicaciones y palabras clave. Ahora, cada publicación puede tener varias palabras clave asociadas mediante `publication_id`, cumpliendo con la **Cuarta Forma Normal (4FN)**.

---

# **Quinta Forma Normal (5FN)**
La 5FN asegura que una tabla no pueda dividirse en tablas más pequeñas (usando atributos relacionados) y luego combinarse (con un join) para producir redundancias o inconsistencias.

En términos más sencillos, 5FN garantiza que al unir las tablas no se pueda obtener información adicional que no estuviera ya disponible en las tablas separadas.

## **Ejemplo: Sistema Universitario**

Imagina una base de datos universitaria con dos tablas normalizadas: **Cursos** e **Inscripciones**.

### **Tabla de Cursos**
| **id_curso** (PK) | **nombre_curso**               | **departamento**   |
|-------------------|--------------------------------|--------------------|
| 101               | Introducción a la programación | Informática        |
| 202               | Estructuras de datos y algoritmos | Informática        |
| 301               | Desarrollo web I              | Informática        |
| 401               | Inteligencia Artificial       | Informática        |

### **Tabla de Inscripciones**
| **id_matricula** (PK) | **id_estudiante** (FK) | **id_curso** (FK) | **calificacion** |
|-----------------------|-----------------------|-------------------|-----------|
| 1                     | 12345                | 101               | 5.0         |
| 2                     | 12345                | 202               | 3.5         |
| 3                     | 56789                | 301               | 3.6        |
| 4                     | 56789                | 401               | 4.2        |

---

### **Problema de Dependencia de Unión**

Supongamos que cada curso tiene un **requisito previo** que se almacena como una columna adicional en la tabla de **Cursos**:

| **id_curso** (PK) | **nombre_curso**               | **departamento**   | **id_curso_requisito_previo** |
|-------------------|--------------------------------|--------------------|-------------------------------|
| 202               | Estructuras de datos y algoritmos | Informática        | 101                           |
| 301               | Desarrollo web I              | Informática        | NULL                          |
| 401               | Inteligencia Artificial       | Informática        | 202                           |

Este diseño parece eficiente, pero introduce una **dependencia de unión** si necesitas consultar:
1. Los cursos en los que está inscrito un estudiante.
2. Los requisitos previos de esos cursos.

Esto requeriría:
- Unir las tablas **Cursos** e **Inscripciones**.
- Volver a unir la tabla **Cursos** consigo misma para recuperar los datos de los requisitos previos.

---

### **Solución: Forma Normalizada (5FN)**

Para eliminar la dependencia de unión, separamos los requisitos previos en una tabla independiente:

#### **Tabla de Requisitos Previos del Curso**
| **id_curso** (FK) | **id_curso_requisito_previo** (FK) |
|-------------------|-----------------------------------|
| 202               | 101                               |
| 301               | NULL                              |
| 401               | 202                               |

---

### **Ventajas de Cumplir con 5FN**

1. **Eficiencia en Consultas:**
   - Recuperar los cursos matriculados y sus requisitos previos ahora solo requiere una unión entre las tablas **Inscripciones** y **Requisitos Previos del Curso**.

2. **Eliminación de Redundancia:**
   - Los requisitos previos se almacenan una sola vez, en lugar de repetirse en cada fila de la tabla **Cursos**.

3. **Consistencia de los Datos:**
   - Si cambian los prerrequisitos de un curso, solo necesitas actualizar la tabla **Requisitos Previos del Curso**, lo que reduce la probabilidad de inconsistencias.

---

## **Resumen**
La **5FN** se aplica para eliminar dependencias complejas de unión, asegurando que los datos estén organizados de manera óptima y evitando redundancias. Aunque es una forma avanzada y poco común, es útil para bases de datos con relaciones altamente interconectadas.

---

## **En resumen: Checklist de Validación de Formas Normales**

Utiliza este checklist para verificar si una tabla está en cada una de las formas normales. Si cumples con las reglas de una forma normal, puedes avanzar a la siguiente.

---

### **Primera Forma Normal (1FN):**
1. **¿El orden de las filas no transmite información?**
   - Las filas deben ser independientes entre sí, y su orden no debe tener significado.

2. **¿Todas las columnas contienen valores del mismo tipo de dato?**
   - Cada columna debe almacenar un único tipo de dato (por ejemplo, texto, números o fechas).

3. **¿Cada celda contiene un único valor atómico?**
   - No debe haber listas, conjuntos o valores compuestos en una celda. Cada celda debe contener un solo valor.

4. **¿Cada fila es única?**
   - Debe existir una clave primaria que identifique de manera única a cada fila.

5. **¿No hay grupos repetidos?**
   - Los datos no deben estar organizados en grupos repetidos dentro de la misma tabla.

---

✅ **Si respondes "Sí" a todas las preguntas, la tabla está en 1FN.**


✅ Si respondes **sí** a todas las preguntas, la tabla está en **1FN**.

---

### **Segunda Forma Normal (2FN):**
1. ¿La tabla ya está en 1FN?
2. ¿Cada atributo no clave depende de la clave completa (no solo de una parte de ella)?
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

## Desnormalización (Denormalization)
La desnormalización se utiliza para modificar la estructura de una base de datos añadiendo datos redundantes. Esto significa combinar múltiples tablas para ejecutar consultas de forma más rápida. Es importante destacar que la desnormalización no implica revertir la normalización ni evitarla, sino que es una técnica de optimización que se aplica después de normalizar.

En una base de datos tradicionalmente normalizada, los datos se almacenan en tablas separadas con el objetivo de minimizar la redundancia. Por ejemplo, podríamos tener una tabla de Cursos y otra de Profesores, donde la tabla de Cursos almacena solo el id_profesor pero no su nombre. Para obtener una lista de Cursos junto con el nombre del Profesor, necesitaríamos realizar un join entre ambas tablas. La desnormalización permite evitar estas uniones costosas al combinar datos relacionados en una sola tabla.

### Ventajas de la Desnormalización
1. **Mejora del rendimiento de consultas**: Reduce el número de uniones necesarias para recuperar datos.
2. **Menor complejidad del esquema**: Combina datos relacionados en menos tablas, simplificando la estructura.
3. **Facilidad de mantenimiento**: Reduce la cantidad de tablas que necesitan ser actualizadas.
4. **Rendimiento de lectura mejorado**: Facilita el acceso directo a los datos.
5. **Mejor escalabilidad**: Reduce el número de tablas, mejorando el rendimiento en sistemas grandes.

### Desventajas de la Desnormalización
1. **Menor integridad de los datos**: La redundancia puede generar inconsistencias.
2. **Mayor complejidad**: Introducir datos redundantes puede complicar el diseño.
3. **Mayor uso de almacenamiento**: Los datos redundantes aumentan el tamaño de la base de datos.
4. **Actualizaciones más complejas**: Modificar los datos puede ser más difícil debido a la redundancia.
5. **Menor flexibilidad**: Adaptar el esquema a nuevos requerimientos puede ser más complicado.

## Ejercicio en clase

Normalizar hasta la 3FN la siguiente tabla que tiene el siguient esquema:
```plaintext
orden(id_orden, fecha, id_cliente, nombre_cliente, ciudad, id_articulo, nombre_articulo, cantidad, precio)
```

| **id_orden (PK)** | **fecha**   | **id_cliente** | **nombre_cliente**             | **ciudad**   | **id_articulo (PK)** | **nombre_articulo** | **cantidad** | **precio**   |
|-------------------|-------------|----------------|--------------------------------|--------------|-----------------|---------------------|--------------|--------------|
| 2301              | 23/02/11    | 101            | Perez Suarez Martin            | Bogotá       | 3786            | Red                 | 3            | 35           |
| 2301              | 23/02/11    | 101            | Perez Suarez Martin            | Bogotá       | 4011            | Raqueta             | 6            | 65           |
| 2301              | 23/02/11    | 101            | Perez Suarez Martin            | Bogotá       | 9132            | Escoba              | 8            | 4            |
| 2302              | 25/02/11    | 107            | Gonzalez Rios Juan Fernando    | Medellín     | 5794            | Trapero             | 4            | 5            |
| 2303              | 27/02/11    | 110            | Baron Gutierrez Pedro          | Cali         | 4011            | Raqueta             | 2            | 65           |
| 2303              | 27/02/11    | 110            | Baron Gutierrez Pedro          | Cali         | 3141            | Funda               | 2            | Diez mil     |


# Bibliografia

- Avi Silberschatz, Henry F. Korth, S. Sudarshan (2019) - Database System Concepts, Seventh Edition, McGraw-Hill.
- https://www.geeksforgeeks.org/normal-forms-in-dbms/
- https://www.youtube.com/watch?v=GFQaEYEc8_8
- https://dbs.academy.lv/lection/dbs_LS07ENa_normalization.pdf
