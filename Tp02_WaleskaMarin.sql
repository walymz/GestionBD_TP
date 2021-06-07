show databases;
use negocioWebRopa;
/*
-- //////////// CREACION DE LA TABLA CONTROL ///////////////////

drop table if exists control;
create table control(
    id int auto_increment primary key,
    tabla varchar(25) not null,
    accion enum('INSERT', 'DELETE', 'UPDATE'),
    fecha date,
    hora time,
    usuario varchar(25),
    idRegistro int
);
 */
 
-- /////////////////   TRIGGER INSERT ARTÍCULOS ///////////////

drop trigger if exists TR_Articulos_Insert;

delimiter //
create trigger TR_Articulos_Insert
   after insert on articulos	
   for each row
   begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
		values ('articulos','insert', curdate(), curtime(), current_user(), New.id);
   end;
// delimiter ;

-- /////////////////   TRIGGER DELETE ARTÍCULOS ///////////////

drop trigger if exists TR_Articulos_Delete;

delimiter //
create trigger TR_Articulos_Delete
   after delete on articulos	
   for each row
   begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
		values ('articulos','delete', curdate(), curtime(), current_user(), old.id);
   end;
// delimiter ;

-- /////////////////   TRIGGER UPDATE ARTÍCULOS ///////////////

drop trigger if exists TR_Articulos_Update;

delimiter //
create trigger TR_Articulos_Update
   after update on articulos	
   for each row
   begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
		values ('articulos','update', curdate(), curtime(), current_user(), New.id);
   end;
// delimiter ;

-- /////////////////   TRIGGER INSERT FACTURAS ///////////////

drop trigger if exists TR_Facturas_Insert;

delimiter //
create trigger TR_Facturas_Insert
   after insert on facturas	
   for each row
   begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
		values ('facturas','insert', curdate(), curtime(), current_user(), New.id);
   end;
// delimiter ;

-- /////////////////   TRIGGER DELETE FACTURAS ///////////////

drop trigger if exists TR_Facturas_Delete;

delimiter //
create trigger TR_Facturas_Delete
   after delete on facturas	
   for each row
   begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
		values ('facturas','delete', curdate(), curtime(), current_user(), old.id);
   end;
// delimiter ;

-- /////////////////   TRIGGER UPDATE FACTURAS ///////////////

drop trigger if exists TR_Facturas_Update;

delimiter //
create trigger TR_Facturas_Update
   after update on facturas	
   for each row
   begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
		values ('facturas','update', curdate(), curtime(), current_user(), New.id);
   end;
// delimiter ;


-- /////////////////   TRIGGER INSERT DETALLES ///////////////

drop trigger if exists TR_Detalles_Insert;

delimiter //
create trigger TR_Detalles_Insert
   after insert on detalles	
   for each row
   begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
		values ('detalles','insert', curdate(), curtime(), current_user(), New.id);
   end;
// delimiter ;

-- /////////////////   TRIGGER DELETE FACTURAS ///////////////

drop trigger if exists TR_Detalles_Delete;

delimiter //
create trigger TR_Detalles_Delete
   after delete on detalles	
   for each row
   begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
		values ('detalles','delete', curdate(), curtime(), current_user(), old.id);
   end;
// delimiter ;

-- /////////////////   TRIGGER UPDATE FACTURAS ///////////////

drop trigger if exists TR_Detalles_Update;

delimiter //
create trigger TR_Detalles_Update
   after update on detalles	
   for each row
   begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro) 
		values ('detalles','update', curdate(), curtime(), current_user(), New.id);
   end;
// delimiter ;

-- /////////////////   CALL   /////////////////

call SP_Articulos_Insert_Min('Ojotas');
call SP_Articulos_Delete(5);
call SP_Articulos_Update(8, 'Bufanda','ROPA', 'AZUL', 30,8,5,20,3000,4000, 'OTOÑO');

insert into facturas (letra, numero, fecha, medioDePago, idCliente) values ('C', 72, CURDATE(), 'EFECTIVO', 47);
insert into detalles (idArticulo, idFactura, precio, cantidad) values (8, 2, 850, 5);
delete from facturas where id=9;
update facturas set letra='B' where id=9;
delete from detalles where id=9;
update detalles set precio=1100 where id=10;

select * from articulos;
select * from facturas;
select * from detalles;
select * from clientes;
select * from control;










