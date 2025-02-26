# Transaction Control Language (TCL)
El Transaction Control Language (TCL) en SQL se encarga de gestionar y controlar las transacciones en una base de datos. Una transacción es una secuencia de sentencias de consulta y/o actualización que se ejecutan como una unidad lógica de trabajo. Según el estándar SQL, una transacción comienza implícitamente cuando se ejecuta la primera sentencia y se finaliza mediante una de las siguientes instrucciones:

## COMMIT [WORK]
- **Descripción:**  
  Confirma la transacción actual, haciendo permanentes todos los cambios realizados en la base de datos. Una vez que se ejecuta `COMMIT`, los cambios ya no pueden revertirse mediante `ROLLBACK`.
- **Comportamiento:**  
  Tras ejecutar `COMMIT`, se inicia automáticamente una nueva transacción.
- **Nota:**  
  La palabra `WORK` es opcional; puedes escribir tanto `COMMIT` como `COMMIT WORK`.

## ROLLBACK [WORK]
- **Descripción:**  
  Revierte la transacción actual, deshaciendo todas las actualizaciones realizadas durante la transacción. Esto restaura el estado de la base de datos a como estaba antes de iniciar la transacción.
- **Comportamiento:**  
  Se utiliza para cancelar los cambios en caso de error o si se decide no aplicar las modificaciones.
- **Nota:**  
  Al igual que en `COMMIT`, la palabra `WORK` es opcional; se puede usar `ROLLBACK` o `ROLLBACK WORK`.

## Comparación y Uso
- **COMMIT:**  
  Es similar a "guardar cambios" en un documento. Una vez guardados, estos cambios se vuelven permanentes.
- **ROLLBACK:**  
  Es similar a "salir sin guardar cambios", permitiendo anular la transacción y restaurar el estado anterior.

## Iniciando una Transacción

Aunque en muchos sistemas la transacción comienza de forma implícita al ejecutar la primera sentencia SQL, es recomendable iniciarla explícitamente usando `BEGIN` o `START TRANSACTION`. De esta forma, se delimita claramente el inicio de la transacción.

Sintaxis:
```sql
BEGIN;
-- Sentencias SQL (INSERT, UPDATE, DELETE, etc.)
COMMIT;
```

Sintaxis con ROLLBACK:

```sql
BEGIN;
-- Sentencias SQL (INSERT, UPDATE, DELETE, etc.)
ROLLBACK;
```

## Manejo de Fallos
El sistema de bases de datos garantiza que, en caso de fallos (por ejemplo, errores en las sentencias, cortes de energía o caídas del sistema), si la transacción no se ha confirmado con `COMMIT`, sus efectos se revertirán mediante `ROLLBACK`. En escenarios de fallo, al reiniciar el sistema se ejecutará automáticamente un `ROLLBACK` para garantizar la integridad de los datos.

## Propiedades ACID

1. **Atomicidad:**  
   Todas las operaciones dentro de la transacción se ejecutan en su totalidad o ninguna se aplica.  
   *Ejemplo:* En una transferencia de fondos, si una de las dos operaciones falla, ninguna modificación se refleja en la base de datos.

2. **Consistencia:**  
   Al finalizar la transacción, la base de datos debe quedar en un estado consistente, cumpliendo todas las restricciones y reglas del negocio.  
   *Ejemplo:* Actualizar saldos sin violar restricciones como "saldo no negativo".

3. **Aislamiento:**  
   Las transacciones concurrentes se ejecutan de forma aislada, de modo que cada una parece ejecutarse de manera secuencial sin interferir entre sí.  
   *Ejemplo:* Dos transacciones que modifican el mismo registro no provocan estados intermedios inconsistentes.

4. **Durabilidad:**  
   Una vez que una transacción se confirma con `COMMIT`, sus cambios son permanentes, incluso en caso de fallo del sistema o reinicio.  
   *Ejemplo:* Tras confirmar una transferencia de fondos, los nuevos saldos se mantienen aunque se produzca un corte de energía.

# Ejemplo de Transacciones en PostgreSQL

A continuación se muestra un ejemplo completo para ilustrar cómo usar TCL (Transaction Control Language) en PostgreSQL mediante la creación de una tabla de muestra llamada `accounts`. Este ejemplo demuestra cómo iniciar una transacción, realizar inserciones, confirmar (commit) y revertir (rollback) cambios.

---

## Configuración de la Tabla de Ejemplo

Primero, debemos crear la tabla `accounts`:
```sql
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    id SMALLSERIAL,
    name VARCHAR(100) NOT NULL,
    balance DEC(15,2) NOT NULL CHECK(balance >= 0),
    PRIMARY KEY(id)
);
```
---

