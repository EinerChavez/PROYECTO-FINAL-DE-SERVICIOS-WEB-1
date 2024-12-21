GO
USE DB_CARRITO

GO
create proc sp_obtenerCategoria
as
begin
 select * from CATEGORIA
end


go


--PROCEDIMIENTO PARA GUARDAR CATEGORIA
CREATE PROC sp_RegistrarCategoria(
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

go

--PROCEDIMIENTO PARA MODIFICAR CATEGORIA
create procedure sp_ModificarCategoria(
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

go

create proc sp_obtenerProducto
as
begin
 select p.*,c.Descripcion[DescripcionCategoria] from PRODUCTO p
 inner join CATEGORIA c on c.IdCategoria = p.IdCategoria

end

go

create proc sp_registrarProducto(
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

go

create proc sp_editarProducto(
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

go
create proc sp_actualizarRutaImagen(
@IdProducto int,
@RutaImagen varchar(500)
)
as
begin
	update PRODUCTO set RutaImagen = @RutaImagen where IdProducto = @IdProducto
end

go

create proc sp_obtenerUsuario(
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


go

CREATE PROCEDURE sp_registrarUsuario
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

        PRINT ERROR_MESSAGE();
        SET @Resultado = -1; 
    END CATCH;
END;
GO


create proc sp_InsertarCarrito(
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

go

create proc sp_ObtenerCarrito(
@IdUsuario int
)
as
begin
	select c.IdCarrito, p.IdProducto,p.Nombre,p.Precio,p.RutaImagen from carrito c
	inner join PRODUCTO p on p.IdProducto = c.IdProducto
	where c.IdUsuario = @IdUsuario
end

go


create proc sp_registrarCompra(
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

go

create proc sp_ObtenerCompra(
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

