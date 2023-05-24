USE GD1C2023
GO

-- CREACION DEL SCHEMA --
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'NEW_MODEL')
BEGIN
    EXEC('CREATE SCHEMA NEW_MODEL');
END

SELECT [name] FROM sys.schemas;

-- CREACION DE TABLAS --
IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'CUPON_RECLAMO')
BEGIN 
    DROP TABLE NEW_MODEL.CUPON_RECLAMO;
END

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'CUPON')
BEGIN 
    DROP TABLE NEW_MODEL.CUPON;
END

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'CUPON_TIPO')
BEGIN 
    DROP TABLE NEW_MODEL.CUPON_TIPO;
END

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'RECLAMO')
BEGIN
    DROP TABLE NEW_MODEL.RECLAMO;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'OPERADOR')
BEGIN
    DROP TABLE NEW_MODEL.OPERADOR;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'ESTADO_RECLAMO')
BEGIN
    DROP TABLE NEW_MODEL.ESTADO_RECLAMO;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'TIPO_RECLAMO')
BEGIN
    DROP TABLE NEW_MODEL.TIPO_RECLAMO;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'ITEM')
BEGIN
    DROP TABLE NEW_MODEL.ITEM;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'LOCAL_PRODUCTO')
BEGIN
    DROP TABLE NEW_MODEL.LOCAL_PRODUCTO;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'PRODUCTO')
BEGIN
    DROP TABLE NEW_MODEL.PRODUCTO;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'HORARIO')
BEGIN
    DROP TABLE NEW_MODEL.HORARIO;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'DIA')
BEGIN
    DROP TABLE NEW_MODEL.DIA;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'LOCAL')
BEGIN
    DROP TABLE NEW_MODEL.LOCAL;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'CATEGORIA')
BEGIN
    DROP TABLE NEW_MODEL.CATEGORIA;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'TIPO_LOCAL')
BEGIN
    DROP TABLE NEW_MODEL.TIPO_LOCAL;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'PEDIDO')
BEGIN
    DROP TABLE NEW_MODEL.PEDIDO;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'MEDIO_PAGO')
BEGIN
    DROP TABLE NEW_MODEL.MEDIO_PAGO;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'MEDIO_PAGO_TIPO')
BEGIN
    DROP TABLE NEW_MODEL.MEDIO_PAGO_TIPO;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'PEDIDO_ESTADO')
BEGIN
    DROP TABLE NEW_MODEL.PEDIDO_ESTADO;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'PEDIDO_ENVIO')
BEGIN
    DROP TABLE NEW_MODEL.PEDIDO_ENVIO;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'DIRECCION_USUARIO')
BEGIN
    DROP TABLE NEW_MODEL.DIRECCION_USUARIO;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'ALTA')
BEGIN
    DROP TABLE NEW_MODEL.ALTA;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'REPARTIDOR')
BEGIN
    DROP TABLE NEW_MODEL.REPARTIDOR;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'TIPO_MOVILIDAD')
BEGIN
    DROP TABLE NEW_MODEL.TIPO_MOVILIDAD;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'USUARIO')
BEGIN
    DROP TABLE NEW_MODEL.USUARIO;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'LOCALIDAD')
BEGIN
    DROP TABLE NEW_MODEL.LOCALIDAD;
END;

IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] = 'PROVINCIA')
BEGIN
    DROP TABLE NEW_MODEL.PROVINCIA;
END;

CREATE TABLE NEW_MODEL.PROVINCIA(
    PROVINCIA_NRO int IDENTITY PRIMARY KEY,
    PROVINCIA_NOMBRE nvarchar(255) NOT NULL UNIQUE,
);

CREATE TABLE NEW_MODEL.LOCALIDAD(
    LOCALIDAD_NRO int IDENTITY PRIMARY KEY,
    LOCALIDAD_PRIVINCIA_NRO int REFERENCES NEW_MODEL.PROVINCIA,
    LOCALIDAD_NOMBRE nvarchar(255) NOT NULL UNIQUE,
);

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

CREATE TABLE NEW_MODEL.ALTA(
    ALTA_REPARTIDOR_NRO int REFERENCES NEW_MODEL.REPARTIDOR,
    ALTA_LOCALIDAD_NRO int REFERENCES NEW_MODEL.LOCALIDAD,
    ALTA_ACTIVA BIT NOT NULL,
    PRIMARY KEY(ALTA_REPARTIDOR_NRO,ALTA_LOCALIDAD_NRO)
);

