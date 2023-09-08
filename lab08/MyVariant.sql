use Кар_MyBaseClone

create view [Краткость сестра таланта] (id,фамилия,телефон) as
select Id_студента,
Фамилия,
Телефон
from Студенты

select * from "Краткость сестра таланта"
--2
create view [Количество оценок] (фамилия,"кол-во оценок") as select
Фамилия,
count(Успеваемость.Оценка)
from Успеваемость join Студенты
on Успеваемость.Id_студента = Студенты.Id_студента
group by Студенты.Фамилия

select * from "Количество оценок"
--3
create view [Снова студенты, но Никиты] (id,имя,фамилия,адрес) as select
Id_студента,
Имя,
Фамилия,
Адрес
from Студенты
where Имя like 'Ни%'


insert "Снова студенты, но Никиты" values(11,'Никита','Стоун','Партизанская 12')
update "Снова студенты, но Никиты" set имя = 'Ник' where фамилия like 'Стоун'
delete from "Снова студенты, но Никиты" where id = 11
select * from "Снова студенты, но Никиты"
--4
create view [Снова Никиты, но с ограничением] (id,имя,фамилия,адрес) as select
Id_студента,
Имя,
Фамилия,
Адрес
from Студенты
where Имя like 'Ни%'
with check option

insert "Снова Никиты, но с ограничением" values(11,'Лера','Стоун','Партизанская 12')
--5
create view Разнообразие
as select top 2
Название_предмета,
Объём_лабараторных
from Факультативы
order by Название_предмета

select * from Разнообразие
--6
alter view [Количество оценок] with schemabinding
as select
Фамилия [фамилия],
count(Успеваемость.Оценка) [кол-во оценок]
from dbo.Успеваемость join dbo.Студенты
on Успеваемость.Id_студента = Студенты.Id_студента
group by Студенты.Фамилия

alter table dbo.Успеваемость add Test int
alter table dbo.Успеваемость drop column Test
select * from "Количество оценок"
