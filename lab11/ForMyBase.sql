use Кар_MyBaseClone

declare cur cursor for select Название_предмета from Успеваемость
declare @subject nvarchar(50),@str char(100) = ' '
open cur
fetch cur into @subject
print 'предметы:'
while @@FETCH_STATUS = 0
begin
	set @str = rtrim(@subject)+ ', '+@str
	fetch cur into @subject
end
print @str
close cur
deallocate cur
--2
declare curLocal cursor local for select Id_студента, Оценка  from Успеваемость
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

declare curGlobal cursor for select Id_студента, Оценка  from Успеваемость
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
declare cur cursor local static for select Студенты.Имя from Студенты
declare @name varchar(30)
open cur
print 'Количество строк: '+ cast(@@cursor_rows as char)
update Студенты set Имя = 'ни' where Имя = 'Никита'
fetch cur into @name
while @@FETCH_STATUS = 0
begin
	print @name + ' '
	fetch cur into @name
end
select Студенты.Имя from Студенты
close cur
deallocate cur
go
declare cur cursor local dynamic for select Студенты.Имя from Студенты
declare @name varchar(30)
open cur
print 'Количество строк: '+ cast(@@cursor_rows as char)
update Студенты set Имя = 'Никита' where Имя = 'ни'
fetch cur into @name
while @@FETCH_STATUS = 0
begin
	print @name + ' '
	fetch cur into @name
end
select Студенты.Имя from Студенты
close cur
deallocate cur
--4
declare @t int, @rn char(50)
declare curScroll cursor local dynamic scroll for 
	select ROW_NUMBER() over (order by Имя), Имя from Студенты 
open curScroll
fetch FIRST from curScroll into  @t, @rn                
print 'первая: ' + cast(@t as varchar(3))+ ' ' + rtrim(@rn)
fetch NEXT from curScroll into  @t, @rn              
print 'следущая: ' + cast(@t as varchar(3))+ ' ' + rtrim(@rn)      
fetch LAST from  curScroll into @t, @rn       
print 'последняя: ' +  cast(@t as varchar(3))+ ' '+rtrim(@rn)   
fetch PRIOR from curScroll into  @t, @rn        
print 'шаг назад: ' + cast(@t as varchar(3))+ ' ' + rtrim(@rn) 
fetch ABSOLUTE 2 from curScroll into  @t, @rn                
print 'вторая: ' + cast(@t as varchar(3))+ ' ' + rtrim(@rn) 
fetch RELATIVE 1 from curScroll into  @t, @rn          
print 'отн + 1: ' + cast(@t as varchar(3))+ ' ' + rtrim(@rn) 
close curScroll
deallocate curScroll
--5
declare cur cursor local dynamic for select Id_студента, Оценка from Успеваемость FOR UPDATE
declare @id varchar(10), @nt int
open cur
fetch cur into @id, @nt
print @id + ' удаляем ' + cast(@nt as varchar) + ' '
delete Успеваемость where CURRENT OF cur	
fetch cur into @id, @nt
update Успеваемость set Оценка = Оценка + 1 where CURRENT OF cur
print @id + ' изменяем на + 1 ' + cast(@nt as varchar) + ' '
close cur
deallocate cur
--6
go
declare @name nvarchar(20),@n int
declare cur cursor local for select Имя, Оценка  from Успеваемость join Студенты
	on Успеваемость.Id_студента = Студенты.Id_студента join Факультативы
		on Факультативы.Название_предмета = Успеваемость.Название_предмета
		and Оценка < 8 and Имя = 'Никита'
open cur
fetch cur into @name,@n
while @@FETCH_STATUS = 0
begin
	delete Успеваемость where CURRENT OF cur
	fetch cur into @name,@n
end

close cur
deallocate cur
select Имя, Оценка  from Успеваемость join Студенты
	on Успеваемость.Id_студента = Студенты.Id_студента join Факультативы
		on Факультативы.Название_предмета = Успеваемость.Название_предмета
		and Оценка < 5 and Имя = 'Никита'
insert into Успеваемость(Id_студента,Название_предмета,Оценка)
values  (3, 'Ts',3)  
--коррекция
declare @name4 char(20), @n3 int
declare cur2 cursor local for select Id_студента, Оценка from Успеваемость where Id_студента = 1
open cur2
fetch  cur2 into @name4, @n3
update Успеваемость set Оценка=Оценка+1 where current of cur2
close cur2
deallocate cur2

select Id_студента, Оценка from Успеваемость where Id_студента = 1