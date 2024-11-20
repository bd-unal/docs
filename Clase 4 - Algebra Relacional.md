# Álgebra Relacional

## **Paradigmas de Programación**

Los paradigmas de programación son enfoques utilizados para resolver problemas de software y alcanzar los resultados deseados. Cada paradigma define cómo se deben estructurar y escribir los programas. Entre los más comunes están:

- **Imperativo**: Describe **cómo** resolver un problema paso a paso.
- **Declarativo**: Especifica **qué** resultado se desea, dejando que el sistema determine cómo lograrlo.
  
Para una mejor comprensión, puedes ver este video sobre la diferencia entre paradigmas imperativos y declarativos:  
[Video: Imperativo vs Declarativo](https://www.youtube.com/watch?v=vM_2XUs7UGw)

---

## **Lenguajes Relacionales**

![Lenguajes Relacionales](images/Algebra%20Relacional_0.png)

Los lenguajes relacionales son herramientas para interactuar con bases de datos relacionales, permitiendo escribir consultas para modificar o seleccionar datos. Los tres lenguajes más importantes son:

1. **Cálculo Relacional**: Describe **qué** datos se necesitan basándose en lógica de predicados.
2. **Álgebra Relacional**: Describe **cómo** obtener los datos mediante operaciones matemáticas.
3. **SQL**: Lenguaje declarativo ampliamente utilizado, basado en el cálculo y el álgebra relacional.

---

## **Cálculo Relacional**

El cálculo relacional es un lenguaje declarativo que permite especificar **qué** datos se necesitan, sin detallar **cómo** obtenerlos. Se basa en lógica de predicados y tiene dos formas principales:

![Lenguajes Relacionales](images/Algebra%20Relacional_1.png)

### **Cálculo Relacional de Tuplas (TRC)**

- Piensa en una **tupla** como una fila completa de una tabla.
- Se utilizan variables que representan filas y se escriben condiciones para seleccionar las que interesan.

**Ejemplo:**
- **Consulta**: Encuentra los álbumes lanzados en el año 2012.
```
{a | a ∈ albums ∧ a.release_year = 2012}
```

- **Traducción**: Selecciona todas las tuplas `a` de la tabla `albums` donde `release_year` sea igual a 2012.

---

### **Cálculo Relacional de Dominios (DRC)**

- Piensa en valores individuales de columnas (dominios) en lugar de filas completas.
- Se utilizan variables para representar valores específicos de atributos.

**Ejemplo:**
- **Consulta**: Encuentra los títulos de las canciones con duración mayor a 300 segundos.

```
{title | ∃duration (songs(title, _, duration) ∧ duration > 300)}
```

- **Traducción**: Selecciona los `title` de la tabla `songs` donde exista un `duration` tal que su valor sea mayor a 300 segundos.

---

## **SQL (Structured Query Language)**

SQL es un lenguaje declarativo utilizado para interactuar con bases de datos relacionales. Permite definir, manipular y consultar datos, basándose en el álgebra y el cálculo relacional.

**Ejemplo:**
- Recuperar los nombres y países de los artistas de USA:
```sql
SELECT name, country
FROM artists
WHERE country = 'USA';
```

SQL también incluye características imperativas (como procedimientos almacenados) 
```sql
BEGIN
   UPDATE artists SET country = 'Unknown' WHERE country IS NULL;
   INSERT INTO logs (message) VALUES ('Updated unknown countries');
END;
```

Y funcionales (como funciones de agregación).
```sql
SELECT country, COUNT(*) AS total_artists
FROM artists
GROUP BY country;
```

> En clases posteriores aprenderemos como hacer las consultas de los ejemplos anteriores. 👌🏻

## Algebra relacional

El álgebra relacional es un conjunto de operaciones que toman una o dos relaciones como entrada y generan una nueva relación como resultado. Sigue un enfoque procedimental, ya que especifica tanto qué datos se necesitan como cómo obtenerlos.

Las relaciones generadas pueden ser manipuladas posteriormente utilizando las mismas operaciones del álgebra relacional, lo que permite construir consultas más complejas.

Las operaciones de algebra relacional se pueden dividir en:
- Unarias: Operaciones que trabajan sobre una sola relación como entrada
- Binarias: Operaciones que toman dos relaciones como entrada

![4-UnaryBinary](images/Algebra%20Relacional_2.png)

También se pueden dividir en:
- Operaciones conjuntistas: Operaciones basadas en principios de la teoría de conjuntos, donde las relaciones se tratan como conjuntos. Ver repaso de conjuntos [aquí](https://www.probabilitycourse.com/chapter1/1_2_2_set_operations.php).
- Operaciones específicamente relacionales: Operaciones diseñadas específicamente para trabajar con datos relacionales, aprovechando la estructura de tablas.

![4-SetRelational](images/Algebra%20Relacional_3.png)

## Operaciones del Algebra Relacional

Usaremos las siguientes relaciones para demostrar cada una de las operaciones:

#### Artistas (artists):

![4-SetRelational](images/Algebra%20Relacional_4.png)

#### Artistas Archivados (artists_archived):

Note las diferencias y coincidencias con la relación `artists`.

![4-SetRelational](images/Algebra%20Relacional_5.png)

#### Álbumes (albums):

![4-SetRelational](images/Algebra%20Relacional_6.png)

#### Canciones (songs):

![4-SetRelational](images/Algebra%20Relacional_7.png)

### Union (Unión)

La unión es una operación que, a partir de dos relaciones, obtiene una nueva relación formada por todas las tuplas que están en alguna de las relaciones de partida. Es necesario que las dos relaciones sean compatibles.

- <span style="color:#ff0000">Símbolo:</span> `∪`
- <span style="color:#ff0000">Notación:</span> `Relación1 ∪ Relación2`
- <span style="color:#ff0000">Ejemplo:</span> Combina artistas actuales con artistas archivados.

```
artists ∪ artists_archived
```

- <span style="color:#ff0000">Resultado:</span>

![Union](images/Algebra%20Relacional_8.png)

### Difference (Diferencia)

La diferencia es una operación que, a partir de dos relaciones, obtiene una nueva relación formada por todas las tuplas que están en la primera relación y, en cambio, no están en la segunda.

- <span style="color:#ff0000">Símbolo:</span> `−`
- <span style="color:#ff0000">Notación:</span> `Relación1 - Relación2`
- <span style="color:#ff0000">Ejemplo:</span> Encuentra artistas actuales que no están archivados.

```
artists − artists_archived
```

- <span style="color:#ff0000">Resultado:</span>

![Difference](images/Algebra%20Relacional_9.png)

### Intersect (Intersección)

La intersección es una operación que, a partir de dos relaciones, obtiene una nueva relación formada por las tuplas que pertenecen a las dos relaciones de partida.

- <span style="color:#ff0000">Símbolo:</span> `∩`
- <span style="color:#ff0000">Notación:</span> `Relación1 ∩ Relación2`
- <span style="color:#ff0000">Ejemplo:</span> Encuentra los artistas presentes tanto en `artists` como en `artists_archived`.

```
artists ∩ artists_archived
```

- <span style="color:#ff0000">Resultado:</span>

![Intersect](images/Algebra%20Relacional_10.png)

### Cartesian Product (Producto Cartesiano)

El producto cartesiano es una operación que, a partir de dos relaciones, obtiene una nueva relación formada por todas las tuplas que resultan de concatenar tuplas de la primera relación con tuplas de la segunda.

- <span style="color:#ff0000">Símbolo:</span> `×`
- <span style="color:#ff0000">Notación:</span> `Relación1 × Relación2`
- <span style="color:#ff0000">Ejemplo:</span> Combina todos los artistas con todos los álbumes.

```
artists × artists_archived
```

- <span style="color:#ff0000">Resultado:</span>

![Intersect](images/Algebra%20Relacional_11.png)

### Selección (Select)

Es una operación que, a partir de una relación, obtiene una nueva relación formada por todas las tuplas de la relación de partida que cumplen una condición de selección especificada.

- <span style="color:#ff0000">Símbolo:</span> `σ` (teta)
- <span style="color:#ff0000">Notación:</span> `σ condición (Relación)`
- <span style="color:#ff0000">Ejemplo:</span> Encuentra los álbumes lanzados en el año 2012.

```
σ release_year = 2012 (albums)
```

- <span style="color:#ff0000">Resultado:</span>

![Select](images/Algebra%20Relacional_12.png)

### Project (Proyección)

Podemos considerar la proyección como una operación que sirve para elegir algunos atributos de una relación y eliminar el resto.

- <span style="color:#ff0000">Símbolo:</span> `π` (Pi)
- <span style="color:#ff0000">Notación:</span> `π atributos (Relación)`
- <span style="color:#ff0000">Ejemplo:</span> Seleccionar los atributos `name` y `country` de la tabla `artists`.

```
π name, country (artists)
```

- <span style="color:#ff0000">Resultado:</span>

![Project](images/Algebra%20Relacional_13.png)

### Join (Combinación)

La combinación es una operación que, a partir de dos relaciones, obtiene una nueva relación formada por todas las tuplas que resultan de concatenar tuplas de la primera relación con tuplas de la segunda, y que cumplen una condición de combinación especificada.

- <span style="color:#ff0000">Símbolo:</span> `⋈`
- <span style="color:#ff0000">Notación:</span> `Relación1 ⨝ condición Relación2`
- <span style="color:#ff0000">Ejemplo:</span> ¿Cuáles son los artistas y los álbumes en los que han participado esos artistas?. Combina las filas de `artists` y `albums` donde los valores de `artist_id` coinciden.

```
artists ⋈_artists.artist_id = albums.artist_id albums
```

- <span style="color:#ff0000">Resultado:</span>

![Join](images/Algebra%20Relacional_14.png)

El mismo ejemplo puede ser reescrito usando el producfo cartesiano y la selección:

```
σ artists.artist_id = albums.artist_id (artists × albums)
```

#### Explicación Paso a Paso
- Producto Cartesiano (artists × albums): Combina cada fila de `artists` con cada fila de `albums`. Esto genera un número muy grande de combinaciones, incluso aquellas que no tienen sentido (por ejemplo, artistas emparejados con álbumes que no les pertenecen).
- Selección (σ): Filtra las combinaciones para conservar únicamente aquellas donde el `artist_id` en `artists` es igual al `artist_id` en `albums`.

### Rename (Renombrar)

Permite asignar un nombre a los resultados de expresiones relacionales o cambiar el nombre de relaciones existentes. Esto es útil porque, a diferencia de las relaciones en la base de datos, los resultados de las expresiones del álgebra relacional no tienen un nombre que podamos usar para referirnos a ellos directamente.

- <span style="color:#ff0000">Símbolo:</span> `ρ` (rho)
- <span style="color:#ff0000">Notación:</span> `ρ nuevo_nombre (Relación)`
- <span style="color:#ff0000">Ejemplo:</span> Renombra `artists` como `musicians`.

```
ρ musicians (artists)
```

- <span style="color:#ff0000">Resultado:</span>

Nueva relación `musicians`:

![Project](images/Algebra%20Relacional_15.png)

### Assignment (Asignación)

Permite guardar el resultado de una expresión relacional en una variable temporal (o relación temporal). Este operador funciona de manera similar a una asignación en un lenguaje de programación: asigna un resultado a una variable que puede reutilizarse en pasos posteriores de la consulta.

- <span style="color:#ff0000">Símbolo:</span> `←`
- <span style="color:#ff0000">Notación:</span> `Variable ← Expresión`
- <span style="color:#ff0000">Ejemplo:</span> Cómo podemos almacenar en una variable llamada `recent_albums` los álbumes lanzados en el año 2015 para reutilizarlos en consultas posteriores?.

```
recent_albums ← σ release_year = 2015 (albums)
```

- <span style="color:#ff0000">Resultado:</span>

![Assignment](images/Algebra%20Relacional_16.png)

### Bonus (operadores lógicos)

En el álgebra relacional, puedes usar operadores lógicos para combinar múltiples condiciones:
- AND (`∧`): Para combinar condiciones que deben cumplirse simultáneamente.
- OR (`∨`): Para combinar condiciones donde al menos una debe cumplirse.
- NOT (`¬`): Para negar una condición.

- <span style="color:#ff0000">Ejemplo:</span> Queremos seleccionar álbumes que:
1. Fueron lanzados después de 2010 `(release_year > 2010)`.
2. Y cuyos títulos no sean "Greatest Hits" `(title ≠ 'Greatest Hits')`

```
σ_release_year > 2010 ∧ title ≠ 'Greatest Hits' (albums)
```

## Ejercicios en clase

1. Encuentra los artistas que son del Reino Unido (UK).
2. Encuentra los álbumes lanzados en 2020.
3. Muestra solo los nombres de los artistas.
4. Muestra los títulos y años de lanzamiento de todos los álbumes.
5. Combina todos los artistas con todos los álbumes mediante un producto cartesiano y luego filtra las combinaciones donde el artista haya participado en el álbum.
6. Usa un join para encontrar los nombres de los artistas y los títulos de los álbumes en los que participaron.
7. Encuentra los artistas actuales (artists) que no están en la tabla de artistas archivados (artists_archived).
8. Combina todos los artistas actuales y archivados.
9. Encuentra los títulos de las canciones lanzadas por artistas del Reino Unido (UK).
10. Almacena en una variable llamada long_songs las canciones cuya duración sea mayor a 300 segundos, y utiliza esa variable para encontrar sus títulos.


# Bibliografía
- Silberschatz, A., Korth, H. F., & Sudarshan, S. (2019). Database System Concepts (7th ed.). McGraw Hill Education.
- [https://openaccess.uoc.edu/bitstream/10609/200/8/Bases de datos_Módulo2_El modelo relacional y el álgebra relacional.pdf](https://openaccess.uoc.edu/bitstream/10609/200/8/Bases%20de%20datos_M%C3%B3dulo2_El%20modelo%20relacional%20y%20el%20%C3%A1lgebra%20relacional.pdf)
- https://www.probabilitycourse.com/chapter1/1_2_2_set_operations.php
- https://www.youtube.com/watch?v=vM_2XUs7UGw
- https://www.naukri.com/code360/library/difference-between-relational-algebra-and-relational-calculus
