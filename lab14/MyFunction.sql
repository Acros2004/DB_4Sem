create function COUNT_STUDENTS (@nameSub nvarchar(20)) returns int
as begin
	declare @count int = 0
	set @count = (select count(Id_студента) from Успеваемость
	join Факультативы on Факультативы.Название_предмета = Успеваемость.Название_предмета
	where Факультативы.Название_предмета = @nameSub)
	return @count
end

declare @temp int = dbo.COUNT_STUDENTS('БД')
print cast(@temp as nvarchar)

alter function COUNT_STUDENTS (@nameSub nvarchar(20), @mark int) returns int
as begin
	declare @count int = 0
	set @count = (select count(Id_студента) from Успеваемость
	join Факультативы on Факультативы.Название_предмета = Успеваемость.Название_предмета
	where Факультативы.Название_предмета = @nameSub and Успеваемость.Оценка = @mark)
	return @count
end

declare @temp int = dbo.COUNT_STUDENTS('БД',9)
print cast(@temp as nvarchar)
--2
create function FSUBJECT (@id int) returns nvarchar(300)
as begin
	declare @list varchar(300) = 'Дисциплины ',@sub varchar(20)
	declare SUBJECT_CURSOR cursor local for select Успеваемость.Название_предмета from Успеваемость where Id_студента = @id
	open SUBJECT_CURSOR
	fetch next from SUBJECT_CURSOR into @sub
	while @@FETCH_STATUS = 0
	begin
		set @list=@list+rtrim(@sub)+', ';
		fetch SUBJECT_CURSOR into @sub
	end;
	return @list;
end

declare @temp1 nvarchar(350) =  dbo.FSUBJECT(5)
print @temp1
--3
create function FTest (@Subject varchar(10),@id int) returns table
as return
	select Id_студента, Успеваемость.Название_предмета from Успеваемость left outer join Факультативы
	on Успеваемость.Название_предмета = Факультативы.Название_предмета
	where Факультативы.Название_предмета = isnull(@Subject,Факультативы.Название_предмета)
	and Успеваемость.Id_студента = isnull(@id,Успеваемость.Id_студента)

select * from dbo.FTest(null,null);
select * from dbo.FTest('БД',null);
select * from dbo.FTest(null,1);
select * from dbo.FTest('БД',1);
--4
create function FFac (@subject nvarchar(10)) returns int
as begin
	declare @count int = (select count(*) from Факультативы where Факультативы.Название_предмета = isnull(@subject,Факультативы.Название_предмета))
	return @count
end

declare @test2 int = dbo.FFac(null)
print cast(@test2 as nvarchar)
declare @test3 int = dbo.FFac('БД')
print cast(@test3 as nvarchar)

