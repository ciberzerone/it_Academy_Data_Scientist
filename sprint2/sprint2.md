![IT Academy Logo](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/logoIT.png)


[Ver base datos en SQL](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/sql/bbdd.sql)

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

## Consulta 2: Desde cuántos países se realizan las compras

```sql
SELECT COUNT(DISTINCT company.country) AS total_countries
FROM transaction
JOIN company ON transaction.company_id = company.id;
```

### Imagen de  Listado de cuántos países se realizan las compras:
![Listado de cuántos países se realizan las compras](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/ej02_consulta_nro_pais.PNG)

## Consulta 3: Identifica a la compañía con la mayor media de ventass

```sql
SELECT company.company_name, AVG(transaction.amount) AS avg_sales
FROM transaction
JOIN company ON transaction.company_id = company.id
GROUP BY company.company_name
ORDER BY avg_sales DESC
LIMIT 1;
```

### Imagen de consulta Identifica a la compañía con la mayor media de ventas:
![Listado de cuántos países se realizan las compras](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/ej02_consulta_company.PNG)


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


## Consulta 2: Lista las empresas que han realizado transacciones por un amount superior a la media de todas las transacciones.

```sql
SELECT *
FROM transaction
WHERE company_id IN (
    SELECT id
    FROM company
    WHERE country = 'Germany'
);
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



