# Algebra relacional

## Lenguajes de consulta Relacionales:

SQL (Structured Query Language) es principalmente un lenguaje **declarativo**. En un lenguaje declarativo, como SQL, describes **qué** deseas obtener sin especificar **cómo** se debe lograr. Por ejemplo, cuando haces una consulta en SQL, defines los datos que quieres recuperar, pero no dictas los pasos exactos que el motor de la base de datos debe seguir para obtenerlos, ni los indices que debe usar, ni el orden de ejecución. Ejemplo:

```sql
SELECT name, country
FROM artists
WHERE country = 'USA';
```

En contraste, los lenguajes **imperativos** requieren que especifiques cada paso necesario para alcanzar un resultado, detallando **cómo** debe realizarse cada operación. SQL Incluye aspectos imperativos, gracias a extensiones como procedimientos almacenados y bloques de control. Ejemplo:

```sql
BEGIN
    UPDATE artists SET country = 'Unknown' WHERE country IS NULL;
    INSERT INTO logs (message) VALUES ('Updated unknown countries');
END;
```

En un lenguaje de consulta funcional, la computación se expresa como la evaluación de funciones que pueden operar sobre los datos de la base de datos o sobre los resultados de otras funciones. Adicionalmente en un paradigma funcional, la ejecución de las funciones no produces side-effects (efectos secundarios) y no actualizan el estado del programa. SQL tiene características funcionales, especialmente al trabajar con funciones de agregación y agrupación y consultas anidadas. Ejemplo, 

```sql
SELECT country, COUNT(*) AS total_artists
FROM artists
GROUP BY country;
```

> Nota: En clases posteriores aprenderemos como hacer las consultas de los ejemplos anteriores. 👌🏻

# **Algebra Relacional**

Se llama álgebra relacional a un conjunto de operaciones simples sobre tablas relacionales, a partir de las cuales se definen operaciones más complejas mediante composición.

El álgebra relacional se inspira en la teoría de conjuntos para especificar consultas en una base de datos relacional.

Para especificar una consulta en álgebra relacional, es preciso definir uno o más pasos que sirven para ir construyendo, mediante operaciones de álgebra relacional, una nueva relación que contenga los datos que responden a la consulta a partir de las relaciones almacenadas. 

### Operadores

- **Selección (σ):** o restricción que funciona como un filtro.
- **Proyección (Π):** la elección de atributos.
- **Producto cartesiano (X):** combina las tuplas de 2 entidades.
- **Unión Natural - Join (⋈):** combina las tuplas de 2 entidades solo si estas cumplen con un criterio en común.
- **Unión (∪):** agrega todas las tuplas de 2 consultas.
- **Diferencia (-):** agrega las tuplas resultantes de una consulta y remueve de este resultado las tuplas de una segunda consulta.
- **Intersección (∩):** agrega las tuplas de 2 consultas solo si están presentes en cada una de ellas.
- **Agrupación (Γ):** permite operaciones algebraicas sobre los resultados de una consulta.