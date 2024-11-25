# Diseño de Bases de Datos utilizando el Modelo Entidad-Relación

Hasta este punto, hemos explorado los conceptos básicos de las bases de datos y el modelo relacional, adquiriendo una comprensión de sus fundamentos. En esta clase, aprenderemos cómo transformar una necesidad, un requerimiento de negocio o incluso una idea en un diseño estructurado que pueda derivar en un modelo relacional. Este diseño incluirá relaciones y restricciones necesarias para satisfacer los requerimientos identificados.

El diseño de bases de datos es un proceso crítico que requiere atención al detalle y un profundo entendimiento del negocio. El diseñador tiene un rol clave: traducir las necesidades del negocio en un modelo conceptual claro, organizado en entidades, atributos y relaciones que se materializarán en la base de datos. Este proceso es esencial para garantizar que la base de datos no solo cumpla con las expectativas del sistema, sino que también sea eficiente y flexible para futuras necesidades.

---

## Fases del Diseño de Bases de Datos

El diseño de bases de datos sigue un proceso estructurado que se divide en varias fases. Estas fases garantizan la transición ordenada desde los requerimientos hasta la implementación final.

### 1. **Fase de Requisitos**
   - **Objetivo:** Identificar y documentar las necesidades de datos a través de interacciones con expertos y usuarios finales.
   - **Resultado:** Una especificación clara de los requerimientos, que para efectos de este curso será presentada mediante descripciones textuales organizadas.

---

### 2. **Especificación Funcional**
   - **Objetivo:** Definir las operaciones que realizará la base de datos, como consultas, inserciones, actualizaciones y eliminaciones en el sistema.

---

### 3. **Diseño Conceptual**
   - **Objetivo:** Traducir los requerimientos en un esquema conceptual utilizando un modelo de datos abstracto como el Modelo Entidad-Relación (E-R).
   - **Resultado:** Un diagrama Entidad-Relación que representa gráficamente:
     - Entidades (objetos principales del sistema).
     - Relaciones (cómo interactúan las entidades).
     - Restricciones (como cardinalidades y atributos clave).
   - **Revisión:** Verificar que el esquema conceptual cumpla con los requisitos funcionales del sistema.

---

### 4. **Diseño Lógico**
   - **Objetivo:** Mapear el esquema conceptual a un modelo de datos que pueda implementarse en el sistema de gestión de bases de datos (DBMS) seleccionado, es decir en nuestro caso, mapear el esquema conceptual a un modelo relacional.
   - **Resultado:** Un esquema lógico que traduce las entidades y relaciones en tablas relacionales, incluyendo claves primarias y foráneas.
   - **Ejemplo:** Convertir la entidad "Libro" en una tabla con columnas como `ISBN`, `Título` y `Autor`.

---

### 5. **Diseño Físico**
   - **Objetivo:** Especificar los detalles de almacenamiento físico, como índices, particionamiento y configuración de rendimiento.
   - **Resultado:** Un esquema físico optimizado para el DBMS seleccionado.
   - **Ejemplo:** Crear un índice en la columna `ISBN` para mejorar el tiempo de respuesta en las consultas.

---

## Importancia de un Diseño Bien Planeado

Aunque el esquema físico de una base de datos puede modificarse con relativa facilidad, los cambios en el esquema lógico o conceptual son más complejos, ya que afectan consultas y actualizaciones en el código de la aplicación. Por esta razón, es crucial llevar a cabo las fases iniciales del diseño con cuidado y precisión antes de construir el resto de la aplicación.

Un diseño bien elaborado no solo asegura que la base de datos cumpla con los requisitos actuales, sino que también proporciona flexibilidad para adaptarse a futuras necesidades del negocio. Este enfoque estructurado minimiza el riesgo de errores, redundancias y problemas de mantenimiento en la base de datos. 

---

# Diseño de Bases de Datos: Modelo Entidad-Relación para Aplicación de Transporte Aéreo

En este ejercicio, diseñaremos la base de datos para una aplicación de transporte exclusivo para el personal de una aerolínea llamada **Cómoda y Segura**. Esta aplicación, similar a Uber pero con restricciones, está destinada únicamente a empleados de la aerolínea y no requiere pagos directos, ya que los costos se deducen automáticamente de una tarjeta corporativa. Para efectos de nuestro ejemplo, la aplicación se llamará **AeroTaxi**.

