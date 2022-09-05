create database BD_B;
use BD_B;
-- drop database BD_B;
-- drop table tb_funcionario;


create table tb_funcionario(
codFunc int primary key auto_increment,
Nome varchar(200),
Cpf char (11),
CD_DPTO int
);

create table tb_Departamento(
CD_DPTO int primary key auto_increment,
Departamento varchar(50)

);



alter table tb_funcionario add foreign key (CD_DPTO) references tb_Departamento(CD_DPTO);

select * from tb_Departamento, tb_funcionario;

insert into  tb_funcionario (Nome,Cpf,CD_DPTO) values('Juarez Tavora','12344488809', 2);
insert into  tb_funcionario (Nome,Cpf,CD_DPTO) values( 'Lucas Mendes','15611133801', 1 );
insert into  tb_funcionario (Nome,Cpf,CD_DPTO) values( 'Jessé','22277851826', 3);

insert into  tb_Departamento (CD_DPTO,Departamento) values(1, 'TI');
insert into  tb_Departamento (CD_DPTO,Departamento) values( 2, 'Finanças');
insert into  tb_Departamento (CD_DPTO,Departamento) values( 3, 'Marketing');

truncate tb_funcionario;

truncate tb_Departamento;

create view vw_DPTO
as select

tb_Funcionario.codFunc,
tb_Funcionario.Nome,
tb_Funcionario.Cpf,
tb_Departamento.CD_DPTO,
tb_Departamento.Departamento

from tb_funcionario  inner join tb_Departamento
	on.