## Iniciando una Transacción

PostgreSQL envuelve de forma implícita cada sentencia en una transacción, pero es buena práctica iniciarla explícitamente con `BEGIN` (o `BEGIN TRANSACTION` / `BEGIN WORK`) para delimitar el inicio de la transacción.

Por ejemplo, al ejecutar la siguiente instrucción `INSERT`, PostgreSQL inserta inmediatamente una nueva fila en la tabla `accounts`:
```sql
INSERT INTO accounts(name, balance)
VALUES('Bob', 10000);
```
Para iniciar una transacción explícitamente, se puede usar:
```sql
    BEGIN;
```
Luego, se pueden ejecutar las operaciones deseadas dentro de la transacción.

---

## Ejemplo Completo de una Transacción

Este ejemplo inicia una transacción, inserta una nueva cuenta y confirma la transacción:
```sql
-- Inicia la transacción
BEGIN;
-- Inserta una nueva fila en la tabla accounts
INSERT INTO accounts(name,balance)
VALUES('Alice',10000);
-- Finalmente, se confirma la transacción con `COMMIT`, haciendo permanentes los cambios.
COMMIT;
```

---

## Rollback de una Transacción

Si ocurre algún error o decides no aplicar los cambios, se puede revertir la transacción usando `ROLLBACK`. Por ejemplo, para deshacer una actualización en la cuenta con `id = 1`:
```sql
    BEGIN;
    UPDATE accounts
    SET balance = balance - 1000
    WHERE id = 1;
    ROLLBACK;
```
Después de ejecutar `ROLLBACK`, si se consulta la tabla `accounts`, no se observará el cambio realizado, ya que la transacción se ha revertido.

---
## SAVEPOINTS
Un **SAVEPOINT** es un marcador que se establece dentro de una transacción para definir un punto al cual se puede revertir (rollback) sin deshacer toda la transacción. Esto permite controlar más finamente qué operaciones se desean deshacer en caso de error, manteniendo las operaciones previas al savepoint intactas.

## ¿Por qué usar SAVEPOINTS?
- Permiten dividir una transacción larga en etapas.
- Facilitan el manejo de errores, ya que se puede retroceder a un punto específico sin cancelar todas las operaciones realizadas.
- Ayudan a mantener la integridad de los datos en operaciones complejas.

## Ejemplo Práctico

Supongamos que en nuestra tabla `accounts` queremos realizar varias actualizaciones dentro de una misma transacción. Podemos establecer un savepoint después de la primera actualización y, si ocurre un error en las operaciones posteriores, revertir solo hasta ese punto.

La secuencia sería la siguiente:
```sql
BEGIN;
	-- Ejemplo con SAVEPOINTS
	UPDATE accounts
	SET balance = balance - 100
	WHERE id = 1;

	SAVEPOINT sp1;

	UPDATE accounts
	SET balance = balance + 100
	WHERE id = 2;

	-- Si se detecta un error en las operaciones posteriores, podemos revertir a sp1, 
	-- es decir que la suma del balance al id = 2 se revertiría
	ROLLBACK TO SAVEPOINT sp1;
 
	-- Se pueden realizar otras operaciones, y finalmente:
COMMIT;
```

## Explicación del Ejemplo

1. **BEGIN;**  
   Inicia la transacción.

2. **UPDATE accounts SET balance = balance - 100 WHERE id = 1;**  
   Se realiza la primera actualización, por ejemplo, descontando $100 de la cuenta con `id = 1`.

3. **SAVEPOINT sp1;**  
   Se crea un punto de control llamado `sp1`. Esto marca el estado de la transacción hasta ese momento.

4. **UPDATE accounts SET balance = balance + 100 WHERE id = 2;**  
   Se realiza otra actualización, por ejemplo, sumando $100 a la cuenta con `id = 2`.

5. **ROLLBACK TO SAVEPOINT sp1;**  
   Si ocurre algún error en las operaciones posteriores o si se decide cancelar los cambios hechos después del savepoint, se ejecuta esta instrucción para deshacer solo las operaciones realizadas después de `sp1`, dejando intacta la actualización de la cuenta con `id = 1`.

6. **COMMIT;**  
   Confirma la transacción, haciendo permanentes todas las operaciones que no fueron revertidas.

Este mecanismo es especialmente útil cuando se necesitan ejecutar múltiples operaciones y se quiere tener la opción de deshacer parte de ellas sin afectar el estado previo de la transacción.

### RELEASE SAVEPOINT
Puedes usar `RELEASE SAVEPOINT` para destruir un savepoint, manteniendo los efectos d elos comandos ejecutrados después de que fue establecido. 