CREATE TABLE NEW_MODEL.DIRECCION_USUARIO(
    DIRECCION_USUARIO_NRO int IDENTITY PRIMARY KEY,
    DIRECCION_USUARIO_USUARIO_NRO int REFERENCES NEW_MODEL.USUARIO NOT NULL,
    DIRECCION_USUARIO_LOCALIDAD_NRO int REFERENCES NEW_MODEL.LOCALIDAD NOT NULL,
    DIRECCION_USUARIO_NOMBRE nvarchar(50) NOT NULL,
    DIRECCION_USUARIO_DIRECCION nvarchar(255) NOT NULL,
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
    MEDIO_PAGO_MARCA_TARJETA nvarchar(100) NULL
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
    -- No encontre donde reubicamos estas columnas
    -- PEDIDO_TOTAL_SERVICIO decimal(18, 2) NULL
    -- PEDIDO_TOTAL_PRODUCTOS decimal(18, 2) NULL es el campo item_total? 
);

CREATE TABLE NEW_MODEL.TIPO_LOCAL(
    TIPO_LOCAL_NRO int IDENTITY PRIMARY KEY,
    TIPO_LOCAL_NOMBRE nvarchar(50) NOT NULL UNIQUE,
);

CREATE TABLE NEW_MODEL.CATEGORIA(
    CATEGORIA_NRO int IDENTITY PRIMARY KEY,
    CATEGORIA_TIPO_LOCAL_NRO int REFERENCES NEW_MODEL.TIPO_LOCAL,
    CATEGORIA_NOMBRE nvarchar(50) NOT NULL UNIQUE,
);

CREATE TABLE NEW_MODEL.LOCAL(
    LOCAL_NRO int IDENTITY PRIMARY KEY,
    LOCAL_CATEGORIA_NRO int REFERENCES NEW_MODEL.CATEGORIA,
    LOCAL_LOCALIDAD_NRO int REFERENCES NEW_MODEL.LOCALIDAD,
    LOCAL_NOMBRE nvarchar(100) NOT NULL,
	LOCAL_DESCRIPCION nvarchar(255) NOT NULL,
	LOCAL_DIRECCION nvarchar(255) NOT NULL,
);

CREATE TABLE NEW_MODEL.DIA(
    DIA_NRO int IDENTITY PRIMARY KEY,
    HORARIO_LOCAL_DIA nvarchar(50) NULL,

);

CREATE TABLE NEW_MODEL.HORARIO(
    HORARIO_NRO int IDENTITY PRIMARY KEY,
    HORARIO_LOCAL_NRO int REFERENCES NEW_MODEL.LOCAL,
    HORARIO_DIA int REFERENCES NEW_MODEL.DIA,
	HORARIO_LOCAL_HORA_APERTURA decimal(18, 0) NULL,
	HORARIO_LOCAL_HORA_CIERRE decimal(18, 0) NULL,
);


CREATE TABLE NEW_MODEL.PRODUCTO(
    PRDUCTO_NRO int IDENTITY PRIMARY KEY,
    PRODUCTO_LOCAL_CODIGO nvarchar(50) UNIQUE,
-- Que deberiamos dejar como primary key el codigo, el nro, o los dos y poner el codigo como UNIQUE??
	PRODUCTO_LOCAL_NOMBRE nvarchar(50) NOT NULL,
	PRODUCTO_LOCAL_DESCRIPCION nvarchar(255) NOT NULL,
);

CREATE TABLE NEW_MODEL.LOCAL_PRODUCTO(
    LOCAL_PRODUCTO_LOCAL_NRO int REFERENCES NEW_MODEL.LOCAL,
    LOCAL_PRODUCTO_PRODUCTO_NRO int REFERENCES NEW_MODEL.PRODUCTO,
    PRIMARY KEY(LOCAL_PRODUCTO_LOCAL_NRO, LOCAL_PRODUCTO_PRODUCTO_NRO)
);

