create database dbdistribuidoraltda3;
use dbdistribuidoraltda3;

CREATE TABLE tbUF (
    IdUF INT AUTO_INCREMENT PRIMARY KEY,
    UF CHAR(2) UNIQUE
);
CREATE TABLE tbBairro (
    IdBairro INT AUTO_INCREMENT PRIMARY KEY,
    Bairro VARCHAR(200)
);
CREATE TABLE tbCidade (
    IdCidade INT AUTO_INCREMENT PRIMARY KEY,
    Cidade VARCHAR(200)
);
CREATE TABLE tbEndereco (
    CEP decimal(8,0) PRIMARY KEY,
    Logradouro VARCHAR(200),
    IdBairro INT,
    FOREIGN KEY (IdBairro)
        REFERENCES tbBairro (IdBairro),
    IdCidade INT,
    FOREIGN KEY (IdCidade)
        REFERENCES tbCidade (IdCidade),
    IdUF INT,
    FOREIGN KEY (IdUF)
        REFERENCES tbUF (IdUF)
);
CREATE TABLE tbCliente (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    CEP decimal(8,0) NOT NULL,
    CompEnd VARCHAR(50),
    FOREIGN KEY (CEP)
        REFERENCES tbEndereco (CEP)
);
CREATE TABLE tbClientePF (
    IdCliente INT AUTO_INCREMENT,
    FOREIGN KEY (IdCliente)
        REFERENCES tbCliente (Id),
    Cpf VARCHAR(11) NOT NULL PRIMARY KEY,
    Rg VARCHAR(8),
    RgDig VARCHAR(1),
    Nasc DATE
);
CREATE TABLE tbClientePJ (
    IdCliente INT AUTO_INCREMENT,
    FOREIGN KEY (IdCliente)
        REFERENCES tbCliente (Id),
    Cnpj VARCHAR(14) NOT NULL PRIMARY KEY,
    Ie VARCHAR(9)
);
CREATE TABLE tbNotaFiscal (
    NF INT PRIMARY KEY,
    TotalNota DECIMAL(7 , 2 ) NOT NULL,
    DataEmissao DATE NOT NULL
);
CREATE TABLE tbFornecedor (
    Codigo INT PRIMARY KEY AUTO_INCREMENT,
    Cnpj VARCHAR(14) NOT NULL,
    Nome VARCHAR(200),
    Telefone VARCHAR(11)
);
CREATE TABLE tbCompra (
    NotaFiscal INT PRIMARY KEY,
    DataCompra DATE NOT NULL,
    ValorTotal DECIMAL(8 , 2 ) NOT NULL,
    QtdTotal INT NOT NULL,
    Cod_Fornecedor INT,
    FOREIGN KEY (Cod_Fornecedor)
        REFERENCES tbFornecedor (Codigo)
);
CREATE TABLE tbProduto (
    CodBarras BIGINT PRIMARY KEY,
    Qtd INT,
    Nome VARCHAR(50),
    ValorUnitario DECIMAL(6 , 2 ) NOT NULL
);
CREATE TABLE tbItemCompra (
    Qtd INT NOT NULL,
    ValorItem DECIMAL(6 , 2 ) NOT NULL,
    NotaFiscal INT,
    CodBarras BIGINT,
    PRIMARY KEY (NotaFiscal , CodBarras),
    FOREIGN KEY (NotaFiscal)
        REFERENCES tbCompra (NotaFiscal),
    FOREIGN KEY (CodBarras)
        REFERENCES tbProduto (CodBarras)
);
CREATE TABLE tbVenda (
    IdCliente INT,
    FOREIGN KEY (IdCliente)
        REFERENCES tbCliente (Id),
    NumeroVenda INT AUTO_INCREMENT PRIMARY KEY,
    DataVenda DATE NOT NULL,
    TotalVenda DECIMAL(7 , 2 ) NOT NULL,
    NotaFiscal INT,
    FOREIGN KEY (NotaFiscal)
        REFERENCES tbNotaFiscal (NF)
);
CREATE TABLE tbItemVenda (
    NumeroVenda INT,
    CodBarras BIGINT,
    PRIMARY KEY (NumeroVenda , CodBarras),
    FOREIGN KEY (NumeroVenda)
        REFERENCES tbVenda (NumeroVenda),
    FOREIGN KEY (CodBarras)
        REFERENCES tbProduto (CodBarras),
    Qtd INT,
    ValorItem DECIMAL(6 , 2 )
);

-- exercício 1 
-- use dbdistribuidoraltda3;

-- Exercicio 1 (insert) --

insert into tbFornecedor( Cnpj, Nome, Telefone)
values('1245678937123','Revenda Chico Loco','11934567897');

insert into tbFornecedor( Cnpj, Nome, Telefone)
values('1345678937123','José Faz Tudo S/A','11934567898');

insert into tbFornecedor( Cnpj, Nome, Telefone)
values('1445678937123','Vadalto Entregas','11934567899');