## Funcionalidad Abordada
Nos enfocaremos en el diseño para los **usuarios de la aplicación**, es decir, el personal de la aerolínea que solicita servicios de transporte. Este diseño incluirá el registro de los empleados, la solicitud de servicios y el manejo de la ubicación para el transporte.

---

## FASE DE REQUISITOS:

1. **Registro de Usuarios:** Los empleados de la aerolínea deben poder registrarse en la aplicación proporcionando sus datos personales.
2. **Solicitud de Transporte:** Los usuarios deben poder solicitar un servicio ingresando una dirección manualmente o seleccionándola en un mapa.
3. **Asignación de Conductores:** El sistema debe permitir asociar automáticamente un conductor disponible a cada solicitud.
4. **Gestión de Ubicaciones Frecuentes:** Los usuarios deben poder almacenar direcciones de uso común para simplificar futuras solicitudes.
5. **Historial de Solicitudes:** Los usuarios deben poder consultar un historial de servicios de transporte realizados.

## FASE DE ESPECIFICACIÓN FUNCIONAL

#### **Usuarios**
- **Registrar usuario:** Insertar un nuevo usuario con sus datos personales.
- **Consultar usuario:** Obtener información del usuario a partir de su ID.
- **Actualizar usuario:** Modificar los datos de un usuario existente, como teléfono o rol.
- **Eliminar usuario:** Borrar un registro de usuario (solo para administradores).

#### **Solicitudes de Transporte**
- **Crear solicitud:** Insertar una nueva solicitud de transporte con detalles como ubicación de origen, destino, y hora.
- **Consultar solicitud:** Recuperar una solicitud específica o un conjunto de solicitudes (por ejemplo, historial).
- **Actualizar solicitud:** Cambiar el estado de una solicitud (por ejemplo, "en proceso" o "completada").
- **Eliminar solicitud:** Borrar una solicitud (por ejemplo, en caso de error).

#### **Ubicaciones Frecuentes**
- **Agregar ubicación:** Asociar una nueva dirección al usuario.
- **Consultar ubicaciones:** Obtener todas las ubicaciones frecuentes de un usuario.
- **Eliminar ubicación:** Quitar una dirección de la lista de ubicaciones frecuentes.

#### **Conductores y Vehículos**
- **Registrar conductor:** Insertar un nuevo conductor con sus datos personales.
- **Consultar conductores:** Obtener una lista de conductores disponibles.
- **Asignar vehículo:** Asociar un vehículo específico a un conductor.
- **Consultar vehículos:** Recuperar datos de vehículos disponibles o asignados.

