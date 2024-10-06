-- --------------------------------
-- Actividad: Repaso SQL
-- ejercicio: act_sql_01
-- Módulo: BDA
-- Ciclo: IABD
-- Curso: 2024-25
-- Alumno: José Luis Coloma Tormo
-- --------------------------------
--
-- Creación de Base de Datos Parts Factory (Fábrica de piezas)
drop database if exists PartsFactory;
create database PartsFactory;
use PartsFactory;
-- Creación de tablas Pieces, Providers, Provides
create table Pieces(
	Code int,
    Name text,
    Primary key (Code)
);
--
create table Providers(
  Code varchar(10), -- Código del proveedor (uso VARCHAR en lugar de TEXT)
  Name text,
  Primary key (Code)
);
-- 
create table Provides (
  Piece int,
  Provider varchar(10), -- Código del proveedor (uso VARCHAR en lugar de TEXT)
  Price int,
  primary key (Piece, Provider),
  foreign key (Piece) references Pieces(Code),
  FOREIGN KEY (Provider) references Providers(Code)
);
-- Inserción de datos
insert into Providers(Code, Name) values('HAL', 'Clarke Enterprises');
insert into Providers(Code, Name) values('RBT', 'Susan Calvin Corp.');
insert into Providers(Code, Name) values('TNBC', 'Skellington Supplies');
insert into Pieces(Code, Name) values(1, 'Sprocket');
insert into Pieces(Code, Name) values(2, 'Screw');
insert into Pieces(Code, Name) values(3, 'Nut');
insert into Pieces(Code, Name) values(4, 'Bolt');
insert into Provides(Piece, Provider, Price) values(1, 'HAL', 10);
insert into Provides(Piece, Provider, Price) values(1, 'RBT', 15);
insert into Provides(Piece, Provider, Price) values(2, 'HAL', 20);
insert into Provides(Piece, Provider, Price) values(2, 'RBT', 15);
insert into Provides(Piece, Provider, Price) values(2, 'TNBC', 14);
insert into Provides(Piece, Provider, Price) values(3, 'RBT', 50);
insert into Provides(Piece, Provider, Price) values(3, 'TNBC', 45);
insert into Provides(Piece, Provider, Price) values(4, 'HAL', 5);
insert into Provides(Piece, Provider, Price) values(4, 'RBT', 7);
--
-- 1. Selecciona el nombre de todas las piezas (Pieces).
select Name as nombre_pieza from Pieces;
-- 2. Selecciona todos los datos de los proveedores (Providers)
select * from Providers;
-- 3. Obtén el precio medio de cada pieza (Muestra solo el código de la pieza y el precio medio)
select Piece as Pieza, round(avg(Price),2) as media_precio from Provides
group by Piece;
-- 4. Obtén los nombres de todos los proveedores que suministran la pieza 1.
select pr.Name as proveedores_de_pieza_1 from Providers pr
  join Provides p on p.Provider=pr.Code
  where Piece = 1;
-- otra forma (sin uso de join, con uniones implícitas como suelo utilizarlo)
select pr.Name, p.Price from Providers pr, Provides p  
 where p.Provider=pr.Code
   and Piece=1;
-- 5. Selecciona el nombre de las piezas suministradas por el proveedor con código "HAL".
select p.Provider as proveedor, pi.Name as Pieza  from Provides p
  join Pieces pi on pi.Code = p.Piece
  and p.Provider='HAL';
-- 2ª forma:
select p.Provider, pi.Name from Provides p, Pieces pi
where  pi.Code = p.Piece
and p.Provider='HAL';
-- 6. Para cada pieza, busque la oferta más cara de esa pieza e incluye el nombre de la pieza, el nombre del proveedor 
-- y el precio (ten en cuenta que podría haber dos proveedores que suministren la misma pieza al precio más caro)
select pi.Name as Piece, pr.Name as Provider, p.Price
from Provides p
join Pieces pi on pi.Code = p.Piece
join Providers pr on pr.Code = p.Provider
where p.Price = (
    select max(p2.Price)
    from Provides p2
    where p2.Piece = p.Piece
);
-- 7. Agregua una entrada a la base de datos para indicar que "Skellington Supplies"
-- (código "TNBC") proporcionará piñones (código "1") por 7 centavos cada uno.
insert into Provides(Piece, Provider, Price) values('1', 'TNBC', 7);
select * from Provides;
-- 8. Aumenta todos los precios en un centavo.
update Provides set Price = Price + 1;
-- 9. Actualizae la base de datos para reflejar que "Susan Calvin Corp." (código "RBT") 
-- no suministrará pernos (código 4).
delete from Provides where Provider='RBT' and Piece=4;
-- 10.Actualiza la base de datos para reflejar que "Susan Calvin Corp." (código "RBT") 
-- no proporcionará ninguna pieza (el proveedor aún debe permanecer en la base de datos).
delete from Provides where Provider = 'RBT';