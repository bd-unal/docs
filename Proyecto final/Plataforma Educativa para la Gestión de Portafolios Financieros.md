# Plataforma Educativa para la Gestión de Portafolios Financieros

## Simulación de Inversiones en el Mercado de Valores

### Objetivo

El objetivo de este proyecto es que los estudiantes aprendan a abstraer, diseñar e implementar un modelo de base de datos para una plataforma de aprendizaje en línea, centrada en el mercado de valores. Con esta aplicación, los usuarios podrán registrarse utilizando solo su correo electrónico y recibirán una cantidad de dinero virtual (por ejemplo, 10 dólares a la semana) para invertir en un mercado simulado. Este mercado simulado imitará el comportamiento real de las acciones y otros instrumentos financieros (como opciones y ETF).

Los estudiantes deberán entender algunos conceptos básicos de cómo funcionan la compra y venta de acciones, de manera que puedan construir un sistema que permita a los usuarios:

- **Invertir dinero virtual** en acciones y opciones.
- **Ver sus transacciones** (compras y ventas realizadas).
- **Obtener reportes** sobre el desempeño de sus inversiones, tanto de manera general (todo su portafolio) como detallada (cada acción u opción específica).

De esta manera, el modelo de base de datos deberá almacenar y organizar los datos de manera que la aplicación pueda mostrar información en tiempo real sobre cómo se comportan los valores en el mercado, reflejando ganancias o pérdidas.

### Motivación

Este proyecto permitirá a los estudiantes no solo familiarizarse con el diseño y la gestión de bases de datos, sino también introducirse en el mundo de las inversiones y los mercados financieros. Aunque este tema no suele ser común en la vida académica, es relevante en la economía global. Entender cómo funciona el mercado de valores y cómo invertir de forma informada son conocimientos que pueden ser muy valiosos, tanto a nivel profesional como personal.

Además, este proyecto les permitirá desarrollar habilidades importantes para la vida como ingenieros, ayudándoles a ver el valor de la educación financiera y cómo esta puede contribuir a una vida económica más estable y próspera.

## Entregas

### **Entrega 1: Diseño Conceptual y Físico de la Base de Datos**

- **Descripción:** En esta primera entrega, los estudiantes desarrollarán el modelo conceptual y físico de la base de datos para la plataforma de simulación de inversiones. Esto incluye la definición de las tablas y relaciones necesarias en SQL para representar usuarios, activos financieros, transacciones y el dinero virtual.
- **Temas a cubrir:**
    - **Modelo Entidad-Relación (ER):** Crear el modelo conceptual que incluya entidades clave como Usuario, Portafolio, Activo Financiero, Transacción, y Reporte.
    - **Normalización:** Aplicar normalización hasta la tercera forma normal (3NF) para reducir redundancia y mejorar el rendimiento de la base de datos.
    - **Creación en SQL (DDL):** Implementación del modelo físico en SQL, incluyendo la creación de tablas, relaciones y restricciones de integridad.
- **Objetivos de aprendizaje:**
    - Comprender y aplicar conceptos de diseño de bases de datos relacionales, asegurando una estructura clara y normalizada.
    - Utilizar SQL DDL para la creación y organización de la base de datos.
- **Entrega esperada:**
    - **Diagramas:**
        - Diagrama Entidad-Relación
        - Modelo conceptual
        - Modelo lógico
        - Modelo físico
    - **Script SQL del modelo físico:** Código que crea las tablas y define las relaciones y restricciones de integridad.

---

### **Entrega 2: Población de Datos y Consultas de Simulación de Inversiones**

- **Descripción:** En esta segunda entrega, los estudiantes poblarán la base de datos con datos ficticios de usuarios, activos financieros y transacciones. Además, deberán crear consultas SQL que permitan obtener reportes sobre el desempeño del portafolio de cada usuario y sus transacciones.
- **Temas a cubrir:**
    - **DML (Data Manipulation Language):** Insertar datos ficticios para simular la actividad en el mercado (usuarios, activos financieros y transacciones).
    - **Consultas SQL (DQL):** Desarrollar consultas para obtener reportes como el valor actual del portafolio del usuario, el historial de compras y ventas de acciones, y la rentabilidad de cada activo en el tiempo.
- **Objetivos de aprendizaje:**
    - Aplicar SQL DML para poblar la base de datos con datos de prueba y simular la actividad del mercado.
    - Desarrollar consultas SQL que permitan analizar el desempeño de las inversiones simuladas.
- **Entrega esperada:**
    - **Script de Población de Datos:** Código SQL para insertar datos ficticios que representen transacciones y activos en el mercado.
    - **Consultas de Reporte:** Consultas SQL para generar reportes de desempeño, historial de transacciones y análisis del portafolio.

---

### **Entrega 3: Funcionalidades Avanzadas y Documentación Final**

- **Descripción:** En esta última entrega, los estudiantes implementarán funcionalidades avanzadas como triggers y procedimientos almacenados para simular la actualización de precios de los activos financieros, así como cálculos automáticos de rentabilidad en cada portafolio. También deberán documentar el proyecto completo y presentar los resultados.
- **Temas a cubrir:**
    - **Triggers y Procedimientos Almacenados:** Implementación de triggers para simular la actualización de precios de activos en tiempo real, y procedimientos almacenados para el cálculo de rentabilidad y actualización automática del portafolio de cada usuario.
    - **Transacciones y Manejo de Consistencia:** Utilización de transacciones para asegurar la consistencia de los datos durante la simulación de operaciones de compra y venta.
    - **Optimización con Índices:** Aplicar índices en columnas clave para optimizar la consulta de datos en tiempo real y mejorar el rendimiento de la plataforma.
- **Objetivos de aprendizaje:**
    - Implementar triggers y procedimientos almacenados para simular y automatizar cambios en los precios y las inversiones.
    - Usar transacciones para mantener la integridad de los datos durante la ejecución de operaciones simuladas.
    - Optimizar consultas mediante la indexación de columnas clave.
- **Entrega esperada:**
    - **Script de Triggers y Procedimientos Almacenados:** Código que implemente la simulación de precios y el cálculo de rentabilidad.
    - **Documentación Final:** Explicación detallada del diseño de la base de datos, consultas y funciones avanzadas.
    - **Presentación del Proyecto:** Exposición final donde se demuestre el diseño, implementación y resultados obtenidos.