use master
go

drop database bancoaula
create database bancoaula
use bancoaula


create table tb_cliente (
	id_cliente	int primary key identity (1,1),
	nome		nvarchar (60),
	endrç		nvarchar (100),
	fone		nvarchar (20),
	email		nvarchar (60))

create table tb_hardware (
	id_hardware	int primary key identity (1,1),
	descricao	nvarchar (150),
	preço		decimal,
	qtde		int,
	qtdemín		int)

create table tb_vendas (
	id_venda	int primary key identity (1,1),
	id_cliente	int,
	data		date,
	vlrtotal	decimal,
	desconto	decimal,
	vlrpago		decimal)

create table vendas_itens (
	id_item		int primary key identity (1,1),
	id_venda	int,
	id_hardware int,
	qtde_item	int,
	total_item	int)
go 
exec sp_databases
go
exec sp_tables
exec sp_help tb_cliente