import json
from pymongo import MongoClient

# Conectar a MongoDB
client = MongoClient('mongodb://localhost:27017/')
db = client['mydatabase']  # Nombre de la base de datos
collection = db['mycollection']  # Nombre de la colección

# Cargar datos desde data.json
with open('data.json') as file:
    data = json.load(file)

# Insertar datos en la colección
if isinstance(data, list):
    collection.insert_many(data)
else:
    collection.insert_one(data)

# Realizar consultas
print("Datos insertados:")
for item in collection.find():
    print(item)

# Consultas de ejemplo
contador = collection.count_documents({})
print(f"\nTotal de documentos: {contador}")

contador_mas_30 = collection.count_documents({'edad': {'$gt': 30}})
print(f"Total de personas mayores de 30 años: {contador_mas_30}")




# Cerrar la conexión
client.close()
