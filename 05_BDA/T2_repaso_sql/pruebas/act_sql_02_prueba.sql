-- --------------------------------
-- Actividad: Repaso SQL II
-- ejercicio: act_sql_02
-- Módulo: BDA
-- Ciclo: IABD
-- Curso: 2024-25
-- Alumno: José Luis Coloma Tormo
-- --------------------------------
drop database if exists empresa_IA;
create database empresa_IA;
use empresa_IA;
drop database if exists empresa_IA;
create database empresa_IA;
use empresa_IA;
--
create table Gama_producto (
    gama varchar(50),
    descripcion_texto text,
    descripcion_html text,
    imagen varchar(356),
    primary key (gama)
);
--
create table Producto (
    codigo_producto varchar(15),
    nombre varchar(70),
    gama varchar(50),
    dimensiones varchar(25),
    proveedor varchar(50),
    descripcion text,
    cantidad_en_stock smallint,
    precio_venta decimal(15,2),
    precio_proveedor decimal(15,2),
    primary key (codigo_producto),
    foreign key (gama) references Gama_producto(gama)
);
--
create table Detalle_pedido (
    codigo_pedido int,
    codigo_producto varchar(15),
    cantidad int,
    precio_unidad decimal(15,2),
    numero_linea smallint,
    primary key (codigo_pedido, codigo_producto),
    foreign key (codigo_producto) references Producto(codigo_producto)
);
--
create table Oficina (
    codigo_oficina varchar(10),
    ciudad varchar(50),
    pais varchar(50),
    region varchar(50),
    codigo_postal varchar(10),
    telefono varchar(20),
    linea_direccion1 varchar(50),
    linea_direccion2 varchar(50),
    primary key (codigo_oficina)
);
--
create table Empleado (
    codigo_empleado int,
    nombre varchar(50),
    apellido1 varchar(50),
    apellido2 varchar(50),
    extension varchar(10),
    email varchar(100),
    codigo_oficina varchar(10),
    codigo_jefe int,
    puesto varchar(50),
    primary key (codigo_empleado),
    foreign key (codigo_oficina) references Oficina(codigo_oficina)
);
--
create table Cliente (
    codigo_cliente int,
    nombre_cliente varchar(50),
    nombre_contacto varchar(30),
    apellido_contacto varchar(30),
    telefono varchar(15),
    fax varchar(15),
    linea_direccion1 varchar(50),
    linea_direccion2 varchar(50),
    ciudad varchar(50),
    region varchar(50),
    pais varchar(50),
    codigo_postal varchar(10),
    codigo_empleado_rep_ventas int,
    limite_credito decimal(15,2),
    primary key (codigo_cliente),
    foreign key (codigo_empleado_rep_ventas) references Empleado(codigo_empleado)
);
--
create table Pago (
    codigo_cliente int,
    forma_pago varchar(40),
    id_transaccion varchar(50),
    fecha_pago date,
    total decimal(15,2),
    primary key (id_transaccion),
    foreign key (codigo_cliente) references Cliente(codigo_cliente)
);
--
create table Pedido (
    codigo_pedido int,
    fecha_pedido date,
    fecha_esperada date,
    fecha_entrega date,
    estado varchar(15),
    comentarios text,
    codigo_cliente int,
    primary key (codigo_pedido),
    foreign key (codigo_cliente) references Cliente(codigo_cliente)
);
--
-- 1. Devuelve un listado con la ciudad y el teléfono de las oficinas de España

-- 2. Devuelve un listado con los estados de los pedidos. Los estados no deben repetirse.

-- 3. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos.

-- 4. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.

-- 5. Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.

-- 6. Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.

-- 7. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.

-- 8. Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.

-- 9. Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene