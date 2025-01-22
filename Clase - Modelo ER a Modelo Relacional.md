# Del Modelo ER al Modelo Relacional

## Recapitulando

Los **modelos Entidad-Relación (ER)** conceptuales permiten representar el área temática con mayor precisión en comparación con los modelos lógicos, como los modelos **relacionales**, **de red**, entre otros.

Sin embargo, no existen sistemas de gestión de bases de datos que trabajen directamente con modelos ER. Por esta razón, el diagrama ER debe transformarse en un conjunto de tablas dentro del **modelo de datos relacional** (modelo lógico).

Los **modelos relacionales** se pueden implementar fácilmente utilizando sistemas de gestión de bases de datos relacionales (RDBMS) como **MySQL**, **SQL Server**, **PostgreSQL**, **Oracle**, entre otros. Para facilitar esta implementación, se suelen usar herramientas **CASE** (_Computer-Aided Software Engineering_), que asisten en el mapeo entre modelos conceptuales y lógicos.

---

# ER2RDM (Entity-Relationship to Relational Data Model)

El método **ER2RDM** se basa en transformar un diagrama ER en un conjunto de **tablas relacionales iniciales**, considerando cuidadosamente cada uno de sus componentes:
- **Atributos atómicos**
- **Atributos multivaluados**
- **Cardinalidades**
- **Obligatoriedad de las relaciones**
- **Otros componentes del diagrama ER**

### **Etapas del Proceso**

1. **Conversión inicial:**
   - Se crea un **modelo lógico relacional (RDM)** a partir del diagrama ER.
   - En esta etapa, cada entidad y relación se traduce en tablas con atributos claramente definidos y respetando las claves primarias y foráneas.

2. **Optimización y normalización:**
   - El modelo lógico inicial se optimiza mediante técnicas de **normalización**, con el objetivo de:
     - Reducir **redundancias**.
     - Mejorar la **integridad de los datos**.
     - Garantizar un diseño eficiente y escalable.

---

### **Nota Final**
Este proceso asegura que el modelo conceptual (ER) se transforme en un esquema relacional que sea compatible con sistemas de bases de datos relacionales. El uso de **normalización** garantiza que el diseño final no solo sea funcional, sino también eficiente para consultas y operaciones.


# El esquema relacional

El esquema especifica el nombre de la relación, el nombre de cada campo (o columna, o atributo) y el dominio de cada campo.

La información de los estudiantes en una base de datos universitaria puede almacenarse en una relación con el siguiente esquema:

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional0.png)

# Tipos de datos

A continuación se presentan los tipos de datos más usados.

