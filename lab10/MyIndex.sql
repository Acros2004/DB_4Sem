use Кар_MyBaseClone;

exec sp_helpindex 'Студенты'
exec sp_helpindex 'Успеваемость'
exec sp_helpindex 'Факультативы'

set nocount on

declare @i int = 0
while @i < 10000
begin
	insert Студенты(Id_студента,Имя,Фамилия,Отчество,Адрес,Телефон)
	values(FLOOR(RAND()*10000), REPLICATE('test',1),REPLICATE('test',2),REPLICATE('test',3),REPLICATE('lenin',1),FLOOR(RAND()*10000))
	set @i = @i + 1;
end;

select * from Студенты where Id_студента between 1500 and 5000

--CREATE clustered index #temp_ind on Студенты(Id_студента asc) нельзя так как есть уже primary key
--2
CREATE index #temp_nonclu on Студенты(Id_студента, Имя)
select Имя from Студенты where Id_студента > 400

drop index #temp_nonclu on Студенты;
--3
CREATE index #temp_table_2_nonclu_2 on Студенты(Id_студента) INCLUDE(Имя)
select Имя from Студенты where Id_студента > 400
drop index #temp_table_2_nonclu_2 on Студенты;
--4
select Id_студента from Студенты where Id_студента between 5000 and 19999;
select Id_студента from Студенты where Id_студента >15000 and Id_студента <19999;
select Id_студента from Студенты where Id_студента = 17000

create  index #table_3_filter on Студенты(Id_студента) where (Id_студента >= 15000 and 
Id_студента < 20000);
drop index #table_3_filter on Студенты;
--5
CREATE index #table_4_ind  on Студенты(Id_студента);

SELECT	name [Индекс],
		avg_fragmentation_in_percent [Фрагментация(%)] 
	FROM sys.dm_db_index_physical_stats(DB_ID(N'Кар_MyBaseClone'), 
  OBJECT_ID(N'Студенты'), NULL, NULL, NULL) ss
  JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id 
  where name is not null;

set nocount on

declare @k int = 0
while @k < 10000
begin
	insert Студенты(Id_студента,Имя,Фамилия,Отчество,Адрес,Телефон)
	values(FLOOR(RAND()*100000), REPLICATE('test',1),REPLICATE('test',2),REPLICATE('test',3),REPLICATE('lenin',1),FLOOR(RAND()*10000))
	set @k = @k + 1;
end;

ALTER index #table_4_ind on Студенты reorganize;
ALTER index #table_4_ind  on Студенты rebuild with (online = off);

drop index #table_4_ind on Студенты;
--6
CREATE index #table_5_ind  on Студенты(Id_студента) with(fillfactor=65);

set nocount on
declare @l int = 0
while @l < 5000
begin
	insert Студенты(Id_студента,Имя,Фамилия,Отчество,Адрес,Телефон)
	values(FLOOR(RAND()*100000), REPLICATE('test',1),REPLICATE('test',2),REPLICATE('test',3),REPLICATE('lenin',1),FLOOR(RAND()*10000))
	set @l = @l + 1;
end;

SELECT	name [Индекс],
		avg_fragmentation_in_percent [Фрагментация(%)] 
	FROM sys.dm_db_index_physical_stats(DB_ID(N'Кар_MyBaseClone'), 
  OBJECT_ID(N'Студенты'), NULL, NULL, NULL) ss
  JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id 
  where name is not null;