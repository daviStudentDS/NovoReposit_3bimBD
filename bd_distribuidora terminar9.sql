-- drop database dbDistribuidoradavierosa;
create database dbdistribuidoradavierosa;
use dbdistribuidoradavierosa;

create table tbCliente(
Id int auto_increment primary key,
NomeCli varchar(200) not null,
NumEnd varchar(6) not null,
CompEnd varchar(50),
CepCli numeric(8)
);

create table tbClientePF(
Id int,
CPF numeric(11) primary key unique,
RG numeric(9) not null,
RG_Dig char(1) not null,
Nasc date not null
);

create table tbClientePJ(
Id int,
CNPJ numeric(14) primary key unique,
IE numeric(11) unique
);

create table tbEndereco(
Logradouro varchar(200) not null,
CEP numeric(8) primary key,
BairroId int not null,
CidadeId int not null,
UFId int not null
);

create table tbBairro(
BairroId int auto_increment primary key,
Bairro varchar(200) not null
);

create table tbCidade(
CidadeId int auto_increment primary key,
Cidade varchar(200)
);

create table tbEstado(
UFId int auto_increment primary key,
UF char(2)
);

create table tbProduto(
CodigoBarras numeric(14) primary key unique,
Nome varchar(200) not null,
Valor decimal not null,
Qtd int
);

create table tbCompra(
NotaFiscal int primary key,
DataCompra date not null,
ValorTotal decimal not null,
QtdTotal int not null,
Codigo int
);

create table tbItemCompra(
NotaFiscal int,
CodigoBarras numeric(14),
ValorItem decimal not null,
Qtd int not null
);

create table tbFornecedor(
Codigo int auto_increment primary  key,
CNPJ numeric(14) unique,
Nome varchar(200) not null,
Telefone numeric(11)
);

create table tbVenda(
NumeroVenda int primary key,
DataVenda datetime,
TotalVenda decimal not null,
Id int not null,
NF int
);

create table tbNotaFiscal(
NF int primary key,
TotalNota decimal not null,
DataEmissao date not null
);

create table tbItemVenda(
NumeroVenda int,
CodigoBarras numeric(14),
ValorItem decimal not null,
Qtd int not null
);

/*create table tbVenda_Produto(
Qtd int primary key,
ValorItem decimal
);
create table tbCompra_Produto(
Qtd int primary key,
ValorItem decimal
); */

alter table tbCliente add constraint FK_CEP_tbCliente foreign key (CepCli) references tbEndereco(CEP);
alter table tbEndereco add constraint FK_BairroId_tbEndereco foreign key (BairroId) references tbBairro(BairroId);
alter table tbEndereco add constraint FK_CidadeId_tbEndereco foreign key (CidadeId) references tbCidade(CidadeId);
alter table tbEndereco add constraint FK_UFId_tbEndereco foreign key (UFId) references tbEstado(UFId);
alter table tbItemCompra add constraint FK_NotaFiscal_tbItemCompra foreign key (NotaFiscal) references tbCompra(NotaFiscal);
alter table tbItemCompra add constraint FK_CodigoBarras_tbItemCompra foreign key (CodigoBarras) references tbProduto(CodigoBarras);
alter table tbCompra add constraint FK_Codigo_tbCompra foreign key (Codigo) references tbFornecedor(Codigo);
alter table tbVenda add constraint FK_Id_tbVenda foreign key (Id) references tbCliente(Id);
alter table tbVenda add constraint FK_NF_tbVenda foreign key (NF) references tbNotaFiscal(NF);
alter table tbItemVenda add constraint FK_NumeroVenda_tbItemVenda foreign key (NumeroVenda) references tbVenda(NumeroVenda);
alter table tbItemVenda add constraint FK_CodigoBarras_tbVenda foreign key (CodigoBarras) references tbProduto(CodigoBarras);
alter table tbClientePF add constraint FK_Id_tbClientePF foreign key (Id) references tbCliente(Id);
alter table tbClientePJ add constraint FK_Id_tbClientePJ foreign key (Id) references tbCliente(Id);

alter table tbItemCompra add primary key(NotaFiscal, CodigoBarras);
alter table tbItemVenda add primary key(NumeroVenda, CodigoBarras);

-- // -- 

