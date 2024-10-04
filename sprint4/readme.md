(https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/cabecera.png)

![IT Academy Logo](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/logoIT.png)


[Ver script de SQL](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint3/sql/script.sql)

[Ver Sprint 4 en PDF](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint3/pdf/sprint4.pdf)

![Nivel 1](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/nivel1.png)

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

### Explicación del Sql

El objetivo de la consulta es obtener una lista de usuarios que han realizado más de 30 transacciones. Para ello, se cuenta la cantidad de transacciones de cada usuario, y solo aquellos usuarios que cumplen con este criterio son incluidos en los resultados. Además, se limita el resultado a un máximo de 5000 registros.


#### Paso a paso:

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
   - Utilizar la tabla `users` como la tabla principal, a la que se le hará uniones para obtener más datos relacionados.

    ```sql
    FROM users u
    ```

3. **Realizar la unión (JOIN) con la tabla `transactions`**  
   - Unir la tabla `transactions` con la tabla `users` mediante una relación en la cual el `user_id` en la tabla `transactions` es igual al `id` del usuario en la tabla `users`.

    ```sql
    JOIN transactions t ON u.id = t.user_id
    ```

4. **Agrupar los datos por usuario (GROUP BY)**  
   - Agrupar los resultados para que cada fila en el resultado corresponda a un usuario único. Esto nos permitirá contar las transacciones de cada usuario.

    ```sql
    GROUP BY u.id, u.name, u.surname
    ```

5. **Filtrar usuarios con más de 30 transacciones (HAVING)**  
   - Usar la cláusula `HAVING` para filtrar a aquellos usuarios cuyo número de transacciones (contadas en el paso anterior) sea mayor a 30.

    ```sql
    HAVING COUNT(t.id) > 30
    ```

6. **Limitar el número de resultados (LIMIT)**  
   - Limitar el número de resultados a 5000, comenzando desde el primer resultado. Esto mejora el rendimiento y evita sobrecargar el sistema si hay muchos usuarios.

    ```sql
    LIMIT 0, 5000;
    ```



![Sql  usuarios con más de 30 transacciones](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/eje08.PNG)

<hr>



# Ejercicio 2:

## Muestra la media de amount por IBAN de las tarjetas de crédito en la compañía Donec Ltd., utiliza por lo menos 2 tablas.


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