insert into tbFornecedor( Cnpj, Nome, Telefone)
values('1545678937123','Astrogildo das Estreça','11934567800');

insert into tbFornecedor( Cnpj, Nome, Telefone)
values('1645678937123','Amoroso e Doce','11934567801');

insert into tbFornecedor(Cnpj, Nome, Telefone)
values('1745678937123','Marcelo Dedal','11934567802');

insert into tbFornecedor(Cnpj, Nome, Telefone)
values('1845678937123','Franciscano Cachaça','11934567803');

insert into tbFornecedor(Cnpj, Nome, Telefone)
values('1945678937123','Joãozinho Chupeta','11934567804');

select * from tbFornecedor;

/*delimiter $$
	create procedure inserirCidade(vCidade varchar(200))
    begin
    insert into tbCidade(Cidade) values (vCidade);
    select * from tbCidade;
    end
$$

call inserirCidade("Rio de Janeiro");
call inserirCidade("São Carlos");
call inserirCidade("Campinas");
call inserirCidade("Franco da Rocha");
call inserirCidade("Osasco");
call inserirCidade("Pirituba");
call inserirCidade("Lapa");
call inserirCidade("Ponta Grossa");
call inserirCidade("Barra Mansa");
call inserirCidade("São Paulo");
*/

delimiter $$
create procedure spInsertCidades(vCidade varchar(200))
begin
if not exists (select IdCidade from tbCidade where Cidade = vCidade) then
	insert into tbCidade(Cidade) values (vCidade);
end if;
end $$

call spInsertCidades('Rio de Janeiro');
call spInsertCidades('São Carlos');
call spInsertCidades('Campinas');
call spInsertCidades('Franco da Rocha');
call spInsertCidades('Osasco');
call spInsertCidades('Pirituba');
call spInsertCidades('Lapa');
call spInsertCidades('Ponta Grossa');

select * from tbCidade;
select * from tbUF;

/*delimiter $$
create procedure inserirUFs(vUF char(2))
begin
	insert into tbUF(UF) values (vUF);
    select * from tbUF;
end
$$

call inserirUFs("SP");
call inserirUFs("RJ");
call inserirUFs("RS"); */
delimiter $$
create procedure spInsertUF(vUF char(2))
begin
if not exists (select IdUf from tbUF where UF = vUF) then
	insert into tbUF(UF) values (vUF);
end if;
end $$

call spInsertUF('SP');
call spInsertUF('RJ');
call spInsertUF('RS');

delimiter $$
create procedure spInsertBairro(vBairro varchar(200))
begin
if not exists (select IdBairro from tbBairro where Bairro = vBairro) then
	insert into tbBairro(Bairro) values (vBairro);
end if;
end $$

call spInsertBairro('Aclimação');
call spInsertBairro('Capão Redondo');
call spInsertBairro('Pirituba');
call spInsertBairro('Liberdade');

select * from tbbairro;


/*delimiter $$
create procedure inserirBairro(vBairro varchar(200))
begin
	insert into tbBairro(Bairro) values (vBairro);
    select * from tbBairro;
end
$$

call inserirBairro("Aclimação");
call inserirBairro("Capão Redondo");
call inserirBairro("Pirituba");
call inserirBairro("Liberdade");
call inserirBairro("Lapa");
call inserirBairro("Penha");
call inserirBairro("Consolação");
call inserirBairro("Barra Funda");
*/


/*

delimiter $$
create procedure inserirProduto(vCodBarras bigint, vNome varchar(50), vValorUnit decimal(6, 2), vQuantidade int)
begin
insert into tbProduto (CodBarras, Nome, ValorUnitario, Qtd) values (vCodBarras, vNome, vValorUnit, vQuantidade);
select * from tbProduto;
end
$$
-- truncate tbProduto - faz com que a tbProduto seja resetada (tanto os dados como o id ou outro auto_increment)
call inserirProduto(12345678910111, 'Rei de Papel Mache', 54.61, 120);
call inserirProduto(12345678910112, 'Bolinha de Sabão', 100.45, 120);
call inserirProduto(12345678910113, 'Carro Bate Bate', 44.00, 120);
call inserirProduto(12345678910114, 'Bola Furada', 10.00, 120);
call inserirProduto(12345678910115, 'Maçã Laranja', 99.44, 120);
call inserirProduto(12345678910116, 'Boneco do Hitler', 124.00, 200);
call inserirProduto(12345678910117, 'Farinha de Suruí', 50.00, 200);
call inserirProduto(12345678910118, 'Zelador de Cemitério', 24.50, 120);*/


delimiter $$
create procedure spInsertProduto(vCodBarras bigint, vNome varchar(50), vValorUnit decimal(6, 2), vQuantidade int)
begin
insert into tbProduto(CodBarras, Nome, ValorUnit, Qtd) values (vCodBarras, vNome, vValorUnit, vQuantidade); 
end $$

