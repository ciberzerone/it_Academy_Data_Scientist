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



<hr>


# Ejercicio 2:  Actualizar número de cuenta del usuario con ID CcU-2938. 

## Consulta 1: La información que debe mostrarse para este registro es: R323456312213576817699999.

### Sql es Mostrar ID CcU-2938

```sql
USE transactions;
SELECT * FROM credit_card
WHERE id = 'CcU-2938';
```


### Imagen de Mostrar ID CcU-2938:
![Mostrar ID CcU-2938](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint3/imagen/eje02_actualizar01.PNG)


### Sql Actualizacion del campo Iban del id CcU-2938

```sql
USE transactions;
UPDATE credit_card
SET iban = 'R323456312213576817699999'
WHERE id = 'CcU-2938';
```

### Imagen de sql de la Actualizacion del campo Iban del id CcU-2938:
![sql de la Actualizacion del campo Iban del id CcU-2938](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint3/imagen/eje02_actualizar02.PNG)

### Sql Mostrar campo Iban del id CcU-2938 actualizado

```sql
SELECT * FROM credit_card
WHERE id = 'CcU-2938';
```

### Imagen de  Sql Mostrar campo Iban del id CcU-2938 actualizado:
![Sql Mostrar campo Iban del id CcU-2938 actualizado](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint3/imagen/eje02_actualizar03.PNG)

<hr>


# Ejercicio 2:  En la tabla `transaction` ingresar un nuevo usuario. 

## Consulta 1: Ingresar los siguientes datos:

### Imagen de  Datos a ingresar:
![Mostrar ID CcU-2938](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint3/imagen/eje02_actualizar01.PNG)


### Sql es Mostrar ID CcU-2938

```sql
USE transactions;
SELECT * FROM credit_card
WHERE id = 'CcU-2938';
```


### Imagen de Mostrar ID CcU-2938:
![Mostrar ID CcU-2938](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint3/imagen/eje02_actualizar01.PNG)

