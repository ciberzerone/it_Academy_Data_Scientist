![cabecera](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/cabecera.png)

![IT Academy Logo](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/logoIT.png)


[Ver script de SQL](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint3/sql/script.sql)

[Ver Sprint 4 en PDF](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint3/pdf/sprint4.pdf)

![Nivel 1](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint2/imagen/nivel1.png)

Diseña una base de datos con un esquema de estrella que contenga, al menos 4 tablas de las que puedas realizar las siguientes consultas:

## Sql de Base de Datos  `sprint4`

```sql
-- Creacion base de datos sprint4

CREATE DATABASE IF NOT EXISTS sprint4;
use sprint4;

```
![Sql Creacion Base de datos](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/eje01.PNG)

## Creacion de Tablas: Transacciones, usuarios, producto y tarjeta de credito.
Tabla Fact (hechos): transacciones (la tabla principal que contiene las ventas/operaciones).
Tablas Dimensión: usuarios, productos, y tarjetas_credito.

## Sql de Tabla `Transactions`

```sql
-- Creacion de la tabla Transactions

CREATE TABLE transactions (
    id VARCHAR(50) NOT NULL PRIMARY KEY,  -- Identificador único
    card_id VARCHAR(50) NULL,             -- Puede ser NULL si no hay tarjeta asociada
    business_id VARCHAR(50) NULL,         -- Puede ser NULL si no hay negocio asociado
    timestamp TIMESTAMP NOT NULL,         -- Marca de tiempo obligatoria
    amount DECIMAL(10, 2) NOT NULL,       -- El monto de la transacción no debe ser NULL
    declined BOOLEAN NOT NULL,            -- Indica si la transacción fue rechazada
    product_ids TEXT NULL,                -- Puede ser NULL si no hay productos asociados
    user_id INT NULL,                     -- Puede ser NULL si el usuario no está identificado
    lat DECIMAL(15, 10) NULL,             -- Puede ser NULL si la ubicación no está disponible
    longitude DECIMAL(15, 10) NULL        -- Puede ser NULL si la ubicación no está disponible
);

```

![Sql Creacion tabla transacciones](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/eje02.PNG)

## Sql de Tabla `companies`

```sql
-- Creacion de la tabla companies

CREATE TABLE companies (
    company_id VARCHAR(6) NOT NULL PRIMARY KEY,  -- Identificador único de la compañía
    company_name VARCHAR(100) NOT NULL,          -- Nombre de la compañía es obligatorio
    phone VARCHAR(20) NULL,                      -- Puede ser NULL si no hay teléfono disponible
    email VARCHAR(100) NULL,                     -- Puede ser NULL si no hay email disponible
    country VARCHAR(50) NULL,                    -- Puede ser NULL si no hay país disponible
    website VARCHAR(255) NULL                    -- Puede ser NULL si no hay sitio web disponible
);

```

![Sql Creacion tabla companies](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/eje03.PNG)


## Sql de Tabla `credit_card_data`

```sql
-- Creacion de la tabla credit_card_data

CREATE TABLE credit_card_data (
    id VARCHAR(8) NOT NULL PRIMARY KEY,         -- Identificador único
    user_id INT NOT NULL,                       -- Relación con la tabla de usuarios, siempre presente
    iban VARCHAR(34) NULL,                      -- Puede ser NULL si no hay IBAN disponible
    pan VARCHAR(19) NULL,                       -- Puede ser NULL si no hay PAN disponible
    pin VARCHAR(6) NULL,                        -- Puede ser NULL si no hay PIN disponible
    cvv VARCHAR(4) NULL,                        -- Puede ser NULL si no hay CVV disponible
    track1_data VARCHAR(128) NULL,              -- Puede ser NULL si no hay track1 disponible
    track2_data VARCHAR(128) NULL,              -- Puede ser NULL si no hay track2 disponible
    expiring_date DATE NULL                     -- Puede ser NULL si no hay fecha de expiración disponible
);


```
![Sql Creacion tabla productos](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/eje04.PNG)


## Sql de Tabla `users`

```sql
-- Creacion de la tabla users

CREATE TABLE users (
    id INT NOT NULL PRIMARY KEY,              -- Identificador único
    name VARCHAR(100) NOT NULL,               -- El nombre del usuario no puede ser NULL
    surname VARCHAR(100) NOT NULL,            -- El apellido del usuario no puede ser NULL
    phone VARCHAR(50) NULL,                   -- Puede ser NULL si no hay teléfono disponible
    email VARCHAR(150) NULL,                  -- Puede ser NULL si no hay email disponible
    birth_date DATE NULL,                     -- Puede ser NULL si no hay fecha de nacimiento disponible
    country VARCHAR(50) NULL,                 -- Puede ser NULL si no hay país disponible
    city VARCHAR(100) NULL,                   -- Puede ser NULL si no hay ciudad disponible
    postal_code VARCHAR(20) NULL,             -- Puede ser NULL si no hay código postal disponible
    address VARCHAR(255) NULL                 -- Puede ser NULL si no hay dirección disponible
);
```

