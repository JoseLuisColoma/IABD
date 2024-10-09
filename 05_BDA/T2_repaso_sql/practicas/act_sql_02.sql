-- --------------------------------
-- Actividad: Repaso SQL II
-- ejercicio: act_sql_02
-- Módulo: BDA
-- Ciclo: IABD
-- Curso: 2024-25
-- Alumno: José Luis Coloma Tormo
-- --------------------------------
USE jardineria;
-- 1. Devuelve un listado con la ciudad y el teléfono de las oficinas de España
SELECT pais,
       ciudad, 
	   telefono
  FROM oficina
 WHERE pais = 'España';
--
-- 2. Devuelve un listado con los estados de los pedidos. Los estados no deben repetirse.
SELECT DISTINCT estado
  FROM pedido;
--
-- 3. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. 
-- Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos.
SELECT DISTINCT c.codigo_cliente AS cod_cliente
  FROM cliente c
  JOIN pago p ON p.codigo_cliente = c.codigo_cliente
 WHERE p.fecha_pago LIKE '2008-%';
 -- Otra forma. También se podría hacer con un BETWEEN con la fecha_pago:
 SELECT DISTINCT c.codigo_cliente AS cod_cliente
   FROM cliente c
   JOIN pago p ON p.codigo_cliente = c.codigo_cliente
  WHERE fecha_pago BETWEEN '2008-01-01' AND '2008-12-31';
--
-- 4. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.
SELECT c.nombre_cliente AS nom_cliente,
       c.ciudad,
       e.puesto AS puesto_empl,
       e.codigo_empleado AS cod_empl
  FROM cliente c
  JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
  JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
 WHERE c.ciudad = 'Madrid'
   AND e.puesto = 'Representante Ventas'
   AND e.codigo_empleado IN (11, 30);
-- NOTA: El empledo con codigo 11 no es Representante de Ventas
--
-- 5. Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.
SELECT c.nombre_cliente AS nom_cliente,
       COUNT(p.codigo_pedido) AS cantidad_pedidos
  FROM cliente c
  LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
 GROUP BY c.nombre_cliente
 ORDER BY c.nombre_cliente ASC;
--
-- 6. Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. 
-- Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.
SELECT c.nombre_cliente, 
       COALESCE(SUM(dp.precio_unidad * dp.cantidad), 0) AS total_pagado
  FROM cliente c
  LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
  LEFT JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
 GROUP BY c.codigo_cliente, c.nombre_cliente
 ORDER BY c.nombre_cliente ASC;
-- NOTA: En PLSQL conozco la función integrada NVL(expresion, valor_si_nulo). Es como un IF y se emplea mucho para 
-- convertir valores NULL a Cero y para que no falle el código en general con posibles valores de NULL indeseados. 
-- He buscado algo similar en SQL y existe la función COALESCE (que no conocía) para convertir valores NULL a cero.
--
-- 7. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.
SELECT DISTINCT c.nombre_cliente
  FROM cliente c
  JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
 WHERE p.fecha_pedido BETWEEN '2008-01-01' AND '2008-12-31'
 ORDER BY c.nombre_cliente ASC;
--
-- 8. Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido 
-- de su representante de ventas y la ciudad donde está su oficina.
SELECT DISTINCT c.nombre_cliente AS nom_cliente,
       e.nombre AS nom_empleado,
       e.apellido1 AS apellido_empleado,
       e.puesto AS puesto_empleado,
       o.ciudad
  FROM cliente c
  JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
  JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
 ORDER BY nom_cliente ASC;
--
-- 9. Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene
SELECT o.ciudad, COUNT(e.codigo_empleado) AS num_empleados
  FROM oficina o
  LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
 GROUP BY o.ciudad;