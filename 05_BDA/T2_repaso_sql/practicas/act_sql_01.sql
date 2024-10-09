-- ------------------------------
-- Actividad: Repaso SQL
-- ejercicio: act_sql_01
-- Módulo: BDA
-- Ciclo: IABD
-- Curso: 2024-25
-- Alumno: José Luis Coloma Tormo
-- -------------------------------
-- 
-- NOTA INCIAL: El código al terminarlo, lo he formateado (en Workbench: Ctrl+b) y arreglado un poco
-- para que quede más legible
--
-- Creación de Base de Datos Fábrica de piezas
-- Dropeo primero la base de datos (para pruebas y crearla desde inicio cada vez)
DROP DATABASE IF EXISTS fabrica_piezas;
CREATE DATABASE fabrica_piezas;
USE fabrica_piezas;
-- Creación de tablas Pieces, Providers, Provides
CREATE TABLE Pieces (
    Code INT,
    Name VARCHAR(50),
    PRIMARY KEY (Code)
);
CREATE TABLE Providers (
    Code VARCHAR(10),
    Name VARCHAR(100),
    PRIMARY KEY (Code)
);
CREATE TABLE Provides (
    Piece INT,
    Provider VARCHAR(10),
    Price INT,
    PRIMARY KEY (Piece , Provider),
    FOREIGN KEY (Piece)
        REFERENCES Pieces (Code),
    FOREIGN KEY (Provider)
        REFERENCES Providers (Code)
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
SELECT Name AS nom_pieza
  FROM Pieces;
-- 2. Selecciona todos los datos de los proveedores (Providers)
SELECT * FROM Providers;
-- 3. Obtén el precio medio de cada pieza (Muestra solo el código de la pieza y el precio medio)
SELECT Piece AS cod_pieza, 
       ROUND(AVG(Price), 2) AS media_precio
  FROM Provides
 GROUP BY Piece;
-- 4. Obtén los nombres de todos los proveedores que suministran la pieza 1.
SELECT p.Piece AS nom_pieza, 
       pr.Name AS prov_pieza_1
  FROM Providers pr
  JOIN Provides p ON p.Provider = pr.Code
 WHERE p.Piece = 1;
-- Otra forma (sin uso de joins, con uniones implícitas filtrando por las PK como suelo utilizarlo en el trabajo)
SELECT p.Piece AS cod_pieza, 
       pr.Name AS prov_pieza_1
  FROM Providers pr,
       Provides p
 WHERE p.Provider = pr.Code
   AND Piece = 1;
-- 5. Selecciona el nombre de las piezas suministradas por el proveedor con código "HAL".
SELECT p.Provider AS cod_prov, 
       pi.Name AS nom_pieza
  FROM Provides p
  JOIN Pieces pi ON pi.Code = p.Piece 
   AND p.Provider = 'HAL';
-- Otra forma implícitamente:
SELECT p.Provider AS cod_prov, 
       pi.Name AS nom_pieza
  FROM Provides p,
       Pieces pi
 WHERE pi.Code = p.Piece 
   AND p.Provider = 'HAL';
-- 6. Para cada pieza, busque la oferta más cara de esa pieza e incluye el nombre de la pieza, el nombre del proveedor 
-- y el precio (ten en cuenta que podría haber dos proveedores que suministren la misma pieza al precio más caro)
SELECT pi.Name AS nom_pieza,
       pr.Name AS nom_prov,
       p.Price AS precio_max
  FROM Provides p
  JOIN Pieces pi ON pi.Code = p.Piece
  JOIN Providers pr ON pr.Code = p.Provider
 WHERE p.Price = (
         SELECT MAX(p2.Price)
           FROM Provides p2
          WHERE p2.Piece = p.Piece
          );
-- otra forma:
SELECT pi.Name AS nom_pieza,
       pr.Name AS nom_prov,
       p.Price AS precio_max
  FROM Provides p,
       Pieces pi,
       Providers pr
 WHERE pi.Code = p.Piece
   AND pr.Code = p.Provider
   AND p.Price = (
          SELECT MAX(p2.Price)
            FROM Provides p2
		   WHERE p2.Piece = p.Piece);
-- 7. Agregua una entrada a la base de datos para indicar que "Skellington Supplies"
-- (código "TNBC") proporcionará piñones (código "1") por 7 centavos cada uno.
-- Comprobamos con un Select que el insert se ha realizado correctamente.
INSERT INTO Provides(Piece, Provider, Price) 
	 VALUES('1', 'TNBC', 7);
SELECT * FROM Provides;
-- 8. Aumenta todos los precios en un centavo.
UPDATE Provides 
   SET Price = Price + 1;
-- 9. Actualiza la base de datos para reflejar que "Susan Calvin Corp." (código "RBT") 
-- no suministrará pernos (código 4).
DELETE FROM Provides 
 WHERE Provider = 'RBT' 
   AND Piece = 4;
-- 10.Actualiza la base de datos para reflejar que "Susan Calvin Corp." (código "RBT") 
-- no proporcionará ninguna pieza (el proveedor aún debe permanecer en la base de datos).
DELETE FROM Provides 
 WHERE Provider = 'RBT';
-- comprobaciones finales
 SELECT * FROM Provides;
 SELECT * FROM Providers;