| **Tipo**                     | **Tamaño Máximo** | **Descripción**                                                                                     | **Rango**                                                                                                                                           | **Ejemplo**                                      |
|------------------------------|-------------------|-----------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------|
| **bit**                     | 1 byte            | Describe una señal                                                                                 | 1 / 0                                                                                                                                               | 1, 0                                             |
| **boolean**                 | 1 byte            | Describe un estado                                                                                 | `true` / `false`                                                                                                                                    | `true`, `false`                                  |
| **smallint**                | 2 bytes           | Entero de rango pequeño                                                                            | -32,768 a +32,767                                                                                                                                   | 10, -500                                         |
| **integer**                 | 4 bytes           | Opción típica para entero                                                                          | -2,147,483,648 a +2,147,483,647                                                                                                                     | 100, -20000                                      |
| **bigint**                  | 8 bytes           | Entero de rango grande                                                                             | -9,223,372,036,854,775,808 a +9,223,372,036,854,775,807                                                                                             | 1,000,000,000,000                                |
| **decimal**                 | Variable          | Precisión especificada por el usuario, exacta.                                                     | Hasta 131,072 dígitos antes del punto decimal y hasta 16,383 dígitos después del punto decimal                                                       | 123456789.123456                                 |
| **numeric**                 | Variable          | Precisión especificada por el usuario, exacta.                                                     | Similar a `decimal`: Hasta 131,072 dígitos antes del punto decimal y hasta 16,383 dígitos después del punto decimal                                  | 100000000.00                                     |
| **char**                    | Variable          | Longitud limitada                                                                                  | 1 a 255 caracteres                                                                                                                                  | 'A', 'Texto fijo'                                |
| **varchar**                 | Variable          | Longitud variable con límite                                                                       | Hasta el límite definido (por ejemplo, VARCHAR(255))                                                                                                | 'Texto variable'                                 |
| **text**                    | Variable          | Cadenas de texto de longitud ilimitada                                                             | Longitud ilimitada                                                                                                                                  | 'Descripción extensa de un texto'               |
| **date**                    | 4 bytes           | Fecha (sin hora del día)                                                                           | `0001-01-01` a `9999-12-31`                                                                                                                         | `2024-12-01`                                     |
| **time**                    | 8 bytes           | Hora del día (sin fecha)                                                                           | `00:00:00` a `23:59:59`                                                                                                                             | `14:30:00`                                       |
| **timestamp**               | 8 bytes           | Tanto la fecha como la hora (sin la zona horaria)                                                  | `0001-01-01 00:00:00` a `9999-12-31 23:59:59`                                                                                                       | `2024-12-01 14:30:00`                            |
| **timestamp con zona horaria** | 12 bytes          | Fecha y hora, con zona horaria                                                                     | `0001-01-01 00:00:00+offset` a `9999-12-31 23:59:59+offset`                                                                                          | `2024-12-01 14:30:00+02:00`                      |
| **UUID**                    | 128 bytes         | Identificadores únicos universales (UUID) según RFC 4122, ISO/IEC 9834-8:2005                     | Identificadores únicos en formato estándar UUID: 8-4-4-4-12 caracteres hexadecimales                                                                | `123e4567-e89b-12d3-a456-426614174000`           |

