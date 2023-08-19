# Crud-empleados
scripts SQL

-- Crear la base de datos
CREATE DATABASE Empleados;

-- Usar la base de datos recién creada
USE Empleados;

-- Crear la tabla Empleados
CREATE TABLE Empleados (
    ID INT PRIMARY KEY,
    Nombre NVARCHAR(255),
    Apellido NVARCHAR(255),
    Email NVARCHAR(255) UNIQUE,
    Salario DECIMAL(18, 2)
);

-- Insertar 10 registros
INSERT INTO Empleados (ID, Nombre, Apellido, Email, Salario)
VALUES
    (1, 'Juan Pablo', 'Pérez', 'danicarpsv@gmail.com', 2500.00),
    (2, 'María', 'Gómez', 'maria@example.com', 3000.50),
    (3, 'Carlos', 'López', 'carlos@example.com', 2200.75),
    (4, 'Ana', 'Rodríguez', 'ana@example.com', 2800.25),
    (5, 'Luis', 'Martínez', 'luis@example.com', 2600.80),
    (6, 'Laura', 'Hernández', 'laura@example.com', 3200.00),
    (7, 'Pedro', 'Sánchez', 'pedro@example.com', 2400.50),
    (8, 'Sofía', 'Torres', 'sofia@example.com', 2900.75),
    (9, 'Miguel', 'Ramírez', 'miguel@example.com', 2700.20),
    (10, 'Elena', 'Díaz', 'elena@example.com', 3100.00);

USE [empleados]
GO

CREATE PROCEDURE [dbo].[sp_DeleteEmpleado]
    @EmpleadoID INT
AS
BEGIN
    DELETE FROM Empleados WHERE ID = @EmpleadoID;
END
GO

CREATE PROCEDURE [dbo].[sp_InsertEmpleado]
    @Nombre NVARCHAR(255),
    @Apellido NVARCHAR(255),
    @Email NVARCHAR(255),
    @Salario DECIMAL(18, 2)
AS
BEGIN
    INSERT INTO Empleados (Nombre, Apellido, Email, Salario)
    VALUES (@Nombre, @Apellido, @Email, @Salario);
END
GO

CREATE PROCEDURE [dbo].[sp_SelectAllEmpleados]
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT ID, Nombre, Apellido, Email, Salario
    FROM Empleados;
END
GO

CREATE PROCEDURE [dbo].[sp_UpdateEmpleado]
    @EmpleadoID INT,
    @Nombre NVARCHAR(255),
    @Apellido NVARCHAR(255),
    @Email NVARCHAR(255),
    @Salario DECIMAL(18, 2)
AS
BEGIN
    UPDATE Empleados
    SET Nombre = @Nombre, Apellido = @Apellido, Email = @Email, Salario = @Salario
    WHERE ID = @EmpleadoID;
END
GO

CREATE PROCEDURE [dbo].[sp_SelectEmpleadoById]
    @Id INT
AS
BEGIN
    SELECT ID, Nombre, Apellido, Email, Salario
    FROM Empleados
    WHERE ID = @Id;
END
GO
