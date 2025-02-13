USE [DB_CARRITO]
GO
/****** Object:  Table [dbo].[CARRITO]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARRITO](
	[IdCarrito] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NULL,
	[IdProducto] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCarrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CATEGORIA]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CATEGORIA](
	[IdCategoria] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) NULL,
	[Activo] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COMPRA]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMPRA](
	[IdCompra] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NULL,
	[TotalProducto] [int] NULL,
	[Total] [decimal](10, 2) NULL,
	[Contacto] [varchar](50) NULL,
	[Telefono] [varchar](50) NULL,
	[Direccion] [varchar](500) NULL,
	[IdDistrito] [varchar](10) NULL,
	[FechaCompra] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCompra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DETALLE_COMPRA]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_COMPRA](
	[IdDetalleCompra] [int] IDENTITY(1,1) NOT NULL,
	[IdCompra] [int] NULL,
	[IdProducto] [int] NULL,
	[Cantidad] [int] NULL,
	[Total] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDetalleCompra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DISTRITO]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DISTRITO](
	[IdDistrito] [varchar](6) NOT NULL,
	[Descripcion] [varchar](45) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRODUCTO]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO](
	[IdProducto] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](500) NULL,
	[Descripcion] [varchar](500) NULL,
	[IdCategoria] [int] NULL,
	[Precio] [decimal](10, 2) NULL,
	[Stock] [int] NULL,
	[RutaImagen] [varchar](100) NULL,
	[Activo] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIO]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIO](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombres] [varchar](100) NULL,
	[Apellidos] [varchar](100) NULL,
	[Correo] [varchar](100) NULL,
	[Contrasena] [varchar](100) NULL,
	[EsAdministrador] [bit] NULL,
	[Activo] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CATEGORIA] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[CATEGORIA] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[COMPRA] ADD  DEFAULT (getdate()) FOR [FechaCompra]
GO
ALTER TABLE [dbo].[PRODUCTO] ADD  DEFAULT ((0)) FOR [Precio]
GO
ALTER TABLE [dbo].[PRODUCTO] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[PRODUCTO] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[USUARIO] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[USUARIO] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
GO
ALTER TABLE [dbo].[CARRITO]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[PRODUCTO] ([IdProducto])
GO
ALTER TABLE [dbo].[CARRITO]  WITH CHECK ADD FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[USUARIO] ([IdUsuario])
GO
ALTER TABLE [dbo].[COMPRA]  WITH CHECK ADD FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[USUARIO] ([IdUsuario])
GO
ALTER TABLE [dbo].[DETALLE_COMPRA]  WITH CHECK ADD FOREIGN KEY([IdCompra])
REFERENCES [dbo].[COMPRA] ([IdCompra])
GO
ALTER TABLE [dbo].[DETALLE_COMPRA]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[PRODUCTO] ([IdProducto])
GO
ALTER TABLE [dbo].[PRODUCTO]  WITH CHECK ADD FOREIGN KEY([IdCategoria])
REFERENCES [dbo].[CATEGORIA] ([IdCategoria])
GO
/****** Object:  StoredProcedure [dbo].[sp_actualizarRutaImagen]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_actualizarRutaImagen](
@IdProducto int,
@RutaImagen varchar(500)
)
as
begin
	update PRODUCTO set RutaImagen = @RutaImagen where IdProducto = @IdProducto
end


GO
/****** Object:  StoredProcedure [dbo].[sp_editarProducto]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_editarProducto](
@IdProducto int,
@Nombre varchar(500),
@Descripcion varchar(500),
@IdCategoria int,
@Precio decimal(10,2),
@Stock int,
@Activo bit,
@Resultado bit output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Descripcion = @Descripcion and IdProducto != @IdProducto)
	begin
		update PRODUCTO set 
		Nombre = @Nombre,
		Descripcion = @Descripcion,
		IdCategoria = @IdCategoria,
		Precio =@Precio ,
		Stock =@Stock ,
		Activo = @Activo where IdProducto = @IdProducto

		SET @Resultado =1
	end
end


GO
/****** Object:  StoredProcedure [dbo].[sp_InsertarCarrito]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_InsertarCarrito](
@IdUsuario int,
@IdProducto int,
@Resultado int output
)
as
begin
	set @Resultado = 0
	if not exists (select * from CARRITO where IdProducto = @IdProducto and IdUsuario = @IdUsuario)
	begin
		update PRODUCTO set Stock = Stock -1 where IdProducto = @IdProducto
		insert into CARRITO(IdUsuario,IdProducto) values ( @IdUsuario,@IdProducto)
		set @Resultado = 1
	end
	
end


GO
/****** Object:  StoredProcedure [dbo].[sp_ListarCompras]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ListarCompras]
AS
BEGIN
    SELECT 
        u.IdUsuario,
        u.Nombres,
        c.TotalProducto,
        c.Telefono,
        c.FechaCompra
    FROM 
        COMPRA c
    INNER JOIN 
        USUARIO u ON c.IdUsuario = u.IdUsuario
    ORDER BY 
        c.FechaCompra DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ModificarCategoria]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--PROCEDIMIENTO PARA MODIFICAR CATEGORIA
create procedure [dbo].[sp_ModificarCategoria](
@IdCategoria int,
@Descripcion varchar(60),
@Activo bit,
@Resultado bit output
)
as
begin
	SET @Resultado = 1
	IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion =@Descripcion and IdCategoria != @IdCategoria)
		
		update CATEGORIA set 
		Descripcion = @Descripcion,
		Activo = @Activo
		where IdCategoria = @IdCategoria
	ELSE
		SET @Resultado = 0

end



GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerCarrito]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_ObtenerCarrito](
@IdUsuario int
)
as
begin
	select c.IdCarrito, p.IdProducto,p.Nombre,p.Precio,p.RutaImagen from carrito c
	inner join PRODUCTO p on p.IdProducto = c.IdProducto
	where c.IdUsuario = @IdUsuario
end


GO
/****** Object:  StoredProcedure [dbo].[sp_obtenerCategoria]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_obtenerCategoria]
as
begin
 select * from CATEGORIA
end



GO
/****** Object:  StoredProcedure [dbo].[sp_ObtenerCompra]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_ObtenerCompra](
@IdUsuario int)
as
begin
select c.Total,convert(char(10),c.FechaCompra,103)[Fecha],

(select p.Nombre,p.RutaImagen,dc.Total,dc.Cantidad from DETALLE_COMPRA dc
inner join PRODUCTO p on p.IdProducto = dc.IdProducto
where dc.IdCompra = c.IdCompra
FOR XML PATH ('PRODUCTO'),TYPE) AS 'DETALLE_PRODUCTO'

from compra c
where c.IdUsuario = @IdUsuario
FOR XML PATH('COMPRA'), ROOT('DATA') 
end


GO
/****** Object:  StoredProcedure [dbo].[sp_obtenerProducto]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_obtenerProducto]
as
begin
 select p.*,c.Descripcion[DescripcionCategoria] from PRODUCTO p
 inner join CATEGORIA c on c.IdCategoria = p.IdCategoria

end


GO
/****** Object:  StoredProcedure [dbo].[sp_obtenerUsuario]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_obtenerUsuario](
@Correo varchar(100),
@Contrasena varchar(100)
)
as
begin
	IF EXISTS (SELECT * FROM usuario WHERE correo = @Correo and contrasena = @Contrasena)
	begin
		SELECT IdUsuario,Nombres,Apellidos,Correo,Contrasena,EsAdministrador FROM usuario WHERE correo = @Correo and contrasena = @Contrasena
	end
end



GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarCategoria]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--PROCEDIMIENTO PARA GUARDAR CATEGORIA
CREATE PROC [dbo].[sp_RegistrarCategoria](
@Descripcion varchar(50),
@Resultado bit output
)as
begin
	SET @Resultado = 1
	IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion)

		insert into CATEGORIA(Descripcion) values (
		@Descripcion
		)
	ELSE
		SET @Resultado = 0
	
end


GO
/****** Object:  StoredProcedure [dbo].[sp_registrarCompra]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[sp_registrarCompra](
@IdUsuario int,
@TotalProducto int,
@Total decimal(10,2),
@Contacto varchar(100),
@Telefono varchar(100),
@Direccion varchar(100),
@IdDistrito varchar(10),
@QueryDetalleCompra nvarchar(max),
@Resultado bit output
)
as
begin
	begin try
		SET @Resultado = 0
		begin transaction
		
		declare @idcompra int = 0
		insert into COMPRA(IdUsuario,TotalProducto,Total,Contacto,Telefono,Direccion,IdDistrito) values
		(@IdUsuario,@TotalProducto,@Total,@Contacto,@Telefono,@Direccion,@IdDistrito)

		set @idcompra = scope_identity()

		set @QueryDetalleCompra = replace(@QueryDetalleCompra,'¡idcompra!',@idcompra)

		EXECUTE sp_executesql @QueryDetalleCompra

		delete from CARRITO where IdUsuario = @IdUsuario

		SET @Resultado = 1

		commit
	end try
	begin catch
		rollback
		SET @Resultado = 0
	end catch
end


GO
/****** Object:  StoredProcedure [dbo].[sp_registrarProducto]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[sp_registrarProducto](
@Nombre varchar(500),
@Descripcion varchar(500),
@IdCategoria int,
@Precio decimal(10,2),
@Stock int,
@RutaImagen varchar(500),
@Resultado int output
)
as
begin
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM PRODUCTO WHERE Descripcion = @Descripcion)
	begin
		insert into PRODUCTO(Nombre,Descripcion,IdCategoria,Precio,Stock,RutaImagen) values (
		@Nombre,@Descripcion,@IdCategoria,@Precio,@Stock,@RutaImagen)

		SET @Resultado = scope_identity()
	end
end


GO
/****** Object:  StoredProcedure [dbo].[sp_registrarUsuario]    Script Date: 5/07/2024 21:50:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_registrarUsuario]
    @Nombres varchar(100),
    @Apellidos varchar(100),
    @Correo varchar(100),
    @Contrasena varchar(100),
    @EsAdministrador bit,
    @Resultado int OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SET @Resultado = 0;
        IF NOT EXISTS (SELECT 1 FROM USUARIO WHERE Correo = @Correo)
        BEGIN
            INSERT INTO USUARIO (Nombres, Apellidos, Correo, Contrasena, EsAdministrador)
            VALUES (@Nombres, @Apellidos, @Correo, @Contrasena, @EsAdministrador);

            SET @Resultado = SCOPE_IDENTITY();
        END
    END TRY
    BEGIN CATCH
        -- Manejo de errores
        PRINT ERROR_MESSAGE();
        SET @Resultado = -1; -- Indica un error
    END CATCH;
END;
GO


insert into USUARIO(Nombres,Apellidos,Correo,Contrasena,EsAdministrador) values ('test','user','admin@ejemplo.com','admin123',1)

GO
insert into CATEGORIA(Descripcion) values
('lacteos'),
('cereales'),
('bebidas'),
('verduras'),
('enlatados'),
('limpieza')

GO
select * from CATEGORIA

insert into PRODUCTO(Nombre,Descripcion,IdCategoria,Precio,Stock,RutaImagen) values('Arroz',
'saco de arroz de 49 kilos san luis',1,'150.50','50','~/Imagenes/Productos/1.jpeg')



insert into PRODUCTO(Nombre,Descripcion,IdCategoria,Precio,Stock,RutaImagen) values('Detergente','Detergente ACE de 4.5 kilogramos',6,'15.50','80','~/Imagenes/Productos/2.jpeg')

insert into DISTRITO(IdDistrito, Descripcion) values (1,'La esperanza')
insert into DISTRITO(IdDistrito,Descripcion) values (2,'Trujillo')
insert into DISTRITO(IdDistrito,Descripcion) values (3,'El porvenir')
insert into DISTRITO(IdDistrito,Descripcion) values (4,'Florencia de mora')
insert into DISTRITO(IdDistrito,Descripcion) values (5,'Victor larco')
insert into DISTRITO(IdDistrito,Descripcion) values (6,'Moche')
insert into DISTRITO(IdDistrito,Descripcion) values (7,'Huanchaco')
insert into DISTRITO(IdDistrito,Descripcion) values (8,'Poroto')
insert into DISTRITO(IdDistrito,Descripcion) values (9,'Simbal')
insert into DISTRITO(IdDistrito,Descripcion) values (10,'Laredo')
go


use DB_CARRITO;

select*from USUARIO;

select*from PRODUCTO;

select*from CARRITO;

select*from COMPRA;

select*from DETALLE_COMPRA;

select*from DISTRITO;

EXEC sp_obtenerProducto;

EXEC sp_obtenerCategoria;

EXEC sp_ObtenerCompra @IdUsuario = 3009;
