use ���_MyBaseClone

create table NIK_Base
(
	ID int identity,
	STMT varchar(20) --DML-��������
		check (STMT in ('INS','DEL','UPD')),
	TRNAME varchar(50), --��� ��������
	CC varchar(300) -- ����������
)
--drop table NIK_Base
go
create trigger Faculty_INS on ������������ after insert
as
	declare @a1 char(10),@a2 varchar(100),@a3 char(1),@a4 char(20),@in varchar(300)
	print '�������'
	set @a1 = (select ��������_�������� from inserted)
	set @a2 = (select �����_������ from inserted)
	set @a3 = (select �����_������������ from inserted)
	set @a4 = (select �����_������������ from inserted)
	set @in = @a1+' '+cast(@a2 as nvarchar)+ ' '+cast(@a3 as nvarchar)+ ' '+cast(@a4 as nvarchar)
	insert into NIK_Base(STMT,TRNAME,CC) values('INS','Faculty_INS',@in)
	return
insert into ������������ values('����� ������',0,0,0)
select * from NIK_Base
--2
go
create trigger Faculty_DEL on ������������ after delete
as
	declare @a1 char(10),@a2 varchar(100),@a3 char(1),@a4 char(20),@in varchar(300)
	print '��������'
	set @a1 = (select ��������_�������� from deleted)
	set @a2 = (select �����_������ from deleted)
	set @a3 = (select �����_������������ from deleted)
	set @a4 = (select �����_������������ from deleted)
	set @in = @a1+' '+cast(@a2 as nvarchar)+ ' '+cast(@a3 as nvarchar)+ ' '+cast(@a4 as nvarchar)
	insert into NIK_Base(STMT,TRNAME,CC) values('DEL','Faculty_DEL',@in)
	return

delete ������������ where ��������_�������� = '����� ������'
select * from NIK_Base
--3
go
create trigger Faculty_UPD on ������������ after insert
as
	declare @a1 char(10),@a2 varchar(100),@a3 char(1),@a4 char(20),@in varchar(300)
	print '����������'
	set @a1 = (select ��������_�������� from inserted)
	set @a2 = (select �����_������ from inserted)
	set @a3 = (select �����_������������ from inserted)
	set @a4 = (select �����_������������ from inserted)
	set @in = @a1+' '+cast(@a2 as nvarchar)+ ' '+cast(@a3 as nvarchar)+ ' '+cast(@a4 as nvarchar)
	
	set @a1 = (select ��������_�������� from deleted)
	set @a2 = (select �����_������ from deleted)
	set @a3 = (select �����_������������ from deleted)
	set @a4 = (select �����_������������ from deleted)
	set @in = @in+' '+@a1+' '+cast(@a2 as nvarchar)+ ' '+cast(@a3 as nvarchar)+ ' '+cast(@a4 as nvarchar)
	
	
	insert into NIK_Base(STMT,TRNAME,CC) values('UPD','Faculty_UPD',@in)
	return

