use ���_MyBaseClone;

select ��������.�������,��������.���, ������������.������,������������.��������_��������
from ��������,������������,������������
where ������������.Id_�������� = ��������.Id_�������� and
��������.��� in (
select ��������.��� from ��������
where ��������.��� like '%������%'
);
--2
select ��������.�������,��������.���, ������������.������,������������.��������_��������
from �������� join ������������
on ��������.Id_�������� = ������������.Id_��������, ������������
where ������������.Id_�������� = ��������.Id_�������� and
��������.��� in (
select ��������.��� from ��������
where ��������.��� like '%������%'
);
--3
select ��������.�������,��������.���, ������������.������,������������.��������_��������
from �������� join ������������
on ��������.Id_�������� = ������������.Id_��������
join ������������
on ������������.��������_�������� = ������������.��������_��������
where ��������.��� like '%������%';
--4
select Id_��������,��������_��������,������
from ������������ �
where ��������_��������=(select top (1) ��.��������_��������
from ������������ ��
where ��.Id_�������� = �.Id_�������� order by ��������_�������� desc)
--5
select ��������.������� from ��������
where not exists (select* from ������������
where ��������.Id_�������� = ������������.Id_��������);
--6
select top 1
( select avg(������) from ������������
where ������������.��������_�������� like '��')[��],
( select avg(������) from ������������
where ������������.��������_�������� like '���')[���]
from ������������
--7
select ������,Id_��������
from ������������ student1
where student1.������ >= all(select student2.������
from ������������ student2
where student1.Id_�������� != student2.Id_��������);
--8
select ������,Id_��������
from ������������ student1
where student1.������ >= any(select student2.������
from ������������ student2
where student1.Id_�������� != student2.Id_��������);
