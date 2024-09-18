import csv

# Definir el tamaño del batch para agrupar múltiples filas en un solo INSERT
batch_size = 1000  # Ajusta este valor según el tamaño de tus datos

# Abre tu archivo CSV
with open('../csv/users.csv', newline='', encoding='utf-8') as csvfile:
    csvreader = csv.reader(csvfile, delimiter=';')
    header = next(csvreader)  # Lee el encabezado

    # Preparar las sentencias INSERT INTO
    sql_insert_statements = []
    values_batch = []
    
    for row in csvreader:
        values_batch.append(f"({', '.join([f'\'{item}\'' for item in row])})")

        # Si el tamaño del batch alcanza el límite, agrupa el INSERT
        if len(values_batch) >= batch_size:
            insert_statement = f"INSERT INTO users ({', '.join(header)}) VALUES {', '.join(values_batch)};"
            sql_insert_statements.append(insert_statement)
            values_batch = []  # Resetea el batch

    # Si quedaron valores sin procesar, los agrega en el último batch
    if values_batch:
        insert_statement = f"INSERT INTO users ({', '.join(header)}) VALUES {', '.join(values_batch)};"
        sql_insert_statements.append(insert_statement)

    # Escribe todas las sentencias SQL a un archivo
    with open('../sql/inserts_transactions.sql', 'w') as sqlfile:
        for statement in sql_insert_statements:
            sqlfile.write(statement + '\n')

print("Archivo de sentencias SQL por batch generado con éxito.")


import csv

# Abrir el archivo CSV
with open('../csv/users.csv', 'r') as file:
    csv_reader = csv.reader(file, delimiter=';')
    
    for row in csv_reader:
        # Convertir fechas al formato correcto
        birth_date = row[5].replace('"', '').strip()
        birth_date = datetime.strptime(birth_date, '%b %d, %Y').strftime('%Y-%m-%d')
        
        # Crear el SQL insert
        insert_query = f"INSERT INTO users (id, name, surname, phone, email, birth_date, country, city, postal_code, address) " \
                       f"VALUES ('{row[0]}', '{row[1]}', '{row[2]}', '{row[3]}', '{row[4]}', '{birth_date}', " \
                       f"'{row[6]}', '{row[7]}', '{row[8]}', '{row[9]}');"
        print(insert_query)


