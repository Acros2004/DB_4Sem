create view [�������������] as
select TEACHER [���],
TEACHER_NAME [��� �������������],
GENDER [���],
PULPIT [��� ������]
from TEACHER

select * from �������������
--2
create view [���������� ������]
as select FACULTY_NAME [���������],
count(PULPIT.FACULTY) [���������� ������]
from FACULTY join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME

select * from "���������� ������"
--3
create view ��������� (���,"������������ ���������","��� ���������")
as select AUDITORIUM,
AUDITORIUM_NAME,
AUDITORIUM_TYPE
from AUDITORIUM
where AUDITORIUM_TYPE like '��%'

insert ��������� values('111-1','�����','��')
update ��������� set "������������ ���������" = '������' where ��� = '111-1'
delete from ��������� where "������������ ���������" = '������'
select * from ���������
--4
create view ���������_��������� (���,"������������ ���������","��� ���������")
as select AUDITORIUM,
AUDITORIUM_NAME,
AUDITORIUM_TYPE
from AUDITORIUM
where AUDITORIUM_TYPE like '��%'
with check option

insert ���������_��������� values ('222-2','������ ����', '��')
select * from ���������
--5
create view ���������� (���,"������������ ����������","��� �������")
as select top 10 SUBJECT,
SUBJECT_NAME,
PULPIT
from SUBJECT
order by SUBJECT_NAME;

select * from ����������

--6
alter view [���������� ������] with schemabinding
as select FACULTY.FACULTY_NAME [���������],
count(PULPIT.PULPIT_NAME) [���������� ������]
from dbo.FACULTY join dbo.PULPIT
on PULPIT.FACULTY = FACULTY.FACULTY
group by FACULTY.FACULTY_NAME


select * from "���������� ������"
