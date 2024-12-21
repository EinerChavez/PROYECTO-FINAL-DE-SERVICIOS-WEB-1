GO
USE DB_CARRITO


go


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
