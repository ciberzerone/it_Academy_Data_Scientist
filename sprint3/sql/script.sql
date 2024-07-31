USE transactions;
--  Ejercicio 1: Creamos la tabla credit_card
CREATE TABLE IF NOT EXISTS credit_card (
    id VARCHAR(15) PRIMARY KEY,
    iban VARCHAR(34),
    pan VARCHAR(19),
    pin VARCHAR(4),
    cvv VARCHAR(4),
    expiring_date DATE
);

CREATE TABLE IF NOT EXISTS user (
        id INT PRIMARY KEY,
        name VARCHAR(100),
        surname VARCHAR(100),
        phone VARCHAR(150),
        email VARCHAR(150),
        birth_date VARCHAR(100),
        country VARCHAR(150),
        city VARCHAR(150),
        postal_code VARCHAR(100),
        address VARCHAR(255),
        FOREIGN KEY(id) REFERENCES transaction(user_id)        
    );


-- índices para optimizar las consultas
CREATE INDEX idx_user_id ON transaction(user_id);
CREATE INDEX idx_credit_card_id ON transaction(credit_card_id);

-- establecer una relación adecuada con las otras dos tablas ("transaction" y "company").
ALTER TABLE transaction
ADD CONSTRAINT fk_credit_card
FOREIGN KEY (credit_card_id) REFERENCES credit_card(id);

-- Ejercicio 2:  Actualizar número de cuenta del usuario con ID CcU-2938. 

-- Mostrar antes de actualizar la data
SELECT * FROM credit_card
WHERE id = 'CcU-2938';

-- Actualizar la data update 
UPDATE credit_card
SET iban = 'R323456312213576817699999'
WHERE id = 'CcU-2938';

-- Ejercicio 3:  En la tabla "transaction" ingresa un nuevo usuario con la siguiente información:
-- Deshabilitar las comprobaciones de claves foráneas temporalmente

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


-- Ejercicio 4:  Eliminar la columna `pan` de la tabla `credit_card`. Recuerda mostrar el cambio realizado. 
-- para modificar la tabla 'credit_card' se utilizar 'alter' y para eliminar la columna 'pan' se utiliza drop 

ALTER TABLE credit_card
DROP COLUMN pan;

-- para mostrar los cambios en la tabla 'credit_card' utilizare  Describe credit_card nos muestra la estructura

DESCRIBE credit_card;

