use ���_MyBaseClone

create view [��������� ������ �������] (id,�������,�������) as
select Id_��������,
�������,
�������
from ��������

select * from "��������� ������ �������"
--2
create view [���������� ������] (�������,"���-�� ������") as select
�������,
count(������������.������)
from ������������ join ��������
on ������������.Id_�������� = ��������.Id_��������
group by ��������.�������

select * from "���������� ������"
--3
create view [����� ��������, �� ������] (id,���,�������,�����) as select
Id_��������,
���,
�������,
�����
from ��������
where ��� like '��%'


insert "����� ��������, �� ������" values(11,'������','�����','������������ 12')
update "����� ��������, �� ������" set ��� = '���' where ������� like '�����'
delete from "����� ��������, �� ������" where id = 11
select * from "����� ��������, �� ������"
--4
create view [����� ������, �� � ������������] (id,���,�������,�����) as select
Id_��������,
���,
�������,
�����
from ��������
where ��� like '��%'
with check option

insert "����� ������, �� � ������������" values(11,'����','�����','������������ 12')
--5
create view ������������
as select top 2
��������_��������,
�����_������������
from ������������
order by ��������_��������

select * from ������������
--6
alter view [���������� ������] with schemabinding
as select
������� [�������],
count(������������.������) [���-�� ������]
from dbo.������������ join dbo.��������
on ������������.Id_�������� = ��������.Id_��������
group by ��������.�������

alter table dbo.������������ add Test int
alter table dbo.������������ drop column Test
select * from "���������� ������"
