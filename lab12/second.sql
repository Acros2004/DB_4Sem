use UNIVER
--4
-----�������� B-----
begin transaction
	select @@SPID;
	insert AUDITORIUM_TYPE values ('��', '���������� ���');
	update AUDITORIUM_TYPE set AUDITORIUM_TYPENAME = '���������� �������' where AUDITORIUM_TYPE = '��';
	
-----t1-----
-----t2-----
rollback;
--5
begin transaction
-----t1-----
update PULPIT set FACULTY = '��' --�� �� 
where PULPIT = '��' 
-----t2-----
commit; 
--6 � ��� 7
begin transaction 	  
    insert TEACHER values ('���������', 'GGGGGGGG', '�', '����');
	update TEACHER set TEACHER_NAME = '�������� ��������� ��������' where TEACHER_NAME = '������'
commit; 
 


