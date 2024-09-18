![IT Academy Logo](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/logoIT.png)


[Ver script de SQL](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint3/sql/script.sql)

[Ver Sprint 4 en PDF](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint3/pdf/sprint4.pdf)

![Nivel 1](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/nivel1.PNG)

Diseña una base de datos con un esquema de estrella que contenga, al menos 4 tablas de las que puedas realizar las siguientes consultas:

## Sql de Base de Datos  `proyecto_db`

```sql
-- Creacion base de datos proyecto_db

CREATE DATABASE proyecto_db;
USE proyecto_db;

```
![Sql Creacion Base de datos](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/eje01.PNG)

## Creacion de Tablas: Transacciones, usuarios, producto y tarjeta de credito.
Tabla Fact (hechos): transacciones (la tabla principal que contiene las ventas/operaciones).
Tablas Dimensión: usuarios, productos, y tarjetas_credito.

## Sql de Tabla `Transacciones`

```sql
-- Creacion de la tabla transacciones

CREATE TABLE transactions (
    id    VARCHAR(36) NOT NULL  PRIMARY KEY,
    card_id VARCHAR(50),
    business_id VARCHAR(50),
    timestamp TIMESTAMP,
    amount DECIMAL(10, 2),
    declined BOOLEAN,
    product_ids TEXT, 
    user_id INT,
    lat DECIMAL(15, 10),
    longitude DECIMAL(15, 10)
    );


```

![Sql Creacion tabla transacciones](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/eje02.PNG)

## Sql de Tabla `companies`

```sql
-- Creacion de la tabla companies

CREATE TABLE companies (
    company_id VARCHAR(10) PRIMARY KEY,
    company_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    country VARCHAR(50),
    website VARCHAR(200)
);

```

![Sql Creacion tabla companies](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/eje03.PNG)


## Sql de Tabla `credit_card_data`

```sql
-- Creacion de la tabla credit_card_data

CREATE TABLE credit_card_data (
    id VARCHAR(10) PRIMARY KEY,
    user_id INT,
    iban VARCHAR(34),
    pan VARCHAR(19),
    pin VARCHAR(10),
    cvv VARCHAR(4),
    track1_data VARCHAR(128),
    track2_data VARCHAR(128),
    expiring_date DATE
);


```
![Sql Creacion tabla productos](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/eje04.PNG)


## Sql de Tabla `users`

```sql
-- Creacion de la tabla tarjetas_credito

CREATE TABLE users (
    id INT PRIMARY KEY,            
    name VARCHAR(100),             
    surname VARCHAR(100),          
    phone VARCHAR(50),             
    email VARCHAR(150),            
    birth_date DATE,               
    country VARCHAR(100),          
    city VARCHAR(100),             
    postal_code VARCHAR(20),       
    address VARCHAR(255)           
);

```

![Sql Creacion tabla Users](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/eje05.PNG)




## Esquema estrella de la base de datos


```sql
-- Alterar a las tablas agregando las relaciones 

# darle esquema de estrella 
-- Agregar clave foránea para `user_id` que referencia a la tabla `users`
ALTER TABLE transactions
ADD CONSTRAINT fk_user
FOREIGN KEY (user_id) REFERENCES users(id);

-- Agregar clave foránea para `card_id` que referencia a la tabla `credit_card_data`
ALTER TABLE transactions
ADD CONSTRAINT fk_card
FOREIGN KEY (card_id) REFERENCES credit_card_data(id);

-- Agregar clave foránea para `business_id` que referencia a la tabla `companies`
ALTER TABLE transactions
ADD CONSTRAINT fk_business
FOREIGN KEY (business_id) REFERENCES companies(company_id);


```


![Sql Alteracion de las tablas](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/eje06.PNG)



## ER de la base de datos



![Sql Alteracion de las tablas](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/eje07.PNG)



# Ejercicio 1:

## Realiza una subconsulta que muestre a todos los usuarios con más de 30 transacciones utilizando al menos 2 tablas.


## Sql de tabla Usuarios con más de 30 transacciones

```sql
-- Usuarios con más de 30 transacciones
SELECT u.id, u.name, u.surname, COUNT(t.id) AS transaction_count
FROM users u
JOIN transactions t ON u.id = t.user_id
GROUP BY u.id, u.name, u.surname
HAVING COUNT(t.id) > 30
LIMIT 0, 5000;
```

