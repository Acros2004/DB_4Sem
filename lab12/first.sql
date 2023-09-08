set nocount on
if exists (select * from SYS.objects where OBJECT_ID=object_id(N'DBO.L'))
drop table L;

declare @c int,@flag char = 'c'
set IMPLICIT_TRANSACTIONS ON
create table L(K int)
insert L values (1),(2),(3),(4),(5),(6)
set @c = (select count(*) from L)
print '���������� ����� � ������� L: ' + cast(@c as varchar(2))
if(@flag = 'c') commit
else rollback
set IMPLICIT_TRANSACTIONS OFF

if exists(select * from SYS.objects where OBJECT_ID = object_id(N'DBO.L'))
print '����������'
else print '�� ����������'

--2
use UNIVER

begin try
	begin tran
		insert FACULTY values ('��','��� �� ��� ���')
		insert FACULTY values ('��','����� � ���')
		--insert FACULTY values ('�������������������','�� �����')
		update FACULTY set FACULTY_NAME = '������' where FACULTY = '��'
	commit tran
end try
begin catch
	print '������ '+case
	when error_number() = 2627 and patindex('%FACULTY_PK%',error_message()) > 0
	then '������������' 
	else '����������� ������: '+ cast(error_number() as varchar(5))+ error_message()
	end;
	if @@TRANCOUNT > 0 rollback tran;
end catch

select * from FACULTY
--3
declare @point varchar(3)
begin try
	begin tran
		delete from AUDITORIUM where AUDITORIUM = '111-1'
		set @point = 'p1'; save tran @point
		insert into AUDITORIUM values('111-1','��',40,'������')
		set @point = 'p2'; save tran @point
		insert into AUDITORIUM values('111-1','��',40,'������')
		set @point = 'p3'; save tran @point
	commit tran
end try
begin catch
	print '������ ' + error_message()
	if @@TRANCOUNT > 0
	begin
		print '�����: ' + cast(@point as varchar)
		rollback tran @point
		commit tran
	end
end catch
--4. ���������� ����� ��� ������� (��������� ������� � ����� �)
-----�������� A-----
set transaction isolation level READ UNCOMMITTED;
begin transaction
-----t1-----
	select @@SPID, 'insert AUDITORIUM_TYPE' '���������', * from AUDITORIUM_TYPE
															   where AUDITORIUM_TYPE = '��';
	select @@SPID, 'update AUDITORIUM_TYPE' '���������', * from AUDITORIUM_TYPE
															   where AUDITORIUM_TYPE = '��';
	WAITFOR DELAY '00:00:10';

	select @@SPID, 'insert AUDITORIUM_TYPE' '���������', * from AUDITORIUM_TYPE
															   where AUDITORIUM_TYPE = '��';
	select @@SPID, 'update AUDITORIUM_TYPE' '���������', * from AUDITORIUM_TYPE
															   where AUDITORIUM_TYPE = '��';
commit;
-----t2-----
--5. ������� ��������� � ����� �(� � � �������) (������� ��� ���������� ��������� ������ � ����� ��� ������� ������. ������)
set transaction isolation level READ COMMITTED
begin transaction

select 'update PULPIT' '���������', count(*)
from PULPIT where FACULTY = '��';

WAITFOR DELAY '00:00:10';

select 'update PULPIT' '���������', count(*)
from PULPIT where FACULTY = '��';

commit;

--6. ����������, ��� �������� ������ ��������� ��������� ������ (� � � �������)
set transaction isolation level REPEATABLE READ
begin transaction
select TEACHER_NAME FROM TEACHER
WHERE PULPIT = '����';

	WAITFOR DELAY '00:00:10';
select case
    when TEACHER = '���������' THEN 'insert TEACHER'
	else ' '
	end '���������', TEACHER , TEACHER_NAME from TEACHER where PULPIT = '����';

commit;
--7.
set transaction isolation level SERIALIZABLE 
begin transaction
select case
    when TEACHER = '���' THEN 'insert TEACHER'
	else ' '
	end '���������', TEACHER , TEACHER_NAME from TEACHER where PULPIT = '����';

	WAITFOR DELAY '00:00:10';
select case
    when TEACHER = '���' THEN 'insert TEACHER'
	else ' '
	end '���������', TEACHER , TEACHER_NAME from TEACHER where PULPIT = '����';

commit;
--8 �������� ����������� ����������
select * from PULPIT

begin tran
	begin tran
	update PULPIT set PULPIT_NAME='����' where PULPIT.FACULTY = '����';
	commit;
	if @@TRANCOUNT > 0 rollback;

select * from PULPIT
	
