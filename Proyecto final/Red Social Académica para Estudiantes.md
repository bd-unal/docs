# Red Social Académica para Estudiantes

## Objetivo

El objetivo de este proyecto es desarrollar una base de datos relacional para una red social académica que facilite la interacción entre estudiantes de una universidad. En esta plataforma, los estudiantes pueden crear perfiles, unirse a grupos temáticos, publicar contenido académico, y comentar en las publicaciones de otros estudiantes. La base de datos debe permitir la gestión de perfiles, conexiones entre estudiantes, publicaciones, comentarios, y recomendaciones de contenido basado en áreas de interés. El sistema será capaz de generar reportes sobre la actividad de los usuarios y la popularidad de temas específicos, además de enviar alertas sobre nuevas publicaciones en los grupos de interés de cada estudiante.

## Motivación

Este proyecto es especialmente motivador porque permite a los estudiantes aplicar sus conocimientos en el desarrollo de una plataforma que simula una red social, un tipo de sistema que ya conocen y utilizan en su vida diaria. Además, la plataforma está enfocada en el ámbito académico, lo que ayuda a reforzar la idea de que las bases de datos pueden ser herramientas poderosas para crear entornos de colaboración y aprendizaje. A lo largo del proyecto, los estudiantes tendrán la oportunidad de aplicar conocimientos fundamentales y avanzados de bases de datos en un contexto que les resulta relevante y cercano.

## Entregas

### **Entrega 1: Diseño Conceptual y Físico de la Base de Datos**

- **Descripción:** En la primera entrega, los estudiantes diseñarán el modelo conceptual y el modelo físico de la base de datos. Esto incluye la definición de las tablas y sus relaciones en SQL, tomando en cuenta las entidades necesarias para construir una red social funcional.
- **Temas a cubrir:**
    - **Modelo Entidad-Relación (ER):** Diseño del modelo conceptual que incluya entidades principales como Estudiantes, Publicaciones, Comentarios, Grupos y Seguidores.
    - **Normalización:** Aplicación de normalización hasta la tercera forma normal (3NF) para optimizar la estructura y evitar redundancia.
    - **Creación en SQL (DDL):** Implementación del modelo físico en SQL, con la creación de tablas, relaciones y restricciones de integridad.
- **Objetivos de aprendizaje:** Comprender y aplicar el diseño de bases de datos relacionales, asegurando una estructura clara y normalizada; usar SQL DDL para la implementación de la base de datos.
- **Entrega esperada:**
    - **Diagramas**
        - Diagrama Entidad-Relación
        - Modelo conceptual
        - Modelo lógico
        - Modelo físico
    - **Script SQL del modelo físico:** Código que crea las tablas y define las relaciones y restricciones de integridad.

### **Entrega 2: Población de Datos y Consultas de Interacción Social**

- **Descripción:** En esta segunda entrega, los estudiantes deben poblar la base de datos con datos ficticios de usuarios, publicaciones, y comentarios, y desarrollar consultas SQL para generar reportes sobre las interacciones de los estudiantes.
- **Temas a cubrir:**
    - **DML (Data Manipulation Language):** Inserción de datos ficticios en las tablas de usuarios, publicaciones, comentarios y conexiones entre estudiantes.
    - **Consultas en SQL (DQL):** Creación de consultas avanzadas que permitan obtener reportes como publicaciones más comentadas, publicaciones recientes en un grupo específico, y estudiantes más activos.
- **Objetivos de aprendizaje:** Aplicar SQL DML para poblar la base de datos con datos de prueba, y desarrollar consultas DQL para obtener información relevante de la red social.
- **Entrega esperada:**
    - **Script de Población de Datos:** Código SQL para insertar datos ficticios que simulen la actividad en la red social.
    - **Consultas de Reporte:** Consultas SQL para obtener estadísticas como publicaciones populares, temas más comentados y lista de miembros de un grupo específico.

### **Entrega 3: Funcionalidades Avanzadas, Recomendaciones de Contenido y Documentación Final**

- **Descripción:** En esta última entrega, los estudiantes implementarán funcionalidades avanzadas, como triggers para notificaciones automáticas sobre nuevas publicaciones en los grupos de interés, y procedimientos almacenados para recomendaciones de contenido en función de los temas de interés de cada usuario. También deberán documentar el proyecto completo.
- **Temas a cubrir:**
    - **Transacciones y Triggers:** Implementación de triggers para enviar notificaciones cuando se publica nuevo contenido en los grupos de interés de cada usuario.
    - **Procedimientos Almacenados para Recomendaciones:** Crear procedimientos almacenados que analicen los temas más vistos por cada usuario y generen recomendaciones de contenido similar.
    - **Optimización con Índices:** Aplicar índices en columnas clave para optimizar el acceso a datos y mejorar el rendimiento de las consultas.
- **Objetivos de aprendizaje:** Usar transacciones, triggers y procedimientos almacenados para mejorar la automatización y personalización del sistema; optimizar consultas mediante la indexación de columnas clave.
- **Entrega esperada:**
    - **Script de Transacciones, Triggers y Procedimientos Almacenados:** Código que implemente las notificaciones y recomendaciones.
    - **Documentación Final:** Explicación del diseño de la base de datos, los reportes de interacción social y las funcionalidades avanzadas implementadas.
    - **Interfaz de Visualización:** Visualizar el feed o muro de publicaciones para cada grupo de interes por usuario.
    - **Presentación del Proyecto:** Exposición final donde se demuestre el diseño, implementación y resultado final.