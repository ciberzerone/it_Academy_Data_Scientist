import csv
from datetime import datetime

# Rutas de archivo
input_file = 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users_ca.csv'
output_file = 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users_ca_cleaned.csv'

# Función para limpiar las comillas alrededor de los campos
def clean_quotes(field):
    # Remover comillas si están en los extremos
    if field.startswith('"') and field.endswith('"'):
        return field[1:-1]
    return field

# Función para limpiar las comas internas solo en el campo 'address'
def clean_address(address):
    return address.replace(',', '')

# Función para convertir la fecha al formato adecuado para MySQL
def format_birth_date(birth_date):
    try:
        # Intentar convertir del formato '%d-%b-%y' a '%Y-%m-%d'
        return datetime.strptime(birth_date, '%d-%b-%y').strftime('%Y-%m-%d')
    except ValueError:
        # Si no se puede convertir, intentar con otro formato
        try:
            # Intentar convertir del formato '%b %d, %Y' a '%Y-%m-%d'
            return datetime.strptime(birth_date, '%b %d, %Y').strftime('%Y-%m-%d')
        except ValueError:
            # Si no se puede convertir, retornar la fecha original sin cambios
            return birth_date

# Leer y procesar el archivo CSV
with open(input_file, mode='r', newline='', encoding='utf-8') as infile, \
     open(output_file, mode='w', newline='', encoding='utf-8') as outfile:

    reader = csv.reader(infile, delimiter=',')
    writer = csv.writer(outfile, delimiter=',')

    # Procesar cada fila
    for row in reader:
        # Limpiar las comillas de todos los campos
        cleaned_row = [clean_quotes(field) for field in row]
        
        # Convertir el campo birth_date al formato adecuado (asumiendo que está en la sexta posición)
        cleaned_row[5] = format_birth_date(cleaned_row[5])
        
        # Limpiar las comas del campo 'address' (suponiendo que es la última columna)
        cleaned_row[-1] = clean_address(cleaned_row[-1])
        
        # Escribir la fila limpia en el archivo de salida
        writer.writerow(cleaned_row)

print(f"Archivo limpiado y guardado como {output_file}")