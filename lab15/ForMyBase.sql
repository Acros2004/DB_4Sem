use Кар_MyBaseClone

create table NIK_Base
(
	ID int identity,
	STMT varchar(20) --DML-оператор
		check (STMT in ('INS','DEL','UPD')),
	TRNAME varchar(50), --имя триггера
	CC varchar(300) -- коментарий
)
--drop table NIK_Base
go
create trigger Faculty_INS on Факультативы after insert
as
	declare @a1 char(10),@a2 varchar(100),@a3 char(1),@a4 char(20),@in varchar(300)
	print 'Вставка'
	set @a1 = (select Название_предмета from inserted)
	set @a2 = (select Объём_лекций from inserted)
	set @a3 = (select Объём_практических from inserted)
	set @a4 = (select Объём_лабараторных from inserted)
	set @in = @a1+' '+cast(@a2 as nvarchar)+ ' '+cast(@a3 as nvarchar)+ ' '+cast(@a4 as nvarchar)
	insert into NIK_Base(STMT,TRNAME,CC) values('INS','Faculty_INS',@in)
	return
insert into Факультативы values('Уроки отдыха',0,0,0)
select * from NIK_Base
--2
go
create trigger Faculty_DEL on Факультативы after delete
as
	declare @a1 char(10),@a2 varchar(100),@a3 char(1),@a4 char(20),@in varchar(300)
	print 'Удаление'
	set @a1 = (select Название_предмета from deleted)
	set @a2 = (select Объём_лекций from deleted)
	set @a3 = (select Объём_практических from deleted)
	set @a4 = (select Объём_лабараторных from deleted)
	set @in = @a1+' '+cast(@a2 as nvarchar)+ ' '+cast(@a3 as nvarchar)+ ' '+cast(@a4 as nvarchar)
	insert into NIK_Base(STMT,TRNAME,CC) values('DEL','Faculty_DEL',@in)
	return

delete Факультативы where Название_предмета = 'Уроки отдыха'
select * from NIK_Base
--3
go
create trigger Faculty_UPD on Факультативы after insert
as
	declare @a1 char(10),@a2 varchar(100),@a3 char(1),@a4 char(20),@in varchar(300)
	print 'Обновление'
	set @a1 = (select Название_предмета from inserted)
	set @a2 = (select Объём_лекций from inserted)
	set @a3 = (select Объём_практических from inserted)
	set @a4 = (select Объём_лабараторных from inserted)
	set @in = @a1+' '+cast(@a2 as nvarchar)+ ' '+cast(@a3 as nvarchar)+ ' '+cast(@a4 as nvarchar)
	
	set @a1 = (select Название_предмета from deleted)
	set @a2 = (select Объём_лекций from deleted)
	set @a3 = (select Объём_практических from deleted)
	set @a4 = (select Объём_лабараторных from deleted)
	set @in = @in+' '+@a1+' '+cast(@a2 as nvarchar)+ ' '+cast(@a3 as nvarchar)+ ' '+cast(@a4 as nvarchar)
	
	
	insert into NIK_Base(STMT,TRNAME,CC) values('UPD','Faculty_UPD',@in)
	return

