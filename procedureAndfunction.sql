--1.Un procedimiento almacenado para registrar una venta.

CREATE OR REPLACE FUNCTION registrar_venta(
    cliente_id INT,
    detalles JSONB -- Ejemplo: [{"id_producto": 1, "cantidad": 2}, {"id_producto": 2, "cantidad": 1}]
) RETURNS VOID AS $$
DECLARE
    venta_id INT;
    detalle JSONB; -- Cambiamos el tipo de dato a JSONB
    producto_stock INT;
BEGIN
    -- Validar que el cliente exista
    IF NOT EXISTS (SELECT 1 FROM cliente WHERE id_cliente = cliente_id) THEN
        RAISE EXCEPTION 'El cliente con ID % no existe.', cliente_id;
    END IF;

    -- Crear la venta
    INSERT INTO venta (id_cliente) VALUES (cliente_id) RETURNING id_venta INTO venta_id;

    -- Procesar cada detalle de la venta
    FOR detalle IN SELECT value FROM jsonb_array_elements(detalles) LOOP
        -- Verificar stock del producto
        SELECT stock INTO producto_stock
        FROM producto
        WHERE id_producto = (detalle->>'id_producto')::INT;

        IF producto_stock < (detalle->>'cantidad')::INT THEN
            RAISE EXCEPTION 'No hay suficiente stock para el producto con ID %. Stock disponible: %',
                            (detalle->>'id_producto')::INT, producto_stock;
        END IF;

        -- Actualizar stock
        UPDATE producto
        SET stock = stock - (detalle->>'cantidad')::INT
        WHERE id_producto = (detalle->>'id_producto')::INT;

        -- Registrar detalle de venta
        INSERT INTO detalle_venta (id_venta, id_producto, cantidad)
        VALUES (venta_id, (detalle->>'id_producto')::INT, (detalle->>'cantidad')::INT);
    END LOOP;

    RAISE NOTICE 'Venta registrada exitosamente con ID: %', venta_id;
END;
$$ LANGUAGE plpgsql;

--1.para ver 
SELECT registrar_venta(1, '[{"id_producto": 1, "cantidad": 1}, {"id_producto": 4, "cantidad": 2}]');

--2.Validar que el cliente exista.

CREATE OR REPLACE PROCEDURE aumentar_stock(
    producto_id INT,
    cantidad INT
) AS $$
BEGIN
    -- Validar que el producto exista
    IF NOT EXISTS (SELECT 1 FROM producto WHERE id_producto = producto_id) THEN
        RAISE EXCEPTION 'El producto con ID % no existe.', producto_id;
    END IF;

    -- Aumentar el stock
    UPDATE producto
    SET stock = stock + cantidad
    WHERE id_producto = producto_id;

    RAISE NOTICE 'Stock del producto con ID % incrementado en % unidades.', producto_id, cantidad;
END;
$$ LANGUAGE plpgsql;

--2.para ver
CALL aumentar_stock(1, 10); -- Aumentar ese estock

--3.Verificar que el stock sea suficiente antes de procesar la venta.

CREATE OR REPLACE PROCEDURE listar_productos_agotados() AS $$
DECLARE
    producto RECORD; -- Declaramos la variable como RECORD
BEGIN
    RAISE NOTICE '=== PRODUCTOS AGOTADOS ===';
    FOR producto IN
        SELECT nombre, stock
        FROM producto
        WHERE stock = 0
    LOOP
        RAISE NOTICE 'Producto: %, Stock: %', producto.nombre, producto.stock;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

--3.para ver
CALL listar_productos_agotados();

--4.Si no hay stock suficiente, Notificar por medio de un mensaje en consola usando RAISE.
CREATE OR REPLACE PROCEDURE calcular_ventas_por_cliente(
    cliente_id INT
) AS $$
DECLARE
    total DECIMAL(10, 2);
BEGIN
    -- Validar que el cliente exista
    IF NOT EXISTS (SELECT 1 FROM cliente WHERE id_cliente = cliente_id) THEN
        RAISE EXCEPTION 'El cliente con ID % no existe.', cliente_id;
    END IF;

    -- Calcular ventas totales
    SELECT COALESCE(SUM(p.precio * dv.cantidad), 0) INTO total
    FROM detalle_venta dv
    JOIN producto p ON dv.id_producto = p.id_producto
    JOIN venta v ON dv.id_venta = v.id_venta
    WHERE v.id_cliente = cliente_id;

    RAISE NOTICE 'Ventas totales del cliente con ID %: $%', cliente_id, total;
END;
$$ LANGUAGE plpgsql;

--4.para ver
CALL calcular_ventas_por_cliente(1); --calcular la venta

--5.Si hay stock, se realiza el registro de la venta.
CREATE OR REPLACE PROCEDURE identificar_clientes_inactivos() AS $$
DECLARE
    cliente RECORD; -- Declaramos la variable como RECORD
BEGIN
    RAISE NOTICE '=== CLIENTES INACTIVOS EN LOS ÚLTIMOS 6 MESES ===';
    FOR cliente IN
        SELECT c.nombre, c.correo
        FROM cliente c
        LEFT JOIN venta v ON c.id_cliente = v.id_cliente
        WHERE v.fecha_venta IS NULL OR v.fecha_venta < CURRENT_DATE - INTERVAL '6 months'
    LOOP
        RAISE NOTICE 'Cliente: %, Correo: %', cliente.nombre, cliente.correo;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


--5.para ver
CALL identificar_clientes_inactivos();