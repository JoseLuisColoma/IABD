create database bda_repaso_sql;
use bda_repaso_sql;

-- Crea una tabla llamada "Clientes" con columnas para el nombre, apellido y correo electrónico.
create table Clientes (
	dni varchar(10) primary key,
    nombre varchar(50),
    apellido varchar(50),
    email varchar(100)
);

-- Inserta tres registros en la tabla "Clientes" con información ficticia.
insert into Clientes (dni, nombre, apellido, email) values ('12345678A', 'Jose', 'Perez', 'jose@gmail.com');
insert into Clientes (dni, nombre, apellido, email) values ('23456789B', 'Juan', 'Gómez', 'juan@gmail.com');
insert into Clientes (dni, nombre, apellido, email) values ('34567890C', 'María', 'González', 'maria@gmail.com');
insert into Clientes (dni, nombre, apellido, email) values ('44567890D', 'Ana', 'Paz', 'ana@gmail.com');
insert into Clientes (dni, nombre, apellido, email) values ('66666666X', 'Antonio', 'Hernández', 'antonio@gmail.com');

-- Selecciona todos los registros de la tabla "Clientes".
select * from Clientes;

-- Actualiza el correo electrónico del cliente con nombre "Juan" a "juan.nuevo@email.com".
update Clientes set email = 'juan.nuevo@google,com' where nombre = 'Juan';

-- Elimina el registro de la tabla "Clientes" correspondiente al cliente con apellido "Pérez".
delete from Clientes where apellido = 'Pérez';

-- Crea una tabla llamada "Productos" con columnas para el nombre del producto y su precio.
create table Productos (
	id_producto integer primary key auto_increment,
    nombre_producto varchar(100),
    precio decimal(10,3)
);

-- Inserta cinco registros en la tabla "Productos" con información ficticia.
insert into Productos (nombre_producto, precio) values ('Tarjeta gráfica', 300);
insert into Productos (nombre_producto, precio) values ('Laptop', 300);
insert into Productos (nombre_producto, precio) values ('Teclado', 25);
insert into Productos (nombre_producto, precio) values ('Monitor', 125);
insert into Productos (nombre_producto, precio) values ('Mouse', 9);

select * from Productos;

-- Selecciona todos los productos cuyo precio sea mayor a 50.
select p.* from Productos p where precio > 50;

-- Actualiza el precio del producto llamado "Laptop" a 800.
update Productos p set p.precio = 800 where p.nombre_producto = 'Laptop'; 
 
-- Elimina todos los productos cuyo precio sea menor o igual a 10.
delete from Productos where precio <= 10;

-- Crea una tabla "Pedidos" con las columnas: número de pedido y el cliente al que pertenece (usando una clave externa).
create table Pedidos (
	num_pedido integer auto_increment,
    cliente_id varchar(10),
    primary key (num_pedido),
    foreign key (cliente_id) references Clientes(dni)
);

-- Inserta registros en la tabla "Pedidos", relacionando cada pedido con un cliente existente.
insert into Pedidos (cliente_id) values ('44567890D');
insert into Pedidos (cliente_id) values ('34567890C');
insert into Pedidos (cliente_id) values ('23456789B');
insert into Pedidos (cliente_id) values ('44567890D');
insert into Pedidos (cliente_id) values ('44567890D');

-- Realiza una consulta que muestre el nombre del cliente y el número de pedido para todos los pedidos.
select c.nombre, p.num_pedido 
from Clientes c
join Pedidos p on c.dni = p.cliente_id;

-- Realiza una consulta que muestre el nombre del cliente y la direccíón de correo para todos los clientes que hayan realizado un pedido.
select distinct c.nombre, c.email 
from Clientes c, Pedidos p
where c.dni = p.cliente_id
and exists (select pr.cliente_id from Pedidos pr where c.dni = pr.cliente_id);

-- Realiza una consulta que muestre el nombre del cliente y la cantidad total de pedidos que ha realizado.
select c.nombre, count(p.num_pedido) as total_pedidos
from Clientes c
join Pedidos p on c.dni = p.cliente_id
group by c.nombre;
