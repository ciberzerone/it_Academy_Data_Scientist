use sprint4;

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


CREATE TABLE companies (
    company_id VARCHAR(150) NOT NULL PRIMARY KEY,  -- Identificador único de la compañía
    company_name VARCHAR(100) NOT NULL,          -- Nombre de la compañía es obligatorio
    phone VARCHAR(20) NULL,                      -- Puede ser NULL si no hay teléfono disponible
    email VARCHAR(100) NULL,                     -- Puede ser NULL si no hay email disponible
    country VARCHAR(50) NULL,                    -- Puede ser NULL si no hay país disponible
    website VARCHAR(255) NULL                    -- Puede ser NULL si no hay sitio web disponible
);

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

CREATE TABLE products (
    id INT NOT NULL PRIMARY KEY,              -- Identificador único
    product_name VARCHAR(255) NOT NULL,       -- El nombre del producto no puede ser NULL
    price DECIMAL(10, 2) NOT NULL,            -- El precio no puede ser NULL
    color VARCHAR(7) NULL,                    -- Puede ser NULL si no hay color disponible
    weight DECIMAL(5, 2) NULL,                -- Puede ser NULL si no hay peso disponible
    warehouse_id VARCHAR(10) NULL             -- Puede ser NULL si no hay almacén asociado
);

-- Importacion de datos a la tabla `Transactions`
-- Especifica que se está cargando datos desde un archivo  
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/transactions.csv' 
-- Define que los datos se insertarán en la tabla transactions.
INTO TABLE transactions                                                           
-- Especifica que los campos en el archivo CSV están separados por punto y coma (;).
FIELDS TERMINATED BY ','                                                          
--  Indica que los valores de los campos están encerrados entre comillas dobles (").
ENCLOSED BY '"'                                                                    
-- Indica que cada línea en el archivo está separada por un salto de línea (\n)
LINES TERMINATED BY '\n'                                                          
--  ignorar la primera línea del archivo, que contiene los encabezados de las columnas.
IGNORE 1 LINES                                                                    
-- Mapea las columnas del archivo CSV a las columnas correspondientes de la tabla
(id, card_id, business_id, timestamp, amount, declined, product_ids, user_id, lat, longitude);  


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/credit_card_data.csv'
INTO TABLE credit_card_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, user_id, iban, pan, pin, cvv, track1_data, track2_data, @expiring_date)
SET expiring_date = STR_TO_DATE(@expiring_date, '%m/%d/%y');


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, product_name, @price, color, weight, warehouse_id)
SET price = REPLACE(@price, '$', '');


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users_usa_cleaned.csv'
INTO TABLE users
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id, name, surname, phone, email, birth_date, country, city, postal_code, address);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users_uk_cleaned.csv'
INTO TABLE users
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id, name, surname, phone, email, birth_date, country, city, postal_code, address);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users_ca_cleaned.csv'
INTO TABLE users
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(id, name, surname, phone, email, birth_date, country, city, postal_code, address);

-- Dar Esquema Estrella

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

-- ejercicio # 1
SELECT u.id, u.name, u.surname, COUNT(t.id) AS total_transactions
FROM users u
JOIN transactions t ON u.id = t.user_id
GROUP BY u.id, u.name, u.surname
HAVING COUNT(t.id) > 30
LIMIT 0, 100;


-- ejercicio # 2

SELECT co.company_name,
       cc.iban,
       ROUND(AVG(t.amount), 2) AS promedio_suma_transacciones
FROM companies co
INNER JOIN transactions t ON co.company_id = t.business_id
INNER JOIN credit_card_data cc ON t.card_id = cc.id
WHERE co.company_name = 'Donec Ltd'
GROUP BY cc.iban;
