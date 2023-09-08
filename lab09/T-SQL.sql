use UNIVER
declare @c char ='C',
		@v varchar(4)='БГТУ',
		@d datetime,
		@t time,
		@i int,
		@s smallint,
		@ti tinyint,
		@n numeric(12,5)
set @d = GETDATE()
set @t ='22:22:22:22'
select @i = 123,@s = 111,@ti = 12,@n = 111111.11111
select @i i,@s s, @ti ti,@n n
print 'i='+cast(@s as varchar(10))
print 's='+cast(@s as varchar(10))
print 'ti='+cast(@ti as varchar(10))
print 'n='+cast(@n as varchar(13))
--2
declare @v1 int,@v2 int, @v3 int,@v4 int
select @v1 = sum(AUDITORIUM_CAPACITY) from AUDITORIUM
if @v1 > 200
begin
select @v2 = (select count(*) from AUDITORIUM),
	@v3 = (select avg(AUDITORIUM_CAPACITY) from AUDITORIUM)
	set @v4 = (select count(*) from AUDITORIUM where AUDITORIUM_CAPACITY < @v3)
select @v2 'Количество', @v3 'Средняя вместимость',@v4 'Вместимость меньше',
	100*(cast(@v4 as float)/cast(@v2 as float)) 'Процент аудиторий'
end
else print 'Общая вместимость' + cast(@v1 as varchar(10))

--3
select * from AUDITORIUM
print 'число строк: '+cast(@@rowcount as varchar(12));
print 'версия SQL Server: '+cast(@@version as varchar(100));
print 'идентификатор процесса: '+cast(@@spid as varchar(12));
print 'код последней ошибки: '+cast(@@error as varchar(10));
print 'имя сервера: '+cast(@@servername as varchar(100));
print 'уровень вложенности транзакции: '+cast(@@trancount as varchar(20));
print 'статус выборки: '+cast(@@fetch_status as varchar(20));
print 'уровень вложенности текущей процедуры: '+cast(@@nestlevel as varchar(20));
--4
declare @tt int=3, @x float=4, @z float;
if (@tt>@x) set @z=power(SIN(@tt),2);
if (@tt<@x) set @z=4*(@tt+@x);
if (@tt=@x) set @z=1-exp(@x-2);
print 'z='+cast(@z as varchar(10));

declare @fio varchar(100)='Каребо Никита Сергеевич'
select  substring(@fio, 1, charindex(' ', @fio))
		+substring(@fio, charindex(' ', @fio)+1,1)+'.'
		+substring(@fio, charindex(' ', @fio, charindex(' ', @fio)+1)+1,1)+'.' 'ФИО'

select NAME,BDAY, YEAR(GETDATE())-YEAR(BDAY) [Возраст]	
from STUDENT 
where MONTH(BDAY)=MONTH(getdate())+1

declare @gr integer = 5, @wd date
set @wd = (select top(1) PROGRESS.PDATE from PROGRESS 
join STUDENT on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
where STUDENT.IDGROUP = 5 and PROGRESS.SUBJECT = 'СУБД')
select DATENAME(dw,@wd) [День недели]

--5
declare @CountOfGroups int = (select COUNT(*) from GROUPS)
if(@CountOfGroups < 10)
	begin
	print 'Кол-во групп меньше 10'
	print 'Кол-во ' + CAST(@CountOfGroups as varchar)
end
else if(@CountOfGroups < 15)
	begin
	print 'Кол-во групп меньше 15'
	print 'Кол-во ' + CAST(@CountOfGroups as varchar)
end
else if(@CountOfGroups < 20)
	begin
	print 'Кол-во групп меньше 20'
	print 'Кол-во ' + CAST(@CountOfGroups as varchar)
end
else if(@CountOfGroups >= 21)
	begin
	print 'Кол-во групп >= 21'
	print 'Кол-во ' + CAST(@CountOfGroups as varchar)
end

--6
select student.NAME [Имя], student.IDGROUP [Группа],
case	when progress.NOTE between 0 and 3 then 'плохо'
		when progress.NOTE between 4 and 6 then 'нормально'
		when progress.NOTE between 7 and 8 then 'неплохо'
else 'отлично'
end Оценка, COUNT(*)[Количество]
from student, PROGRESS where student.IDGROUP=4
group by student.NAME, student.IDGROUP,
case	when progress.NOTE between 0 and 3 then 'плохо'
		when progress.NOTE between 4 and 6 then 'нормально'
		when progress.NOTE between 7 and 8 then 'неплохо'
else 'отлично'
end

--7
create table #Table
(
	ID int identity(0,100),
	LOTO INT,
	Moneys money
);
set nocount on -- не выводить сообщение о вводе строки
declare @ii int = 0;
while @ii < 10
	begin
	insert #Table(LOTO,Moneys)
		values(1500*Rand(),15000*(Rand()))
	set @ii= @ii+1;
	end;
select * from #Table
drop table #Table

--8
declare @xx int = 1
while @xx < 10
begin
	print @xx
	set @xx=@xx+1
	if (@xx > 5) return
end
--9
declare @5 int = 5, @0 int = 0;
begin TRY
	print @5/@0;
end try
begin catch
	print 'Код последней ошибки ' + CAST(ERROR_NUMBER() as varchar(200));
	print 'Сообщение об ошибке ' + ERROR_MESSAGE()
	print 'Номер строки с ошибкой ' +CAST(ERROR_LINE() as varchar(200));
	print 'Уровень серьезности ошибки ' + CAST(ERROR_SEVERITY() as varchar(200));
	print 'Метка ошибки ' + CAST(ERROR_STATE() as varchar(200));
end catch