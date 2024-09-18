import csv

# Definir el tamaño del batch para agrupar múltiples filas en un solo INSERT
batch_size = 1000  # Ajusta este valor según el tamaño de tus datos

# Abre tu archivo CSV
with open('../csv/transactions.csv', newline='', encoding='utf-8') as csvfile:
    csvreader = csv.reader(csvfile, delimiter=';')
    header = next(csvreader)  # Lee el encabezado

    # Preparar las sentencias INSERT INTO
    sql_insert_statements = []
    values_batch = []
    
    for row in csvreader:
        values_batch.append(f"({', '.join([f'\'{item}\'' for item in row])})")

        # Si el tamaño del batch alcanza el límite, agrupa el INSERT
        if len(values_batch) >= batch_size:
            insert_statement = f"INSERT INTO transactions ({', '.join(header)}) VALUES {', '.join(values_batch)};"
            sql_insert_statements.append(insert_statement)
            values_batch = []  # Resetea el batch

    # Si quedaron valores sin procesar, los agrega en el último batch
    if values_batch:
        insert_statement = f"INSERT INTO transactions ({', '.join(header)}) VALUES {', '.join(values_batch)};"
        sql_insert_statements.append(insert_statement)

    # Escribe todas las sentencias SQL a un archivo
    with open('inserts_batch.sql', 'w') as sqlfile:
        for statement in sql_insert_statements:
            sqlfile.write(statement + '\n')

print("Archivo de sentencias SQL por batch generado con éxito.")

