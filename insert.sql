INSERT INTO proveedor (nombre, correo, telefono)
VALUES 
('TechCorp', 'techcorp@example.com', '123456789'),
('ElectroWorld', 'electroworld@example.com', '987654321'),
('GadgetHub', 'gadgets@example.com', '555111222'),
('SmartTech', 'smarttech@example.com', '555333444'),
('GlobalParts', 'globalparts@example.com', '555555666'),
('DigitalGear', 'digitalgear@example.com', '555777888'),
('FutureElectronics', 'futureelectronics@example.com', '555999000'),
('TechSolutions', 'techsolutions@example.com', '555123123'),
('Innovatech', 'innovatech@example.com', '555456456'),
('NextGen', 'nextgen@example.com', '555789789'),
('PowerSupply', 'powersupply@example.com', '555101101'),
('MicroParts', 'microparts@example.com', '555202202'),
('LogicTech', 'logictech@example.com', '555303303'),
('QuantumDevices', 'quantumdevices@example.com', '555404404'),
('NanoTech', 'nanotech@example.com', '555505505');

INSERT INTO producto (nombre, categoria, precio, stock, id_proveedor)
VALUES 
('Laptop Dell XPS', 'Computadoras', 1500.00, 10, 1),
('Teclado Mecánico Razer', 'Accesorios', 120.00, 30, 4),
('iPhone 14', 'Teléfonos', 1200.00, 2, 2),         
('Monitor LG 27"', 'Monitores', 300.00, 20, 3),
('Mouse Logitech G502', 'Accesorios', 80.00, 50, 5),
('SSD Kingston 500GB', 'Almacenamiento', 70.00, 1, 6), 
('Tarjeta Gráfica NVIDIA RTX 3060', 'Componentes', 400.00, 8, 7),
('Procesador Intel i7', 'Componentes', 350.00, 15, 8),
('Memoria RAM Corsair 16GB', 'Componentes', 100.00, 0, 9),
('Audífonos Sony WH-1000XM5', 'Audio', 250.00, 12, 10),
('Cargador USB-C Anker', 'Accesorios', 30.00, 100, 11),
('Router TP-Link Archer AX50', 'Redes', 150.00, 18, 12),
('Disco Duro Externo Seagate 1TB', 'Almacenamiento', 90.00, 2, 13), 
('Tablet Samsung Galaxy Tab S8', 'Tablets', 600.00, 7, 14),
('Impresora HP LaserJet', 'Impresoras', 200.00, 0, 15); 

INSERT INTO cliente (nombre, correo, telefono)
VALUES 
('Juan Pérez', 'juanperez@example.com', '5551234567'),
('María López', 'marialopez@example.com', '5559876543'),
('Carlos Ramírez', 'carlosramirez@example.com', '5551112222'),
('Ana Torres', 'anatorres@example.com', '5553334444'),
('Luis Fernández', 'luisfernandez@example.com', '5555556666'),
('Sofía García', 'sofiagarcia@example.com', '5557778888'),
('Diego Martínez', 'diegomartinez@example.com', '5559990000'),
('Laura Hernández', 'laurahernandez@example.com', '5551231234'),
('Javier Morales', 'javiermorales@example.com', '5554564567'),
('Valeria Castro', 'valeriacastro@example.com', '5557897890'),
('Roberto Guzmán', 'robertoguzman@example.com', '5551011010'),
('Isabel Vargas', 'isabelvargas@example.com', '5552022020'),
('Miguel Sánchez', 'miguelsanchez@example.com', '5553033030'),
('Camila Ortega', 'camilaortega@example.com', '5554044040'),
('Ricardo Paredes', 'ricardoparedes@example.com', '5555055050');

INSERT INTO venta (id_cliente, fecha_venta)
VALUES 
(1, '2023-10-01'),
(2, '2023-10-02'),
(3, '2023-10-03'),
(4, '2023-10-04'),
(5, '2023-10-05'),
(6, '2023-10-06'),
(7, '2023-10-07'),
(8, '2023-10-08'),
(9, '2023-10-09'),
(10, '2023-10-10'),
(11, '2023-10-11'),
(12, '2023-10-12'),
(13, '2023-10-13'),
(14, '2023-10-14'),
(15, '2023-10-15');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad)
VALUES 
(1, 1, 1), 
(1, 4, 2), 
(2, 2, 1), 
(3, 3, 1), 
(3, 5, 3), 
(4, 6, 2), 
(5, 7, 1), 
(6, 8, 1), 
(7, 9, 4), 
(8, 10, 1),
(9, 11, 5), 
(10, 12, 1), 
(11, 13, 2), 
(12, 14, 1),  
(13, 15, 1);  