insert into ������������ values('����� ������',0,0,0)
update ������������ set ��������_�������� = '����� � �������' where ��������_�������� = '����� ������'
select * from NIK_Base
--4
go
create trigger Faculty_FULL on ������������ after insert,delete,update
as
	declare @a1 char(10),@a2 varchar(100),@a3 char(1),@a4 char(20),@in varchar(300)
	if ((select count (*) from inserted) > 0 and (select count(*) from deleted) = 0)
	begin
		print '��������� �������:INS'
		set @a1 = (select ��������_�������� from inserted)
		set @a2 = (select �����_������ from inserted)
		set @a3 = (select �����_������������ from inserted)
		set @a4 = (select �����_������������ from inserted)
		set @in = @a1+' '+cast(@a2 as nvarchar)+ ' '+cast(@a3 as nvarchar)+ ' '+cast(@a4 as nvarchar)
		insert into NIK_Base(STMT,TRNAME,CC) values('INS','Faculty_FULL',@in)
	end
	else if ((select count(*) from inserted) = 0 and (select count(*) from deleted) > 0)
	begin
		print '��������� �������:DEL'
		set @a1 = (select ��������_�������� from deleted)
		set @a2 = (select �����_������ from deleted)
		set @a3 = (select �����_������������ from deleted)
		set @a4 = (select �����_������������ from deleted)
		set @in = @a1+' '+cast(@a2 as nvarchar)+ ' '+cast(@a3 as nvarchar)+ ' '+cast(@a4 as nvarchar)
		insert into NIK_Base(STMT,TRNAME,CC) values('DEL','Faculty_FULL',@in)
	end

	else if ((select count(*) from inserted)>0 and (select count(*) from deleted)>0)
	begin
		print '��������� �������:UPD'
		set @a1 = (select ��������_�������� from inserted)
		set @a2 = (select �����_������ from inserted)
		set @a3 = (select �����_������������ from inserted)
		set @a4 = (select �����_������������ from inserted)
		set @in = @a1+' '+cast(@a2 as nvarchar)+ ' '+cast(@a3 as nvarchar)+ ' '+cast(@a4 as nvarchar)
	
		set @a1 = (select ��������_�������� from deleted)
		set @a2 = (select �����_������ from deleted)
		set @a3 = (select �����_������������ from deleted)
		set @a4 = (select �����_������������ from deleted)
		set @in = @in+' '+@a1+' '+cast(@a2 as nvarchar)+ ' '+cast(@a3 as nvarchar)+ ' '+cast(@a4 as nvarchar)
	
		insert into NIK_Base(STMT,TRNAME,CC) values('UPD','Faculty_FULL',@in)
		end
	return

delete ������������ where ��������_�������� = '����� � �������'
insert into ������������ values('����� ������',0,0,0)
update ������������ set ��������_�������� = '����� � �������' where ��������_�������� = '����� ������'
select * from NIK_Base
--6
go 
create trigger Faculty_DEL1 on ������������ after delete
as print 'DELETE Trigger 1'
return;
go
create trigger Faculty_DEL2 on ������������ after delete
as print 'DELETE Trigger 2'
return;  
go
create trigger Faculty_DEL3 on ������������ after delete
as print 'DELETE Trigger 3'
return;  

select t.name, e.type_desc 
from sys.triggers t join  sys.trigger_events e  
on t.object_id = e.object_id  
where OBJECT_NAME(t.parent_id) = '������������' and e.type_desc = 'DELETE'

exec SP_SETTRIGGERORDER @triggername = 'Faculty_DEL3', @order = 'First', @stmttype = 'DELETE'
exec SP_SETTRIGGERORDER @triggername = 'Faculty_DEL2', @order = 'Last',  @stmttype = 'DELETE'

delete ������������ where ��������_�������� = '����� � �������'
select * from NIK_Base
--7
go
create trigger TranTestMyBASE on ������������ after insert,delete,update
as 
	declare @c int = (select count (*) from ������������); 	 
	if (@c > 5) 
	begin
		raiserror('����� ���������� ������������� �� ����� ��������� 5', 10, 1);
		rollback; 
	end; 
	return;    

insert into ������������ values('����� ������',0,0,0)
--8
go
create trigger F_INSTEAD_OF on ������������ instead of delete
as
	raiserror('�������� ���������',10,1)
	return

delete ������������ where ��������_�������� = '����� � �������' 

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
	if @OBJ_NAME = '������������' 
	begin
		print '��� �������: ' + cast(@EVENT_TYPE as varchar)
		print '��� �������: ' + cast(@OBJ_NAME as varchar)
		print '��� �������: ' + cast(@OBJ_TYPE as varchar)
		raiserror('�������� � �������� ���������.', 16, 1)
		rollback  
	end
--drop trigger Faculty_DDL
alter table ������������ drop column ������
