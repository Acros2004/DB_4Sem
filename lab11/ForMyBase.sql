use ���_MyBaseClone

declare cur cursor for select ��������_�������� from ������������
declare @subject nvarchar(50),@str char(100) = ' '
open cur
fetch cur into @subject
print '��������:'
while @@FETCH_STATUS = 0
begin
	set @str = rtrim(@subject)+ ', '+@str
	fetch cur into @subject
end
print @str
close cur
deallocate cur
--2
declare curLocal cursor local for select Id_��������, ������  from ������������
declare @str2 varchar(10), @note real
open curLocal
fetch curLocal into @str2,@note
print '1. ' +@str2 + ': '+ cast(@note as varchar)
go
declare @str2 varchar(10), @note real
open curLocal
fetch curLocal into @str2,@note
print '2. '+ @str2 + ': ' + cast(@note as varchar)
go

declare curGlobal cursor for select Id_��������, ������  from ������������
declare @str2 varchar(10), @note real
open curGlobal
fetch curGlobal into @str2,@note
print '1. ' +@str2 + ': '+ cast(@note as varchar)
go
declare @str2 varchar(10), @note real
fetch curGlobal into @str2,@note
print '2. '+ @str2 + ': ' + cast(@note as varchar)
go
close curGlobal
deallocate curGlobal
--3
declare cur cursor local static for select ��������.��� from ��������
declare @name varchar(30)
open cur
print '���������� �����: '+ cast(@@cursor_rows as char)
update �������� set ��� = '��' where ��� = '������'
fetch cur into @name
while @@FETCH_STATUS = 0
begin
	print @name + ' '
	fetch cur into @name
end
select ��������.��� from ��������
close cur
deallocate cur
go
declare cur cursor local dynamic for select ��������.��� from ��������
declare @name varchar(30)
open cur
print '���������� �����: '+ cast(@@cursor_rows as char)
update �������� set ��� = '������' where ��� = '��'
fetch cur into @name
while @@FETCH_STATUS = 0
begin
	print @name + ' '
	fetch cur into @name
end
select ��������.��� from ��������
close cur
deallocate cur
--4
declare @t int, @rn char(50)
declare curScroll cursor local dynamic scroll for 
	select ROW_NUMBER() over (order by ���), ��� from �������� 
open curScroll
fetch FIRST from curScroll into  @t, @rn                
print '������: ' + cast(@t as varchar(3))+ ' ' + rtrim(@rn)
fetch NEXT from curScroll into  @t, @rn              
print '��������: ' + cast(@t as varchar(3))+ ' ' + rtrim(@rn)      
fetch LAST from  curScroll into @t, @rn       
print '���������: ' +  cast(@t as varchar(3))+ ' '+rtrim(@rn)   
fetch PRIOR from curScroll into  @t, @rn        
print '��� �����: ' + cast(@t as varchar(3))+ ' ' + rtrim(@rn) 
fetch ABSOLUTE 2 from curScroll into  @t, @rn                
print '������: ' + cast(@t as varchar(3))+ ' ' + rtrim(@rn) 
fetch RELATIVE 1 from curScroll into  @t, @rn          
print '��� + 1: ' + cast(@t as varchar(3))+ ' ' + rtrim(@rn) 
close curScroll
deallocate curScroll
--5
declare cur cursor local dynamic for select Id_��������, ������ from ������������ FOR UPDATE
declare @id varchar(10), @nt int
open cur
fetch cur into @id, @nt
print @id + ' ������� ' + cast(@nt as varchar) + ' '
delete ������������ where CURRENT OF cur	
fetch cur into @id, @nt
update ������������ set ������ = ������ + 1 where CURRENT OF cur
print @id + ' �������� �� + 1 ' + cast(@nt as varchar) + ' '
close cur
deallocate cur
--6
go
declare @name nvarchar(20),@n int
declare cur cursor local for select ���, ������  from ������������ join ��������
	on ������������.Id_�������� = ��������.Id_�������� join ������������
		on ������������.��������_�������� = ������������.��������_��������
		and ������ < 8 and ��� = '������'
open cur
fetch cur into @name,@n
while @@FETCH_STATUS = 0
begin
	delete ������������ where CURRENT OF cur
	fetch cur into @name,@n
end

close cur
deallocate cur
select ���, ������  from ������������ join ��������
	on ������������.Id_�������� = ��������.Id_�������� join ������������
		on ������������.��������_�������� = ������������.��������_��������
		and ������ < 5 and ��� = '������'
insert into ������������(Id_��������,��������_��������,������)
values  (3, 'Ts',3)  
--���������
declare @name4 char(20), @n3 int
declare cur2 cursor local for select Id_��������, ������ from ������������ where Id_�������� = 1
open cur2
fetch  cur2 into @name4, @n3
update ������������ set ������=������+1 where current of cur2
close cur2
deallocate cur2

select Id_��������, ������ from ������������ where Id_�������� = 1