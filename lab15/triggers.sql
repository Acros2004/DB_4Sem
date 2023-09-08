use UNIVER
--создаём триггер который срабатывает после вставки в TEACHER
create table TR_AUDIT
(
	ID int identity,
	STMT varchar(20) --DML-оператор
		check (STMT in ('INS','DEL','UPD')),
	TRNAME varchar(50), --имя триггера
	CC varchar(300) -- коментарий
)
--drop table TR_AUDIT
go
create trigger TR_TEACHER_INS on TEACHER after insert
as
	declare @a1 char(10),@a2 varchar(100),@a3 char(1),@a4 char(20),@in varchar(300)
	print 'Вставка'
	set @a1 = (select TEACHER from inserted)
	set @a2 = (select TEACHER_NAME from inserted)
	set @a3 = (select GENDER from inserted)
	set @a4 = (select PULPIT from inserted)
	set @in = @a1+' '+@a2+ ' '+@a3+ ' '+@a4
	insert into TR_AUDIT(STMT,TRNAME,CC) values('INS','TR_TEACHER_INS',@in)
	return

insert into TEACHER values('nik','nikita','м','ИСиТ')
select * from TR_AUDIT
delete TEACHER where TEACHER = 'nik'
delete TR_AUDIT where STMT = 'INS'
--2 теперь тоже самое но с удалением
go 
create trigger TR_TEACHER_DEL on TEACHER after delete
as
	declare @a1 char(10),@a2 varchar(100),@a3 char(1),@a4 char(20),@in varchar(300)
	print 'Удаление'
	set @a1 = (select TEACHER from deleted)
	set @a2 = (select TEACHER_NAME from deleted)
	set @a3 = (select GENDER from deleted)
	set @a4 = (select PULPIT from deleted)
	set @in = @a1+' '+@a2+ ' '+@a3+ ' '+@a4
	insert into TR_AUDIT(STMT,TRNAME,CC) values('DEL','TR_TEACHER_DEL',@in)
	return

delete TEACHER where TEACHER = 'nik'
select * from TR_AUDIT
--3
go
create trigger TR_TEACHER_UPD on TEACHER after update
as
	declare @a1 char(10),@a2 varchar(100),@a3 char(1),@a4 char(20),@in varchar(300)
	print 'Обновление'
	set @a1 = (select TEACHER from inserted)
	set @a2 = (select TEACHER_NAME from inserted)
	set @a3 = (select GENDER from inserted)
	set @a4 = (select PULPIT from inserted)
	set @in = @a1+' '+@a2+ ' '+@a3+ ' '+@a4

	set @a1 = (select TEACHER from deleted)
	set @a2 = (select TEACHER_NAME from deleted)
	set @a3 = (select GENDER from deleted)
	set @a4 = (select PULPIT from deleted)
	set @in =@in+' '+ @a1+' '+@a2+ ' '+@a3+ ' '+@a4
	insert into TR_AUDIT(STMT,TRNAME,CC) values('UPD','TR_TEACHER_DEL',@in)
	return

