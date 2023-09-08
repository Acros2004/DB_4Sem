use ���_MyBaseClone;

exec sp_helpindex '��������'
exec sp_helpindex '������������'
exec sp_helpindex '������������'

set nocount on

declare @i int = 0
while @i < 10000
begin
	insert ��������(Id_��������,���,�������,��������,�����,�������)
	values(FLOOR(RAND()*10000), REPLICATE('test',1),REPLICATE('test',2),REPLICATE('test',3),REPLICATE('lenin',1),FLOOR(RAND()*10000))
	set @i = @i + 1;
end;

select * from �������� where Id_�������� between 1500 and 5000

--CREATE clustered index #temp_ind on ��������(Id_�������� asc) ������ ��� ��� ���� ��� primary key
--2
CREATE index #temp_nonclu on ��������(Id_��������, ���)
select ��� from �������� where Id_�������� > 400

drop index #temp_nonclu on ��������;
--3
CREATE index #temp_table_2_nonclu_2 on ��������(Id_��������) INCLUDE(���)
select ��� from �������� where Id_�������� > 400
drop index #temp_table_2_nonclu_2 on ��������;
--4
select Id_�������� from �������� where Id_�������� between 5000 and 19999;
select Id_�������� from �������� where Id_�������� >15000 and Id_�������� <19999;
select Id_�������� from �������� where Id_�������� = 17000

create  index #table_3_filter on ��������(Id_��������) where (Id_�������� >= 15000 and 
Id_�������� < 20000);
drop index #table_3_filter on ��������;
--5
CREATE index #table_4_ind  on ��������(Id_��������);

SELECT	name [������],
		avg_fragmentation_in_percent [������������(%)] 
	FROM sys.dm_db_index_physical_stats(DB_ID(N'���_MyBaseClone'), 
  OBJECT_ID(N'��������'), NULL, NULL, NULL) ss
  JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id 
  where name is not null;

set nocount on

declare @k int = 0
while @k < 10000
begin
	insert ��������(Id_��������,���,�������,��������,�����,�������)
	values(FLOOR(RAND()*100000), REPLICATE('test',1),REPLICATE('test',2),REPLICATE('test',3),REPLICATE('lenin',1),FLOOR(RAND()*10000))
	set @k = @k + 1;
end;

ALTER index #table_4_ind on �������� reorganize;
ALTER index #table_4_ind  on �������� rebuild with (online = off);

drop index #table_4_ind on ��������;
--6
CREATE index #table_5_ind  on ��������(Id_��������) with(fillfactor=65);

set nocount on
declare @l int = 0
while @l < 5000
begin
	insert ��������(Id_��������,���,�������,��������,�����,�������)
	values(FLOOR(RAND()*100000), REPLICATE('test',1),REPLICATE('test',2),REPLICATE('test',3),REPLICATE('lenin',1),FLOOR(RAND()*10000))
	set @l = @l + 1;
end;

SELECT	name [������],
		avg_fragmentation_in_percent [������������(%)] 
	FROM sys.dm_db_index_physical_stats(DB_ID(N'���_MyBaseClone'), 
  OBJECT_ID(N'��������'), NULL, NULL, NULL) ss
  JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id 
  where name is not null;