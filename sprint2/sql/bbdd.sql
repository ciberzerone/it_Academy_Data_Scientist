    -- Creamos la base de datos
    CREATE DATABASE IF NOT EXISTS transactions;
    USE transactions;

    -- Creamos la tabla company
    CREATE TABLE IF NOT EXISTS company (
        id VARCHAR(15) PRIMARY KEY,
        company_name VARCHAR(255),
        phone VARCHAR(15),
        email VARCHAR(100),
        country VARCHAR(100),
        website VARCHAR(255)
    );


    -- Creamos la tabla transaction
    CREATE TABLE IF NOT EXISTS transaction (
        id VARCHAR(255) PRIMARY KEY,
        credit_card_id VARCHAR(15) REFERENCES credit_card(id),
        company_id VARCHAR(20), 
        user_id INT REFERENCES user(id),
        lat FLOAT,
        longitude FLOAT,
        timestamp TIMESTAMP,
        amount DECIMAL(10, 2),
        declined BOOLEAN,
        FOREIGN KEY (company_id) REFERENCES company(id) 
    );
    -- Ejercicio 2
    -- Consulta 1: Listado de los países que están realizando compras
        SELECT DISTINCT company.country
        FROM transaction
        JOIN company ON transaction.company_id = company.id;

    -- Consulta 2: Desde cuántos países se realizan las compras
        SELECT COUNT(DISTINCT company.country) AS total_countries
        FROM transaction
        JOIN company ON transaction.company_id = company.id;
    
    -- Consulta 3: Identifica a la compañía con la mayor media de ventass
        SELECT company.company_name, AVG(transaction.amount) AS avg_sales
        FROM transaction
        JOIN company ON transaction.company_id = company.id
        GROUP BY company.company_name
        ORDER BY avg_sales DESC
        LIMIT 1;

    -- Ejercicio 3: SubConsultas SQL  sin utilizar JOIN
    -- Consulta 1: Muestra todas las transacciones realizadas por empresas de Alemania.
        SELECT *
        FROM transaction
        WHERE company_id IN (
            SELECT id
            FROM company
            WHERE country = 'Germany'
        );
    -- Consulta 2: Lista las empresas que han realizado transacciones por un amount superior a la media de todas las transacciones.
        SELECT *
        FROM transaction
        WHERE company_id IN (
            SELECT id
            FROM company
            WHERE country = 'Germany'
        );
    -- Consulta 3: Transacciones registradas, entrega el listado de estas empresas
        SELECT *
        FROM company
        WHERE id NOT IN (
        SELECT DISTINCT company_id
        FROM transaction
        );