![IT Academy Logo](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/logoIT.png)


[Ver scripts SQL](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/sql/bbdd.sql)

[Ver Sprint en PDF](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/pdf/sprint2.pdf)

![Nivel 1](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/nivel1.PNG)

# Ejercicio 1: Esquema de Base de Datos: Company y Transaction

El esquema creado incluye dos tablas principales: `company` y `transaction`. A continuación, se describen estas tablas y las variables que contienen, así como las relaciones entre ellas.

## Tabla `company` 

Esta tabla almacena información sobre las empresas involucradas en las transacciones. Contiene los siguientes campos:

- **id**: Identificador único de la empresa (VARCHAR(15)).
- **company_name**: Nombre de la empresa (VARCHAR(255)).
- **phone**: Número de teléfono de la empresa (VARCHAR(15)).
- **email**: Dirección de correo electrónico de la empresa (VARCHAR(100)).
- **country**: País de la empresa (VARCHAR(100)).
- **website**: Sitio web de la empresa (VARCHAR(255)).

## Tabla `transaction`

Esta tabla registra las transacciones realizadas y contiene los siguientes campos:

- **id**: Identificador único de la transacción (VARCHAR(255)).
- **credit_card_id**: Identificador de la tarjeta de crédito utilizada en la transacción (VARCHAR(15)).
- **company_id**: Identificador de la empresa involucrada en la transacción (VARCHAR(20)), referencia a `company(id)`.
- **user_id**: Identificador del usuario que realiza la transacción (INT), referencia a `user(id)`.
- **lat**: Latitud de la ubicación donde se realizó la transacción (FLOAT).
- **longitude**: Longitud de la ubicación donde se realizó la transacción (FLOAT).
- **timestamp**: Marca de tiempo de la transacción (TIMESTAMP).
- **amount**: Monto de la transacción (DECIMAL(10, 2)).
- **declined**: Indica si la transacción fue rechazada (BOOLEAN).

## Relaciones Entre las Tablas

Las tablas están relacionadas de la siguiente manera:

- La tabla `transaction` tiene una clave foránea `company_id` que referencia a `company(id)`.
- La tabla `transaction` también tiene una clave foránea `user_id` que referencia a `user(id)`, aunque no se proporcionaron detalles de la tabla `user` en el esquema actual.

## Diagrama del Esquema

A continuación se presenta un diagrama que ilustra la relación entre las tablas `company`

A continuación se presenta un diagrama que ilustra la relación entre las tablas `company` y `transaction`:

![Diagrama del Esquema](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/trans01.png)




# Ejercicio 2: Consultas SQL para el Esquema de Base de Datos

## Consulta 1: Listado de los países que están realizando compras

```sql
SELECT DISTINCT company.country
FROM transaction
JOIN company ON transaction.company_id = company.id;
```

### Imagen de  Listado de los países que están realizando compras:
![Listado de los países que están realizando compra](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/ej02_consulta_pais.PNG)


### Explicación del Código

**SELECT:**
Para especificar qué columnas queremos recuperar de la base de datos.

**DISTINCT:**
Para eliminar filas duplicadas del resultado. En este caso, asegurará que solo se devuelvan países únicos.

**company.country:**
Para seleccionar la columna `country` de la tabla `company`.

**FROM transaction:**
Para recuperar los datos de la tabla `transaction`.

**JOIN company ON transaction.company_id = company.id:**
- **JOIN:** Para combinar filas de dos o más tablas basadas en una condición relacionada entre ellas.
- **company:** Es la tabla que estamos uniendo con la tabla `transaction`.
- **ON transaction.company_id = company.id:** especifica la condición de combinar las filas de ambas tablas donde el valor de `company_id` en la tabla `transaction` coincide con el valor de `id` en la tabla `company`.

### Lo que hace la consulta:

- **Unión de tablas:**  unir la tabla `transaction` con la tabla `company` utilizando el campo `company_id` en `transaction` y el campo `id` en `company` para acceder a los datos de ambas tablas en una sola consulta.
- **Selección de países únicos:** Después de unir las tablas, la consulta selecciona los valores únicos de la columna `country` de la tabla `company`.



## Consulta 2: Desde cuántos países se realizan las compras

```sql
SELECT COUNT(DISTINCT company.country) AS total_countries
FROM transaction
JOIN company ON transaction.company_id = company.id;
```

### Imagen de  Listado de cuántos países se realizan las compras: 
![Listado de cuántos países se realizan las compras](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/ej02_consulta_nro_pais.PNG)

### Explicación del Código

**SELECT COUNT(DISTINCT company.country) AS total_countries:**
- **SELECT:** Para especificar qué columnas o expresiones  recuperar de la base de datos.
- **COUNT(DISTINCT company.country):** La función `COUNT` para contar el número de filas. `DISTINCT` dentro de `COUNT`, para contar el número de valores únicos en la columna `company.country`.
- **AS total_countries:** La cláusula `AS` para dar un alias al resultado  `total_countries`. 

**FROM transaction:**
Para recuperar los datos de la tabla `transaction`.