insert into Факультативы values('Уроки отдыха',0,0,0)
update Факультативы set Название_предмета = 'Отдых с Никитой' where Название_предмета = 'Уроки отдыха'
select * from NIK_Base
--4
go
create trigger Faculty_FULL on Факультативы after insert,delete,update
as
	declare @a1 char(10),@a2 varchar(100),@a3 char(1),@a4 char(20),@in varchar(300)
	if ((select count (*) from inserted) > 0 and (select count(*) from deleted) = 0)
	begin
		print 'составной триггер:INS'
		set @a1 = (select Название_предмета from inserted)
		set @a2 = (select Объём_лекций from inserted)
		set @a3 = (select Объём_практических from inserted)
		set @a4 = (select Объём_лабараторных from inserted)
		set @in = @a1+' '+cast(@a2 as nvarchar)+ ' '+cast(@a3 as nvarchar)+ ' '+cast(@a4 as nvarchar)
		insert into NIK_Base(STMT,TRNAME,CC) values('INS','Faculty_FULL',@in)
	end
	else if ((select count(*) from inserted) = 0 and (select count(*) from deleted) > 0)
	begin
		print 'составной триггер:DEL'
		set @a1 = (select Название_предмета from deleted)
		set @a2 = (select Объём_лекций from deleted)
		set @a3 = (select Объём_практических from deleted)
		set @a4 = (select Объём_лабараторных from deleted)
		set @in = @a1+' '+cast(@a2 as nvarchar)+ ' '+cast(@a3 as nvarchar)+ ' '+cast(@a4 as nvarchar)
		insert into NIK_Base(STMT,TRNAME,CC) values('DEL','Faculty_FULL',@in)
	end

	else if ((select count(*) from inserted)>0 and (select count(*) from deleted)>0)
	begin
		print 'составной триггер:UPD'
		set @a1 = (select Название_предмета from inserted)
		set @a2 = (select Объём_лекций from inserted)
		set @a3 = (select Объём_практических from inserted)
		set @a4 = (select Объём_лабараторных from inserted)
		set @in = @a1+' '+cast(@a2 as nvarchar)+ ' '+cast(@a3 as nvarchar)+ ' '+cast(@a4 as nvarchar)
	
		set @a1 = (select Название_предмета from deleted)
		set @a2 = (select Объём_лекций from deleted)
		set @a3 = (select Объём_практических from deleted)
		set @a4 = (select Объём_лабараторных from deleted)
		set @in = @in+' '+@a1+' '+cast(@a2 as nvarchar)+ ' '+cast(@a3 as nvarchar)+ ' '+cast(@a4 as nvarchar)
	
		insert into NIK_Base(STMT,TRNAME,CC) values('UPD','Faculty_FULL',@in)
		end
	return

delete Факультативы where Название_предмета = 'Отдых с Никитой'
insert into Факультативы values('Уроки отдыха',0,0,0)
update Факультативы set Название_предмета = 'Отдых с Никитой' where Название_предмета = 'Уроки отдыха'
select * from NIK_Base
--6
go 
create trigger Faculty_DEL1 on Факультативы after delete
as print 'DELETE Trigger 1'
return;
go
create trigger Faculty_DEL2 on Факультативы after delete
as print 'DELETE Trigger 2'
return;  
go
create trigger Faculty_DEL3 on Факультативы after delete
as print 'DELETE Trigger 3'
return;  

select t.name, e.type_desc 
from sys.triggers t join  sys.trigger_events e  
on t.object_id = e.object_id  
where OBJECT_NAME(t.parent_id) = 'Факультативы' and e.type_desc = 'DELETE'

exec SP_SETTRIGGERORDER @triggername = 'Faculty_DEL3', @order = 'First', @stmttype = 'DELETE'
exec SP_SETTRIGGERORDER @triggername = 'Faculty_DEL2', @order = 'Last',  @stmttype = 'DELETE'

delete Факультативы where Название_предмета = 'Отдых с Никитой'
select * from NIK_Base
--7
go
create trigger TranTestMyBASE on Факультативы after insert,delete,update
as 
	declare @c int = (select count (*) from Факультативы); 	 
	if (@c > 5) 
	begin
		raiserror('общее количество факультативов не может превышать 5', 10, 1);
		rollback; 
	end; 
	return;    

insert into Факультативы values('Уроки отдыха',0,0,0)
--8
go
create trigger F_INSTEAD_OF on Факультативы instead of delete
as
	raiserror('Удаление запрещено',10,1)
	return

delete Факультативы where Название_предмета = 'Отдых с Никитой' 

drop trigger F_INSTEAD_OF
drop trigger Faculty_INS
drop trigger Faculty_DEL
drop trigger Faculty_UPD
drop trigger Faculty_FULL
drop trigger Faculty_DEL1
drop trigger Faculty_DEL2
drop trigger Faculty_DEL3
drop trigger TranTestMyBASE

--9
go
create trigger Performance_DDL on database for DDL_DATABASE_LEVEL_EVENTS  
as   
	declare @EVENT_TYPE varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)')
	declare @OBJ_NAME varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)')
	declare @OBJ_TYPE varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)')
	if @OBJ_NAME = 'Успеваемость' 
	begin
		print 'Тип события: ' + cast(@EVENT_TYPE as varchar)
		print 'Имя объекта: ' + cast(@OBJ_NAME as varchar)
		print 'Тип объекта: ' + cast(@OBJ_TYPE as varchar)
		raiserror('Операции с таблицей запрещены.', 16, 1)
		rollback  
	end
--drop trigger Faculty_DDL
alter table Успеваемость drop column Оценка
