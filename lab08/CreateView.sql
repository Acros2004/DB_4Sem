create view [Преподаватель] as
select TEACHER [код],
TEACHER_NAME [имя преподавателя],
GENDER [пол],
PULPIT [код кфедры]
from TEACHER

select * from Преподаватель
--2
create view [Количество кафедр]
as select FACULTY_NAME [факультет],
count(PULPIT.FACULTY) [Количество кафедр]
from FACULTY join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME

select * from "Количество кафедр"
--3
create view Аудитории (код,"наименование аудитории","тип аудитории")
as select AUDITORIUM,
AUDITORIUM_NAME,
AUDITORIUM_TYPE
from AUDITORIUM
where AUDITORIUM_TYPE like 'ЛК%'

insert Аудитории values('111-1','Никит','ЛК')
update Аудитории set "наименование аудитории" = 'Каребо' where код = '111-1'
delete from Аудитории where "наименование аудитории" = 'Каребо'
select * from Аудитории
--4
create view Лекторные_аудитории (код,"наименование аудитории","тип аудитории")
as select AUDITORIUM,
AUDITORIUM_NAME,
AUDITORIUM_TYPE
from AUDITORIUM
where AUDITORIUM_TYPE like 'ЛК%'
with check option

insert Лекторные_аудитории values ('222-2','Ошибка типо', 'НК')
select * from Аудитории
--5
create view Дисциплины (код,"наименование дисциплины","код кафедры")
as select top 10 SUBJECT,
SUBJECT_NAME,
PULPIT
from SUBJECT
order by SUBJECT_NAME;

select * from Дисциплины

--6
alter view [Количество кафедр] with schemabinding
as select FACULTY.FACULTY_NAME [факультет],
count(PULPIT.PULPIT_NAME) [количество кафедр]
from dbo.FACULTY join dbo.PULPIT
on PULPIT.FACULTY = FACULTY.FACULTY
group by FACULTY.FACULTY_NAME


select * from "Количество кафедр"
