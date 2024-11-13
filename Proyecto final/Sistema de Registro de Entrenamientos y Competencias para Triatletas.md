# Sistema de Registro de Entrenamientos y Competencias para Triatletas

## Objetivo

El objetivo principal de este proyecto es desarrollar una base de datos relacional que permita a triatletas registrar, analizar y mejorar su rendimiento en cada una de las disciplinas del triatlón: natación, ciclismo y running. La base de datos debe almacenar datos relevantes de entrenamientos y competencias, como distancias, tiempos, velocidades y otros indicadores de rendimiento, permitiendo así que los triatletas obtengan reportes detallados y personalizados de su evolución. A través de funcionalidades avanzadas, como alertas de nuevos récords personales y cálculos de promedios, el sistema ofrecerá una visión integral del progreso de cada atleta, ayudándoles a establecer y alcanzar metas específicas.

## Motivación

En el mundo deportivo, especialmente en disciplinas de resistencia como el triatlón, el análisis de datos es crucial para planificar entrenamientos y maximizar el rendimiento. Un sistema como este ayuda a los atletas a identificar sus fortalezas y debilidades, así como a hacer ajustes informados en su plan de entrenamiento.

Este proyecto abarca todos los temas del curso de bases de datos, desde el diseño inicial hasta la optimización de consultas avanzadas. Cada fase está diseñada para que los estudiantes comprendan cómo se estructura y gestiona una base de datos robusta, cómo se optimiza para consultas de análisis, y cómo se conecta con aplicaciones externas para su uso en el día a día. Este enfoque motiva a los estudiantes a ver la utilidad práctica de sus habilidades, fomentando el aprendizaje a través de un tema que combina tecnología y rendimiento deportivo.

## Entregas

### **Entrega 1: Diseño Conceptual y Físico de la Base de Datos**

- **Descripción:** En esta primera entrega, los estudiantes deberán realizar el diseño conceptual y el modelo físico de la base de datos, incluyendo la creación de tablas y sus relaciones en SQL.
- **Temas a cubrir:**
    - **Modelo Entidad-Relación (ER):** Crear el modelo conceptual de la base de datos, definiendo entidades y relaciones principales como Atletas, Entrenamientos, Competencias y Disciplinas.
    - **Normalización:** Aplicar normalización hasta la tercera forma normal (3NF) para optimizar la estructura y evitar redundancia.
    - **Creación en SQL (DDL):** Generar el esquema de la base de datos en SQL, creando tablas, relaciones y restricciones de integridad.
- **Objetivos de aprendizaje:** Comprender el diseño de bases de datos relacionales y la normalización, y aplicar SQL DDL para implementar el modelo físico.
- **Entrega esperada:**
    - **Diagramas**
        - Diagrama Entidad-Relación
        - Modelo conceptual
        - Modelo lógico
        - Modelo físico
    - **Script SQL para el modelo físico:** Código de creación de tablas y relaciones en SQL, incluyendo restricciones de integridad.

### **Entrega 2: Población de Datos y Consultas de Análisis de Rendimiento**

- **Descripción:** En esta segunda entrega, los estudiantes deben poblar la base de datos con datos ficticios de entrenamientos y competencias, y realizar consultas SQL para obtener estadísticas clave de rendimiento.
- **Temas a cubrir:**
    - **DML (Data Manipulation Language):** Insertar datos ficticios en las tablas de atletas, entrenamientos, y competencias.
    - **Consultas en SQL (DQL):** Crear consultas avanzadas para obtener reportes de rendimiento, como tiempos promedio en cada disciplina, mejores tiempos y clasificación en competencias.
- **Objetivos de aprendizaje:** Usar SQL DML para manipular datos, y practicar DQL para generar reportes de análisis de rendimiento.
- **Entrega esperada:**
    - **Script de Población de Datos:** Código SQL para insertar datos ficticios.
    - **Consultas de Reporte:** Consultas SQL que generen reportes como “mejor tiempo por disciplina”, “velocidad promedio en ciclismo” y “posición en competencias”.

### **Entrega 3: Implementación de Funcionalidades Avanzadas y Documentación Final**

- **Descripción:** En la última entrega, los estudiantes deben implementar funcionalidades avanzadas en la base de datos, incluyendo transacciones, triggers para alertas de rendimiento, y procedimientos almacenados para cálculos específicos. También deben documentar el proyecto completo y conectar la base de datos con una aplicación en cualquier lenguaje de programación que permita visualizar una parte específica como puede ser la visualización de los entrenamientos de los triatletas.
- **Temas a cubrir:**
    - **Transacciones:** Implementar transacciones que aseguren la consistencia al registrar nuevos entrenamientos o competencias.
    - **Triggers y Procedimientos Almacenados:** Crear un trigger que genere una alerta si se registra un nuevo récord personal y un procedimiento almacenado que calcule el promedio de velocidad en cada disciplina.
    - **Optimización con Índices:** Añadir índices en columnas clave para mejorar la eficiencia de consultas.
- **Objetivos de aprendizaje:** Usar transacciones y funcionalidades avanzadas de SQL para mejorar la automatización, y optimizar el acceso a datos mediante índices.
- **Entrega esperada:**
    - **Script de Transacciones, Triggers y Procedimientos Almacenados:** Código que implemente las transacciones, triggers y procedimientos descritos.
    - **Documentación Final del Proyecto:** Explicación completa del diseño de la base de datos, las consultas de rendimiento y las funcionalidades avanzadas.
    - **Interfaz de Visualización:** Crear una aplicación que permita al usuario ver su rendimiento y comparar tiempos  (si puede ser gráficamente mejor).
    - **Presentación del Proyecto:** Exposición final donde se demuestre el diseño, implementación y resultado final.