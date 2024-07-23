![IT Academy Logo](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/logoIT.png)


[Ver script de SQL](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/sql/bbdd.sql)

[Ver Sprint 3 en PDF](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/pdf/sprint2.pdf)

![Nivel 1](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/nivel1.PNG)

# Ejercicio 1:

El esquema creado incluye dos tablas principales: `company` y `transaction`. A continuación, se describen estas tablas y las variables que contienen, así como las relaciones entre ellas.

## Diseño de la Tabla  `credit_card`

Esta tabla almacena información sobre las tarjetas de creditos involucradas en las transacciones. Contiene los siguientes campos:

### Columnas:

- **id**: Identificador único de la tarjeta de crédito.
- **iban**: Número IBAN de la tarjeta.
- **pan**: Número PAN de la tarjeta.
- **pin**: PIN de la tarjeta.
- **cvv**: Código CVV de la tarjeta.
- **expiring_date**: Fecha de vencimiento de la tarjeta.

### Claves y Relaciones:

- **id**: Clave primaria.


## Sql de tabla  `credit_card`

```sql
-- Creacion la tabla credit_card
CREATE TABLE IF NOT EXISTS credit_card (
    id VARCHAR(15) PRIMARY KEY,
    iban VARCHAR(34),
    pan VARCHAR(19),
    pin VARCHAR(4),
    cvv VARCHAR(4),
    expiring_date DATE
);

```
## Introducir la data en la  `credit_card`
Al insertar los datos, arroja un error por el formato de los datos expiring_date, una solucion podria ser utilizar varchar, pero se utizo STR_TO_DATE(cadena, formato) que convierte los datos de una cadena a un formato de fecha

```sql
-- convertirá la cadena '10/30/22' en la fecha 2022-10-30.
('CcU-2938', 'TR301950312213576817638661', '5424465566813633', '3257', '984', STR_TO_DATE('10/30/22', '%m/%d/%y')),

```

##  Identificar de forma única cada tarjeta en la  `credit_card`


```sql
    id VARCHAR(15) PRIMARY KEY,

```

##  Establecer  relación con la tabla `transaction`

```sql
ALTER TABLE transaction
ADD CONSTRAINT fk_credit_card
FOREIGN KEY (credit_card_id) REFERENCES credit_card(id);

```

## Diagrama del Esquema

A continuación se presenta un diagrama que ilustra la relación entre las tablas `user`, `credit_card`, `company` y `transaction`:

![Diagrama del Esquema](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint3/imagen/eje01ER.PNG)




# Ejercicio 2:  Actualizar número de cuenta del usuario con ID CcU-2938. 

## Consulta 1: La información que debe mostrarse para este registro es: R323456312213576817699999.

### Sql es Mostrar ID CcU-2938

```sql
USE transactions;
SELECT * FROM credit_card
WHERE id = 'CcU-2938';
```


### Imagen de Mostrar ID CcU-2938:
![Listado de los países que están realizando compra](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/ej02_consulta_pais.PNG)



```sql
CREATE INDEX idx_credit_card_iban ON credit_card(iban);
CREATE INDEX idx_credit_card_pan ON credit_card(pan);
```

### Imagen de  Listado de los países que están realizando compras:
![Listado de los países que están realizando compra](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/ej02_consulta_pais.PNG)



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