call spInsertProduto('12345678910111', 'Rei de Papel Mache', '54.61', '120');
call spInsertProduto('12345678910112', 'Bolinha de Sabão', '100.45', '120');
call spInsertProduto('12345678910113', 'Carro Bate Bate', '44.00', '120');
call spInsertProduto('12345678910114', 'Bola Furada', '10.00', '120');
call spInsertProduto('12345678910115', 'Maçã Laranja', '99.44', '120');
call spInsertProduto('12345678910116', 'Boneco do Hitler', '124.00', '200');
call spInsertProduto('12345678910117', 'Farinha de Suruí', '50.00', '200');
call spInsertProduto('12345678910118', 'Zelador de Cemitério', '24.50', '100');

/*drop procedure inserirEndereco;
delimiter $$
create procedure inserirEndereco(vLogradouro varchar(200), vBairro varchar(200), vCidade varchar(200), vUF char(2), vCEP varchar(8))
begin
	if not exists (select IdBairro from tbBairro where Bairro = vBairro) then
		insert into tbBairro (Bairro) values (vBairro);
    end if;
    if not exists (select IdCidade from tbCidade where Cidade = vCidade) then
		insert into tbCidade (Cidade) values (vCidade);
    end if;
    if not exists (select IdUF from tbUF where UF = vUF) then
		insert into tbUF (UF) values (vUF);
    end if;
	insert into tbEndereco values (vCEP, vLogradouro, (select IdBairro from tbBairro where Bairro = vBairro), (select IdCidade from tbCidade where Cidade = vCidade), (select IdUF from tbUF where UF = vUF));
	select * from tbEndereco;
    -- falta selecionar/mostrar os dados corretamente
end
$$

call inserirEndereco("Rua da Federal", "Lapa", "São Paulo", "SP", "12345050");
call inserirEndereco("Av Brasil", "Lapa", "Campinas", "SP", "12345051");
call inserirEndereco("Rua Liberdade", "Consolação", "São Paulo", "SP", "12345052");
call inserirEndereco("Av Paulista", "Penha", "Rio de Janeiro", "RJ", "12345053");
call inserirEndereco("Rua Ximbú", "Penha", "Rio de Janeiro", "RJ", "12345054");
call inserirEndereco("Rua Piu XI", "Penha", "Campinas", "SP", "12345055");
call inserirEndereco("Rua Chocolate", "Aclimação", "Barra Mansa", "SP", "12345056");
call inserirEndereco("Rua Pão na Chapa", "Barra Funda", "Ponta Grossa", "RS", "12345057");

-- inserir o resto dos dados */

/*delimiter $$
create procedure spInsertBairro(vBairro varchar(200))
begin
if not exists (select IdBairro from tbBairro where Bairro = vBairro) then
	insert into tbBairro(Bairro) values (vBairro);
end if;
end $$

call spInsertBairro('Aclimação');
call spInsertBairro('Capão Redondo');
call spInsertBairro('Pirituba');
call spInsertBairro('Liberdade');

select * from tbbairro; */

delimiter $$
create procedure spInsertEndereco(vCEP decimal(8,0), vLogradouro varchar(200), vBairro varchar(200), vCidade varchar(200), vUF char(2))
begin
if not exists (select CEP from tbEndereco where CEP = vCEP) then
	if not exists (select IdBairro from tbBairro where Bairro = vBairro) then
		insert into tbBairro(Bairro) values (vBairro);
	end if;

	if not exists (select IdUf from tbUF where UF = vUF) then
		insert into tbUF(UF) values (vUF);
	end if;

	if not exists (select IdCidade from tbCidade where Cidade = vCidade) then
		insert into tbCidade(Cidade) values (vCidade);
	end if;

	set @IdBairro = (select IdBairro from tbBairro where Bairro = vBairro);
	set @IdUf = (select IdUF from tbUF where UF = vUf);
	set @IdCidade = (select IdCidade from tbCidade where Cidade = vCidade);

	insert into tbEndereco(CEP, Logradouro, IdBairro, IdCidade, IdUF) values
	(vCEP, vLogradouro, @IdBairro, @IdCidade, @IdUF); 
end if;
end $$

describe tbendereco;

call spInsertEndereco(12345050, 'Rua da Federal', 'Lapa', 'São Paulo', 'SP');
call spInsertEndereco(12345051, 'Av Brasil', 'Lapa', 'Campinas', 'SP');
call spInsertEndereco(12345052, 'Rua Liberdade', 'Consolação', 'São Paulo', 'SP');
call spInsertEndereco(12345053, 'Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertEndereco(12345054, 'Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertEndereco(12345055, 'Rua Piu XI', 'Penha', 'Campina', 'SP');
call spInsertEndereco(12345056, 'Rua Chocolate', 'Aclimação', 'Barra Mansa', 'RJ');
call spInsertEndereco(12345057, 'Rua Pão na Chapa', 'Barra Funda', 'Ponto Grossa', 'RS');

select * from tbCliente;
select * from tbClientePF;
select * from tbEndereco;
select * from tbUF;
select * from tbCidade;
select * from tbBairro;

-- drop database dbdistribuidoraltda3;