insert into tbFornecedor (Nome, CNPJ, Telefone) values ('Revenda Chico Louco', '1245678937123', '11934567897');
insert into tbFornecedor (Nome, CNPJ, Telefone) values ('José Faz Tudo S/A', '1345678937123', '11934567898');
insert into tbFornecedor (Nome, CNPJ, Telefone) values ('Vadalto Entregas', '1445678937123', '11934567899');
insert into tbFornecedor (Nome, CNPJ, Telefone) values ('Astrogildo das Estrela', '1545678937123', '11934567800');
insert into tbFornecedor (Nome, CNPJ, Telefone) values ('Amoroso e Doce', '1645678937123', '11934567801');
insert into tbFornecedor (Nome, CNPJ, Telefone) values ('Marcelo Dedal', '1745678937123', '11934567802');
insert into tbFornecedor (Nome, CNPJ, Telefone) values ('Franciscano Cachaça', '1845678937123', '11934567803');
insert into tbFornecedor (Nome, CNPJ, Telefone) values ('joãozinho Chupeta', '1945678937123', '11934567804');


-- Criando stored procedure

delimiter $$
create procedure spInsertCidade(vCidade varchar(200))
begin
insert into tbCidade (Cidade)
	values (vCidade);
end $$

call spInsertCidade ('Rio de Janeiro');
call spInsertCidade ('São Carlo');
call spInsertCidade ('Campinas');
call spInsertCidade ('Franco da Rocha');
call spInsertCidade ('Osasco');
call spInsertCidade ('Pirituba');
call spInsertCidade ('Lapa');
call spInsertCidade ('Ponta Grossa');


delimiter $$
create procedure spInsertEstado(vUF char(2))
begin
insert into tbEstado (UF)
	values (vUF);
end $$

call spInsertEstado('SP');
call spInsertEstado('RJ');
call spInsertEstado('RS');


delimiter $$
create procedure spInsertBairro(vBairro varchar(200))
begin
insert into tbBairro (Bairro)
	values (vBairro);
end $$

call spInsertBairro ('Aclimação');
call spInsertBairro ('Capão Redondo');
call spInsertBairro ('Pirituba');
call spInsertBairro ('Liberdade');


delimiter $$
create procedure spInsertProduto(vCodigoBarras numeric(14), vNome varchar(200), vValor decimal, vQtd int)
begin
insert into tbProduto (CodigoBarras, Nome, Valor, Qtd)
	values (vCodigoBarras, vNome, vValor, vQtd);
end $$

call spInsertProduto (12345678910111, 'Rei de Papel Mache', 54.61, 120);
call spInsertProduto (12345678910112, 'Bolinha de Sabão', 100.45, 120);
call spInsertProduto (12345678910113, 'Carro Bate Bate', 44.00, 120);
call spInsertProduto (12345678910114, 'Bola Furada', 10.00, 120);
call spInsertProduto (12345678910115, 'Maça Laranja', 99.44, 120);
call spInsertProduto (12345678910116, 'Boneco do Hitler', 124.00, 200);
call spInsertProduto (12345678910117, 'Farinha de Suruí', 50.00, 200);
call spInsertProduto (12345678910118, 'Zelador de Cemitério', 24.50, 100);    

-- exercicio 6
delimiter $$
create procedure spInsertEndereco(vCEP varchar(8), vLogradouro varchar(200), vBairro varchar(200), vCidade varchar(200), vUF char(2))
begin 

declare idBairroSP int;
declare idCidadeSP int;
declare idUFSP int;
declare mensgErro int;

if not exists (select * from tbBairro where Bairro = vBairro) then
	insert into tbbairro (bairro) values (vBairro);
end if;
 
if not exists (select * from tbCidade where Cidade = vCidade) then
	insert into tbcidade (cidade) values (vCidade);
end if;

if not exists (select * from tbestado where  UF = vUF) then
	insert into tbestado (uf) values (vUF);
end if;


if not exists (select * from tbEndereco where vCEP = CEP) then

	set @idBairroSP = (select BairroId from tbBairro where Bairro = vBairro);
	set @idCidadeSP = (select CidadeId from tbCidade where Cidade = vCidade);
	set @idUFSP = (select UFId from tbestado where UF = vUF);
    
    else
		select("Existente");
end if;