CREATE TABLE NEW_MODEL.ITEM(
	ITEM_LOCAL_PRODUCTO_LOCAL_NRO int,
	ITEM_LOCAL_PRODUCTO_PRODUCTO_NRO int,
    ITEM_PEDIDO_NRO int REFERENCES NEW_MODEL.PEDIDO,
    ITEM_CANTIDAD decimal(18,0) DEFAULT 0 NOT NULL,
    ITEM_PRECIO decimal(18,2) DEFAULT 0 NOT NULL,
    ITEM_TOTAL decimal(18,2) DEFAULT 0 NOT NULL,
	FOREIGN KEY (ITEM_LOCAL_PRODUCTO_LOCAL_NRO, ITEM_LOCAL_PRODUCTO_PRODUCTO_NRO) REFERENCES NEW_MODEL.LOCAL_PRODUCTO(LOCAL_PRODUCTO_LOCAL_NRO, LOCAL_PRODUCTO_PRODUCTO_NRO),
    PRIMARY KEY(ITEM_LOCAL_PRODUCTO_LOCAL_NRO, ITEM_LOCAL_PRODUCTO_PRODUCTO_NRO,ITEM_PEDIDO_NRO)
);

CREATE TABLE NEW_MODEL.TIPO_RECLAMO(
	TIPO_RECLAMO_NRO int IDENTITY PRIMARY KEY,
	TIPO_RECLAMO_NOMBRE nvarchar(50) NOT NULL
);

CREATE TABLE NEW_MODEL.ESTADO_RECLAMO(
	ESTADO_RECLAMO_NRO int IDENTITY PRIMARY KEY,
	ESTADO_RECLAMO_NOMBRE NVARCHAR(50) NOT NULL
);

CREATE TABLE NEW_MODEL.OPERADOR(
	OPERADOR_NRO int IDENTITY PRIMARY KEY,
	OPERADOR_RECLAMO_DNI_NUMERO int UNIQUE,
	OPERADOR_RECLAMO_NOMBRE nvarchar(255) NOT NULL,
	OPERADOR_RECLAMO_APELLIDO nvarchar(255) NOT NULL,
	OPERADOR_RECLAMO_TELEFONO decimal(18,0) NOT NULL,
	OPERADOR_RECLAMO_DIRECCION nvarchar(255) NOT NULL,
	OPERADOR_RECLAMO_MAIL nvarchar(255) NOT NULL,
	OPERADOR_RECLAMO_FECHA_NAC datetime NOT NULL
);

CREATE TABLE NEW_MODEL.RECLAMO(
	RECLAMO_NRO	int IDENTITY PRIMARY KEY,
	RECLAMO_USUARIO_NRO int REFERENCES NEW_MODEL.USUARIO,
	RECLAMO_PEDIDO_NRO int REFERENCES NEW_MODEL.PEDIDO,
	RECLAMO_TIPO_RECLAMO_NRO int REFERENCES NEW_MODEL.TIPO_RECLAMO,
	RECLAMO_ESTADO_RECLAMO_NRO int REFERENCES NEW_MODEL.ESTADO_RECLAMO,
	RECLAMO_OPERADOR_NRO int REFERENCES NEW_MODEL.OPERADOR,
	RECLAMO_FECHA datetime NOT NULL,
	RECLAMO_DESCRIPCION nvarchar(255) NOT NULL,
	RECLAMO_FECHA_SOLUCION datetime NULL,
	RECLAMO_SOLUCION nvarchar(255) NULL,
	RECLAMO_CALIFICACION decimal(18, 0) NOT NULL
);

CREATE TABLE NEW_MODEL.CUPON_TIPO(
	CUPON_TIPO_NRO int IDENTITY PRIMARY KEY,
	CUPON_TIPO_NOMBRE nvarchar(50) NULL,
);

CREATE TABLE NEW_MODEL.CUPON(
	CUPON_NRO int IDENTITY PRIMARY KEY,
	CUPON_USUARIO_NRO int REFERENCES NEW_MODEL.USUARIO,
	CUPON_PEDIDO_NRO int REFERENCES NEW_MODEL.PEDIDO,
	CUPON_TIPO_NRO int REFERENCES NEW_MODEL.CUPON_TIPO,
	CUPON_MONTO decimal(18,2) NULL,
	CUPON_FECHA_ALTA datetime NULL,
	CUPON__FECHA_VENCIMIENTO datetime NULL
);

