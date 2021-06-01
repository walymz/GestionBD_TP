show databases;
use negocioWebRopa;

describe articulos;
describe facturas;
describe detalles;

-- /////////////////   TABLA ARTÍCULOS  ///////////////

drop procedure if exists SP_Articulos_Insert_Min;
delimiter //
create procedure SP_Articulos_Insert_Min (in Pdescripcion varchar(25))
begin
	insert into articulos (descripcion) values (Pdescripcion);
end
// delimiter ;

drop procedure if exists SP_Articulos_Insert_Full;
delimiter //
create procedure SP_Articulos_Insert_Full (
     in Pdescripcion varchar(25), 
        Ptipo enum('CALZADO', 'ROPA'), 
        Pcolor varchar(20), 
        Ptalle_num varchar(20), 
        Pstock int, 
        PstockMin int, 
        PstockMax int, 
        Pcosto double, 
        Pprecio double, 
        Ptemporada enum('VERANO', 'OTOÑO','INVIERNO')
        )
begin
	    insert into articulos (descripcion, 
                              tipo, 
                              color, 
                              talle_num, 
                              stock, 
                              stockMin,
                              stockMax, 
                              costo, 
                              precio, 
                              temporada) 
		values (Pdescripcion,Ptipo, Pcolor, 
					PTalle_num, Pstock, PstockMin, 
                    PstockMax, Pcosto, Pprecio, Ptemporada);
end
// delimiter ;

drop procedure if exists SP_Articulos_Delete;

delimiter //
create procedure SP_Articulos_Delete (in Pid int)
begin
	delete from articulos where id=Pid;
end
// delimiter ;

drop procedure if exists SP_Articulos_Update;

delimiter //
create procedure SP_Articulos_Update (
	in Pid int, 
	   Pdescripcion varchar(25), 
       Ptipo enum('CALZADO', 'ROPA'), 
       Pcolor varchar(20), 
       Ptalle_num varchar(20), 
       Pstock int, 
       PstockMin int, 
       PstockMax int, 
       Pcosto double, 
       Pprecio double, 
       Ptemporada enum('VERANO', 'OTOÑO','INVIERNO')
       )
begin
	update articulos set descripcion=Pdescripcion, tipo=Ptipo, color=Pcolor, 
                         talle_num=Ptalle_num, stock=Pstock, stockMin=PstockMin, 
                         stockMax=PstockMax, costo=Pcosto, precio=Pprecio, 
                         temporada=Ptemporada
					 where id=Pid;
end
// delimiter ;

drop procedure if exists SP_Articulos_All;

delimiter //
create procedure SP_Articulos_All()
	begin
        select * from articulos;
	  
	end;
// delimiter ; 

drop procedure if exists SP_Articulos_Reponer;

delimiter //
create procedure SP_Articulos_Reponer()
begin
   select * from articulos 
			where stock < stockMin
            order by tipo, descripcion asc;
end;
// delimiter ;

-- /////////////////   TABLA FACTURAS  ///////////////

drop procedure if exists SP_Facturas_Insert;

delimiter //
create procedure SP_Facturas_Insert(
	in  Pletra enum('A', 'B', 'C'), 
		Pnumero int, 
        Pfecha date, 
        PmedioDePago enum('EFECTIVO','DEBITO','TARJETA'), 
        PidCliente int)
begin
  insert into facturas(letra, numero, 
					   fecha, medioDePago, 
                       idCliente) 
		 values (Pletra, Pnumero,Pfecha,PmedioDePago,PidCliente);
end;
// delimiter ;

drop procedure if exists SP_Facturas_Delete;

delimiter //
create procedure SP_Facturas_Delete(in Pid int)
begin
     delete from facturas where id=Pid;
end;
// delimiter ;

drop procedure if exists SP_Facturas_Update;

delimiter //
create procedure SP_Facturas_Update(
	in Pid int, 
		Pletra enum('A','B','C'), 
        Pnumero int, 
        Pfecha date, 
        PmedioDePago enum('EFECTIVO', 'DEBITO', 'TARJETA'), 
        PidCliente int)
begin
   update facturas set letra = Pletra, numero = Pnumero, 
					   fecha = Pfecha, medioDePago = PmedioDePago, 
                       idCliente = PidCliente
				   where (id=Pid);
end;
// delimiter ;

drop procedure if exists SP_Facturas_All;

delimiter //
create procedure SP_Facturas_All()
begin
    select * from facturas;
end;
// delimiter ;

drop procedure if exists SP_Facturas_AgregarDetalle;

delimiter //
create procedure SP_Facturas_AgregarDetalle(
	in PidArticulo int,  
		PidFactura int, 
        Pprecio double, 
        Pcantidad int
        )
begin
    insert into detalles (idArticulo, idFactura, 
						  precio, cantidad) 
		   values (PidArticulo, PidFactura, 
				   Pprecio, Pcantidad);
end;

// delimiter ;

-- /////////////////   TABLA DETALLES  ///////////////

drop procedure if exists SP_Detalles_Delete;

delimiter //
create procedure SP_Detalles_Delete (in Pid int)
begin
    delete from detalles where id = Pid;
end; 

// delimiter ;

drop procedure if exists SP_Detalles_All;

delimiter //
create procedure SP_Detalles_All()
begin
    select * from detalles;
end;
// delimiter ;

-- /////////////////   CALL   /////////////////

call SP_Articulos_Insert_Min('Lampara');
call SP_Articulos_Insert_Full('CAMISA', 'ROPA', 'AMARILLO', '4', 2, 5, 20, 1000, 3000, 'VERANO');
call SP_Articulos_Delete(2);
call SP_Articulos_Update(3, 'CALZA', 'ROPA', 'Rojo', '35', 2, 5, 20, 1000, 3000, 'VERANO');
call SP_Articulos_All();
call SP_Articulos_Reponer();
call SP_Facturas_Insert('A', 65, curdate(), 'EFECTIVO', 4);
call SP_Facturas_Insert('A', 66, curdate(), 'DEBITO', 4);
call SP_Facturas_Delete(3);
call SP_Facturas_Update(1,'B', 67, curdate(), 'DEBITO', 3);
call SP_Facturas_All();
call SP_Facturas_AgregarDetalle(2, 5, 3500, 2);
call SP_Facturas_AgregarDetalle(3, 6, 500, 1);
call SP_Detalles_Delete(6);
call SP_Detalles_All();

select * from clientes;
select * from articulos;
select * from facturas;
select * from detalles;









