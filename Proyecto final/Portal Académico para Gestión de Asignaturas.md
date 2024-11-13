# Portal Académico para Gestión de Asignaturas

## **Objetivo**

Este proyecto busca desarrollar una base de datos relacional para un portal académico que gestione asignaturas universitarias, sus créditos, requisitos y cupos disponibles. El sistema permitirá que los estudiantes se inscriban en asignaturas, consulten sus requisitos, vean los profesores que las dictan, y puedan cancelarlas si es necesario. La base de datos también debe registrar la relación entre estudiantes, asignaturas, y profesores, para generar reportes sobre la ocupación de cupos y las asignaturas en curso para cada estudiante y docente.

## **Motivación**

Este proyecto es fundamental en el contexto universitario, permitiendo a los estudiantes gestionar de forma autónoma sus inscripciones y ayudando a los docentes a supervisar la asignación de cupos en sus clases. La estructura de datos también refuerza conceptos importantes de bases de datos como relaciones de muchos a muchos, integridad referencial y manejo de restricciones. Además, al simular un portal académico, los estudiantes podrán aplicar los conocimientos adquiridos en un entorno familiar y práctico.

---

### Entregas

### **Entrega 1: Diseño Conceptual y Físico de la Base de Datos**

- **Descripción:** En esta primera entrega, los estudiantes diseñarán el modelo entidad-relación (ER) y el modelo físico de la base de datos, estructurando las entidades y relaciones necesarias para el sistema de gestión de asignaturas.
- **Temas a cubrir:**
    - **Modelo Entidad-Relación (ER):** Crear el modelo conceptual de la base de datos, definiendo entidades como Asignaturas, Estudiantes, Profesores, Inscripciones y Requisitos.
    - **Normalización:** Aplicar la normalización hasta la tercera forma normal (3NF) para evitar redundancias y asegurar la integridad de los datos.
    - **Creación en SQL (DDL):** Generar el modelo físico en SQL, creando las tablas, relaciones, y restricciones de integridad necesarias.
- **Entrega esperada:**
    - **Diagramas**
        - Diagrama Entidad-Relación
        - Modelo conceptual
        - Modelo lógico
        - Modelo físico
    - **Script SQL del modelo físico:** Código que crea las tablas y define las relaciones y restricciones de integridad.

---

### **Entrega 2: Población de Datos y Consultas para Gestión de Asignaturas**

- **Descripción:** En esta segunda entrega, los estudiantes deben poblar la base de datos con datos ficticios de estudiantes, asignaturas, profesores y requisitos. También deben desarrollar consultas SQL para la gestión de inscripciones y requisitos.
- **Temas a cubrir:**
    - **DML (Data Manipulation Language):** Inserción de datos ficticios en las tablas para simular la asignación de estudiantes, profesores, y requisitos de cada asignatura.
    - **Consultas en SQL (DQL):** Crear consultas avanzadas para obtener reportes como asignaturas disponibles por estudiante, cupos restantes, profesores asignados, y verificar si un estudiante cumple con los requisitos para inscribir una asignatura.
- **Objetivos de aprendizaje:** Usar SQL DML para poblar la base de datos y desarrollar consultas DQL que respondan a las necesidades de gestión de un sistema académico.
- **Entrega esperada:**
    - **Script de Población de Datos:** Código SQL para insertar datos ficticios que simulen la actividad en la red social.
    - **Consultas de Reporte:** Consultas SQL para obtener estadísticas como publicaciones populares, temas más comentados y lista de miembros de un grupo específico.

---

### **Entrega 3: Funcionalidades Avanzadas, Gestión de Inscripciones y Documentación Final**

- **Descripción:** En la última entrega, los estudiantes implementarán funcionalidades avanzadas, como transacciones para inscribir y cancelar asignaturas, triggers para actualizar el estado de los cupos automáticamente y procedimientos almacenados para verificar los requisitos de inscripción. Además, deberán documentar el proyecto completo.
- **Temas a cubrir:**
    - **Transacciones:** Implementar transacciones que aseguren la integridad al momento de inscribir o cancelar una asignatura, actualizando cupos y eliminando registros según sea necesario.
    - **Triggers y Procedimientos Almacenados:** Crear triggers que actualicen el número de cupos al registrar o cancelar una inscripción, y procedimientos almacenados que verifiquen si un estudiante cumple con los requisitos de una asignatura antes de inscribirla.
    - **Optimización con Índices:** Añadir índices en columnas clave para mejorar la eficiencia de las consultas frecuentes (ej., búsqueda de asignaturas por requisitos o cupos).
- **Objetivos de aprendizaje:** Usar transacciones, triggers y procedimientos almacenados para automatizar procesos en la base de datos y asegurar la integridad en operaciones críticas.
- **Entrega esperada:**
    - **Script de Transacciones, Triggers y Procedimientos Almacenados:** Código que implemente las funcionalidades de inscripción y cancelación.
    - **Documentación Final:** Explicación del diseño de la base de datos y las funcionalidades avanzadas implementadas.
    - **Interfaz de Visualización:** Una interfaz donde el estudiante pueda inscribir y cancelar asignaturas.
    - **Presentación del Proyecto:** Exposición final donde se demuestre el diseño, implementación y resultado final.