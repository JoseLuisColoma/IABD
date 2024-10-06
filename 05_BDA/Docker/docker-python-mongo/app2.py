from pymongo import MongoClient
from data import clientes

# Conectar a la base de datos MongoDB en el contenedor llamado 'mongobd'
client = MongoClient("mongodb://mongobd:27017")

# Seleccionar la base de datos (se creará si no existe)
db = client["mi_base_de_datos"]

# Insertar documentos de ejemplo en la colección 'clientes'
def insertar_clientes():
    clientes = [
        {"nombre": "Juan Pérez", "edad": 30, "ciudad": "Madrid", "correo": "juan.perez@example.com", "telefono": "+34 612 345 678"},
        {"nombre": "Ana Gómez", "edad": 25, "ciudad": "Barcelona", "correo": "ana.gomez@example.com", "telefono": "+34 678 901 234"},
        {"nombre": "Luis Fernández", "edad": 35, "ciudad": "Valencia", "correo": "luis.fernandez@example.com", "telefono": "+34 912 345 678"},
        {"nombre": "Marta Sánchez", "edad": 28, "ciudad": "Sevilla", "correo": "marta.sanchez@example.com", "telefono": "+34 654 321 987"},
        {"nombre": "Carlos López", "edad": 40, "ciudad": "Bilbao", "correo": "carlos.lopez@example.com", "telefono": "+34 123 456 789"}
    ]

    result = db.clientes.insert_many(clientes)
    print(f"Clientes insertados: {result.inserted_ids}")

# Consultar todos los clientes
def consultar_clientes():
    print("Clientes en la colección:")
    for cliente in db.clientes.find():
        print(cliente)

# Consultar productos por categoría
def consultar_productos_por_categoria(categoria):
    print(f"Productos en la categoría '{categoria}':")
    for producto in db.productos.find({"categoria": categoria}):
        print(producto)

# Consultar órdenes pendientes
def consultar_ordenes_pendientes():
    print("Órdenes pendientes:")
    for orden in db.ordenes.find({"estado": "Pendiente"}):
        print(orden)

# Contar el número de órdenes por cliente
def contar_ordenes_por_cliente():
    print("Número de órdenes por cliente:")
    pipeline = [
        {"$group": {"_id": "$cliente_id", "total": {"$sum": "$cantidad"}}}
    ]
    for resultado in db.ordenes.aggregate(pipeline):
        print(f"Cliente ID: {resultado['_id']}, Total Órdenes: {resultado['total']}")

# Función principal para ejecutar las consultas
def main():
    # Uncomment to insert clients only once
    # insertar_clientes()
    consultar_clientes()
    consultar_productos_por_categoria("Electrónica")
    consultar_ordenes_pendientes()
    contar_ordenes_por_cliente()

# Ejecutar el script
if __name__ == "__main__":
    main()
    client.close()
