If(db_id(N'imagen') IS NULL)
	CREATE DATABASE imagen;
GO

USE imagen;
GO

IF NOT EXISTS (SELECT name, xtype 
FROM sysobjects WHERE name='usuarios' and xtype='U')
    CREATE TABLE usuarios (
        id_usuario		INT NOT NULL PRIMARY KEY IDENTITY(1,1),
		correo			VARCHAR(128) NOT NULL UNIQUE,
		contrasena		VARCHAR(128) NOT NULL,
		usuario			VARCHAR(20) NOT NULL UNIQUE,
		seguidores		INT NOT NULL DEFAULT 0,
		publicaciones	INT NOT NULL DEFAULT 0,
		seguidos		INT NOT NULL DEFAULT 0,
		fotoPerfil		VARCHAR(128) NOT NULL DEFAULT 'snimagen.jpg',
		descripcion		VARCHAR(512) DEFAULT '',
		estado			TINYINT DEFAULT 1,
		creacion		DATETIME NOT NULL DEFAULT getdate()
    )
GO


IF NOT EXISTS (SELECT name, xtype FROM sysobjects WHERE name='imagenes' and xtype='U')
    CREATE TABLE imagenes (
        id_imagen			INT NOT NULL PRIMARY KEY IDENTITY(1,1),
		id_usuario			INT FOREIGN KEY REFERENCES usuarios(id_usuario),
		imagen				VARCHAR(128) NOT NULL,
		descripcion			VARCHAR(256) DEFAULT '',
		likes				INT NOT NULL DEFAULT 0,
		fechaPublicacion	DATETIME NOT NULL DEFAULT getdate(),
		estado				INT DEFAULT 1
    )
GO

IF NOT EXISTS (SELECT name, xtype FROM sysobjects WHERE name='comentarios' and xtype='U')
    CREATE TABLE comentarios (
        id_comentario		INT NOT NULL PRIMARY KEY IDENTITY(1,1),
		id_usuario			INT FOREIGN KEY REFERENCES usuarios(id_usuario),
		id_imagen			INT FOREIGN KEY REFERENCES imagenes(id_imagen),
		padre				INT DEFAULT 0,
		comentario			VARCHAR(256) NOT NULL DEFAULT '',
		likes				INT NOT NULL DEFAULT 0,
		fechaPublicacion	DATETIME NOT NULL DEFAULT getdate(),
		estado				INT DEFAULT 1
    )
GO

INSERT INTO usuarios(usuario, correo, contrasena, fotoPerfil, descripcion) VALUES('prueba','prueba@prueba.com', '12345', 'fotito.jpg', 'Ninguna');

SELECT * FROM usuarios;