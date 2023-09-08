USE master;
go
CREATE database ���_MyBaseClone on primary
(name = N'���_MyBaseClone_mdf',filename = N'D:\BD\���_MyBaseClone_mdf.mdf',
    size = 10240Kb, maxsize=UNLIMITED, filegrowth=1024Kb),
( name = N'���_MyBaseClone_ndf', filename = N'D:\BD\���_MyBaseClone_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),
filegroup FG1
( name = N'���_MyBaseClone_fg1_1', filename = N'D:\BD\���_MyBaseClone_fg1_1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'���_MyBaseClone_fg1_2', filename = N'D:\BD\���_MyBaseClone_fg1_2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
filegroup FG2
( name = N'���_MyBaseClone_fg2_1', filename = N'D:\BD\���_MyBaseClone_fg2_1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'���_MyBaseClone_fg2_2', filename = N'D:\BD\���_MyBaseClone_fg2_2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
filegroup FG3
( name = N'���_MyBaseClone_fg3_1', filename = N'D:\BD\���_MyBaseClone_fg3_1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'���_MyBaseClone_fg3_2', filename = N'D:\BD\���_MyBaseClone_fg3_2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
( name = N'���_MyBaseClone_log', filename=N'D:\BD\���_MyBaseClone_log.ldf',       
   size=10240Kb,  maxsize=1Gb, filegrowth=10%)
   go

 USE ���_MyBaseClone;
Create table ��������
( Id_�������� int primary key,
  ��� nvarchar(20),
  ������� nvarchar(20) not null,
  �������� nvarchar(20),
  ����� nvarchar(30),
  ������� nchar(9),

) on FG1;

Create table ������������
(
	��������_�������� nvarchar(20) primary key,
	�����_������ smallint,
	�����_������������ smallint,
	�����_������������ smallint
) on FG2;

Create table ������������
(
	Id_�������� int not null foreign key references 
								��������(Id_��������),
	��������_�������� nvarchar(20) not null foreign key references
								������������(��������_��������),
	������ smallint
) on FG3;