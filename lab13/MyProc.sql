use Кар_MyBaseClone

create procedure PProgress
as begin
	declare @k int = (select count(*) from Успеваемость)
	select * from Успеваемость
	return @k
end

declare @i int = 0
exec @i = PProgress
print 'PProgress: '+ cast(@i as varchar(3))

--2
alter procedure [dbo].[PProgress] @id int = NULL,@c int output
as begin
	declare @k int = (select count(*) from Успеваемость)
	print '@p='+cast(@id as nvarchar)+',@c='+cast(@c as varchar(3))
	select * from Успеваемость where Id_студента = @id
	set @c = @@ROWCOUNT
	return @k
end

declare @temp_2 int = 0, @out_2 int = 0;
exec @temp_2 = PProgress '1', @out_2 output;
print 'всего: ' + convert(varchar, @temp_2);
print 'именно 1: ' + convert(varchar, @out_2);

--3
alter procedure PProgress @id int
as begin
	select * from Успеваемость where Id_студента = @id;
end;

CREATE table #SUBJECT
(Id_студента int primary key,
Название_предмета varchar(50),
Оценка int);

insert #SUBJECT exec PProgress @id = 5; 
SELECT * from #SUBJECT;
--4
create procedure PProgress_Insert @id int,@nameOfSubject nvarchar(50),@mark int
as begin try
	insert into Успеваемость(Id_студента,Название_предмета,Оценка)
		values (@id,@nameOfSubject,@mark)
	return 1
end try
begin catch
print 'номер ошибки: ' + cast(error_number() as varchar(6));	
	print 'сообщение: ' + error_message();
	print 'уровень: ' + cast(error_severity() as varchar(6));
	print 'метка: ' + cast(error_state() as varchar(8));
	print 'номер строки: ' + cast(error_line() as varchar(8));
	if error_procedure() is not null   
		print 'имя процедуры: ' + error_procedure();
	return -1;
end catch;

DECLARE @rc int; 
exec @rc = PProgress_Insert @id = 5,@nameOfSubject = 'БД',@mark = 9
print 'ответ: '+cast(@rc as varchar(3));
--5
create procedure SUBJECT_REPORT @id int
as declare @rc int = 0;
begin try
	if not exists (select Id_студента from Успеваемость where Id_студента = @id)
	raiserror('ошибка в параметрах', 11, 1);
	declare @subs_list char(300) = '', @sub char(10);
	declare SUBJECTS_L12 cursor for select Название_предмета from Успеваемость where Id_студента = @id;
	open SUBJECTS_L12;
	fetch SUBJECTS_L12 into @sub;
	while (@@FETCH_STATUS = 0)
	begin
		set @subs_list = rtrim(@sub) + ', ' + @subs_list;
		set @rc += 1;
		fetch SUBJECTS_L12 into @sub;
	end;
	print 'ID ' + cast(@id as nvarchar) + ':';
	print rtrim(@subs_list);
	close SUBJECTS_L12;
	deallocate SUBJECTS_L12;
	return @rc;
end try
begin catch
	print 'номер ошибки: ' + cast(error_number() as varchar(6));	
	print 'сообщение: ' + error_message();
	print 'уровень: ' + cast(error_severity() as varchar(6));
	print 'метка: ' + cast(error_state() as varchar(8));
	print 'номер строки: ' + cast(error_line() as varchar(8));
	if error_procedure() is not null   
		print 'имя процедуры: ' + error_procedure();
	return @rc;
end catch;
go
--drop procedure SUBJECT_REPORT

declare @temp_5 int;
exec @temp_5 = SUBJECT_REPORT 1;
print 'Количество: ' + convert(varchar, @temp_5);
go
--6
create proc P_INSERT
@nameSubject nvarchar(20),@v_l int,@v_p int,@v_lab int,@id int,
@mark int
as begin try
	set transaction isolation level SERIALIZABLE
	begin tran 
		insert into Факультативы(Название_предмета,Объём_лекций,Объём_практических,Объём_лабараторных)
			values(@nameSubject,@v_l,@v_p,@v_lab)
		exec PProgress_Insert @id, @nameSubject,@mark
	commit tran
end try
begin catch
	print 'номер:  ' + cast(ERROR_NUMBER() as varchar)
	print 'уровень: ' + cast(ERROR_SEVERITY() as varchar)
	print 'сообщение:   ' + cast(ERROR_MESSAGE() as varchar)
	if @@TRANCOUNT > 0 
		rollback tran
	return -1
end catch

--drop procedure P_INSERT
exec P_INSERT @nameSubject = 'TEST',@v_l = 3,@v_p = 3,@v_lab = 3, @id =1,
@mark = 6
select * from Успеваемость