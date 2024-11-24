# Diseño de Bases de Datos usando el modelo Entidad-Relación

Hasta este punto, hemos explorado los conceptos básicos de las bases de datos y el modelo relacional, adquiriendo una comprensión de sus fundamentos y principios. En esta clase, aprenderemos cómo transformar una necesidad, un requerimiento de negocio o incluso una simple idea en un diseño sólido que pueda derivar en un modelo relacional, incorporando relaciones y restricciones que cumplan con esos requerimientos.

El diseño de bases de datos es un proceso que exige atención al detalle y un profundo entendimiento del contexto del negocio. El rol del diseñador es clave, ya que su responsabilidad principal es traducir dichas necesidades en representaciones claras, organizadas en entidades y atributos dentro de la base de datos. Este proceso de diseño no solo es importante, sino que resulta esencial para garantizar que la base de datos satisfaga eficazmente las necesidades del negocio.

## Fases del diseño
1. **Fases de Requisitos**  : Se identifican y documentan las necesidades de datos a través de interacciones con expertos y usuarios. El resultado de esta fase es una especificación de los requerimientos de usuario que puede realizarse usando algún estandar de la industria como el IEEE 830 pero para efectos de este curso definiremos los requerimientos con descripciones textuales claras.

2. **Especificación funcional:** Definir operaciones que se realizarán en la base de datos (consultas, actualizaciones, eliminación de datos, navegación de historia).

- **Diagramación y transformación lógica**  

  - **Diseño conceptual:** Uso de modelos de datos (como el modelo entidad-relación) para representar entidades, atributos y relaciones, y creación del diagrama entidad-relación (E-R).
  - **Diseño lógico y físico:** Mapear el esquema conceptual a un modelo relacional en la fase lógica; en la fase física, se optimizan el almacenamiento y las estructuras de índice.
  - **Revisión y optimización:** Confirmar que los requisitos están cubiertos, **eliminar redundancias** y eliminar conflictos lógicos. E.G. referencias cíclicas

**Revisión y Optimización**

- Confirmar que los requisitos están cubiertos, eliminar redundancias y eliminar conflictos lógicos. E.G. referencias cíclicas.