### Explicacion:

# Explicación del Pseudocódigo

El objetivo de la consulta es obtener una lista de usuarios que han realizado más de 30 transacciones. Para ello, se cuenta la cantidad de transacciones de cada usuario, y solo aquellos usuarios que cumplen con este criterio son incluidos en los resultados. Además, se limita el resultado a un máximo de 5000 registros.

## Pseudocódigo detallado:

1. **Seleccionar columnas relevantes**  
   - Seleccionamos los datos de los usuarios (`id`, `name`, `surname`).
   - Contamos cuántas transacciones tiene cada usuario.

2. **Especificar la fuente de datos primaria**  
   - Usamos la tabla de usuarios (`users`) como fuente principal de la consulta.

3. **Relacionar los datos entre las tablas**  
   - Unimos la tabla `transactions` con la tabla `users` para relacionar las transacciones con los usuarios.
   - La relación entre las dos tablas se realiza a través del campo `user_id` en la tabla `transactions`, que debe coincidir con el `id` del usuario en la tabla `users`.

4. **Agrupar los resultados**  
   - Agrupamos los resultados por usuario, usando `id`, `name` y `surname`.
   - Esto es necesario para contar cuántas transacciones tiene cada usuario y asegurar que los resultados no se dupliquen.

5. **Filtrar los usuarios que cumplen con una condición**  
   - Usamos la función `HAVING` para filtrar a los usuarios que tienen más de 30 transacciones, contando las filas de la tabla `transactions` por usuario.

6. **Limitar los resultados**  
   - Finalmente, limitamos la cantidad de resultados a un máximo de 5000 usuarios para optimizar la consulta y evitar sobrecargar el sistema.

## Pseudocódigo paso a paso:

1. **Inicio de la consulta**  
   - Definir las columnas a seleccionar:
     - `u.id`: el identificador único del usuario.
     - `u.name`: el nombre del usuario.
     - `u.surname`: el apellido del usuario.
     - `COUNT(t.id)`: el conteo de transacciones realizadas por ese usuario, usando el campo `id` de la tabla `transactions`.

    ```sql
    SELECT u.id, u.name, u.surname, COUNT(t.id) AS transaction_count
    ```

2. **Especificar la tabla base (tabla `users`)**  
   - Utilizamos la tabla `users` como la tabla principal, a la que se le hará uniones para obtener más datos relacionados.

    ```sql
    FROM users u
    ```

3. **Realizar la unión (JOIN) con la tabla `transactions`**  
   - Unimos la tabla `transactions` con la tabla `users` mediante una relación en la cual el `user_id` en la tabla `transactions` es igual al `id` del usuario en la tabla `users`.

    ```sql
    JOIN transactions t ON u.id = t.user_id
    ```

4. **Agrupar los datos por usuario (GROUP BY)**  
   - Agrupamos los resultados para que cada fila en el resultado corresponda a un usuario único. Esto nos permitirá contar las transacciones de cada usuario.

    ```sql
    GROUP BY u.id, u.name, u.surname
    ```

5. **Filtrar usuarios con más de 30 transacciones (HAVING)**  
   - Usamos la cláusula `HAVING` para filtrar a aquellos usuarios cuyo número de transacciones (contadas en el paso anterior) sea mayor a 30.

    ```sql
    HAVING COUNT(t.id) > 30
    ```

6. **Limitar el número de resultados (LIMIT)**  
   - Limitamos el número de resultados a 5000, comenzando desde el primer resultado. Esto mejora el rendimiento y evita sobrecargar el sistema si hay muchos usuarios.

    ```sql
    LIMIT 0, 5000;
    ```

## Explicación de cada paso:

1. **Seleccionar las columnas**:
   - Se seleccionan las columnas `id`, `name` y `surname` de los usuarios.
   - Se cuenta cuántas transacciones (`t.id`) tiene cada usuario usando `COUNT(t.id)` y se le da el alias `transaction_count`.

2. **Tabla principal (`FROM users`)**:
   - La tabla `users` es la fuente principal de datos para la consulta.

3. **Unión (JOIN)**:
   - Se realiza un `JOIN` para unir la tabla `users` con `transactions`, relacionando el `user_id` en `transactions` con el `id` de la tabla `users`.

