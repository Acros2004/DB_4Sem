use UNIVER
--4
-----Сценарий B-----
begin transaction
	select @@SPID;
	insert AUDITORIUM_TYPE values ('СЗ', 'Спортивный зал');
	update AUDITORIUM_TYPE set AUDITORIUM_TYPENAME = 'Лекционный кабинет' where AUDITORIUM_TYPE = 'ЛК';
	
-----t1-----
-----t2-----
rollback;
--5
begin transaction
-----t1-----
update PULPIT set FACULTY = 'Ни' --ИТ Ни 
where PULPIT = 'ЛВ' 
-----t2-----
commit; 
--6 и для 7
begin transaction 	  
    insert TEACHER values ('УУУУУУУУУ', 'GGGGGGGG', 'м', 'ИСиТ');
	update TEACHER set TEACHER_NAME = 'Акунович Станислав Иванович' where TEACHER_NAME = 'Никита'
commit; 
 


