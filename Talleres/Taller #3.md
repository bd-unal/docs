# 🌳 **Taller Práctico: Construcción de una Aplicación de Árbol Genealógico con SQL (DDL, DML y DQL)**  

En este taller, diseñaremos un sistema que permita a los usuarios ingresar sus datos personales, los de su familia y la información relacionada con estudios, hobbies y relaciones familiares. 

El objetivo es aplicar los conceptos de **Definición de Datos (DDL)**, **Manipulación de Datos (DML)** y **Consulta de Datos (DQL)** de una manera práctica y funcional.

--- 

## 📌 Entrega

El taller debe ser enviado al correo del profesor antes de finalizar el día (Enero 29 11:59pm). Los entregables son:
- Documento `pdf` con capturas de pantalla de las consultas y sus resultados, así como algún comentario adicional cuando lo considere pertinente.
- El documento debe incluir una reflexión sobre qué fue lo más fácil y lo más difícil del taller.  
- Archivo `.sql` con las consultas generadas. El archivo debe tener comentarios para referenciar a que hace referencia cada consulta. Ver [este archivo como ejemplo](ejemplos%2FClase%20-%20DQL%20b%C3%A1sico%20y%20DML%2FClase%20-%20DQL%20b%C3%A1sico%20y%20DML.sql).

---

## **📌 Requisitos del Sistema**  

El sistema debe permitir a los usuarios:  
1. **Registrar su información personal**.  
2. **Agregar información de familiares y definir relaciones (padres, hijos, cónyuge, hermanos, etc.)**.  
3. **Almacenar los estudios realizados por cada persona**.  
4. **Registrar los hobbies de cada persona**.  
5. **Consultar relaciones familiares, estudios y hobbies**.  

---

## **1️⃣ Creación de la Base de Datos y Estructura de Tablas (DDL)**  

### **Ejercicio 1: Creación de la base de datos**  
Crea una base de datos llamada `arbol_genealogico_db`.  

💡 **Pista**: Usa `CREATE DATABASE`.  

### **Ejercicio 2: Creación de Tablas**  

Crea las siguientes tablas con sus respectivos atributos y restricciones:  

#### **Tabla `persona`**  
Almacena la información básica de cada usuario y sus familiares.  
- `id_persona` (clave primaria, autoincremental).  
- `nombre` (obligatorio).  
- `apellido` (obligatorio).  
- `fecha_nacimiento` (obligatorio).  
- `email` (único y obligatorio).  
- `telefono` (valor opcional).  
- `genero` (opcional).  

#### **Tabla `relacion_familiar`**  
Almacena la relación entre personas (padres, hijos, cónyuge, hermanos, etc.).  
- `id_relacion` (clave primaria, autoincremental).  
- `id_persona_1` (clave foránea que referencia a `persona`).  
- `id_persona_2` (clave foránea que referencia a `persona`).  
- `tipo_relacion` (obligatorio, ejemplo: ‘Padre’, ‘Madre’, ‘Hijo’, ‘Hermano’, ‘Cónyuge’).  

#### **Tabla `estudios`**  
Registra los estudios de cada persona.  
- `id_estudio` (clave primaria, autoincremental).  
- `id_persona` (clave foránea que referencia a `persona`).  
- `nivel_educativo` (Ejemplo: Primaria, Secundaria, Universidad).  
- `institucion` (Nombre de la institución).  
- `anio_finalizacion` (Debe ser un número positivo).  

#### **Tabla `hobbies`**  
Registra los hobbies de cada persona.  
- `id_hobby` (clave primaria, autoincremental).  
- `id_persona` (clave foránea que referencia a `persona`).  
- `nombre_hobby` (Ejemplo: Natación, Lectura, Cocina, Ciclismo).  

💡 **Pistas**:  
- Usa `SERIAL` para claves primarias.  
- Usa `NOT NULL` para los campos obligatorios.  
- Usa `CHECK` para validar restricciones numéricas.  
- Usa `FOREIGN KEY` para definir relaciones entre tablas.  

---

## **2️⃣ Inserción y Manipulación de Datos (DML)**  

### **Ejercicio 3: Inserción de Datos**  

🔹 **Registra al menos 5 personas en la base de datos**.  
🔹 **Registra al menos 3 relaciones familiares**.  
🔹 **Registra estudios realizados para al menos 3 personas**.  
🔹 **Registra al menos 2 hobbies por persona**.  

💡 **Pistas**:  
- Usa `INSERT INTO` para agregar datos.  
- Asegúrate de que las relaciones familiares sean correctas.  
- Evita duplicados en las relaciones familiares (una persona no puede ser su propio padre o madre).  

### **Ejercicio 4: Actualización de Datos**  
🔹 **Actualiza el número de teléfono de una persona**.  
🔹 **Modifica la institución de estudio de una persona**.  
🔹 **Cambia el nombre de un hobby registrado**.  

💡 **Pistas**:  
- Usa `UPDATE` con `SET` para modificar datos.  
- Usa `WHERE` para asegurarte de modificar solo los datos correctos.  

### **Ejercicio 5: Eliminación de Datos**  
🔹 **Elimina un hobby de una persona**.  
🔹 **Elimina un estudio registrado de una persona**.  
🔹 **Elimina una persona solo si no tiene relaciones familiares registradas**.  

💡 **Pistas**:  
- Usa `DELETE FROM` con `WHERE`.  
- Usa `ON DELETE CASCADE` en claves foráneas si deseas eliminar registros relacionados automáticamente.  

---

## **3️⃣ Consultas de Datos (DQL)**  

### **Ejercicio 6: Consultas Básicas con SELECT**  
🔹 **Muestra todas las personas registradas en el sistema**.  
🔹 **Lista las relaciones familiares de una persona específica**.  
🔹 **Muestra los estudios de una persona dada**.  
🔹 **Lista todos los hobbies de una persona específica**.  
🔹 **Encuentra todas las personas nacidas después del año 2000**.  
🔹 **Muestra las personas cuyo apellido termine o contenga algun(os) caracter(es) que develvan más de un registro**.  

💡 **Pistas**:  
- Usa `SELECT * FROM tabla` para ver todos los datos.  
- Usa `WHERE` para filtrar registros.  
- Usa `LIKE '%texto'` para encontrar coincidencias en cadenas de texto.  

---

## **4️⃣ Desafío Adicional (deseable pero no obligatorio) 🔥**  

1. **Crea una tabla `historial_estudios`** para almacenar los estudios eliminados.  
2. **Antes de eliminar un estudio, transfiérelo a `historial_estudios`**.  
3. **Crea una consulta que muestre el nombre de la persona, su edad y su relación familiar con otra persona específica**.  

---

¡Felicidades por completar el taller! 🎉🌳  