![Sql Creacion tabla Users](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/eje05.PNG)


## Sql de Tabla `products`

```sql
-- Creacion de la tabla tarjetas_credito

CREATE TABLE products (
    id INT NOT NULL PRIMARY KEY,              -- Identificador único
    product_name VARCHAR(255) NOT NULL,       -- El nombre del producto no puede ser NULL
    price DECIMAL(10, 2) NOT NULL,            -- El precio no puede ser NULL
    color VARCHAR(7) NULL,                    -- Puede ser NULL si no hay color disponible
    weight DECIMAL(5, 2) NULL,                -- Puede ser NULL si no hay peso disponible
    warehouse_id VARCHAR(10) NULL             -- Puede ser NULL si no hay almacén asociado
);
```

![Sql Creacion tabla Users](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/TableProducts.PNG)

## Importacion de datos `Transactions` `companies` `companies`  `credit_card_data`  `users`  `products`


Configurar la carpeta `C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/` en MySQL y copiar los archivos necesarios para la carga de datos.

### Paso 1: Ubicar la carpeta de donde se importa por inercia

- **MySQL 8.0**: Asegúrate de que MySQL 8.0 está correctamente instalado en tu sistema.
- **Archivos CSV**: Los archivos de datos a cargar deben estar disponibles en formato CSV.

```sql
SHOW VARIABLES LIKE 'secure_file_priv';
```
Para saber la ubicación de la carpeta C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\' donde ir los archivos csv para ser importados

La carpeta `Uploads` de MySQL suele encontrarse en la siguiente ubicación en sistemas Windows:

![Ubicacion de la carpeta](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/permisoCarpetaSql.PNG)

### Paso 2: Configuración de permisos la carpeta

Asegúrate de que el servicio MySQL tiene permisos adecuados para acceder y leer archivos en la carpeta `Uploads`.

1. Haz clic derecho en la carpeta `Uploads`.
2. Selecciona **Propiedades** y ve a la pestaña **Seguridad**.
3. Asegúrate de que el usuario que ejecuta MySQL (normalmente `NT AUTHORITY\SYSTEM` o `mysql`) tiene permisos de **lectura** y **escritura**.



![Permisos carpeta Upload](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/permisoCarpeta.PNG)


### Paso 3: Copiar  y pegar los archivos csv en la carpeta Upload

1. Abre el explorador de archivos y navega a `C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/`.
2. Copia los archivos CSV que deseas cargar desde tu ubicación original a la carpeta `Uploads`.


![Permisos carpeta Upload](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/permisoCarpeta02.PNG)



### Paso 3: Reiniciar MySQL desde Windows Power Shell como administrador

1. Abre Windows PowerShell como administrador.
2. Detén el servicio MySQL con el comando:
```bash

net stop Mysql80

```
3.  Inicia el servicio MySQL nuevamente con el comando:

```bash

net start Mysql80

```

Esto reinicia MySQL para aplicar cualquier cambio en la configuración.

![Reiniciar Mysql](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/reiniciarMysql.PNG)



## Importacion de datos a la tabla `Transactions`

```sql 
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/transactions.csv' ---- Especifica que se está cargando datos desde un archivo
INTO TABLE transactions                                                           ----- Define que los datos se insertarán en la tabla transactions.
FIELDS TERMINATED BY ','                                                          ----- Especifica que los campos en el archivo CSV están separados por punto y coma (;).
ENCLOSED BY '"'                                                                    -----  Indica que los valores de los campos están encerrados entre comillas dobles (").
LINES TERMINATED BY '\n'                                                          -----Indica que cada línea en el archivo está separada por un salto de línea (\n)
IGNORE 1 LINES                                                                    -----  ignorar la primera línea del archivo, que contiene los encabezados de las columnas.
(id, card_id, business_id, timestamp, amount, declined, product_ids, user_id, lat, longitude);  -----Mapea las columnas del archivo CSV a las columnas correspondientes de la tabla
```



![Reiniciar Mysql](https://github.com/ciberzerone/it_Academy_Data_Scientist/blob/main/sprint4/imagen/insertTransactions.PNG)












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