use ���_MyBaseClone
Create table ��������
( Id_�������� int primary key,
  ��� nvarchar(20),
  ������� nvarchar(20) not null,
  �������� nvarchar(20),
  ����� nvarchar(30),
  ������� nchar(9),

);

Alter table �������� add Pol nchar(1) default'�' check (Pol in('�','�'));

Alter table ��������
DROP CONSTRAINT CK__��������__Pol__412EB0B6;
Alter table ��������
drop constraint DF__��������__Pol__403A8C7D;
Alter table �������� drop Column Pol; 

insert into ������������(Id_��������,��������_��������,������)
	values (1,'���',9),
	(1,'Ts',9),
	(1,'��',10),
	(1,'���',9),
	(2,'���',8),
	(2,'Ts',9),
	(2,'��',8),
	(2,'���',9),
	(3,'���',6),
	(3,'Ts',5),
	(3,'��',7),
	(3,'���',8),
	(4,'���',8),
	(4,'Ts',8),
	(4,'��',8),
	(4,'���',8);

insert into �������(��������,������,�����������_����,�������_���������,�������_�����,��������)
	values ("�����",12342,1234,"��","��","����"),
			("������",54321,23232,"���","���","�����"),
			("����",123,222,"���","���","����");
insert into ��������(��������,������,����������)
	values("����",123,4321),
		   ("�����",222,3333),
		   ("����",333,1111);

create table �������(
�������� nvarchar(20) primary key,
������ int,
�����������_���� int,
�������_��������� nvarchar(10),
�������_����� nvarchar(10),
�������� nvarchar(20) foreign key references ��������(��������),
);
create table ��������(�������� nvarchar(20) primary key,������ int,���������� int,);