insert into tbEndereco(CEP, Logradouro, BairroId, CidadeId, UFId) values (vCEP, vLogradouro, @idBairroSP, @idCidadeSP, @idUFSP);
end $$ 


call spInsertEndereco(12345050, "Rua da Federal", "Lapa", "São Paulo", "SP");
call spInsertEndereco(12345051, "Av Brasil", "Lapa", "Campinas", "SP");
call spInsertEndereco(12345052, "Rua Liberdade", "Consolação", "São Paulo", "SP");
call spInsertEndereco(12345053, "Av Paulista", "Penha", "Rio de Janeiro", "RJ");
call spInsertEndereco(12345054, "Rua Ximbú", "Penha", "Rio de Janeiro", "RJ");
call spInsertEndereco(12345055, "Rua Piu X1", "Penha", "Campinas", "SP");
call spInsertEndereco(12345056, "Rua chocolate", "Aclimação", "Barra Mansa", "RJ");
call spInsertEndereco(12345057, "Rua Pão na Chapa", "Barra Funda", "Ponta Grossa", "RS");

select * from tbEndereco;
select * from tbBairro;
select * from tbCidade;
select * from tbUF;

-- exercicio 7 
delimiter $$
create procedure spInsertClientePF (vNome varchar(50), vNumEnd decimal(6,0), vCompEnd varchar(50), vCEP decimal(8,0), vCPF decimal(11,0), vRG decimal(8,0), vRgDig char(1), vNasc date,
vLogradouro varchar(200), vBairro varchar(200), vCidade varchar(200), vUF char(2))
begin
    if not exists (select CEP from tbEndereco where CEP = vCEP) then
		if not exists (select BairroId from tbBairro where Bairro = vBairro) then
			insert into tbBairro(Bairro) values (vBairro);
		end if;

		if not exists (select UFId from tbEstado where UF = vUF) then
			insert into tbEstado(UF) values (vUF);
		end if;

		if not exists (select CidadeId from tbCidade where Cidade = vCidade) then
			insert into tbCidade(Cidade) values (vCidade);
		end if;

		set @BairroId = (select BairroId from tbBairro where Bairro = vBairro);
		set @UFId = (select UFId from tbEstado where UF = vUf);
		set @CidadeId = (select CidadeId from tbCidade where Cidade = vCidade);

		insert into tbEndereco(CEP, Logradouro, BairroId, CidadeId, UFId) values
		(vCEP, vLogradouro, @BairroId, @CidadeId, @UFId); 
        else
		select("Existente");
	end if;
    
   	if not exists (select CPF from tbClientePF where CPF = vCPF) then
		insert into tbCliente(NomeCli, CepCli, NumEnd, CompEnd) values (vNome, vCEP, vNumEnd, vCompEnd);
		insert into tbClientePF(CPF, RG, Rg_Dig, Nasc) values (vCPF, vRG, vRgDig, vNasc);
	end if;
end $$


