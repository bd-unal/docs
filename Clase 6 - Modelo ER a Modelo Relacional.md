# Del Modelo ER al Modelo Relacional

# Recapitulando..

Los modelos ER conceptuales permiten representar el área temática con mayor precisión que los modelos lógicos \(relacionales\, de red\, etc\.\)\.

Sin embargo\, no existen sistemas de gestión de bases de datos que admitan modelos ER\.

Por lo tanto\, el diagrama ER se convierte en tablas en el modelo de datos relacional \(modelo lógico\)\.

Los modelos relacionales se pueden implementar fácilmente mediante sistemas de gestión de bases de datos relacionales como MySQL\, SQL Server\, PostgreSQL\, Oracle\, etc\. Con el uso de herramientas CASE \(Computer Aided Software Engineering\)\.

# ER2RDM (Entity-Relationship to Relationship Data Model)

El método ER2RDM se basa en transformar un diagrama ER en un conjunto de tablas relacionales iniciales\, considerando cuidadosamente cada uno de sus componentes:  _atributos atómicos_ \,  _atributos multivaluado_ s\,  _cardinalidades_  y la  _obligatoriedad de las relaciones_ \.

El proceso consta de dos etapas principales:

__Conversión inicial:__  Se crea un modelo lógico relacional \(RDM\) a partir del diagrama ER\, donde cada entidad y relación se traduce en tablas con atributos claramente definidos\.

__Optimización y normalización__ : El modelo lógico inicial se optimiza mediante técnicas de normalización para reducir redundancias\, mejorar la integridad de los datos y garantizar un diseño eficiente\.

# El esquema relacional

El esquema especifica el nombre de la relación\, el nombre de cada campo \(o columna\, o atributo\) y el dominio de cada campo\.

La información de los estudiantes en una base de datos universitaria puede almacenarse en una relación con el siguiente esquema:

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional0.png)

# Tipos de datos

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional1.png)

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional2.png)

# Las 12 Reglas de Mapeo ER2RDM

# REGLA-01: PARA CONJUNTO DE ENTIDADES FUERTES CON SOLO ATRIBUTOS SIMPLES

Un conjunto de  __entidades fuertes__  con solo atributos simples requerirá sólo una tabla en el modelo relacional\.

Los atributos de la tabla serán los atributos del conjunto de entidades\.

Se  __eliminarán__  los atributos derivados de la tabla\.

La  __clave principal__  de la tabla será el atributo clave del conjunto de entidades\.

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional3.png)

# REGLA-02: PARA CONJUNTO DE ENTIDADES FUERTES CON ATRIBUTOS COMPUESTOS

Un conjunto de entidades fuertes con cualquier número de atributos compuestos requerirá sólo una tabla en el modelo relacional\.

Durante la conversión\, se tienen en cuenta los atributos simples de los atributos compuestos y no los atributos compuestos\.

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional4.png)

# REGLA-03: PARA CONJUNTO DE ENTIDADES FUERTES CON ATRIBUTOS MULTIVALUADOS

Un conjunto de entidades fuertes con cualquier cantidad de atributos multivaluados requerirá 2 tablas en el modelo relacional\.

Una tabla contendrá todos los  __atributos simples con la clave principal__ \.

La otra tabla contendrá la  __clave principal y todos los atributos multivaluados\.__

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional5.png)

# Ejercicio

Construye el esquema relacional a partir del siguiente diagrama ER:

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional6.png)

# REGLA-04: PARA RELACIÓN BINARIA CON CONJUNTO DE ENTIDADES DÉBILES

* __Una entidad débil:__
  * Depende de una  __entidad fuerte__  para su identificación\.
* En esta regla:
  * La clave primaria de la  __entidad débil__  se crea combinando la clave primaria de la entidad fuerte con los atributos de la entidad débil que son candidatos a formar una clave parcial\.
  * La relación binaria entre la entidad débil y la fuerte se transforma en una tabla para la entidad débil que incluye la clave foránea a la tabla de la entidad fuerte\.

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional7.png)

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional8.png)

# REGLA-05: MAPEAR UN CONJUNTO DE RELACIONES SIN DESCRIPCIÓN EXPLÍCITA DE LAS CARDINALIDADES

* Esta regla se utiliza cuando una relación no tiene una descripción explícita de las cardinalidades \(por ejemplo\, 1:1\, 1:N o N:M\)\. En este caso\, se asume que la relación puede ser N:M por defecto\.
* Una relación entre 2 relaciones requerirá 3 tablas en el modelo relacional\.
* Los atributos de la tabla son:
  * Los atributos de clave principal de los conjuntos de entidades participantes
  * Sus propios atributos descriptivos\, si los hubiera\.
* El conjunto de atributos no descriptivos será la clave principal

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional9.png)

# REGLA-06: MAPEAR RELACIONES BINARIAS CON CARDINALIDAD M:N

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional10.png)

# REGLA-06: MAPEAR RELACIONES BINARIAS CON CARDINALIDAD M:N (EJEMPLO)

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional11.png)