CREATE TABLE NEW_MODEL.CUPON_RECLAMO(
	CUPON_RECLAMO_CUPON_NRO int REFERENCES NEW_MODEL.CUPON,
	CUPON_RECLAMO_RECLAMO_NRO int REFERENCES NEW_MODEL.RECLAMO,
    PRIMARY KEY(CUPON_RECLAMO_CUPON_NRO,CUPON_RECLAMO_RECLAMO_NRO)
);






-- ORDEN DROP TABLES
 BEGIN TRANSACTION  
BEGIN TRY
    DROP TABLE NEW_MODEL.CUPON_RECLAMO
    DROP TABLE NEW_MODEL.CUPON
    DROP TABLE NEW_MODEL.CUPON_TIPO
    DROP TABLE NEW_MODEL.RECLAMO
    DROP TABLE NEW_MODEL.OPERADOR
    DROP TABLE NEW_MODEL.ESTADO_RECLAMO
    DROP TABLE NEW_MODEL.TIPO_RECLAMO
    DROP TABLE NEW_MODEL.ITEM
    DROP TABLE NEW_MODEL.LOCAL_PRODUCTO
    DROP TABLE NEW_MODEL.PRODUCTO
    DROP TABLE NEW_MODEL.HORARIO
    DROP TABLE NEW_MODEL.DIA
    DROP TABLE NEW_MODEL.LOCAL
    DROP TABLE NEW_MODEL.CATEGORIA
    DROP TABLE NEW_MODEL.TIPO_LOCAL
    DROP TABLE NEW_MODEL.PEDIDO
    DROP TABLE NEW_MODEL.MEDIO_PAGO
    DROP TABLE NEW_MODEL.MEDIO_PAGO_TIPO
    DROP TABLE NEW_MODEL.PEDIDO_ESTADO
    DROP TABLE NEW_MODEL.PEDIDO_ENVIO
    DROP TABLE NEW_MODEL.DIRECCION_USUARIO
    DROP TABLE NEW_MODEL.ALTA
    DROP TABLE NEW_MODEL.REPARTIDOR
    DROP TABLE NEW_MODEL.TIPO_MOVILIDAD
    DROP TABLE NEW_MODEL.USUARIO
    DROP TABLE NEW_MODEL.LOCALIDAD
    DROP TABLE NEW_MODEL.PROVINCIA

	PRINT 'Tablas DROPEADAS correctamente.';
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
	THROW 50001, 'Error al hacer DROP TABLAS',1;
END CATCH
GO

    -- DROP TABLE NEW_MODEL.RECLAMO
    -- DROP TABLE NEW_MODEL.OPERADOR
    -- DROP TABLE NEW_MODEL.ESTADO_RECLAMO
    -- DROP TABLE NEW_MODEL.TIPO_RECLAMO
    -- DROP TABLE NEW_MODEL.ITEM
    -- DROP TABLE NEW_MODEL.LOCAL_PRODUCTO
    -- DROP TABLE NEW_MODEL.PRODUCTO
    -- DROP TABLE NEW_MODEL.HORARIO
    -- DROP TABLE NEW_MODEL.DIA
    -- DROP TABLE NEW_MODEL.LOCAL
    -- DROP TABLE NEW_MODEL.CATEGORIA
    -- DROP TABLE NEW_MODEL.TIPO_LOCAL
    -- DROP TABLE NEW_MODEL.PEDIDO
    -- DROP TABLE NEW_MODEL.MEDIO_PAGO
    -- DROP TABLE NEW_MODEL.MEDIO_PAGO_TIPO
    -- DROP TABLE NEW_MODEL.PEDIDO_ESTADO
    -- DROP TABLE NEW_MODEL.PEDIDO_ENVIO
    -- DROP TABLE NEW_MODEL.DIRECCION_USUARIO
    -- DROP TABLE NEW_MODEL.ALTA
    -- DROP TABLE NEW_MODEL.REPARTIDOR
    -- DROP TABLE NEW_MODEL.TIPO_MOVILIDAD
    -- DROP TABLE NEW_MODEL.USUARIO
    -- DROP TABLE NEW_MODEL.LOCALIDAD
    -- DROP TABLE NEW_MODEL.PROVINCIA