call spInsertClientePF('Pimpão', 325, null, 12345051, 12345678911, 12345678, 0, '2000-12-10', 'Av. Brasil', 'Lapa', 'Campinas', 'SP');
call spInsertClientePF('Disney Chaplin', 89, 'Ap. 12', 12345053, 12345678912, 12345679, 0, '2001-11-21', 'Av. Paulista', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertClientePF('Marciano', 744, null, 12345054, 12345678913, 12345680, 0, '2001-06-01', 'Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertClientePF('Lança Perfume', 128, null, 12345059, 12345678914, 12345681, 'X', '2004-04-05', 'Rua Veia', 'Jardim Santa Isabel', 'Cuiabá', 'MT');
call spInsertClientePF('Remédio Amargo', 2485, null, 12345058, 12345678915, 12345682, 0, '2002-07-15', 'Av. Nova', 'Jardim Santa Isabel', 'Cuiabá', 'MT');

select * from tbCliente;
select * from tbClientePF;
select * from tbEndereco;

-- exercicio 8

delimiter $$
create procedure spInsertClientePJ (vNome varchar(50), vCNPJ numeric(14), vIE numeric(11), vCEP numeric(8), vLogradouro varchar(200), vNumEnd decimal(6,0), vCompEnd varchar(50), vBairro varchar(200),
vCidade varchar(200), vUF char(2))
begin
   	if not exists (select CNPJ from tbClientePJ where CNPJ = vCNPJ) then
    if not exists (select CEP from tbEndereco where CEP = vCEP) then
		if not exists (select BairroId from tbBairro where Bairro = vBairro) then
			insert into tbBairro(Bairro) values (vBairro);
		end if;

		if not exists (select UFId from tbEstado where UF = vUF) then
			insert into tbEstado(UF) values (vUF);
		end if;

		if not exists (select CidadeId from tbCidade where Cidade = vCidade) then
			insert into tbCidade(Cidade) values (vCidade);
		end if;

		set @BairroId = (select BairroId from tbBairro where Bairro = vBairro);
		set @UFId = (select UFId from tbEstado where UF = vUf);
		set @CidadeId = (select CidadeId from tbCidade where Cidade = vCidade);

		insert into tbEndereco(CEP, Logradouro, BairroId, CidadeId, UFId) values
		(vCEP, vLogradouro, @BairroId, @CidadeId, @UFId); 
        else
		select("Existente");
	end if;
    

		insert into tbCliente(NomeCli, CepCli, NumEnd, CompEnd) values (vNome, vCEP, vNumEnd, vCompEnd);
		insert into tbClientePJ(CNPJ, IE) values (vCNPJ, vIE);
	end if;
end $$


call spInsertClientePJ('Paganada', 12345678912345, 98765432198, 12345051, 'Av. Brasil', 159, null, 'Lapa', 'Campinas', 'SP');
call spInsertClientePJ('Calotiando', 12345678912346, 98765432199, 12345053, 'Av. Paulista', 69, null, 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertClientePJ('Semgrana', 12345678912347, 98765432100, 12345060, 'Rua dos Amores', 189, null, 'Sei lá', 'Recife', 'PE');
call spInsertClientePJ('CemReais', 12345678912348, 98765432101, 12345060, 'Rua dos Amores', 5024, 'Sala 23', 'Sei lá', 'Recife', 'PE');
call spInsertClientePJ('Durango', 12345678912349, 98765432102, 12345060, 'Rua dos Amores', 1254, null, 'Sei lá', 'Recife', 'PE');

select * from tbCliente;
select * from tbClientePJ;
select * from tbEndereco;

describe tbCliente;

-- exercicio 9

delimiter $$
create procedure spInsertCompra (vNotaFiscal int, vFornecedor varchar(200), vDataCompra date, vCodBarras numeric(14), vValorItem decimal, vQtd int, vQtdTotal int, vValorTotal decimal)
begin
	if not exists (select NotalFiscal from tbCompra where NotaFiscal = vNotaFiscal) then 
		if not exists (select CodigoBarras from tbItemCompra where CodigoBarras = vCodBarras) then
			insert into tbItemCompra(CodigoBarras) values (vCodBarras);
		end if;

		if not exists (select ValorItem from tbItemCompra where ValorItem = vValorItem) then
			insert into tbItemCompra(ValorItem) values (vValorItem);
		end if;

		if not exists (select vQtd from tbItemCompra where Qtd = vQtd) then
			insert into tbItemCompra(Qtd) values (vQtd);
		end if;

		set @NotaFiscal = (select NotaFiscal from tbItemCompra where NotaFiscal = vNotaFiscal);
		set @ValorItem = (select ValorItem from tbItemCompra where ValorItem = vValorItem);
		set @Qtd = (select Qtd from tbItemCompra where Qtd = vQtd);

		insert into tbItemCompra(NotaFiscal, Logradouro, BairroId, CidadeId, UFId) values
		(vCEP, vLogradouro, @BairroId, @CidadeId, @UFId); 
        else
		select("Existente");
	end if;
    
   	if not exists (select CNPJ from tbClientePJ where CNPJ = vCNPJ) then
		insert into tbCliente(Id, NomeCli, CepCli, NumEnd, CompEnd) values (vId, vNome, vCEP, vNumEnd, vCompEnd);
		insert into tbClientePJ(Id, CNPJ, IE) values (vId, vCNPJ, vIE);
	end if;
end $$

call spInsertCompra(8459, 'Amoroso e Doce', 01/03/2018, 12345678910111, 22.22, 200, 700, 21944.00);

set sql_safe_updates = 0 ;



