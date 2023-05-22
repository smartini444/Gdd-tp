USE GD1C2023
GO

-- CREACION DEL SCHEMA --
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'NEW_MODEL')
BEGIN
    EXEC('CREATE SCHEMA NEW_MODEL');
END

SELECT [name] FROM sys.schemas;

-- CREACION DE TABLAS --

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'PEDIDO')
BEGIN 
    DROP TABLE NEW_MODEL.PEDIDO;
END

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'MEDIO_PAGO')
BEGIN 
    DROP TABLE NEW_MODEL.MEDIO_PAGO;
END

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'MEDIO_PAGO_TIPO')
BEGIN 
    DROP TABLE NEW_MODEL.MEDIO_PAGO_TIPO;
END

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'PEDIDO_ESTADO')
BEGIN 
    DROP TABLE NEW_MODEL.PEDIDO_ESTADO;
END

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'PEDIDO_ENVIO')
BEGIN 
    DROP TABLE NEW_MODEL.PEDIDO_ENVIO;
END

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'DIRECCION_USUARIO')
BEGIN 
    DROP TABLE NEW_MODEL.DIRECCION_USUARIO;
END

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'REPARTIDOR')
BEGIN 
    DROP TABLE NEW_MODEL.REPARTIDOR;
END

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'USUARIO')
BEGIN 
    DROP TABLE NEW_MODEL.USUARIO;
END

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'TIPO_MOVILIDAD')
BEGIN 
    DROP TABLE NEW_MODEL.TIPO_MOVILIDAD;
END

CREATE TABLE NEW_MODEL.USUARIO(
    USUARIO_NRO int IDENTITY PRIMARY KEY,
    USUARIO_NOMBRE nvarchar(255) NOT NULL,
    USUARIO_APELLIDO nvarchar(255) NOT NULL,
    USUARIO_DNI decimaL(18,0) NOT NULL UNIQUE,
    USUARIO_FECHA_REGISTRO datetime2(3) NOT NULL,  
    USUARIO_TELEFONO decimal(18, 0) NOT NULL,
    USUARIO_MAIL nvarchar(255) NOT NULL UNIQUE,      
    USUARIO_FECHA_NAC date NOT NULL
);

CREATE TABLE NEW_MODEL.TIPO_MOVILIDAD(
   TIPO_MOVILIDAD_NRO int IDENTITY PRIMARY KEY,
   TIPO_MOVILIDAD_NOMBRE nvarchar(50) NOT NULL UNIQUE
);

CREATE TABLE NEW_MODEL.REPARTIDOR(
    REPARTIDOR_NRO int IDENTITY PRIMARY KEY,
    -- REPARTIDOR_LOCALIDAD_NRO int REFERENCES NEW_MODEL.LOCALIDAD_REPARTIDOR,
    REPARTIDOR_TIPO_MOVILIDAD_NRO int REFERENCES NEW_MODEL.TIPO_MOVILIDAD,
    REPARTIDOR_NOMBRE nvarchar(255) NOT NULL,
    REPARTIDOR_APELLIDO nvarchar(255) NOT NULL,
    REPARTIDOR_DNI decimal(18, 0) NOT NULL UNIQUE,
    REPARTIDOR_TELEFONO decimal(18, 0) NOT NULL,
    REPARTIDOR_DIRECION nvarchar(255) NOT NULL,
    REPARTIDOR_EMAIL nvarchar(255) NOT NULL UNIQUE,
    REPARTIDOR_FECHA_NAC date NOT NULL,
    REPARTIDOR_TIPO_MOVILIDAD nvarchar(50) NOT NULL
);

CREATE TABLE NEW_MODEL.DIRECCION_USUARIO(
    DIRECCION_USUARIO_NRO int IDENTITY PRIMARY KEY,
    DIRECCION_USUARIO_USUARIO_NRO int REFERENCES NEW_MODEL.USUARIO NOT NULL,
    DIRECCION_USUARIO_NOMBRE nvarchar(50) NOT NULL,
    DIRECCION_USUARIO_DIRECCION nvarchar(255) NOT NULL,
    DIRECCION_USUARIO_LOCALIDAD nvarchar(255) NOT NULL,
    DIRECCION_USUARIO_PROVINCIA nvarchar(255) NOT NULL
);


CREATE TABLE NEW_MODEL.PEDIDO_ENVIO(
    PEDIDO_ENVIO_NRO int IDENTITY PRIMARY KEY,
    PEDIDO_ENVIO_REPARTIDOR_NRO int REFERENCES NEW_MODEL.REPARTIDOR,
    PEDIDO_ENVIO_DIRECCION_USUARIO_NRO int REFERENCES NEW_MODEL.DIRECCION_USUARIO NOT NULL,
    PEDIDO_ENVIO_PRECIO decimal(18, 2) DEFAULT 0 NOT NULL,
    PEDIDO_ENVIO_PROPINA decimal(18, 2) DEFAULT 0 NOT NULL
);


CREATE TABLE NEW_MODEL.PEDIDO_ESTADO(
    PEDIDO_ESTADO_NRO int IDENTITY PRIMARY KEY,
    PEDIDO_ESTADO nvarchar(50) NOT NULL UNIQUE
);


CREATE TABLE NEW_MODEL.MEDIO_PAGO_TIPO(
    MEDIO_PAGO_TIPO_NRO int IDENTITY PRIMARY KEY,
    MEDIO_PAGO_TIPO nvarchar(50) NOT NULL UNIQUE
);


CREATE TABLE NEW_MODEL.MEDIO_PAGO(
    MEDIO_PAGO_NRO int IDENTITY PRIMARY KEY,
    MEDIO_PAGO_USUARIO_NRO int REFERENCES NEW_MODEL.USUARIO NOT NULL,
    MEDIO_PAGO_TIPO_NRO int REFERENCES NEW_MODEL.MEDIO_PAGO_TIPO NOT NULL,
    MEDIO_PAGO_NRO_TARJETA nvarchar(50) NULL,
    MARCA_TARJETA nvarchar(100) NULL
);


CREATE TABLE NEW_MODEL.PEDIDO(
    PEDIDO_NRO int IDENTITY PRIMARY KEY,
    PEDIDO_PEDIDO_ENVIO_NRO int REFERENCES NEW_MODEL.PEDIDO_ENVIO NULL,
    PEDIDO_ESTADO_NRO int REFERENCES NEW_MODEL.PEDIDO_ESTADO NOT NULL,
    PEDIDO_MEDIO_PAGO_NRO int REFERENCES NEW_MODEL.MEDIO_PAGO NOT NULL,
    PEDIDO_USUARIO_NRO int REFERENCES NEW_MODEL.USUARIO NOT NULL,
    PEDIDO_TOTAL_CUPONES decimal(18, 2) DEFAULT 0 NOT NULL,
    PEDIDO_TARIFA_SERVICIO decimal(18, 2) DEFAULT 0 NOT NULL,
    PEDIDO_OBSERV nvarchar(255) NULL,
    PEDIDO_FECHA datetime NOT NULL,
    PEDIDO_FECHA_ENTREGA datetime NOT NULL,
    PEDIDO_TIEMPO_ESTIMADO_ENTREGA decimal(18, 2) NOT NULL,
    PEDIDO_CALIFICACION decimal(18, 0) NULL
    -- No encontre donde reubicamos estas dos columnas
    -- PEDIDO_TOTAL_PRODUCTOS decimal(18, 2) NULL,
    -- PEDIDO_TOTAL_SERVICIO decimal(18, 2) NULL
);
