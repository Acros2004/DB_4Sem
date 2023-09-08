--1
use Кар_MyBaseClone

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

begin try
	begin tran
		insert Студенты values (6,'test','test','test','test',12345,2)
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
--3
declare @point varchar(3)
begin try
	begin tran
		delete from Студенты where Id_студента = 6
		set @point = 'p1'; save tran @point
		insert Студенты values (6,'test','test','test','test',12345,2)
		set @point = 'p2'; save tran @point
		insert Студенты values (6,'test','test','test','test',12345,2)
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
--4
set transaction isolation level READ UNCOMMITTED;
begin transaction
	select @@SPID, 'insert Успеваемость' 'результат', * from Успеваемость
															   where Id_студента = 5;
	select @@SPID, 'update Успеваемость' 'результат', * from Успеваемость
															   where Id_студента = 5;
	WAITFOR DELAY '00:00:10';

	select @@SPID, 'insert Успеваемость' 'результат', * from Успеваемость
															   where Id_студента = 5;
	select @@SPID, 'update Успеваемость' 'результат', * from Успеваемость
															   where Id_студента = 5;														 
commit;
--5
set transaction isolation level READ COMMITTED;
begin transaction
	select @@SPID, 'insert Успеваемость' 'результат', * from Успеваемость
															   where Id_студента = 5;
	select @@SPID, 'update Успеваемость' 'результат', * from Успеваемость
															   where Id_студента = 5;
	WAITFOR DELAY '00:00:10';

	select @@SPID, 'insert Успеваемость' 'результат', * from Успеваемость
															   where Id_студента = 5;
	select @@SPID, 'update Успеваемость' 'результат', * from Успеваемость
															   where Id_студента = 5;														 
commit;
--6
set transaction isolation level REPEATABLE READ;
begin transaction
	select @@SPID, 'insert Успеваемость' 'результат', * from Успеваемость
															   where Id_студента = 5;
	select @@SPID, 'update Успеваемость' 'результат', * from Успеваемость
															   where Id_студента = 5;
	WAITFOR DELAY '00:00:20';

	select @@SPID, 'insert Успеваемость' 'результат', * from Успеваемость
															   where Id_студента = 5;
	select @@SPID, 'update Успеваемость' 'результат', * from Успеваемость
															   where Id_студента = 5;														 
commit;
--7
set transaction isolation level SERIALIZABLE;
begin transaction
	select @@SPID, 'insert Успеваемость' 'результат', * from Успеваемость
															   where Id_студента = 5;
	select @@SPID, 'update Успеваемость' 'результат', * from Успеваемость
															   where Id_студента = 5;
	WAITFOR DELAY '00:00:20';

	select @@SPID, 'insert Успеваемость' 'результат', * from Успеваемость
															   where Id_студента = 5;
	select @@SPID, 'update Успеваемость' 'результат', * from Успеваемость
															   where Id_студента = 5;														 
commit;
--8
select * from Успеваемость

begin tran
	begin tran
	update Успеваемость set Оценка= Оценка+1 where Id_студента = 5 and Название_предмета = 'Ts';
	commit;
	if @@TRANCOUNT > 0 rollback;

select * from Успеваемость