La tabla anterior no cubre todos los tipos de datos existentes, en los siguientes enlaces se pueden encontrar más tipos de datos.
- [Link 1](https://blog.nubecolectiva.com/tipos-de-datos-en-postgresql-parte-1/)
- [Link 2](https://www.postgresql.org/docs/8.1/datatype.htm)

### **REGLA-01: PARA CONJUNTO DE ENTIDADES FUERTES CON SOLO ATRIBUTOS SIMPLES**

Un conjunto de **entidades fuertes** con solo **atributos simples** requiere únicamente **una tabla** en el modelo relacional. 

#### **Puntos Clave:**
- Los **atributos de la tabla** serán los mismos que los atributos del conjunto de entidades.
- Los **atributos derivados** **se eliminarán** del modelo relacional.
- La **clave principal** de la tabla será el atributo clave del conjunto de entidades.

Ejemplo:
![](images/Del%20Modelo%20ER%20al%20modelo%20relacional3.png)

### **REGLA-02: PARA CONJUNTO DE ENTIDADES FUERTES CON ATRIBUTOS COMPUESTOS**

Un conjunto de **entidades fuertes** con uno o más **atributos compuestos** requerirá únicamente **una tabla** en el modelo relacional.

#### **Puntos Clave:**
- Durante la conversión, solo se tienen en cuenta los **atributos simples** que componen los atributos compuestos.
- Los **atributos compuestos** no se almacenan directamente; se descomponen en sus partes simples y estas se incluyen en la tabla.

Ejemplo:
![](images/Del%20Modelo%20ER%20al%20modelo%20relacional4.png)

### **REGLA-03: PARA CONJUNTO DE ENTIDADES FUERTES CON ATRIBUTOS MULTIVALUADOS**

Un conjunto de **entidades fuertes** con uno o más **atributos multivaluados** requerirá la creación de **dos tablas** en el modelo relacional.

#### **Puntos Clave:**
1. **Primera Tabla:**
   - Contendrá todos los **atributos simples**.
   - Incluirá la **clave principal** de la entidad.

2. **Segunda Tabla:**
   - Contendrá la **clave principal** de la entidad como clave foránea.
   - Incluirá todos los **atributos multivaluados**.

Ejemplo:
![](images/Del%20Modelo%20ER%20al%20modelo%20relacional5.png)

# Ejercicio

Construye el esquema relacional a partir del siguiente diagrama ER:

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional6.png)

### **REGLA-04: PARA RELACIÓN BINARIA CON CONJUNTO DE ENTIDADES DÉBILES**

Una **entidad débil** depende de una **entidad fuerte** para su identificación. En este caso, la relación binaria se maneja con las siguientes consideraciones:

#### **Puntos Clave:**
1. **Definición de Clave Primaria:**
   - La **clave primaria** de la entidad débil se construye combinando:
     - La **clave primaria** de la entidad fuerte.
     - Los atributos de la entidad débil que son candidatos a formar una **clave parcial**.

2. **Transformación al Modelo Relacional:**
   - La relación binaria entre la entidad débil y la fuerte se convierte en una tabla específica para la **entidad débil**.
   - Esta tabla incluye:
     - Una **clave foránea** que referencia a la tabla de la entidad fuerte.
     - Los atributos propios de la entidad débil.

Especificación General:
![](images/Del%20Modelo%20ER%20al%20modelo%20relacional7.png)

Ejemplo:
![](images/Del%20Modelo%20ER%20al%20modelo%20relacional8.png)

### **REGLA-05: MAPEAR UN CONJUNTO DE RELACIONES SIN DESCRIPCIÓN EXPLÍCITA DE LAS CARDINALIDADES**

Esta regla se aplica cuando una relación no tiene una descripción explícita de las **cardinalidades** (por ejemplo, 1:1, 1:N o N:M). En este caso, se asume por defecto que la relación puede ser **N:M**.

#### **Puntos Clave:**

1. **Relación sin Cardinalidades Específicas:**
   - Se interpreta que la relación puede involucrar múltiples instancias de cada entidad participante (N:M).

2. **Estructura Relacional:**
   - Una relación entre dos entidades requerirá una tabla adicional para representar la relación.
   - Si la relación involucra tres entidades, se necesitarán tres tablas en el modelo relacional.

3. **Atributos de la Tabla:**
   - Incluye los **atributos clave principal** de las entidades participantes.
   - Contiene los **atributos descriptivos** propios de la relación (si existen).

4. **Clave Principal:**
   - La clave primaria de la tabla será el **conjunto de claves principales** de las entidades participantes (clave compuesta).
   - Excluye los atributos descriptivos.

Ejemplo:
![](images/Del%20Modelo%20ER%20al%20modelo%20relacional9.png)

### **REGLA-06: MAPEAR RELACIONES BINARIAS CON CARDINALIDAD M:N**
Esta regla es igual que la anterior con la diferencia que en este caso las cardinalidades son especificadas en el diagrama. Formalmente se puede representar de la siguiente forma.

Especificación general:
![](images/Del%20Modelo%20ER%20al%20modelo%20relacional10.png)

Ejemplo:
![](images/Del%20Modelo%20ER%20al%20modelo%20relacional11.png)

### **REGLA-07: MAPEAR RELACIONES BINARIAS CON CARDINALIDAD 1:N O N:1**

Esta regla se aplica para transformar relaciones binarias con cardinalidades **1:N** o **N:1** al modelo relacional. La relación se modela directamente entre las dos tablas sin necesidad de una tabla intermedia.

#### **Puntos Clave:**

1. **Agregar una clave foránea (FK):**
   - La **clave primaria** de la entidad del lado **1** se agrega como **clave foránea** en la tabla de la entidad del lado **N**.
   - Esta clave foránea establece la relación entre las dos tablas.

2. **Incluir atributos de la relación (si existen):**
   - Si la relación tiene atributos propios, se agregan como **columnas adicionales** en la tabla del lado **N**.

3. **No se necesita una tabla independiente:**
   - La relación se representa directamente a través de la clave foránea en la tabla del lado **N**.
   - No es necesario crear una tabla separada para modelar la relación.

Especificación general:
![](images/Del%20Modelo%20ER%20al%20modelo%20relacional12.png)

Ejemplo:
![](images/Del%20Modelo%20ER%20al%20modelo%20relacional13.png)

### **REGLA-08: MAPEAR RELACIONES BINARIAS CON CARDINALIDAD 1:0,N O 0,1:N**

Esta regla describe cómo transformar relaciones binarias con las siguientes cardinalidades al modelo relacional:
- **Opción A: 1:0,N** (relación obligatoria en un lado y opcional en el otro).
- **Opción B: 0,1:N** (relación opcional en un lado y obligatoria en el otro).

---

#### **Opción A: CARDINALIDAD 1:0,N**
1. **Descripción:**
   - Cada instancia de la entidad del lado **1** está asociada con **cero o más instancias** de la entidad del lado **N**.
   - Cada instancia del lado **N** debe estar asociada con **exactamente una instancia** del lado **1**.

2. **Reglas para el Modelo Relacional:**
   - **Clave Foránea en la Tabla del Lado N:**
     - Agrega una clave foránea en la tabla de la entidad del lado **N**.
     - Esta clave foránea hace referencia a la clave primaria de la tabla del lado **1**.
   - **Restricción `NOT NULL`:**
     - La clave foránea en la tabla del lado **N** debe ser **NOT NULL** porque cada instancia del lado **N** debe estar asociada a una instancia del lado **1**.
   - **Atributos de la Relación:**
     - Si la relación tiene atributos propios, estos se agregan como columnas adicionales en la tabla del lado **N**.

Ejemplo:
![](images/Del%20Modelo%20ER%20al%20modelo%20relacional14-1.png)

---

#### **Opción B: CARDINALIDAD 0,1:N**
1. **Descripción:**
   - Cada instancia de la entidad del lado **N** está asociada con **cero o una instancia** de la entidad del lado **0,1**.
   - Cada instancia del lado **0,1** puede estar asociada con **varias instancias** del lado **N**, pero la relación es opcional.

2. **Reglas para el Modelo Relacional:**
   - **Clave Foránea en la Tabla del Lado N:**
     - Agrega una clave foránea en la tabla de la entidad del lado **N**.
     - Esta clave foránea hace referencia a la clave primaria de la tabla del lado **0,1**.
   - **Restricción `NULL`:**
     - La clave foránea en la tabla del lado **N** debe permitir valores `NULL` porque no todas las instancias del lado **N** estarán asociadas a una instancia del lado **0,1**.
   - **Atributos de la Relación:**
     - Si la relación tiene atributos propios, estos se agregan como columnas adicionales en la tabla del lado **N**.

Ejemplo:
![](images/Del%20Modelo%20ER%20al%20modelo%20relacional14-2.png)

### **REGLA-09: MAPEAR RELACIONES BINARIAS CON CARDINALIDAD 1:1**

Una relación **uno a uno (1:1)** significa que cada instancia de una entidad está relacionada con **solo una instancia** de otra entidad, y viceversa. Este tipo de relación es exclusivo en ambas direcciones.

#### **Opciones para Mapear una Relación 1:1**

1. **Entidad Principal y Secundaria:**
   - Selecciona una entidad como **principal** y la otra como **secundaria**.
   - Agrega la clave primaria de la entidad principal como **clave foránea** en la tabla de la entidad secundaria.
   - Esto mantiene la relación explícita y respeta la cardinalidad.

2. **Fusión de Entidades:**
   - Fusiona ambas entidades en una sola tabla.
   - Usa una clave primaria única que represente ambas entidades.
   - Esta opción es ideal si las entidades tienen atributos comunes o su separación no es estrictamente necesaria.

Opción 1:
![](images/Del%20Modelo%20ER%20al%20modelo%20relacional15.png)

Opción 2:
![](images/Del%20Modelo%20ER%20al%20modelo%20relacional16.png)

### **REGLA-10: MAPEAR RELACIONES BINARIAS CON CARDINALIDAD 1,1:0,1 O 0,1:1,1**

Esta regla se aplica a relaciones binarias donde:
- Una entidad tiene cardinalidad **1,1** (relación obligatoria).
- La otra entidad tiene cardinalidad **0,1** (relación opcional).

#### **Puntos Clave:**

1. **Agregar la Clave Foránea:**
   - La clave primaria de la entidad del lado **1,1** se agrega como **clave foránea** en la tabla de la entidad del lado **0,1** (opcional).
   - Esto asegura que la relación sea correctamente representada en el modelo relacional.

2. **Incluir Restricciones de Unicidad:**
   - La clave foránea en la tabla del lado **0,1** debe tener una restricción **`UNIQUE`**.
   - Esto garantiza que cada instancia de la entidad opcional esté asociada, como máximo, con una instancia de la entidad obligatoria.

3. **Restricción de Obligación en el Lado 1,1:**
   - Todas las instancias de la entidad obligatoria (**1,1**) deben estar relacionadas con al menos una instancia del lado opcional (**0,1**), lo cual puede ser validado a nivel de aplicación o con lógicas adicionales.

Ejemplo:
![](images/Del%20Modelo%20ER%20al%20modelo%20relacional17.png)

### **REGLA-11: MAPEAR RELACIONES BINARIAS CON CARDINALIDAD 0,1:0,1**

Esta regla se aplica a relaciones binarias donde:
- Ambas entidades tienen cardinalidad **0,1**, lo que significa que cada instancia de una entidad **puede o no estar asociada** con una instancia de la otra entidad.
- La relación es completamente **opcional en ambas direcciones**, por lo que ambas entidades pueden existir sin estar relacionadas.

#### **Puntos Clave:**

1. **Clave Foránea:**
   - La clave foránea puede colocarse en cualquiera de las tablas, dependiendo del diseño y del contexto de la aplicación.

2. **Restricción de Unicidad:**
   - No se requiere una restricción **`UNIQUE`** estricta, ya que la relación es opcional en ambas direcciones.
   - Si se aplica una restricción `UNIQUE`, se permite que la clave foránea acepte valores **`NULL`**.

3. **Opcionalidad:**
   - Ambas entidades pueden existir de forma independiente, sin necesidad de establecer una relación.

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional18.png)

