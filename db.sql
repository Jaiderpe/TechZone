-- Crear base de datos
CREATE DATABASE techzone;
\c techzone;

-- Tabla Proveedor
CREATE TABLE proveedor (
    id_proveedor SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(15) NOT NULL
);

-- Tabla Producto
CREATE TABLE producto (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    precio DECIMAL(10, 2) CHECK (precio > 0) NOT NULL,
    stock INT CHECK (stock >= 0) NOT NULL,
    id_proveedor INT REFERENCES proveedor(id_proveedor) ON DELETE CASCADE
);

-- Tabla Cliente
CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(15) NOT NULL
);

-- Tabla Venta
CREATE TABLE venta (
    id_venta SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES cliente(id_cliente) ON DELETE CASCADE,
    fecha_venta DATE NOT NULL DEFAULT CURRENT_DATE
);

-- Tabla Detalle_Venta (Reestructurada)
CREATE TABLE detalle_venta (
    id_detalle_venta SERIAL PRIMARY KEY, -- Clave primaria autoincremental
    id_venta INT NOT NULL,               -- Clave foránea que referencia a la tabla venta
    id_producto INT NOT NULL,            -- Clave foránea que referencia a la tabla producto
    cantidad INT NOT NULL CHECK (cantidad > 0), -- Cantidad vendida, debe ser mayor a 0
    CONSTRAINT fk_venta FOREIGN KEY (id_venta) REFERENCES venta(id_venta) ON DELETE CASCADE,
    CONSTRAINT fk_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE
);