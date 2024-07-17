![IT Academy Logo](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/logoIT.png)

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


### SQL - Company y Transaction:
[Ver Estrucutra SQL](https://github.com/ciberzerone/baseDatos/blob/main/lab01/sql/estructura_dades.sql)



# Ejercicio 2: Consultas SQL para el Esquema de Base de Datos

## Consulta 1: Listado de los países que están realizando compras

```sql
SELECT DISTINCT company.country
FROM transaction
JOIN company ON transaction.company_id = company.id;
```

### Imagen de  Listado de los países que están realizando compras:
![Diagrama del Esquema](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/ej02_consulta_pais.PNG)