insert into TEACHER values('nik','nikita','м','ИСиТ')
update TEACHER set TEACHER_NAME ='cool' where TEACHER = 'nik'
select * from TR_AUDIT
drop trigger TR_TEACHER_UPD
--4
go
create trigger TR_TEACHER on TEACHER after INSERT,DELETE,UPDATE
as
	declare @a1 char(10),@a2 varchar(100),@a3 char(1),@a4 char(20),@in varchar(300)
	if ((select count (*) from inserted) > 0 and (select count(*) from deleted) = 0)
	begin
		print 'составной триггер:INS'
		set @a1 = (select TEACHER from inserted)
		set @a2 = (select TEACHER_NAME from inserted)
		set @a3 = (select GENDER from inserted)
		set @a4 = (select PULPIT from inserted)
		set @in = @a1+' '+@a2+ ' '+@a3+ ' '+@a4
		insert into TR_AUDIT(STMT,TRNAME,CC) values ('INS','TR_TEACHER',@in)
	end
	else if ((select count(*) from inserted) = 0 and (select count(*) from deleted) > 0)
	begin
		print 'составной триггер:DEL'
		set @a1 = (select TEACHER from deleted)
		set @a2 = (select TEACHER_NAME from deleted)
		set @a3 = (select GENDER from deleted)
		set @a4 = (select PULPIT from deleted)
		set @in =@a1+' '+@a2+ ' '+@a3+ ' '+@a4
		insert into TR_AUDIT(STMT,TRNAME,CC) values ('DEL','TR_TEACHER',@in)
	end

	else if ((select count(*) from inserted)>0 and (select count(*) from deleted)>0)
	begin
		print 'составной триггер:UPD'
		set @a1 = (select TEACHER from inserted)
		set @a2 = (select TEACHER_NAME from inserted)
		set @a3 = (select GENDER from inserted)
		set @a4 = (select PULPIT from inserted)
		set @in = @a1+' '+@a2+ ' '+@a3+ ' '+@a4

		set @a1 = (select TEACHER from deleted)
		set @a2 = (select TEACHER_NAME from deleted)
		set @a3 = (select GENDER from deleted)
		set @a4 = (select PULPIT from deleted)
		set @in =@in+' '+ @a1+' '+@a2+ ' '+@a3+ ' '+@a4
		insert into TR_AUDIT(STMT,TRNAME,CC) values('UPD','TR_TEACHER',@in)
	end
return

delete TEACHER where TEACHER='nik'
insert into TEACHER values('nik','nikita','м','ИСиТ')
update TEACHER set TEACHER_NAME = 'cool2' where TEACHER = 'nik'
select * from TR_AUDIT
--5
update TEACHER set GENDER = 'N' where TEACHER = 'nik'
select * from TR_AUDIT
--6
go
create trigger TR_TEACHER_DEL1 on TEACHER after delete
as print 'DELETE Trigger 1'
return;
go
create trigger TR_TEACHER_DEL2 on TEACHER after delete
as print 'DELETE Trigger 2'
return;  
go
create trigger TR_TEACHER_DEL3 on TEACHER after delete
as print 'DELETE Trigger 3'
return;  

select t.name, e.type_desc 
from sys.triggers t join  sys.trigger_events e  
on t.object_id = e.object_id  
where OBJECT_NAME(t.parent_id) = 'TEACHER' and e.type_desc = 'DELETE'

exec SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL3', @order = 'First', @stmttype = 'DELETE'
exec SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL2', @order = 'Last',  @stmttype = 'DELETE'

insert into TEACHER values('nik','nikita','м','ИСиТ')
delete from TEACHER where TEACHER = 'nik'
select * from TR_AUDIT
--7
go
create trigger TranTest on PULPIT after insert,delete,update
as 
	declare @c int = (select count (*) from PULPIT); 	 
	if (@c > 19) 
	begin
		raiserror('общее количество кафедр не может превышать 19', 10, 1);
		 
	end;
	rollback;
	return;    
 
insert into PULPIT(PULPIT,PULPIT_NAME,FACULTY) values('error)','error','ИТ')
--8
go
create trigger F_INSTEAD_OF on FACULTY instead of delete
as
	raiserror('Удаление запрещено',10,1)
	return

delete FACULTY where FACULTY = 'ИСиТ'

drop trigger F_INSTEAD_OF
drop trigger TR_TEACHER_INS
drop trigger TR_TEACHER_DEL
drop trigger TR_TEACHER_UPD
drop trigger TR_TEACHER
drop trigger TR_TEACHER_DEL1
drop trigger TR_TEACHER_DEL2
drop trigger TR_TEACHER_DEL3
drop trigger TranTest
--9
go
create trigger TR_TEACHER_DDL on database for DDL_DATABASE_LEVEL_EVENTS  
as   
	declare @EVENT_TYPE varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)')
	declare @OBJ_NAME varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)')
	declare @OBJ_TYPE varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)')
	if @OBJ_NAME = 'TEACHER' 
	begin
		print 'Тип события: ' + cast(@EVENT_TYPE as varchar)
		print 'Имя объекта: ' + cast(@OBJ_NAME as varchar)
		print 'Тип объекта: ' + cast(@OBJ_TYPE as varchar)
		raiserror('Операции с таблицей запрещены.', 16, 1)
		rollback  
	end

alter table TEACHER drop column TEACHER_NAME

