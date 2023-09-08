use UNIVER;

exec sp_helpindex 'PULPIT'
exec sp_helpindex 'SUBJECT'	
exec sp_helpindex 'FACULTY'
exec sp_helpindex 'TEACHER'

create table #temp_table(
some_ind int,
some_field varchar(20))
set nocount on
declare @i int = 0
while @i < 1000
begin
	insert #temp_table(some_ind,some_field)
		values(FLOOR(RAND()*10000), REPLICATE('nik',3))
		set @i = @i + 1;
end

select count(*) [количество строчек] from #temp_table
select * from #temp_table

select * from #temp_table where some_ind between 1500 and 5000

checkpoint;  
DBCC DROPCLEANBUFFERS;  

CREATE clustered index #temp_table_cl on #temp_table(some_ind asc)

--2

create table #temp_table_1(
some_ind int,
some_field varchar(20),
cc int identity(1,1))
set nocount on
declare @j int = 0
while @j < 10000
begin 
	insert #temp_table_1(some_ind,some_field)
	values (FLOOR(RAND()*10000), REPLICATE('ник',3));
	set @j = @j + 1
end

select count(*) [количество строчек] from #temp_table_1
select * from #temp_table_1

select * from #temp_table_1 where cc >500 and some_ind between 1500 and 5000

CREATE index #temp_table_1_nonclu on #temp_table_1(some_ind, cc)
select cc from #temp_table_1 where some_ind > 500
--3
create table #temp_table_2(
some_ind int, 
some_field varchar(20),
cc int identity(1,1))
set nocount on
DECLARE @k int = 0
while @k < 10000
begin
	insert #temp_table_2(some_ind, some_field)
	values(FLOOR(RAND()*30000), REPLICATE('Fadva',3) );
	set @k = @k + 1; 
end

select * from #temp_table_2 where cc >500 and some_ind between 1500 and 5000
CREATE index #temp_table_2_nonclu_2 on #temp_table_2(some_ind) INCLUDE(cc)
select CC from #temp_table_2 where some_ind > 500
--4
create table #temp_table_3(
some_ind int,
cc int identity(1,1),
some_field varchar(100));
set nocount on
declare @i4 int = 0;
while @i4 < 10000
begin 
	insert #temp_table_3(some_ind,some_field) values(floor(30000*RAND()), replicate('строка',10))
	set @i4 = @i4 + 1;
end

select some_ind from #temp_table_3 where some_ind between 5000 and 19999;
select some_ind from #temp_table_3 where some_ind >15000 and some_ind <20000;
select some_ind from #temp_table_3 where some_ind = 17000

create  index #table_3_filter on #temp_table_3(some_ind) where (some_ind >= 15000 and 
some_ind < 20000); 

--5
Create table #temp_table_4
(
some_ind int,
cc int identity(1,1),
some_field varchar(100)
);
set nocount on;
declare @i5 int=0;
while @i5<10001
begin 
	insert #temp_table_4(some_ind,some_field) values(floor(30000*RAND()), replicate('строка',10))
	set @i5=@i5+1;
end

CREATE index #table_4_ind  on #temp_table_4(some_ind);

SELECT	name [Индекс],
		avg_fragmentation_in_percent [Фрагментация(%)] 
	FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
  OBJECT_ID(N'#temp_table_1_______________________________________________________________________________________________________000000000006'), NULL, NULL, NULL) ss
  JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id 
  where name is not null;

INSERT top(100000) #temp_table_4(some_ind, some_field) select some_ind, some_field from #temp_table_4;

ALTER index #table_4_ind on #temp_table_4 reorganize; 
ALTER index #table_4_ind  on #temp_table_4 rebuild with (online = off);

--6
Create table #temp_table_5
(
some_ind int,
CC int identity(1,1),
some_field varchar(100)
);
set nocount on;
declare @i6 int=0;
while @i6<10001
begin 
	INSERT #temp_table_5(some_ind,some_field) values(floor(30000*RAND()), replicate('строка',10))
	set @i6=@i6+1;
end
CREATE index #table_5_ind  on #temp_table_5(some_ind) with(fillfactor=65);
INSERT top(100000) #temp_table_5(some_ind, some_field) select some_ind, some_field from #temp_table_5;

SELECT	name [Индекс],
		avg_fragmentation_in_percent [Фрагментация(%)] 
	FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
  OBJECT_ID(N'#temp_table_5'), NULL, NULL, NULL) ss
  JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id 
  where name is not null;