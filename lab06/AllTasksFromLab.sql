use UNIVER;
select max(AUDITORIUM_CAPACITY)[максимальная вместимость],
	   min(AUDITORIUM_CAPACITY)[минимальная вместимость],
	   avg(AUDITORIUM_CAPACITY)[среднее значение],
	   sum(AUDITORIUM_CAPACITY)[сумма всех аудиторий],
	   count(*)				   [количество аудиторий]
from AUDITORIUM
--2
select AUDITORIUM_TYPE.AUDITORIUM_TYPE,
max(AUDITORIUM_CAPACITY)[максимальная вместимость],
	   min(AUDITORIUM_CAPACITY)[минимальная вместимость],
	   avg(AUDITORIUM_CAPACITY)[среднее значение],
	   sum(AUDITORIUM_CAPACITY)[сумма всех аудиторий],
	   count(*)				   [количество аудиторий]
from AUDITORIUM join AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE;
--3
select* from(
select 
case 
	when PROGRESS.NOTE = 10 then '10'
	when PROGRESS.NOTE  between 8 and 9 then '8-9'
	when PROGRESS.NOTE  between 6 and 7 then '6-7'
	else '4-5' 
	end[Интервал], COUNT(*)[Количество]
From PROGRESS Group by Case
	when PROGRESS.NOTE = 10 then '10'
	when PROGRESS.NOTE  between 8 and 9 then '8-9'
	when PROGRESS.NOTE  between 6 and 7 then '6-7'
	else '4-5' 
	end) as P
		Order by case[Интервал]
			when '10' then 1
	when '8-9' then 2
	when '6-7' then 3
	else 4 
	end
--4
select  f.FACULTY [Факультет],
		g.PROFESSION [Специальность],
		g.COURSE [Курс],
		round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
from FACULTY f inner join GROUPS g
	on f.FACULTY = g.FACULTY
		inner join STUDENT s
			on s.IDGROUP = g.IDGROUP
				inner join PROGRESS p
	on p.IDSTUDENT = s.IDSTUDENT
group by f.FACULTY, g.PROFESSION, g.COURSE;
--5
select  f.FACULTY [Факультет],
		g.PROFESSION [Специальность],
		g.COURSE [Курс],
		round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
from FACULTY f inner join GROUPS g
	on f.FACULTY = g.FACULTY
		inner join STUDENT s
			on s.IDGROUP = g.IDGROUP
				inner join PROGRESS p
	on p.IDSTUDENT = s.IDSTUDENT
	where p.SUBJECT in ('БД','ОАиП')
group by f.FACULTY, g.PROFESSION, g.COURSE;
--6
select  f.FACULTY [Факультет],
		g.PROFESSION [Специальность],
		g.COURSE [Курс],
		round(avg(cast(p.NOTE as float(4))), 2) [Средняя оценка]
from FACULTY f inner join GROUPS g
	on f.FACULTY = g.FACULTY
		inner join STUDENT s
			on s.IDGROUP = g.IDGROUP
				inner join PROGRESS p
	on p.IDSTUDENT = s.IDSTUDENT
	where f.FACULTY like 'ТОВ'
group by f.FACULTY, g.PROFESSION, g.COURSE;
--7
Select p1.SUBJECT, p1.NOTE,
	(select COUNT(*) from PROGRESS p2
	where p2.SUBJECT=p1.SUBJECT
			and p2.NOTE=p1.NOTE)[Количество]
				from PROGRESS p1
	GROUP BY p1.SUBJECT, p1.NOTE
	HAVING NOTE=8 or NOTE=9