4. **Agrupación (`GROUP BY`)**:
   - Se agrupan los resultados por los campos `id`, `name` y `surname` del usuario. Esto garantiza que cada usuario tenga una única fila en el resultado.

5. **Filtro (`HAVING`)**:
   - Se usa la cláusula `HAVING` para filtrar aquellos usuarios cuyo conteo de transacciones sea mayor a 30.

6. **Limitación de resultados (`LIMIT`)**:
   - Finalmente, se usa `LIMIT` para restringir el número de usuarios devueltos a un máximo de 5000 filas, optimizando el rendimiento.


![Sql  usuarios con más de 30 transacciones](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/eje08.PNG)



## Introducir la data en la  `credit_card`
Al insertar los datos, arroja un error por el formato de los datos expiring_date, una solucion podria ser utilizar varchar, pero se utizo STR_TO_DATE(cadena, formato) que convierte los datos de una cadena a un formato de fecha

```sql
-- convertirá la cadena '10/30/22' en la fecha 2022-10-30.
('CcU-2938', 'TR301950312213576817638661', '5424465566813633', '3257', '984', STR_TO_DATE('10/30/22', '%m/%d/%y')),
... los demas registros ...
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


# Ejercicio 2:  
Muestra la media de amount por IBAN de las tarjetas de crédito en la compañía Donec Ltd., utiliza por lo menos 2 tablas.

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


# Ejercicio 3:  En la tabla `transaction` ingresar un nuevo usuario. 

## Ingresar los siguientes datos:

### Imagen de  Datos a ingresar:
![Mostrar ID CcU-2938](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint3/imagen/eje03_insertar01.PNG)


### Sql de Insert de los datos en la tabla 'transaction' pero a la vez debe ingresarse datos en  tablas:  'company' 'user' 'credit_card'.

```sql
-- Considerando que tambien tenemos los datos de las 'company' 'user' 'credit_card' procedemos a ingresar los datos

-- Insertar un nuevo registro en la tabla 'company'
INSERT INTO company (id, company_name, phone, email, country, website) 
VALUES ('b-9999', 'Ey tacademy', '1234567890', 'contact@eit.com', 'CountryName', 'http://example.com');

-- Insertar un nuevo registro en la tabla 'user'
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) 
VALUES (9999, 'John', 'Doe', '9876543210', 'john.doe@example.com', '1990-01-01', 'barca', 'barcasas', '12345', '123 Main St');

-- Insertar un nuevo registro en la tabla 'credit_card'
INSERT INTO credit_card (id, iban, pan, pin, cvv, expiring_date) 
VALUES ('CcU-9999', 'TR301950312213576817638661', '5424465566813633', '3257', '984', STR_TO_DATE('10/30/22', '%m/%d/%y'));

-- Insertar un nuevo registro en la tabla 'transaction'
INSERT INTO transaction (id, credit_card_id, company_id, user_id, lat, longitude, timestamp, amount, declined) 
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', 9999, 829.999, -117.999, NOW(), 111.11, 0);

```


### Imagen de Mostrar ID CcU-2938:
![Mostrar ID CcU-2938](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint3/imagen/eje03_insertar02.PNG)

### Explicar codigo:
- **INSERT INTO** en las tablas 'transaction', 'company', 'user', 'credit_card'  para evitar Código de error: 1452 que ocurre por solo ingresar los datos en solo en  la tabla 'transaction'.



# Ejercicio 4: Desde recursos humanos te solicitan eliminar la columna `pan` de la tabla `credit_card`. Recuerda mostrar el cambio realizado. 

## Eliminar la columna `pan` de la tabla `credit_card`:


### Sql para eliminar 
```sql
ALTER TABLE credit_card
DROP COLUMN pan;
```
### Imagen Elimar columna pan:
![Mostrar ID CcU-2938](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint3/imagen/eje04_eliminar01.PNG)

### Explicar codigo:
Para modificar la tabla 'credit_card' se utilizar 'alter' y para eliminar la columna 'pan' se utiliza drop 


## Mostrar el cambio realizado:

### Sql para mostrar los cambios en la tabla  credit_card
```sql

DESCRIBE credit_card;

```
### Imagen de  mostrando los cambios realizados en la tabla credit_card:
![Mostrar ID CcU-2938](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint3/imagen/eje04_eliminar02.PNG)

### Explicar codigo:
-- para mostrar  describe credit_card nos muestra la estructura 