### **REGLA-12: MAPEAR RELACIONES TERNARIAS CON CARDINALIDAD N:M:W**

Una relación **ternaria** involucra tres entidades conectadas entre sí en una única relación. El caso **N:M:W** describe una situación donde:

- Cada instancia de las tres entidades puede estar asociada con múltiples instancias de las otras.
- La relación **no puede descomponerse** en relaciones binarias sin perder información o introducir redundancia.

#### **Proceso de Transformación al Modelo Relacional**

1. **Crear una tabla para cada entidad:**
   - Cada una de las entidades participantes (por ejemplo, `Proveedor`, `Producto`, y `Cliente`) tiene su propia tabla.

2. **Crear una tabla para la relación ternaria:**
   - La tabla de la relación representa las conexiones entre las tres entidades.
   - **Clave primaria:** Se forma una clave compuesta utilizando las claves principales de las tres entidades.
   - **Atributos propios de la relación:** Si la relación tiene atributos adicionales (como `cantidad` o `fecha`), estos se agregan a esta tabla.

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional19.png)

# Ejercicio en clase
![](images/Del%20Modelo%20ER%20al%20modelo%20relacional20.png)

# Tarea

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional21.png)

# Bibliografia

- Avi Silberschatz, Henry F. Korth, S. Sudarshan (2019) - Database System Concepts, Seventh Edition, McGraw-Hill.
- https://dbs.academy.lv/lection/dbs_LS06EN_er2rm.pdf
- https://www.linkedin.com/advice/1/how-do-you-map-cardinality-constraints-from-er-relational#:~:text=To%20map%20a%201%3A1,in%20the%20child%20entity%20table.
- https://itsmeebin.wordpress.com/wp-content/uploads/2023/06/mm2.pdf