**JOIN company ON transaction.company_id = company.id:**
- **JOIN:** Para combinar la tabla `company` con la tabla `transaction`.
- **ON transaction.company_id = company.id:**  condición que indica para combinar las filas de ambas tablas donde el valor de `company_id` en la tabla `transaction` coincide con el valor de `id` en la tabla `company`.

### Lo que hace la consulta:

- **Unión de tablas:** La consulta une la tabla `transaction` con la tabla `company` utilizando el campo `company_id` en `transaction` y el campo `id` en `company`. Esto permite acceder a los datos de ambas tablas en una sola consulta.
- **Conteo de países únicos:** Después de unir las tablas, la consulta cuenta el número de valores únicos en la columna `country` de la tabla `company` y le asigna el alias `total_countries`.


## Consulta 3: Identificar a la compañía con la mayor media de ventas

```sql 
SELECT company.company_name, ROUND(AVG(transaction.amount),2) AS avg_sales
FROM transaction
JOIN company ON transaction.company_id = company.id
GROUP BY company.company_name
ORDER BY avg_sales DESC
LIMIT 1;
```

### Imagen de consulta Identifica a la compañía con la mayor media de ventas:
![Listado de cuántos países se realizan las compras](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/ej02_consulta_company.PNG)


### Explicación del codigo:

- **Unión de tablas:** La consulta combina las filas de la tabla `transaction` con las filas de la tabla `company` donde `transaction.company_id` es igual a `company.id`. Esto permite acceder a los datos de ambas tablas en una sola consulta.
- **Cálculo del promedio de ventas:** Después de unir las tablas, la consulta calcula el promedio de `amount` para cada compañía (`company_name`).
- **Redondeo del promedio:** El promedio calculado se redondea a 2 decimales.
- **Agrupación por compañía:** La consulta agrupa los resultados por el nombre de la compañía (`company_name`).
- **Ordenación y selección del mejor resultado:** Los resultados se ordenan en orden descendente según el promedio de ventas (`avg_sales`), y se limita el resultado a la primera fila, que es la compañía con el promedio de ventas más alto.



# Ejercicio 3: SubConsultas SQL  sin utilizar JOIN

## Consulta 1: Muestra todas las transacciones realizadas por empresas de Alemania.

```sql
SELECT *
FROM transaction
WHERE company_id IN (
    SELECT id
    FROM company
    WHERE country = 'Germany'
);
```
### Imagen de consulta todas las transacciones realizadas por empresas de Alemania.:
![Listado de cuántos países se realizan las compras](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/ej03_consulta_germany.PNG)

### Explicación del codigo:

- **Subconsulta: SELECT id  FROM company WHERE country = 'Germany'** 

Seleccionar todos los id de la tabla `company` donde el country es `Germany` para obtener la lista de id de las compañías que están en Alemania.

- **Consulta principal: SELECT * FROM transaction WHERE company_id IN** 
Luego, la consulta principal selecciona todas las columnas (*) de la tabla transaction donde el company_id está en la lista de id obtenidos de la subconsulta.

## Consulta 2: Lista las empresas que han realizado transacciones por un amount superior a la media de todas las transacciones.

```sql
    USE transactions;
    select * from company where id in ( select company_id from transaction where amount > (select avg(amount) from transaction));
```
### Imagen de consulta  empresas que han realizado transacciones por un amount superior a la media de todas las transacciones:
![Listado empresas que han realizado transacciones por un amount superior a la media de todas las transacciones](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/ej03_consulta_media.PNG)



## Consulta 3: Eliminar del sistema las empresas que carecen de transacciones registradas, entrega el listado de estas empresas..

```sql
SELECT *
FROM company
WHERE id NOT IN (
    SELECT DISTINCT company_id
    FROM transaction
);
```
### Imagen de consulta  empresas que carecen de transacciones registradas:
![Listado empresas que carecen de transacciones registradas](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/ej03_consulta_delete03.PNG)
### Para probarlo inserte un registro en la tabla company  
```sql
USE transactions;
INSERT INTO company (id, company_name, phone, email, country, website) VALUES (        'b-2124', 'No tute', '06 77 15 31 14', 'amus@protonmail.couk', 'United Kingdom', 'https://gua.co.uk/settings');
```
### Imagen de sql inserte un registro en la tabla company:
![Listado empresas que carecen de transacciones registradas](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/ej03_consulta_delete02.PNG)


### Imagen de consulta  empresas que carecen de transacciones registradas:
```sql
SELECT *
FROM company
WHERE id NOT IN (
    SELECT DISTINCT company_id
    FROM transaction
);
```
### Imagen de aplicacion de sql con el registro insertado:
![Listado empresas que carecen de transacciones registradas](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/ej03_consulta_delete01.PNG)


### Ejecutar la consulta de eliminación
```sql
DELETE FROM company
WHERE id NOT IN (
    SELECT DISTINCT company_id
    FROM transaction
);
```
### Imagen de aplicacion de sql con el registro insertado:
![Listado empresas que carecen de transacciones registradas](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/ej03_consulta_delete04.PNG)
<hr>