```sql
BEGIN;
    INSERT INTO accounts(name, balance)
    VALUES('David', 10000);
    -- Se crea el savepoint my_savepoint
    SAVEPOINT my_savepoint;
    INSERT INTO accounts(name, balance)
    VALUES('Yully', 10000);
    -- Se destruye el savepoint my_savepoint
    RELEASE SAVEPOINT my_savepoint;
	-- ROLLBACK TO my_savepoint;
	-- Si se desea volver a my_savepoint se presentaría un error
COMMIT;
```

---

## Niveles de Aislamiento en SQL

SQL define distintos niveles de aislamiento que controlan la visibilidad de los cambios realizados por otras transacciones. A continuación, se muestra una tabla resumen con las anomalías que cada nivel permite:

| Nivel de Aislamiento   | Lectura Sucia (Dirty Read) | Lectura No Repetible (Nonrepeatable Read) | Lectura Fantasma (Phantom Read) | Anomalía de Serialización |
|------------------------|----------------------------|-------------------------------------------|---------------------------------|---------------------------|
| Read Uncommitted       | Permitida (no en PG)       | Posible                                   | Posible                         | Posible                   |
| Read Committed         | No posible                 | Posible                                   | Posible                         | Posible                   |
| Repeatable Read        | No posible                 | No posible                                | Permitida (pero no en PG)         | Posible                   |
| Serializable           | No posible                 | No posible                                | No posible                      | No posible                |

> **Nota:** En PostgreSQL, el nivel "Read Uncommitted" se trata internamente como "Read Committed", y "Repeatable Read" puede comportarse de forma similar a "Serializable" en ciertos escenarios.

---

## Anomalías en Transacciones Concurrentes

Sin un aislamiento adecuado, pueden ocurrir varios problemas:

- **Dirty Reads (Lecturas Sucias):**  
  Una transacción lee datos que otra transacción aún no ha confirmado.  
  *Problema:* Si la transacción que realizó la escritura se revierte, los datos leídos son inválidos.
  - Una transacción T1 escribe un valor en X. 
  - T2 lee el valor de X antes de que T1 se confirme. 
  - Si T1 se aborta, T2 habrá leído un valor inválido para X.

- **Nonrepeatable Reads (Lecturas No Repetibles):**  
  Una transacción vuelve a leer el mismo registro y obtiene valores diferentes porque otra transacción modificó ese dato.
  - T1 lee el valor de X.
  - T2 modifica o elimina el valor de X y luego se confirma.
  - Si T1 vuelve a leer X, el valor será diferente o incluso podría haber desaparecido.
  
- **Phantom Reads (Lecturas Fantasma):**  
  Una transacción ejecuta una consulta que devuelve un conjunto de filas; luego, otra transacción inserta o elimina filas que cumplen la misma condición, por lo que al reejecutar la consulta se obtienen resultados diferentes.
  - La transacción T1 lee filas que cumplen con un predicado P.
  - La transacción T2 luego inserta o modifica filas, algunas de las cuales cumplen con P.
  - Si T1 repite su lectura, obtiene un conjunto diferente de resultados.
  - Si T1 escribe valores basados en la lectura original, las nuevas filas pueden quedar fuera.

- **Lost Updates (Actualizaciones Perdidas):**  
  Dos transacciones leen el mismo dato y realizan actualizaciones; la actualización de una transacción sobrescribe la de la otra.
  - La transacción T1 lee el valor de X.
  - La transacción T2 escribe un nuevo valor en X.
  - T1 escribe en X basándose en el valor leído anteriormente.

---

## Niveles de Aislamiento y su Impacto

- **Read Committed:**  
  No permite lecturas sucias, pero sí puede producir lecturas no repetibles y lecturas fantasma. Es el nivel predeterminado en muchos DBMS, incluido PostgreSQL.

- **Repeatable Read:**  
  Evita lecturas sucias y lecturas no repetibles, pero en algunos sistemas aún puede permitir lecturas fantasma.

- **Serializable:**  
  Garantiza la ejecución de transacciones como si se ejecutaran de forma secuencial, eliminando todas las anomalías de concurrencia. Sin embargo, es el nivel más estricto y puede impactar el rendimiento en sistemas con alta concurrencia.

---

## Configuración del Nivel de Aislamiento

Puedes establecer el nivel de aislamiento de una transacción usando la siguiente sintaxis:
```sql
    SET TRANSACTION ISOLATION LEVEL { SERIALIZABLE | REPEATABLE READ | READ COMMITTED | READ UNCOMMITTED };
```

Cada nivel ofrece un equilibrio diferente entre consistencia y rendimiento, y la elección dependerá de las necesidades específicas de la aplicación.

---

