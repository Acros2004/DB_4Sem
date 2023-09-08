create function COUNT_STUDENTS (@nameSub nvarchar(20)) returns int
as begin
	declare @count int = 0
	set @count = (select count(Id_��������) from ������������
	join ������������ on ������������.��������_�������� = ������������.��������_��������
	where ������������.��������_�������� = @nameSub)
	return @count
end

declare @temp int = dbo.COUNT_STUDENTS('��')
print cast(@temp as nvarchar)

alter function COUNT_STUDENTS (@nameSub nvarchar(20), @mark int) returns int
as begin
	declare @count int = 0
	set @count = (select count(Id_��������) from ������������
	join ������������ on ������������.��������_�������� = ������������.��������_��������
	where ������������.��������_�������� = @nameSub and ������������.������ = @mark)
	return @count
end

declare @temp int = dbo.COUNT_STUDENTS('��',9)
print cast(@temp as nvarchar)
--2
create function FSUBJECT (@id int) returns nvarchar(300)
as begin
	declare @list varchar(300) = '���������� ',@sub varchar(20)
	declare SUBJECT_CURSOR cursor local for select ������������.��������_�������� from ������������ where Id_�������� = @id
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
	select Id_��������, ������������.��������_�������� from ������������ left outer join ������������
	on ������������.��������_�������� = ������������.��������_��������
	where ������������.��������_�������� = isnull(@Subject,������������.��������_��������)
	and ������������.Id_�������� = isnull(@id,������������.Id_��������)

select * from dbo.FTest(null,null);
select * from dbo.FTest('��',null);
select * from dbo.FTest(null,1);
select * from dbo.FTest('��',1);
--4
create function FFac (@subject nvarchar(10)) returns int
as begin
	declare @count int = (select count(*) from ������������ where ������������.��������_�������� = isnull(@subject,������������.��������_��������))
	return @count
end

declare @test2 int = dbo.FFac(null)
print cast(@test2 as nvarchar)
declare @test3 int = dbo.FFac('��')
print cast(@test3 as nvarchar)

