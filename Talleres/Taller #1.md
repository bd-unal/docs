
# Taller #1: Introducción a PostgreSQL, pgAdmin y Neon.tech

## **Objetivo del Taller:**

En este taller, los estudiantes aprenderán a:
1. Instalar PostgreSQL y pgAdmin.
2. Crear una base de datos en PostgreSQL.
3. Restaurar una base de datos usando un archivo de respaldo.
4. Ejecutar una consulta SQL sencilla.
5. Explorar las funcionalidades básicas de pgAdmin para la gestión de bases de datos.
6. Usar Neon como herramienta en linea para crear bases de datos.

---
## Paso 1: Instalación de PostgreSQL y pgAdmin

1.  **Instalación de PostgreSQL:**
    - Descarguen PostgreSQL desde el sitio oficial: [https://www.postgresql.org/download/](https://www.postgresql.org/download/)
    - Seleccionen el sistema operativo de su equipo (Windows, MacOS, Linux).
    - Sigan las instrucciones del instalador y asegúrense de:
      - Seleccionar la instalación de **pgAdmin** durante el proceso.
      - Configurar una **contraseña** para el usuario `postgres` (la contraseña de administrador), se recomienda asignar simplemente `password` como contraseña para no olvidarla luego.

2.  **Instalación de pgAdmin:**
    - Si eligieron instalar pgAdmin junto con PostgreSQL, este estará disponible inmediatamente después de la instalación.
    - Alternativamente, pueden descargar pgAdmin como aplicación independiente desde https://www.pgadmin.org/download/.
    - Ejecuten pgAdmin y alternativamente configuren una **contraseña maestra** para asegurar sus conexiones (Al abrir pgAdmin por primera vez aparecerá un cuadro de diálogo solicitándote que establezcas una **Master Password).**
    - Se sugiere usar un password que pueda recordar, por ejemplo, puede usar `password`. Si olvida su contraseña tendrá que desinstalar e instalar postgres nuevamente.

---

## Paso 2: Crear una Base de Datos en PostgreSQL

1.  **Abrir pgAdmin**:
    - Inicien sesión en pgAdmin con la contraseña que configuraron.
    - Conecten el servidor haciendo clic derecho en el servidor `PostgreSQL` -> **Connect Server** e ingresando la contraseña del usuario `postgres`.

2.  **Crear una Base de Datos**:
    - Expandan el árbol de servidores en el panel izquierdo y seleccionen `Databases`.
    - Hagan clic derecho sobre `Databases` -> **Create** -> **Database…**.
    - En el cuadro de diálogo, asignen un nombre a la base de datos (por ejemplo, `taller_academico`).
    - Asegúrense de seleccionar `postgres` como el propietario y hagan clic en **Save** para crear la base de datos.

---

## Paso 3: Restaurar la Base de Datos desde un Respaldo

1.  **Preparar el Archivo de Respaldo**:
    - Descarguen el archivo de respaldo (`taller_academico.tar`) presentado a continuación:
[https://drive.google.com/file/d/1BtpdHbD68-_f2Pi4VwKfh7zj3fgVNUPM/view?usp=sharing](https://drive.google.com/file/d/1BtpdHbD68-_f2Pi4VwKfh7zj3fgVNUPM/view?usp=sharing)
    - Guarden el archivo en una carpeta accesible en su computadora.

2.  **Restaurar la Base de Datos en pgAdmin**:
    - En pgAdmin, hagan clic derecho sobre la base de datos `taller_academico` -> **Restore…**.
    - En el campo **Filename**, seleccionen el archivo `taller_academico.tar`.
    - Dejen los valores predeterminados en las configuraciones y hagan clic en **Restore**.
    - pgAdmin iniciará el proceso de restauración y mostrará un mensaje de éxito al terminar.

---

## Paso 4: Ejecutar una Consulta SQL Sencilla

1.  **Abrir el Editor de SQL**:
    - Seleccionen la base de datos `taller_academico` en el árbol de servidores.
    - Hagan clic derecho sobre la base de datos y seleccionen **Query Tool**.

2.  **Ejecutar una Consulta de Prueba**:
    - En el editor, escriban la siguiente consulta SQL para obtener datos de una tabla específica (ajusten el nombre de la tabla según el contenido del respaldo, por ejemplo, `SELECT * FROM estudiantes LIMIT 10;`).
    - Hagan clic en el botón de **Play** o presionen `F5` para ejecutar la consulta.
    - Los resultados de la consulta aparecerán en la parte inferior del editor.

---

## Paso 5: Exploración de Funcionalidades Básicas de pgAdmin

1.  **Navegación de Tablas y Estructuras**:
    - Expandan la base de datos `taller_academico` en el panel izquierdo.
    - Exploren el apartado `Schemas` -> `public` -> `Tables` para ver las tablas disponibles.
    - Seleccionen cualquier tabla y hagan clic derecho -> **View/Edit Data** -> **All Rows** para visualizar todos los datos en la tabla seleccionada.

2.  **Creación de Consultas de Agregación**:

    - Ejecute las siguientes consultas para visualizar los estudiantes y profesores:
      ```sql
      SELECT * FROM estudiantes;
      SELECT * FROM profesores;
      ```
    - Vuelvan al **Query Tool** y prueben consultas de agregación simples, por ejemplo:
      
      ```sql
      SELECT carrera, COUNT(*) AS cantidad_estudiantes
      FROM estudiantes
      GROUP BY carrera;
      ```
    - Ejecuten la consulta para ver el conteo de estudiantes por carrera.

3.  **Exploración de las Propiedades de la Base de Datos**:
    - Hagan clic derecho sobre la base de datos `taller_academico` -> **Properties** para ver y editar configuraciones de la base de datos (como el propietario y la codificación).

4.  **Generación de Backups**:
    - Practiquen la generación de respaldos seleccionando `taller_academico`, clic derecho -> **Backup…** y seleccionando una ubicación para guardarlo.
    - Borre todas las tablas con **Click Derecho** sobre la tabla y **Delete**
    - Restaure el backup seleccionando el archivo generado anteriormente.
    - Esto permite entender cómo crear y gestionar copias de seguridad de una base de datos en pgAdmin.
   
---

## Paso 6: Exploración de Neon.tech

1. Navegar a [https://neon.tech/](https://neon.tech/)
2. Registrarse y crear una cuenta gratuita con el correo de la Universidad Nacional.
3. Crear nuevo proyecto llamado `bd-unal-2024-2-{nombre}-{apellido}` .
   a. Seleccionar una versión de Postgres que funcione con la versión instalada de pgAdmin. Sino saben que versión de pgAdmin instalaron pueden abrir el programa y en el menú seleccionar **Help -> About pgAdmin 4.** Para saber que versión de Postgres soporta la versión instalada de pgAdmin se puede consultar este link [https://www.pgadmin.org/docs/pgadmin4/6.21/release_notes_6_21.html](https://www.pgadmin.org/docs/pgadmin4/6.21/release_notes_6_21.html)

![taller1-imagen.png](../images%2Ftaller1-imagen.png)

4. Crear un nuevo servidor en pgAdmin para conectarse al proyecto creado en Neon, para esto:
    * En Neon visualice el connection string (cadena de conexión) que aparece en la pantalla después de crear el proyecto. (El connection string es algo como esto `postgresql://neondb_owner:XXXXXXXXXX@ep-tight-brook-a5xgpz7i.us-east-2.aws.neon.tech/neondb?sslmode=require`)
    * Acceda al siguiente link para aprender la estructura del connection string https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-CONNSTRING
    * En pgAdmin haga click derecho sobre Servers y seleccione **Register → Server.**
    *  Asigne un nombre al nuevo servidor. Ejemplo: `Neon BD 2024 - 2`.
    * Vaya al tab de **Connection** y llene los campos de acuerdo con lo que leyó de la estructura del connection string. Seleccione **Save password?** para que la próxima vez no tenga que ingresar el password de nuevo.
    * Finalmente haga click en **Save,** si todo estuvo correcto, el nuevo servidor debe aparecer en la lista de servidores.
    * Explore la opción de Dashboard y verifique todos los parámetros.
6. Repetir los **pasos 1-5** de este taller en Neon. Use este archivo de respaldo:
[https://drive.google.com/file/d/1Hg4Q64Lxvnj8I66VZHs2u2om3n49F3h-/view?usp=sharing](https://drive.google.com/file/d/1Hg4Q64Lxvnj8I66VZHs2u2om3n49F3h-/view?usp=sharing)

7. Explore la página web de Neon y tome nota de cualquier cosa que le llame la atención. Por ejemplo
    * Neon le genera unos snippets de código para realizar la conexión usando distintos lenguajes de programación.
    * Neon cuenta con su propio SQL Editor que le permite ejecutar consultas.
    * Neon le permite monitorear métricas de su bases de datos relacionadas con CPU, memoria, conexiones, etc.
---

### Entrega

1.  **Resumen de Tareas Realizadas**:
   - Escriban un pequeño reporte donde detallen cada uno de los pasos realizados, incluyendo capturas de pantalla de:
      - La base de datos creada y restaurada.
      - La consulta ejecutada.
      - El contenido de una tabla explorada.
      - Los pasos para crear y conectarse al servidor de Neon.

> 💡 Importante: Tenga en cuenta que si bien el servidor creado es para propósitos académicos, DEBE ASEGURARSE DE NO PEGAR O COMPARTIR EL CONNECTION STRING CON EL PASSWORD en el reporte realizado, los agentes maliciosos están presentes en todas partes. El password no debe ser compartido bajo ninguna circunstancia. Esto servirá como una guía para futuras referencias en sus prácticas con PostgreSQL y pgAdmin.

2.  **Entrega**:
- Enviar el reporte y cualquier consulta adicional que hayan realizado durante la exploración para su evaluación y retroalimentación al correo del profesor. Nombrar el correo `Taller #1 - {Nombre} {Apellido}`.

> Plazo de entrega: Noviembre 19 de 2024 antes de las 12:00pm
> Recuerde las políticas del curso. Un trabajo entregado a destiempo tiene un penalidad en la nota. 20% por cada día de retraso sin excepción alguna.

---