## Ejemplo Práctico

Supongamos que queremos realizar una transacción de actualización en una cuenta bancaria:
```sql
-- Transaction isolation level
BEGIN;
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    UPDATE accounts
    SET balance = balance - 100
    WHERE name = 'David';
    -- En este punto, el cambio es visible solo en la transacción actual.
COMMIT;
```

Si se establece el nivel de aislamiento a `SERIALIZABLE`, se garantiza que ninguna otra transacción pueda interferir hasta que esta transacción se complete.

---

## Bloqueos en Bases de Datos

Los **bloqueos** (database locks) son mecanismos esenciales en los sistemas de gestión de bases de datos (DBMS) que permiten controlar el acceso concurrente a los datos, garantizando la integridad y consistencia durante la ejecución de transacciones. A continuación, se explican conceptos clave sobre los bloqueos, sus tipos y algunas consideraciones prácticas.

---

## ¿Por Qué se Usan los Bloqueos?

Cuando múltiples transacciones acceden a la misma información, es necesario prevenir condiciones de carrera y mantener la consistencia de los datos. Los bloqueos ayudan a:
- **Evitar lecturas inconsistentes** (por ejemplo, lecturas sucias o no repetibles).
- **Controlar las actualizaciones concurrentes** para prevenir actualizaciones perdidas.
- **Mantener la integridad referencial** entre las tablas durante operaciones simultáneas.

---

## Tipos de Bloqueos

### 1. Bloqueos Compartidos (Shared Locks)
- **Descripción:** Permiten que múltiples transacciones lean el mismo dato al mismo tiempo, pero impiden que se modifique.
- **Uso típico:** Durante operaciones de `SELECT`.
- **Ejemplo:** Si dos transacciones necesitan leer el saldo de una cuenta, se les puede asignar un bloqueo compartido para evitar que alguien realice cambios mientras se está leyendo la información.

### 2. Bloqueos Exclusivos (Exclusive Locks)
- **Descripción:** Se utilizan cuando una transacción necesita modificar un dato. Este tipo de bloqueo impide que otras transacciones lean o escriban sobre el mismo dato.
- **Uso típico:** Durante operaciones de `UPDATE`, `INSERT` o `DELETE`.
- **Ejemplo:** Cuando una transacción actualiza el saldo de una cuenta, se aplica un bloqueo exclusivo para asegurar que ninguna otra transacción pueda acceder al dato mientras se actualiza.

---

## Granularidad de Bloqueos

Los bloqueos pueden aplicarse a distintos niveles, lo que afecta la concurrencia y el rendimiento:

- **Bloqueos a Nivel de Fila:** Permiten una alta concurrencia, ya que solo se bloquean las filas específicas que están siendo leídas o modificadas.
- **Bloqueos a Nivel de Página:** Bloquean una página entera (un conjunto de filas), lo que puede reducir la concurrencia si varias transacciones necesitan acceder a diferentes filas dentro de la misma página.
- **Bloqueos a Nivel de Tabla:** Bloquean toda la tabla, lo cual es más restrictivo y se utiliza generalmente en operaciones masivas o para simplificar la gestión de bloqueos.

---

## Problemas y Consideraciones de Bloqueo

- **Deadlocks (Interbloqueos):** Ocurren cuando dos o más transacciones se bloquean mutuamente esperando liberar recursos. Los DBMS detectan estos conflictos y abortan una de las transacciones para resolver el interbloqueo.
  
- **Bloqueo de Largas Transacciones:** Las transacciones que duran mucho tiempo pueden mantener bloqueos durante períodos extensos, lo que afecta la concurrencia y el rendimiento general de la base de datos.

- **Actualización de Bloqueos:** Algunos sistemas permiten la actualización de un bloqueo compartido a uno exclusivo (upgrade), pero esto puede ser complejo y a veces conduce a interbloqueos si no se gestiona correctamente.

---

## Estrategias para Minimizar Problemas de Bloqueo

- **Mantener las transacciones cortas y simples:** Esto reduce el tiempo durante el cual se mantienen los bloqueos.
- **Diseñar cuidadosamente la secuencia de operaciones:** Evitar que dos transacciones accedan a los mismos recursos en orden inverso.
- **Manejo de interbloqueos:** Implementar lógica de reintento en la aplicación para manejar transacciones abortadas por interbloqueos.
---
## Implementación de Bloqueos en PostgreSQL

PostgreSQL gestiona los bloqueos de manera automática para garantizar la integridad y consistencia de los datos durante las transacciones. Sin embargo, es posible solicitar bloqueos explícitos para controlar el acceso concurrente a registros o tablas. A continuación, se explican algunos métodos comunes para implementar bloqueos y se ofrecen ejemplos prácticos.

