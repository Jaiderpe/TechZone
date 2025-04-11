-- 1️⃣ Listar productos con stock menor a 5 unidades
SELECT nombre, stock FROM producto WHERE stock < 5;

-- 2️⃣ Calcular ventas totales de un mes específico (ejemplo: Octubre 2023)
SELECT SUM(p.precio * dv.cantidad) AS total_ventas
FROM detalle_venta dv
JOIN producto p ON dv.id_producto = p.id_producto
JOIN venta v ON dv.id_venta = v.id_venta
WHERE EXTRACT(MONTH FROM v.fecha_venta) = 10 AND EXTRACT(YEAR FROM v.fecha_venta) = 2023;

-- 3️⃣ Obtener el cliente con más compras realizadas
SELECT c.nombre, COUNT(v.id_venta) AS total_compras
FROM cliente c
JOIN venta v ON c.id_cliente = v.id_cliente
GROUP BY c.nombre
ORDER BY total_compras DESC
LIMIT 1;

-- 4️⃣ Listar los 5 productos más vendidos
SELECT p.nombre, SUM(dv.cantidad) AS total_vendido
FROM producto p
JOIN detalle_venta dv ON p.id_producto = dv.id_producto
GROUP BY p.nombre
ORDER BY total_vendido DESC
LIMIT 5;

-- 5️⃣ Consultar ventas realizadas en un rango de fechas de tres días y un mes
SELECT *
FROM venta
WHERE fecha_venta BETWEEN '2023-10-01' AND '2023-10-03'
OR EXTRACT(MONTH FROM fecha_venta) = 10;

-- 6️⃣ Identificar clientes que no han comprado en los últimos 6 meses
SELECT c.nombre
FROM cliente c
LEFT JOIN venta v ON c.id_cliente = v.id_cliente
WHERE v.fecha_venta IS NULL OR v.fecha_venta < CURRENT_DATE - INTERVAL '6 months';