> Nota👨🏻‍💻: Por convención para la clase, todos los nombres de entidades, relaciones y atributos, en este y todos los diagramas seguirán la convención snake_case. Consulte [aquí](https://es.wikipedia.org/wiki/Snake_case) para más detalles.
---
> Nota 2👉: Existen varias notaciones para el modelo entidad relación, para este caso usaremos la notación Chen por ser la usada en el libro de referencia, sin embargo se puede suar cualquier notación. Para mas información entrar [aquí](https://www.lucidchart.com/pages/es/que-es-un-diagrama-entidad-relacion).
---
> Nota 3 ➡️: Los diagramas pueden ser encontrados el el siguiente [link](https://drive.google.com/file/d/1tTywcj2pOB-zwR_5SGhG86gkkUaKcTG4/view?usp=sharing).

## DISEÑO CONCEPTUAL USANDO EL MODELO ENTIDAD-RELACIÓN (E-R)
El modelo entidad relación describe la estructura de la base de datos a través de un diagrama que es conocido como el Diagrama Entidad-Relación (ER Diagram). Un modelo ER es un diseño o blueprint de una base de datos que posteriormente puede implementarse como base de datos. Los componentes principales del modelo E-R son: **conjunto de entidades (entity sets)**  y **conjunto de relaciones (relationship set)**.

### Conceptos Fundamentales

#### **1: Entidad (Entity):**
Una entidad es una "cosa" u ""objeto" en el mundo real que se distingue de todos los demás objetos.  

- **Ejemplo en nuestra aplicación:**
  - Un **usuario** registrado en la aplicación.
  - Un **vehículo** asignado para el transporte.

#### **2: Conjunto de Entidades:**
Un conjunto de entidades representa un grupo de objetos del mismo tipo que comparten las mismas propiedades o atributos. <span style="color:#ff0000">Un conjunto de entidades es representado en el diagrama ER por medio de un rectangulo.</span>

- **Ejemplo en nuestra aplicación:**
  - El conjunto de entidades **Usuario** incluye a todos los empleados que utilizan la aplicación.
  - El conjunto de entidades **Vehículo** incluye a todos los vehículos disponibles para transporte.

#### **3. Atributos:**
Una entidad está representada por un conjunto de atributos. Los atributos son propiedades descriptivas que posee cada miembro de una entidad. Cada entidad tiene un **valor** para cada uno de sus atributos. <span style="color:#ff0000">Un atributo es representado en el diagrama ER por medio un ovalo.</span>

- **Ejemplo en nuestra aplicación:**
  - Los atributos del conjunto de entidades **Usuario** incluyen: `id_usuario`, `nombre`, `apellido`, `email`, `telefono` y `rol`.
  - Los atributos del conjunto de entidades **Vehículo** incluyen?

#### **4. Relaciones:** 
Una relación es una asociación entre 2 o más entidades. 
- **Ejemplo en nuestra aplicación:**
  - Podemos definir una relación **solicita** cuando el usuario Javier solicita un servicio de transporte en la aplicación. 

#### **5. Conjunto de Relaciones (Relationship Sets)**
Representan asociaciones entre dos o más conjuntos de entidades. Normalmente las relaciones son binarias (2 conjuntos de entidades), pero hay ocasiones en las que una relación puede involucrar más de 2 entidades. <span style="color:#ff0000">Un conjunto de relaciones es representado en el diagrama ER por medio un rombo.</span>

EL grado de una relación se mide por el número de conjuntos de entidades que participan en una relación, es decir, si 2 conjuntos de entidades participan en una relación, se dice que el grado de la relación es 2. 
- **Ejemplo en nuestra aplicación:**
  - El conjunto de relaciones **Solicita** describe todas las solicitudes de transporte realizadas por los usuarios.

#### **6. Instancia de una relación (Relationship instance):**
Una instancia de relación en un esquema ER representa la asociación entre entidades del mundo real que se esta diseñando. Por ejemplo, la entidad vehiculo y la entidad conductor puede ser instanciada de la siguiente manera:

```plaintext
Vehículo                Conductor
Peugeot 206 - ZSE123    Javier Monroy
Mazda 3 - RFE453        Jose López
```

#### **7. Atributos de Relaciones**
Una relación puede tener atributos adicionales que describen la interacción. 

- **Ejemplo en nuestra aplicación:**
  - La relación **solicita** puede incluir atributos como `fecha`, `hora` y `direccion`, que describen la solicitud de transporte realizada por un usuario.

### Atributos Complejos
#### **1. Atributos Simples y Compuestos**
- **Simples**: No pueden dividirse en partes más pequeñas. Ejemplo: `email`.
- **Compuestos**: Pueden subdividirse. Ejemplo: `nombre_completo` puede dividirse en `nombre` y `apellido`.

#### **2. Atributos univaluados y multivaluados (Single-Valued y Multivalued)**:
- **Univaluados**: Un atributo univaluado tiene un único valor asociado con cada entidad. No puede contener múltiples valores para una misma instancia. El atributo `email` en la entidad **usuario** es univaluado, ya que cada usuario tiene un único correo electrónico registrado.

- **Multivaluados**: Un atributo multivaluado puede contener un conjunto de valores asociados con una sola entidad. El número de valores puede variar entre instancias de la entidad. El atributo `ubicaciones_frecuentes` en la entidad **usuario** es multivaluado, ya que un usuario puede tener varias direcciones registradas como ubicaciones frecuentes (por ejemplo, "Casa", "Oficina", "Aeropuerto", "Amorcito" 😅). <span style="color:#ff0000">Un atributo multivaluado es representado en el diagrama ER por medio de un ovalo doble.</span>

#### **3. Atributos Derivados:**
El valor de un atributo derivado se calcula a partir de otros atributos relacionados o entidades asociadas. Estos valores no se almacenan directamente, sino que se **computan** cuando son necesarios. El atributo `edad` en la entidad **usuario** es derivado, ya que su valor puede calcularse a partir del atributo `fecha_nacimiento` y la fecha actual. <span style="color:#ff0000">Un atributo derivado es representado en el diagrama ER por medio un ovalo con linea punteada.</span>

### Mapping Cardinalities
Las cardinalidades en un modelo ER especifican la cantidad de instancias de una entidad que pueden estar asociadas con una instancia de otra entidad en una relación. A continuación, explicaremos las cardinalidades con ejemplos basados en nuestra aplicación de transporte **AeroTaxi**.

#### **Uno-a-Uno (One-to-one) - 1:1:** 
En una relación 1:1, cada instancia de una entidad está asociada con exactamente una instancia de otra entidad, y viceversa.

- **Ejemplo en nuestra aplicación:**
Un conductor puede estar asignado a **un único vehículo**, y cada vehículo solo puede estar asignado a un conductor.

#### **Uno-a-Muchos (One-to-Many) - 1:N:** 
En una relación 1:N, una instancia de una entidad puede estar asociada con múltiples instancias de otra entidad, pero cada instancia de la segunda entidad está asociada con una sola instancia de la primera.

- **Ejemplo en nuestra aplicación:**
Un usuario puede tener múltiples ubicaciones frecuentes, pero cada ubicación frecuente pertenece a un único usuario.

#### **Muchos-a-Uno (Many-to-One) - N:1:** 
En una relación N:1, múltiples instancias de una entidad pueden estar asociadas con una única instancia de otra entidad.

- **Ejemplo en nuestra aplicación:**
Muchos vehículos están asociados a una única empresa transportadora.
- Explicación:
  - La empresa "Mi Vehículo Seguro" es propietaria de todos los vehículos.
  - Cada vehículo pertenece exclusivamente a una empresa.

#### **Muchos-a-Muchos (Many-to-Many) - M:N:** 
En una relación M:N, múltiples instancias de una entidad pueden estar asociadas con múltiples instancias de otra entidad.

- **Ejemplo en nuestra aplicación:**
Un usuario puede solicitar múltiples servicios de transporte, y cada servicio puede ser solicitado por múltiples usuarios (por ejemplo, en un caso donde un grupo de empleados comparte un viaje).
- Explicación:
  - Los usuarios realizan solicitudes de transporte.
  - Un servicio puede incluir a más de un usuario (por ejemplo, un viaje compartido).

### Restricciones de Cardinalidad Mínima y Máxima en Diagramas E-R
En los diagramas ER, las líneas que conectan entidades con relaciones pueden incluir restricciones de cardinalidad mínima y máxima. Estas restricciones permiten definir con mayor precisión cuántas veces una entidad puede participar en una relación. Estas restricciones se pueden representar de la forma `l..h` donde:
- **Cardinalidad Mínima (`l`):**
  - Define el número mínimo de veces que una entidad debe participar en una relación.
  - Un valor de 1 indica participación total, es decir, la entidad debe aparecer al menos una vez en la relación.
  - Un valor de 0 indica que la participación es opcional.
- **Cardinalidad Máxima (`h`):**
  - Define el número máximo de veces que una entidad puede participar en una relación.
  - Un valor de 1 indica que la entidad puede participar en una sola relación.
  - Un valor de * (asterisco) indica que no hay límite en la participación.

- **Ejemplo en nuestra aplicación:**
  - Cada vehículo debe estar asociado a una empresa transportadora y una empresa puede tener ninguno o varios vehiculos.

### Participación Total y Parcial de Entidades en Relaciones
En un modelo Entidad-Relación (E-R), la participación de un conjunto de entidades `𝐸` en un conjunto de relaciones 
`𝑅` describe si todas o solo algunas entidades en `𝐸` están asociadas con al menos una relación en `𝑅`.

- **Participación total**: Se dice que la participación de una entidad `𝐸` en una relación `R` es total si todas las entidades en `𝐸` participan en al menos una relación en `𝑅`. Se representa con doble linea en el diagrama ER.

  - Ejemplo: Cada vehículo debe estar asociado a una empresa transportadora, reflejado con una línea doble.
Esto asegura que no haya vehículos "huérfanos" en el sistema.

- **Participación parcial**: Se dice que la participación de una entidad `E` en una relación `𝑅` es parcial si es posible que algunas entidades en `𝐸` no participen en ninguna relación en `𝑅`.

  - **Ejemplo en nuestra aplicación:** Las empresas transportadoras pueden existir en el sistema aunque no tengan vehículos asignados, reflejado con una línea simple.

### Entidades fuertes y débiles
De todos los tipos de atributos, uno de los mas importante que debes conocer son los atributos de clave primaria y foránea. El mismo concepto de llave primaria y llave foranea del modelo relacional aplica a este modelo, es decir, las claves primarias son los atributos que permiten identificar a una fila de otra. Gracias a eso otorgan un valor único a cada fila. <span style="color:#ff0000">Se representan con un atributo con el título subrayado.</span>

- **Entidades Fuertes**:
Una entidad fuerte tiene una clave primaria propia que permite identificar de manera única a cada instancia. No depende de ninguna otra entidad para existir. <span style="color:#ff0000">Se representan de la misma forma que una entidad normal.</span>.
  - Ejemplo: `Usuario` Representa a los empleados que utilizan la aplicación. Cada usuario tiene un identificador único `id_usuario`, que actúa como clave primaria. Esta entidad no depende de ninguna otra para su existencia.

- **Entidades débiles**: Una entidad débil no puede existir sin una entidad fuerte de la que depende. Su identificación requiere combinar su clave foranea con la clave primaria de la entidad fuerte asociada. <span style="color:#ff0000">Se representan con un rectangulo doble.</span>

  - Ejemplo: `Ubicaciones Frecuentes` - Representa las direcciones frecuentes asociadas a un usuario. Cada ubicación tiene una clave parcial `id_ubicacion`, pero necesita la clave primaria de la entidad Usuario (`id_usuario`) para ser identificada de manera única. Sin el usuario, estas ubicaciones no tienen sentido dentro del sistema.i

## Otras notaciones

Consulte [aquí](- https://www.lucidchart.com/pages/es/que-es-un-diagrama-entidad-relacion) para ver otras notaciones usadas para el diagrama ER.

- Notación de Martin y notación patas de gallo
- Notación de Bachman
- Notación de IDEF1X
- Notación de Barker

## Pasos para crear un diagrama ER
En estos 5 pasos puedes crear tu diagrama entidad relación:

1. Identificación de entidades
2. Identificación de las relaciones
3. Identificación de la cardinalidad de las relaciones
4. Identificación de atributos
5. Create el diagrama ER

## Mejores prácticas para desarrollar efectivamente un diagrama ER
- Eliminar entidades y relaciones redundantes
- Debe asegurarse de que todas sus entidades y relaciones estén etiquetadas correctamente
- Puede haber varios enfoques válidos para un diagrama ER. Debe asegurarse de que el diagrama ER admita todos los datos que necesita almacenar.
- Debe asegurarse de que cada entidad solo aparezca una vez en el diagrama ER
- Nombra cada relación, entidad y atributo que esté representado en tu diagrama.
- Nunca conectes las relaciones entre sí
- Debes usar colores para resaltar partes importantes del diagrama ER.

## Ejercicio en clase
Terminar el modelo entidad relación de la aplicación **AeroTaxi** con base en los requerimientos y la especificación funcional (Fase 1 y 2).


## Bibliografía
- Silberschatz, A., Korth, H. F., & Sudarshan, S. (2019). Database System Concepts (7th ed.). McGraw Hill Education.
- https://www.lucidchart.com/pages/es/que-es-un-diagrama-entidad-relacion
- https://www.du.ac.in/du/uploads/departments/Operational%20Research/24042020_E-R%20Model.pdf
- https://www.gleek.io/blog/er-model-cardinality



 