## 1. Bloqueos de Filas con SELECT ... 

Cuando necesitas asegurarte de que las filas que vas a modificar no sean alteradas por otra transacción, puedes utilizar la cláusula `FOR UPDATE` en tu consulta `SELECT`. Esto bloquea las filas seleccionadas hasta que la transacción actual finalice.

Ejemplo:
  ```sql
   SELECT balance FROM accounts 
   WHERE name = 'Bob'
   FOR UPDATE;
  ```
Este comando bloquea la fila correspondiente a la cuenta 'A-102', impidiendo que otra transacción la modifique hasta que se realice un COMMIT o ROLLBACK.

## 2. Bloqueo de Tablas con LOCK TABLE

Para operaciones que requieren asegurar la exclusividad sobre todos los registros de una tabla, se puede utilizar el comando `LOCK TABLE`. Esto bloquea la tabla completa en un modo específico.

Ejemplo:

```sql
LOCK TABLE orders IN EXCLUSIVE MODE;
```

Con este comando, la tabla `orders` se bloquea en modo exclusivo, lo que impide que otras transacciones realicen operaciones de escritura (o incluso algunas de lectura, según el modo) hasta que se libere el bloqueo.

Para aprender de otros tipos de bloqueos vaya a este [link](https://medium.com/@hnasr/postgres-locks-a-deep-dive-9fc158a5641c).

## 3. Bloqueos Automáticos en PostgreSQL

PostgreSQL aplica bloqueos de forma automática según la operación ejecutada:
- **SELECT:** Obtiene bloqueos compartidos, permitiendo que múltiples transacciones lean simultáneamente sin interferir.
- **INSERT, UPDATE, DELETE:** Obtienen bloqueos exclusivos sobre las filas afectadas, para evitar modificaciones concurrentes que puedan causar inconsistencias.

## Consideraciones Importantes

- **Deadlocks (Interbloqueos):**  
  Ocurren cuando dos o más transacciones se bloquean mutuamente al esperar que cada una libere recursos. PostgreSQL detecta los deadlocks y aborta una de las transacciones para resolver el conflicto.
  
- **Duración del Bloqueo:**  
  Los bloqueos se mantienen durante toda la transacción. Por ello, es recomendable mantener las transacciones lo más cortas y simples posible para minimizar el impacto en la concurrencia.

- **Uso Responsable de Bloqueos Explícitos:**  
  Utiliza bloqueos explícitos (como `FOR UPDATE` o `LOCK TABLE`) solo cuando sea necesario, ya que pueden limitar la concurrencia y afectar el rendimiento de la base de datos.

---

# Funciones y Procedimientos en SQL (PostgreSQL)

En PostgreSQL existen dos mecanismos principales para encapsular bloques de código SQL: las **funciones** y los **procedimientos**. Aunque ambos permiten agrupar instrucciones SQL y lógica de programación, tienen diferencias clave, especialmente en cuanto al control de transacciones.

---

## Funciones en SQL

### Características
- **Retorno de valores:** Las funciones siempre devuelven un valor (o una tabla, en el caso de funciones que retornan sets).  
- **Uso en consultas:** Se pueden invocar dentro de sentencias SQL (por ejemplo, en el `SELECT` o en cláusulas `WHERE`).  
- **No permiten control explícito de transacciones:** Dentro de una función, no se pueden emitir comandos como `COMMIT` o `ROLLBACK`.
- **Idempotencia:** Suelen ser determinísticas, lo que significa que con los mismos parámetros devolverán siempre el mismo resultado (salvo efectos externos).

### Sintaxis Básica
Para crear una función en PostgreSQL se usa `CREATE FUNCTION`:
```sql
CREATE OR REPLACE FUNCTION nombre_funcion(parametros)
RETURNS tipo_retorno AS $$
DECLARE
    -- Declaración de variables (opcional)
BEGIN
    -- Lógica de la función
    RETURN valor;
END;
$$ LANGUAGE plpgsql;
```
### Ejemplo: Calcular el Doble de la Tarifa de Alquiler
Utilizando la base de datos Pagila, la siguiente función calcula el doble del valor en la columna rental_rate de la tabla film.
```sql
CREATE OR REPLACE FUNCTION double_rental_rate(p_rate NUMERIC)
RETURNS NUMERIC AS $$
BEGIN
    RETURN p_rate * 2;
END;
$$ LANGUAGE plpgsql;
```
Luego, se puede utilizar en una consulta de esta manera:
```sql
SELECT film_id, title, rental_rate, double_rental_rate(rental_rate) AS "Doble Tarifa" FROM film;
```
---

## Procedimientos en SQL

### Características
- **No retornan valor directamente:** Los procedimientos son bloques de código que ejecutan acciones y pueden retornar resultados mediante parámetros OUT, pero no tienen un valor de retorno directo como las funciones.
- **Control de transacciones:** A diferencia de las funciones, los procedimientos permiten incluir comandos de control de transacciones, como `COMMIT`, `ROLLBACK` y `SAVEPOINT`.
- **Invocados mediante CALL:** Se utilizan con la instrucción `CALL` y se orientan más a operaciones de mantenimiento o manipulación compleja que requieren control transaccional.

### Sintaxis Básica
Para crear un procedimiento en PostgreSQL (disponible desde la versión 11), se utiliza `CREATE PROCEDURE`:
```sql
CREATE OR REPLACE PROCEDURE nombre_procedimiento(parametros)
LANGUAGE plpgsql
AS $$
DECLARE
    -- Declaración de variables (opcional)
BEGIN
    -- Lógica del procedimiento
    -- Se pueden usar COMMIT, ROLLBACK, SAVEPOINT, etc.
END;
$$;
```
### Ejemplo: Ajustar la Tarifa de Alquiler de una Película
Este procedimiento actualiza la columna rental_rate de una película específica en la tabla film, multiplicándola por un factor dado. Esto simula un ajuste en el precio de alquiler.
```sql
CREATE OR REPLACE PROCEDURE adjust_rental_rate(p_film_id INT, p_multiplier NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE film
    SET rental_rate = rental_rate * p_multiplier
    WHERE film_id = p_film_id;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;
```
Para ejecutar el procedimiento, utiliza:
```sql
CALL adjust_rental_rate(1, 1.10);
```
Luego, verifica el resultado con:
```sql
SELECT film_id, title, rental_rate FROM film WHERE film_id = 1;
```
---

## Cuando usar un procedimiento
- Tareas de manipulación y procesamiento de datos.
- Implementación de lógica y reglas de negocios en la base de datos.
- Reducción del riesgo de ataques de inyección SQL.
- Mejora de la modularidad y la capacidad de mantenimiento del código.
- Automatización de operaciones rutinarias de la base de datos.

---

## Diferencias Clave entre Funciones y Procedimientos

| Característica                        | Función                             | Procedimiento                        |
|---------------------------------------|-------------------------------------|--------------------------------------|
| **Valor de retorno**                  | Devuelve un valor o set de filas    | No retorna valor directamente         |
| **Uso en consultas**                  | Puede ser utilizada dentro de `SELECT` y otras cláusulas | No puede ser invocado dentro de una consulta; se usa con `CALL` |
| **Control de transacciones**          | No permite comandos como COMMIT o ROLLBACK | Permite control explícito de transacciones (COMMIT, ROLLBACK, SAVEPOINT) |
| **Aplicación**                        | Ideal para cálculos y transformaciones | Ideal para operaciones complejas y mantenimiento de datos |

---

## Conclusión

- **Funciones:** Son ideales para encapsular lógica de negocio que debe retornar un valor y ser utilizada en consultas SQL, pero no permiten manipulación directa del flujo de transacciones.
- **Procedimientos:** Son más adecuados para operaciones que requieren control transaccional (como múltiples actualizaciones que deben confirmarse o revertirse) y no necesitan retornar un valor de forma directa.

Estos mecanismos permiten estructurar y organizar el código SQL, facilitando el mantenimiento y la reutilización de lógica en la base de datos.

---

# Data Control Language (DCL) y Gestión de Roles y Usuarios en SQL

El Data Control Language (DCL) se encarga de gestionar los permisos y el acceso a los objetos de la base de datos. Además, la administración de roles y usuarios es fundamental para controlar quién puede realizar qué acciones en el sistema, y así garantizar la seguridad e integridad de los datos.

---

En una base de datos, podemos asignar a un usuario diferentes formas de autorización sobre áreas específicas del sistema. Estas autorizaciones para trabajar con datos incluyen:

- Permiso para **leer** datos.
- Permiso para **insertar** nuevos datos.
- Permiso para **actualizar** datos existentes.
- Permiso para **eliminar** datos.

Cada uno de estos permisos se denomina **privilegio**. Podemos autorizar a un usuario con todos, ninguno o una combinación de estos privilegios en partes específicas de la base de datos, como en una tabla o en una vista.

Cuando un usuario envía una consulta o una actualización, el sistema SQL verifica primero si la operación está autorizada, basándose en los privilegios que se le han concedido. Si la consulta o actualización no cuenta con los permisos necesarios, se rechaza.

Además de los permisos sobre los datos, los usuarios pueden recibir autorizaciones para modificar el **esquema** de la base de datos, lo que les permite, por ejemplo, crear, modificar o eliminar tablas y otros objetos.

Un usuario con ciertos privilegios puede, a su vez, delegar (`GRANT`) esos permisos a otros o revocar (`REVOKE`) autorizaciones previamente concedidas. En esta sección se explica cómo especificar estos permisos en SQL.

La forma máxima de autoridad es la que posee el **administrador de la base de datos**. Este rol le permite autorizar nuevos usuarios, reestructurar la base de datos y realizar otras tareas administrativas. Este nivel de autorización es similar al de un superusuario o administrador en un sistema operativo.

---

## 1. Comandos DCL

### GRANT
El comando GRANT se utiliza para otorgar permisos sobre objetos de la base de datos (como tablas, vistas o procedimientos) a usuarios o roles.

Ejemplo:
```sql
GRANT SELECT, INSERT ON film TO analyst;
```
*Esto otorga a 'analyst' el permiso de consultar e insertar datos en la tabla film de la base de datos pagila.*

---

### REVOKE
El comando REVOKE se utiliza para retirar permisos previamente otorgados.

Ejemplo:
```sql
REVOKE INSERT ON film FROM analyst;
```
*Esto retira el permiso de inserción en la tabla film al rol o usuario 'analyst'.*

> Todas las opciones disponibles de estos comandos en la documentación oficial de postgres [acá](https://www.postgresql.org/docs/current/sql-revoke.html).

---

## 2. Gestión de Roles y Usuarios

### Usuarios
Un **usuario** es una cuenta que se utiliza para conectarse a la base de datos. Cada usuario tiene credenciales (nombre de usuario y contraseña) y puede tener permisos específicos asignados directamente o mediante roles.

### Roles
Un **rol** es un conjunto de privilegios que se puede asignar a uno o más usuarios. La ventaja de usar roles es que facilita la administración de permisos; en lugar de otorgar permisos individualmente a cada usuario, se pueden agrupar en un rol y luego asignar ese rol a varios usuarios.

### Ejemplos prácticos

1. **Crear un rol:**
```sql
   CREATE ROLE analyst;
```
2. **Otorgar permisos a un rol:**
```sql
   GRANT SELECT, UPDATE ON film TO analyst;
```

3. **Crear un usuario y asignarle un rol:**
```sql 
   CREATE USER john WITH PASSWORD 'mypassword';
   
   GRANT analyst TO john;
```

Con estos comandos, el usuario 'john' hereda todos los permisos asignados al rol 'analyst'. Esto facilita la administración de la seguridad, ya que si en el futuro deseas modificar los permisos para todos los analistas, solo tendrás que actualizar el rol, sin tener que cambiar cada usuario individualmente.

---

## 3. Resumen y Consideraciones

- **DCL (GRANT/REVOKE):**  
  Permite controlar el acceso a los objetos de la base de datos otorgando o retirando permisos a usuarios y roles.

- **Gestión de Usuarios:**  
  Los usuarios son las cuentas individuales que se conectan a la base de datos.

- **Gestión de Roles:**  
  Los roles agrupan privilegios y se asignan a usuarios para facilitar la administración de permisos.

- **Buenas Prácticas:**  
  - Utiliza roles para centralizar la administración de permisos.  
  - Otorga únicamente los privilegios necesarios para cada rol o usuario.  
  - Revoca permisos que ya no sean necesarios para minimizar riesgos de seguridad.

La combinación de DCL, junto con una adecuada gestión de roles y usuarios, es esencial para mantener la seguridad y la integridad de una base de datos, permitiendo que solo los usuarios autorizados realicen operaciones específicas.

---

# Ejercicios Prácticos en la Base de Datos Pagila

A continuación se presentan 7 ejercicios que abarcan TCL, funciones, procedimientos almacenados y DCL. Estos ejercicios tienen un nivel de complejidad moderado y están diseñados para que pongas en práctica conceptos avanzados utilizando la base de datos **pagila**.

---

## Ejercicio 1: Procedimiento Almacenado para Actualizar Tarifas de Alquiler por Categoría

**Objetivo:**  
Crear un procedimiento que reciba el nombre o ID de una categoría y un multiplicador, y que actualice la tarifa de alquiler (`rental_rate`) de todas las películas pertenecientes a esa categoría. Se debe utilizar control de transacciones (TCL) para confirmar o revertir la operación en caso de error.

**Pistas:**  
- Consulta las tablas `film` y `film_category` para identificar las películas de la categoría.
- Utiliza un bloque `BEGIN...EXCEPTION...END` para capturar errores y ejecutar `ROLLBACK` en caso necesario.
- Aplica `COMMIT` al finalizar la transacción correctamente (ten en cuenta que, en un procedimiento almacenado, la gestión de transacciones puede variar según la versión de PostgreSQL).

---

## Ejercicio 2: Función para Calcular Ingresos Totales de una Película

**Objetivo:**  
Crear una función que, dado un `film_id`, calcule el total de ingresos obtenidos por esa película a partir de la suma de los pagos realizados. Se deberá utilizar la tabla `payment` (y relacionar con `rental` e `inventory` si es necesario).

**Pistas:**  
- La función debe retornar un valor numérico (por ejemplo, de tipo `NUMERIC`).
- Considera las relaciones entre las tablas `film`, `inventory`, `rental` y `payment` para filtrar los registros correspondientes.
- Implementa manejo de excepciones para casos en los que el `film_id` no exista o no tenga registros asociados.

---

## Ejercicio 3: Procedimiento Almacenado para Reasignar Inventario entre Tiendas

**Objetivo:**  
Diseñar un procedimiento que permita mover elementos de inventario de una tienda a otra. El procedimiento debe recibir un `film_id`, un `store_id` de origen y otro de destino, y actualizar la tabla `inventory` para reflejar el cambio.

**Pistas:**  
- Verifica que existan suficientes registros en la tienda de origen antes de realizar el traslado.
- Utiliza TCL (COMMIT y ROLLBACK) para asegurar la integridad de la transacción.
- Implementa validaciones y manejo de errores dentro del bloque del procedimiento.

---

## Ejercicio 4: Gestión de Permisos con DCL para Operaciones de Alquiler

**Objetivo:**  
Utilizar comandos DCL para administrar permisos en las tablas relacionadas con los alquileres. Crea un rol llamado `rental_manager` y otorga permisos específicos sobre las tablas `rental`, `payment`, `inventory` y `film`. Luego, retira algunos de esos permisos.

**Pistas:**  
- Usa el comando `CREATE ROLE rental_manager;` para crear el rol.
- Otorga permisos con `GRANT SELECT, INSERT, UPDATE ON ... TO rental_manager;`.
- Revoca permisos con `REVOKE` para limitar algunas operaciones.
- Asegúrate de documentar los comandos utilizados.

---

## Ejercicio 5: Función para Validar la Disponibilidad de Inventario

**Objetivo:**  
Crear una función que reciba un `film_id` y un `store_id`, y retorne la cantidad de copias disponibles (no alquiladas) de esa película en la tienda indicada.

**Pistas:**  
- Utiliza las tablas `inventory` y `rental` para determinar la disponibilidad.
- Considera que una copia está disponible si no se encuentra en un registro activo de la tabla `rental`.
- La función debe incluir manejo de errores para validar que el `film_id` y `store_id` existan.

---

## Ejercicio 6: Procedimiento Almacenado para Procesar el Alquiler de una Película

**Objetivo:**  
Desarrollar un procedimiento que simule el proceso de alquiler de una película. El procedimiento debe:
1. Recibir un `customer_id` y un `film_id`.
2. Verificar la disponibilidad de un inventario para el `film_id` en la tienda asociada al cliente.
3. Insertar un registro en la tabla `rental` y actualizar el estado de la copia en `inventory`.
4. Utilizar TCL para asegurar que, en caso de error, se realice un `ROLLBACK`.

**Pistas:**  
- Realiza las validaciones necesarias sobre disponibilidad antes de insertar.
- Considera la creación de una transacción explícita o el uso de bloques de manejo de errores.
- Puedes utilizar funciones auxiliares (como la del Ejercicio 5) para comprobar la disponibilidad.

---

## Ejercicio 7: Integración de DCL en Funciones y Procedimientos

**Objetivo:**  
Crear una función o procedimiento que realice una operación sensible (por ejemplo, recalcular la tarifa de alquiler de una película basándose en nuevos parámetros). Luego, utilizando DCL, restringe el permiso de ejecución de este objeto solo a un rol específico (por ejemplo, `admin_rental`).

**Pistas:**  
- Define la función/procedimiento y prueba su funcionamiento.
- Utiliza `GRANT EXECUTE ON FUNCTION/PROCEDURE ... TO admin_rental;` para otorgar permisos.
- Realiza pruebas creando un usuario que no pertenezca al rol `admin_rental` y verifica que no pueda ejecutar la función/procedimiento.
- Documenta cada paso y explica cómo los permisos afectan la ejecución.

---

## Bibliografía
- Silberschatz, A., Korth, H. F., & Sudarshan, S. (2019). Database System Concepts (7th ed.). McGraw Hill Education.
- https://neon.tech/postgresql/postgresql-tutorial/postgresql-transaction
