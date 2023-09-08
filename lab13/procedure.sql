use UNIVER
create procedure PSUBJECT
as begin
	declare @k int = (select count(*) from SUBJECT)
	select SUBJECT[Код],SUBJECT_NAME[дисциплина],PULPIT[кафедра] from SUBJECT
	return @k;
end
drop procedure PSUBJECT
declare @i int = 0
exec @i = PSUBJECT
print 'Subject: '+ cast(@i as varchar(3))
--2
alter procedure [dbo].[PSUBJECT] @p varchar(20) = NULL,@c int output
as begin
	declare @k int = (select count(*) from SUBJECT)
	print '@p='+@p+',@c='+cast(@c as varchar(3))
	select SUBJECT[Код],SUBJECT_NAME[дисциплина],PULPIT[кафедра] from SUBJECT where PULPIT = @p
	set @c = @@ROWCOUNT
	return @k
end

declare @temp_2 int = 0, @out_2 int = 0;
exec @temp_2 = PSUBJECT 'ИСиТ', @out_2 output;
print 'всего: ' + convert(varchar, @temp_2);
print 'именно исита: ' + convert(varchar, @out_2);
--3
alter procedure PSUBJECT @p varchar(20)
as begin
	select * from SUBJECT where SUBJECT.PULPIT = @p;
end;

CREATE table #SUBJECT
(Код varchar(10) primary key,
дисциплина varchar(50),
кафедра varchar(10));
--drop table #SUBJECT;

insert #SUBJECT exec PSUBJECT @p = 'ИСиТ'; 
SELECT * from #SUBJECT;
--4
create procedure PAUDITORIUM_INSERT @a char(20), @n varchar(50),  @c int=0, @t char(10)
as begin try
	insert into AUDITORIUM(AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY, AUDITORIUM_NAME)
		values (@a, @t, @c, @n)
	return 1;
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
--drop procedure PAUDITORIUM_INSERT;

DECLARE @rc int; 
exec @rc=PAUDITORIUM_INSERT @a='222-2', @t='ЛК', @c=60, @n='nikitos';
print 'ответ: '+cast(@rc as varchar(3));
--delete AUDITORIUM where AUDITORIUM='222-2';

select * from AUDITORIUM;
--5
create procedure SUBJECT_REPORT @p char(10)
as declare @rc int = 0;
begin try
	if not exists (select SUBJECT from SUBJECT where PULPIT = @p)
	raiserror('ошибка в параметрах', 11, 1);
	declare @subs_list char(300) = '', @sub char(10);
	declare SUBJECTS_L12 cursor for select SUBJECT from SUBJECT where PULPIT = @p;
	open SUBJECTS_L12;
	fetch SUBJECTS_L12 into @sub;
	while (@@FETCH_STATUS = 0)
	begin
		set @subs_list = rtrim(@sub) + ', ' + @subs_list;
		set @rc += 1;
		fetch SUBJECTS_L12 into @sub;
	end;
	print 'Кафедра ' + rtrim(@p) + ':';
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
exec @temp_5 = SUBJECT_REPORT 'ИСиТ';
print 'Количество: ' + convert(varchar, @temp_5);
go
--6
create proc PAUDITORIUM_INSERTX 
@AUD char(20), @NAME varchar(50), @CAPACITY int = 0,
@AUD_TYPE char(10), @AUD_TYPENAME varchar(70)
as begin try
	set transaction isolation level SERIALIZABLE
	begin tran
		insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME) values (@NAME, @AUD_TYPENAME)
		exec PAUDITORIUM_INSERT @AUD, @AUD_TYPE, @CAPACITY, @NAME
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
--drop procedure PAUDITORIUM_INSERTX;

exec PAUDITORIUM_INSERTX @AUD = 'nik', @NAME = 'nik', 
@CAPACITY = 50, @AUD_TYPE = 'nik', @AUD_TYPENAME = 'niki'
delete AUDITORIUM_TYPE where AUDITORIUM_TYPE='nik'
delete AUDITORIUM where AUDITORIUM_TYPE='nik';
select * from AUDITORIUM;