# REGLA-07: MAPEAR RELACIONES BINARIAS CON CARDINALIDAD 1:N O N:1

* Agregar una clave foránea \(FK\):
  * La clave primaria de la entidad del lado 1 se agrega como clave foránea en la tabla del lado N\.
  * La clave foránea establece la relación entre las dos tablas\.
* Incluir atributos de la relación \(si existen\):
  * Si la relación tiene atributos propios\, estos se agregan como columnas adicionales en la tabla del lado N\.
* Evitar crear una tabla independiente para la relación:
  * La relación se representa directamente mediante la clave foránea\, por lo que no es necesario crear una tabla separada\.

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional12.png)

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional13.png)

# REGLA-08: MAPEAR RELACIONES BINARIAS CON CARDINALIDAD 1:0,N

Se tratan de la misma manera que las relaciones binarias con cardinalidad 1:N o  N:1\, la diferencia está en que la clave foránea que se agrega a entidad del lado N puede tomar valores NULL \(nullable\)\.

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional14.png)

Una relación uno a uno \(1:1\) significa que cada instancia de una entidad puede estar relacionada con solo una instancia de otra entidad\, y viceversa\. Para asignar una relación 1:1  en un modelo ER a un modelo relacional\, puede elegir una de las entidades como entidad principal y la otra como entidad secundaria\. Luego\, puede agregar la clave principal de la entidad principal como una clave externa en la tabla de entidades secundarias\. Alternativamente\, puede fusionar las dos entidades en una tabla y usar una clave principal única para ambas\.

# REGLA-09: MAPEAR RELACIONES BINARIAS CON CARDINALIDAD 1:1 (EJEMPLO)

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional15.png)

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional16.png)

# REGLA-10: MAPEAR RELACIONES BINARIAS CON CARDINALIDAD 1,1:0,1 OR 0,1:1,1

* Una entidad tiene cardinalidad 1\,1 \(relación obligatoria\)\, mientras que la otra tiene cardinalidad 0\,1 \(relación opcional\)\.
* Agregar la clave foránea en la tabla del lado opcional \(0\,1\):
  * La clave foránea se coloca en la tabla de la entidad con cardinalidad 0\,1\.
* Incluir restricciones de unicidad:
  * Se asegura que la clave foránea en el lado opcional tenga una restricción UNIQUE y sea requerida\.

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional17.png)

# REGLA-11: MAPEAR RELACIONES BINARIAS CON CARDINALIDAD 0,1:0,1

* Ambas entidades tienen cardinalidad 0\,1\.
* Cada instancia de una entidad puede o no estar asociada con una instancia de la otra entidad\.
* Es una relación opcional en ambas direcciones\, lo que significa que ambas entidades pueden existir sin relación alguna\.
* Clave foránea en cualquiera de las entidades:
  * La clave foránea puede colocarse en cualquiera de las tablas\, dependiendo del diseño\.
* No se requiere restricción de unicidad:
  * Como la relación es opcional en ambas direcciones\, puede aplicarse la restricción UNIQUE con NULL\.

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional18.png)

# REGLA-12: MAPEAR RELACIONES TERNARIAS CON CARDINALIDAD N:M:W

* Una relación ternaria involucra tres entidades conectadas entre sí en una única relación\. El caso N:M:W describe una situación donde:
  * Cada instancia de las tres entidades puede estar asociada con múltiples instancias de las otras\.
  * La relación no se puede descomponer en relaciones binarias sin perder información o introducir redundancia\.
* Para transformarla en el modelo relacional:
  * Crear una tabla para cada entidad
  * Crear una tabla para la relación ternaria donde la llave primaria es una llave compuesta de las 3 llaves foráneas\.

# REGLA-12: MAPEAR RELACIONES TERNARIAS CON CARDINALIDAD (EJEMPLO)

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional19.png)

# Ejercicio

# Ejercicio en clase

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional20.png)

# Tarea

![](images/Del%20Modelo%20ER%20al%20modelo%20relacional21.png)

# Bibliografia

__Avi Silberschatz\, Henry F\. Korth\, S\. Sudarshan \(2019\) \- Database System Concepts\, Seventh Edition\, McGraw\-Hill\.__

_[https://dbs\.academy\.lv/lection/dbs\_LS06EN\_er2rm\.pdf](https://dbs.academy.lv/lection/dbs_LS06EN_er2rm.pdf)_

_[https://www\.linkedin\.com/advice/1/how\-do\-you\-map\-cardinality\-constraints\-from\-er\-relational\#:~:text=To%20map%20a%201%3A1\,in%20the%20child%20entity%20table](https://www.linkedin.com/advice/1/how-do-you-map-cardinality-constraints-from-er-relational#:~:text=To%20map%20a%201%3A1,in%20the%20child%20entity%20table)_  __\.__

__https://itsmeebin\.wordpress\.com/wp\-content/uploads/2023/06/mm2\.pdf__

# 

