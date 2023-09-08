set nocount on
if exists (select * from SYS.objects where OBJECT_ID=object_id(N'DBO.L'))
drop table L;

declare @c int,@flag char = 'c'
set IMPLICIT_TRANSACTIONS ON
create table L(K int)
insert L values (1),(2),(3),(4),(5),(6)
set @c = (select count(*) from L)
print 'количество строк в таблице L: ' + cast(@c as varchar(2))
if(@flag = 'c') commit
else rollback
set IMPLICIT_TRANSACTIONS OFF

if exists(select * from SYS.objects where OBJECT_ID = object_id(N'DBO.L'))
print 'Существует'
else print 'Не сушествует'

--2
use UNIVER

begin try
	begin tran
		insert FACULTY values ('Ни','где же мой сон')
		insert FACULTY values ('ки','давно я его')
		--insert FACULTY values ('таааааааааааааааааа','не видел')
		update FACULTY set FACULTY_NAME = 'Каребо' where FACULTY = 'Ни'
	commit tran
end try
begin catch
	print 'ошибка '+case
	when error_number() = 2627 and patindex('%FACULTY_PK%',error_message()) > 0
	then 'дублирование' 
	else 'неизвестная ошибка: '+ cast(error_number() as varchar(5))+ error_message()
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
		insert into AUDITORIUM values('111-1','ЛК',40,'никита')
		set @point = 'p2'; save tran @point
		insert into AUDITORIUM values('111-1','ЛК',40,'никита')
		set @point = 'p3'; save tran @point
	commit tran
end try
begin catch
	print 'ошибка ' + error_message()
	if @@TRANCOUNT > 0
	begin
		print 'точка: ' + cast(@point as varchar)
		rollback tran @point
		commit tran
	end
end catch
--4. показываем сразу все приколы (Запускаем целиком А потом Б)
-----Сценарий A-----
set transaction isolation level READ UNCOMMITTED;
begin transaction
-----t1-----
	select @@SPID, 'insert AUDITORIUM_TYPE' 'результат', * from AUDITORIUM_TYPE
															   where AUDITORIUM_TYPE = 'СЗ';
	select @@SPID, 'update AUDITORIUM_TYPE' 'результат', * from AUDITORIUM_TYPE
															   where AUDITORIUM_TYPE = 'ЛК';
	WAITFOR DELAY '00:00:10';

	select @@SPID, 'insert AUDITORIUM_TYPE' 'результат', * from AUDITORIUM_TYPE
															   where AUDITORIUM_TYPE = 'СЗ';
	select @@SPID, 'update AUDITORIUM_TYPE' 'результат', * from AUDITORIUM_TYPE
															   where AUDITORIUM_TYPE = 'ЛК';
commit;
-----t2-----
--5. памятка запускаем А потом Б(А и Б целиком) (сказать что появляется фантомная строка и также это явление неповт. данных)
set transaction isolation level READ COMMITTED
begin transaction

select 'update PULPIT' 'результат', count(*)
from PULPIT where FACULTY = 'ИТ';

WAITFOR DELAY '00:00:10';

select 'update PULPIT' 'результат', count(*)
from PULPIT where FACULTY = 'ИТ';

commit;

--6. показываем, что возможно только фантомное появление строки (А и Б целиком)
set transaction isolation level REPEATABLE READ
begin transaction
select TEACHER_NAME FROM TEACHER
WHERE PULPIT = 'ИСиТ';

	WAITFOR DELAY '00:00:10';
select case
    when TEACHER = 'УУУУУУУУУ' THEN 'insert TEACHER'
	else ' '
	end 'результат', TEACHER , TEACHER_NAME from TEACHER where PULPIT = 'ИСиТ';

commit;
--7.
set transaction isolation level SERIALIZABLE 
begin transaction
select case
    when TEACHER = 'ППП' THEN 'insert TEACHER'
	else ' '
	end 'результат', TEACHER , TEACHER_NAME from TEACHER where PULPIT = 'ИСиТ';

	WAITFOR DELAY '00:00:10';
select case
    when TEACHER = 'ППП' THEN 'insert TEACHER'
	else ' '
	end 'результат', TEACHER , TEACHER_NAME from TEACHER where PULPIT = 'ИСиТ';

commit;
--8 показать вложенность транзакций
select * from PULPIT

begin tran
	begin tran
	update PULPIT set PULPIT_NAME='ХТиТ' where PULPIT.FACULTY = 'ХТиТ';
	commit;
	if @@TRANCOUNT > 0 rollback;

select * from PULPIT
	
