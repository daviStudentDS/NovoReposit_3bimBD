 -- drop database dbdistribuidora
-- create database dbdistribuidora;
use dbdistribuidora;

-- set foreign_key_checks = 0;
-- set sql_safe_updates = 0;

-- drop table tbUF;

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
    CEP VARCHAR(8) PRIMARY KEY,
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
    CEP VARCHAR(8) NOT NULL,
    NumEnd INT NOT NULL,
    CompEnd VARCHAR(50),
    FOREIGN KEY (CEP)
        REFERENCES tbEndereco (CEP)
);
CREATE TABLE tbClientePF (

    Id INT AUTO_INCREMENT,
    FOREIGN KEY (Id)
        REFERENCES tbCliente (Id),
    Cpf VARCHAR(11) NOT NULL PRIMARY KEY,
    Rg VARCHAR(8),
    RgDig VARCHAR(1),
    Nasc DATE
);
CREATE TABLE tbClientePJ (
    Id INT AUTO_INCREMENT,
    FOREIGN KEY (Id)
        REFERENCES tbCliente (Id),
    Cnpj VARCHAR(14) NOT NULL PRIMARY KEY,
    Ie VARCHAR(11)
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
    Cod_Fornecedor INT,
    DataCompra DATE NOT NULL,
    QtdTotal INT NOT NULL,
    ValorTotal DECIMAL(8 , 2 ) NOT NULL,
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
    PRIMARY KEY (NotaFiscal, CodBarras),
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
    TotalVenda DECIMAL(7 , 2 ),
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

-- exerc??cio 1 

-- Exercicio 1 (insert) --

insert into tbFornecedor( Cnpj, Nome, Telefone)
values('1245678937123','Revenda Chico Loco','11934567897');

insert into tbFornecedor( Cnpj, Nome, Telefone)
values('1345678937123','Jos?? Faz Tudo S/A','11934567898');

insert into tbFornecedor( Cnpj, Nome, Telefone)
values('1445678937123','Vadalto Entregas','11934567899');

insert into tbFornecedor( Cnpj, Nome, Telefone)
values('1545678937123','Astrogildo das Estre??a','11934567800');

insert into tbFornecedor( Cnpj, Nome, Telefone)
values('1645678937123','Amoroso e Doce','11934567801');

insert into tbFornecedor(Cnpj, Nome, Telefone)
values('1745678937123','Marcelo Dedal','11934567802');

insert into tbFornecedor(Cnpj, Nome, Telefone)
values('1845678937123','Franciscano Cacha??a','11934567803');

insert into tbFornecedor(Cnpj, Nome, Telefone)
values('1945678937123','Jo??ozinho Chupeta','11934567804');

-- select * from tbFornecedor;

delimiter $$
	create procedure inserirCidade(vCidade varchar(200))
    begin
    insert into tbCidade(Cidade) values (vCidade);
    select * from tbCidade;
    end
$$

call inserirCidade("Rio de Janeiro");
call inserirCidade("S??o Carlos");
call inserirCidade("Campinas");
call inserirCidade("Franco da Rocha");
call inserirCidade("Osasco");
call inserirCidade("Pirituba");
call inserirCidade("Lapa");
call inserirCidade("Ponta Grossa");

select * from tbcidade;

delimiter $$
create procedure inserirUFs(vUF char(2))
begin
	insert into tbUF(UF) values (vUF);
    select * from tbUF;
end
$$

call inserirUFs("SP");
call inserirUFs("RJ");
call inserirUFs("RS");

delimiter $$
create procedure inserirBairro(vBairro varchar(200))
begin
	insert into tbBairro(Bairro) values (vBairro);
    select * from tbBairro;
end
$$

call inserirBairro("Aclima????o");
call inserirBairro("Cap??o Redondo");
call inserirBairro("Pirituba");
call inserirBairro("Liberdade");

delimiter $$
create procedure inserirProduto(vCodBarras bigint, vNome varchar(50), vValorUnit decimal(6, 2), vQuantidade int)
begin
insert into tbProduto (CodBarras, Nome, ValorUnitario, Qtd) values (vCodBarras, vNome, vValorUnit, vQuantidade);
select * from tbProduto;
end
$$


call inserirProduto(12345678910111, 'Rei de Papel Mache', 54.61, 120);
call inserirProduto(12345678910112, 'Bolinha de Sab??o', 100.45, 120);
call inserirProduto(12345678910113, 'Carro Bate Bate', 44.00, 120);
call inserirProduto(12345678910114, 'Bola Furada', 10.00, 120);
call inserirProduto(12345678910115, 'Ma???? Laranja', 99.44, 120);
call inserirProduto(12345678910116, 'Boneco do Hitler', 124.00, 200);
call inserirProduto(12345678910117, 'Farinha de Suru??', 50.00, 200);
call inserirProduto(12345678910118, 'Zelador de Cemit??rio', 24.50, 120);

-- Inserindo endere??o (EX - 6)
delimiter $$
create procedure inserirEndereco(vLogradouro varchar(200), vBairro varchar(200), vCidade varchar(200), vUF char(2), vCEP varchar(8))
begin
	set @cep = vCEP;
    
	if ((select CEP from tbEndereco where CEP = @cep)) then
    if not exists (select IdBairro from tbBairro where Bairro = vBairro) then
		insert into tbBairro (Bairro) values (vBairro);
    end if;
    if not exists (select IdCidade from tbCidade where Cidade = vCidade) then
		insert into tbCidade (Cidade) values (vCidade);
    end if;
    if not exists (select IdUF from tbUF where UF = vUF) then
		insert into tbUF (UF) values (vUF);
    end if;
    -- insert into tbEndereco values (vCEP, vLogradouro, (select IdBairro from tbBairro where Bairro = vBairro), (select IdCidade from tbCidade where Cidade = vCidade), (select IdUF from tbUF where UF = vUF));
    insert into tbEndereco(Logradouro, CEP, IdCidade, IdUF) values (vLogradouro, (select IdBairro from tbBairro order by IdBairro desc limit 1), vCEP, (select IdCidade from tbCidade order by IdCidade desc  limit 1), (select IdUF from tbEstado order by IdUF desc limit 1));
    -- select @logradouro, @bairro, @cidade, @uf, @cep;
    select Logradouro, Bairro, Cidade, UF, CEP from tbEndereco, tbBairro, tbCidade, tbUF;
    select * from tbEndereco;
    else
		select "Esse endere??o j?? existe";
    end if;
end
$$

call inserirEndereco("Rua da Federal", "Lapa", "S??o Paulo", "SP", "12345050");
call inserirEndereco("Av Brasil", "Lapa", "Campinas", "SP", "12345051");
call inserirEndereco("Rua Liberdade", "Consola????o", "S??o Paulo", "SP", "12345052");
call inserirEndereco("Av Paulista", "Penha", "Rio de Janeiro", "RJ", "12345053");
call inserirEndereco("Rua Ximb??", "Penha", "Rio de Janeiro", "RJ", "12345054");
call inserirEndereco("Rua Piu XI", "Penha", "Campinas", "SP", "12345055");
call inserirEndereco("Rua Chocolate", "Aclima????o", "Barra Mansa", "RJ", "12345056");
call inserirEndereco("Rua P??o na Chapa", "Barra Funda", "Ponta Grossa", "RS", "12345057");


-- Ex 7 inserindo dados na tbClientePF

DELIMITER $$
CREATE PROCEDURE sp_insertClientPF (vnome_cli VARCHAR(200), vnum_end NUMERIC(6), vcomp_end VARCHAR(50), vcep_cli NUMERIC(8),
									vCPF NUMERIC(14), vRG NUMERIC(9), vRG_Dig char(1), vNasc DATE, vLogradouro varchar(200),
                                    vBairro varchar(200), vCidade varchar(200), vUF varchar(200))
BEGIN
	DECLARE vId_cli INT;
    call spInsertEndereco(vcep_cli, vLogradouro, vBairro, vCidade, vUF);
	INSERT INTO tbCliente
    VALUES(Default, vnome_cli, vnum_end, vcomp_end, vcep_cli);
    SET vId_cli := (SELECT Id FROM tbcliente ORDER BY Id DESC LIMIT 1);
    
    INSERT INTO tbclientePF
					VALUES( vCPF, vRG, vRg_Dig, vNasc, vId_cli);
END
$$

-- Inserindo dados PF na tbCliente

delimiter $$
create procedure spInsertCliente (vNome varchar(50), vNumEnd decimal(6,0), vCompEnd varchar(50), vCEP decimal(8,0), vCPF decimal(11,0), vRG decimal(8,0), vRgDig char(1), vNasc date,
vLogradouro varchar(200), vBairro varchar(200), vCidade varchar(200), vUF char(2))
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
   	if not exists (select CPF from tbClientePF where CPF = vCPF) then
		insert into tbCliente(Nome, Cep, NumEnd, CompEnd) values
																(vNome, vCEP, vNumEnd, vCompEnd);
        set @IdCli = (SELECT Id FROM tbcliente ORDER BY Id DESC LIMIT 1);
		insert into tbClientePF(Id, CPF, RG, RgDig, Nasc) values
															(@idCli, vCPF, vRG, vRgDig, vNasc);
	end if;
end $$

call spInsertCliente('Pimp??o', 325, null, 12345051, 12345678911, 12345678, 0, '2000-12-10', 'Av. Brasil', 'Lapa', 'Campinas', 'SP');
call spInsertCliente('Disney Chaplin', 89, 'Ap. 12', 12345053, 12345678912, 12345679, 0, '2001-11-21', 'Av. Paulista', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertCliente('Marciano', 744, null, 12345054, 12345678913, 12345680, 0, '2001-06-01', 'Rua Ximb??', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertCliente('Lan??a Perfume', 128, null, 12345059, 12345678914, 12345681, 'X', '2004-04-05', 'Rua Veia', 'Jardim Santa Isabel', 'Cuiab??', 'MT');
call spInsertCliente('Rem??dio Amargo', 2485, null, 12345058, 12345678915, 12345682, 0, '2002-07-15', 'Av. Nova', 'Jardim Santa Isabel', 'Cuiab??', 'MT');

-- -----------------

delimiter $$
create procedure spInsertClientePJ (vNome varchar(50), vCNPJ numeric(14), vIE numeric(11), vCEP decimal(8,0), vLogradouro varchar(200),
				vNumEnd decimal(6,0), vCompEnd varchar(50),
				vBairro varchar(200), vCidade varchar(200), vUF char(2))
begin
if not exists (select CNPJ from tbClientePJ where CNPJ = vCNPJ) then
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
	-- ----
		insert into tbCliente(Nome, Cep, NumEnd, CompEnd) values (vNome, vCEP, vNumEnd, vCompEnd);
        set @IdCli = (SELECT Id FROM tbCliente ORDER BY Id DESC LIMIT 1);
		insert into tbClientePJ(Id, CNPJ, IE) values (@idCli, vCNPJ, vIE);
	end if;
end if;
end
$$

call spInsertClientePJ('Paganada', 12345678912345, 98765432198, 12345051, 'Av. Brasil', 159, null, 'Lapa', 'Campinas', 'SP');
call spInsertClientePJ('Caloteando', 12345678912346, 98765432199, 12345053, 'Av. Paulista', 69, null, 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertClientePJ('Semgrana', 12345678912347, 98765432100, 12345060, 'Rua dos Amores', 189, null, 'Sei L??', 'Recife', 'PE');
call spInsertClientePJ('Cemreais', 12345678912348, 98765432101, 12345060, 'Rua dos Amores', 5024, 'Sala 23', 'Sei L??', 'Recife', 'PE');
call spInsertClientePJ('Durango', 12345678912349, 98765432102, 12345060, 'Rua dos Amores', 1254, null, 'Sei L??', 'Recife', 'PE');

/* select * from tbclientepf;
select * from tbclientepj;
select * from tbendereco;
select * from tbcidade;
select * from tbbairro;
select * from tbUf;
select * from tbcliente;
*/

DELIMITER $$
CREATE PROCEDURE spInsertCompra(vNotaFiscal int, vFornecedor varchar(200), vDataCompra date,
                                vCodigoBarras bigint, vValorItem decimal(6,2), vQtd int, vQtdTotal int,
                                vValorTotal decimal(8, 2))
begin 
if (select Codigo from tbFornecedor where Nome = vFornecedor) then
			set @IdFornecedor = (select Codigo from tbFornecedor where Nome = vFornecedor);
            if not exists (select NF from tbNotaFiscal where NF = vNotaFiscal) then
				insert into tbNotaFiscal(NF, TotalNota, DataEmissao) values (vNotaFiscal, vValorTotal, vDataCompra);
                insert into tbCompra(NotaFiscal, DataCompra, ValorTotal, QtdTotal, Cod_Fornecedor) values (vNotaFiscal, vDataCompra, vValorTotal, vQtdTotal,
				@IdFornecedor);
                insert into tbItemCompra(Qtd, ValorItem, NotaFiscal, CodBarras) values (vQtd, vValorItem, vNotaFiscal, vCodigoBarras);
			else
				if not exists(select * from tbItemCompra where NotaFiscal = vNotaFiscal and CodBarras = vCodigoBarras) then
					insert into tbItemCompra(Qtd, ValorItem, NotaFiscal, CodBarras) values (vQtd, vValorItem, vNotaFiscal, vCodigoBarras);
				
                else
					select "O produto j?? foi registrado e comprado.";
				end if;
            end if;
		else
			select "O fornecedor n??o existe, portanto a compra n??o pode ser feita";
		end if;
        
end $$

# drop procedure spInsertCompra;
call spInsertCompra(8459, 'Amoroso e Doce', '2018-05-01', 12345678910111, 22.22, 200, 700, 21944.00);
call spInsertCompra(2482, 'Revenda Chico Loco', '2020-04-22', 12345678910112, 40.50, 180, 180, 7290.00);
call spInsertCompra(21563, 'Marcelo Dedal', '2020-07-12', 12345678910113, 3.00, 300, 300, 900.00);
call spInsertCompra(8459, 'Amoroso e Doce', '2020-12-04', 12345678910114, 35.00, 500, 700, 21944.00);
call spInsertCompra(156354, 'Revenda Chico Loco', '2021-11-23', 12345687910115, 54.00, 350, 350, 18900.00);;

select * from tbCompra;
select * from tbNotaFiscal;
select * from tbItemCompra;

-- EX 10
# drop procedure spInsertVenda;
DELIMITER $$
CREATE PROCEDURE spInsertVenda(	vNumeroVenda int,
								vCliente varchar(200),
                                vCodigoBarras bigint, 
                                vValorItem decimal(6,2), 
                                vQtd int,
                                vTotalVenda decimal(8, 2), 
                                vNotaFiscal int)
begin 
-- NUM VENDA AUTO INCREMENT
-- DATA VENDA (DATA ATUAL, DD / MM / YY)
-- SELECT DATE_FORMAT(current_date(), "%d-%m-%Y");
-- SELECT current_date();
		if (select id from tbCliente where Nome = vCliente) then -- CHECA SE O CLIENTE EXISTE
			set @IdCliente = (select id from tbCliente where Nome = vCliente);
            -- set @DataVenda = DATE_FORMAT(current_date(), "%d-%m-%Y"); FORMATO BRASIL
            set @DataVenda = current_date();
            set @NotaFiscal = (select NF from tbNotaFiscal where NF = vNotaFiscal);
            
            if (select CodBarras from tbProduto where codbarras = vcodigobarras) then -- CHECA SE O PRODUTO EXISTE
				if not exists (select NumeroVenda from tbVenda where NumeroVenda = vNumeroVenda) then -- checa se a venda j?? foi cadastrada
					insert into tbvenda (NumeroVenda, IdCliente, DataVenda, TotalVenda, NotaFiscal) values (vNumeroVenda, @IdCliente, @DataVenda, vTotalVenda, vNotaFiscal);
                    insert into tbitemvenda (NumeroVenda, CodBarras, Qtd, ValorItem) values (vNumeroVenda, vCodigoBarras, vQtd, vValorItem);
				else
					select "Essa venda j?? foi cadastrada.";
				end if;
			else
				select "O produto n??o existe.";
            end if;
		else
			select "O cliente n??o foi registrado, portanto a compra n??o pode ser feita";
		end if;
        
end $$

call spInsertVenda(1, "Pimp??o",12345678910111,54.61,1,54.61, null);
call spInsertVenda(2, "Lan??a Perfume",12345678910112,100.45,2,200.90, null);
call spInsertVenda(3, "Pimp??o",12345678910113,44.00,1,44.00, null);  

select * from tbVenda;
select * from tbItemVenda;

-- EX 11

-- drop procedure spInsertNF;
delimiter $$
create procedure spInsertNF (vNF int, vCliente varchar(50))
begin
if exists (select Id from tbCliente where Nome = vCliente) then
	if not exists (select NF from tbNotaFiscal where NF = vNF) then
		set @IdCliente = (select Id from tbCliente where Nome = vCliente);
		set @TotalNota = (select sum(TotalVenda) from tbVenda where IdCliente = @IdCliente);
		set @DataVenda = current_date();
    
		if exists (select NumeroVenda from tbVenda where IdCliente = @IdCliente) then
			insert into tbNotaFiscal (NF, TotalNota, DataEmissao) values (vNF, @TotalNota, @DataVenda);
		else
			select "O Cliente n??o realizou nenhum pedido.";
		end if;
	else
		select "A nota fiscal j?? existe.";
	end if;
else
	select "O cliente n??o existe.";
end if;
end
$$

call spInsertNF(359, "Pimp??o");
call spInsertNF(360, "Lan??a Perfume");

# EXERC??CIO 12

DELIMITER $$
create procedure spInsertProduto(vCodigoBarras bigint, vNome varchar(50), vValorUnit decimal(6,2), vQtd int)
BEGIN
if not exists (select CodBarras from tbproduto where CodBarras = vCodigoBarras) then
		insert into tbproduto (CodBarras, Qtd, Nome, ValorUnitario) values (vCodigoBarras, vQtd, vNome, vValorUnit);
		else
			select "O produto j?? foi inserido";
    end if;
END
$$

call spInsertProduto(12345678910130, 'Camiseta de Poli??ster', 35.61, 100);
call spInsertProduto(12345678910131, 'Blusa Frio Moletom', 200.00, 100);
call spInsertProduto(12345678910132, 'Vestido Decote Redondo', 144.00, 50);
call spInsertProduto (12345678910111, 'Rei de Papel Mache', 54.61, 120);
call spInsertProduto (12345678910112, 'Bolinha de Sab??o', 100.45, 120);
call spInsertProduto (12345678910113, 'Carro Bate Bate', 44.00, 120);

select * from tbproduto;

# EXERC??CIO 13 

 DELIMITER $$
create procedure spDeleteProduto(vCodigoBarras bigint)
BEGIN
	if exists (select CodBarras from tbproduto where CodBarras = vCodigoBarras) then                                                                                                                                                                                                                         
		delete from tbproduto where CodBarras = vCodigoBarras;
		else 
			select "O produto n??o existe";
    end if;
END
$$

call spDeleteProduto(12345678910116);
call spDeleteProduto(12345678910117);

select * from tbproduto;



# EXERC??CIO 14

DELIMITER $$

create procedure spUpdateProduto(vCodigoBarras bigint, vNome varchar(50), vValorUnit decimal(6,2))
BEGIN

if exists (select CodBarras from tbProduto where CodBarras = VCodigoBarras) then
update tbproduto                              
set Nome= vNome, ValorUnitario = vValorUnit where CodBarras = vCodigoBarras;
else
	select "Inexistente";
end if;


END $$

call spUpdateProduto(12345678910111, 'Rei de Papel Mache', 64.50);
call spUpdateProduto(12345678910112, 'Bolinha de Sab??o', 120.00);
call spUpdateProduto(12345678910113, 'Carro Bate Bate', 64.00);

select * from tbproduto;

# EXERC??CIO 15 	CRIANDO UMA PROCEDURE PRA EXIBIR OS REGISTROS DA TABELA -  Rosa

 DELIMITER $$

create procedure spExibirProdutos()
BEGIN

select * from tbproduto;

end $$

call spExibirProdutos;

 /*CREATE PROCEDURE Selecionar_Produtos(IN quantidade INT)
BEGIN
SELECT * FROM PRODUTOS
LIMIT quantidade;
END $$
DELIMITER ;

*/

-- drop procedure spExibirProdutos;

-- EX 17
create table tbprodutoHistorico LIKE tbproduto;

select * from tbHistorico
select *  from tbProdutoHistorico;

alter table tbprodutoHistorico  add Ocorrencia varchar(20);
alter table tbprodutoHistorico add Atualizacao datetime;
alter table 

describe tbProdutoHistorico;
describe tbproduto;


-- EX18

alter table tbProdutoHistorico drop primary key;

alter table tbProdutoHistorico drop primary key;
alter table tbProdutoHistorico add
	constraint pk_tbProdutoHistorico primary key (CodBarras, Atualizacao, Ocorrencia);


-- EX19

delimiter $$
	create trigger tgrHistoricoInsert after insert on tbProduto
		for each row
	begin
	 insert into tbProdutoHistorico
     set CodBarras = new.CodBarras,
		 Qtd = new.Qtd, 
         Nome = new.Nome,
         ValorUnitario = new.ValorUnitario,
         Atualizacao = current_timestamp(),
         Ocorrencia = 'Novo';
	end;
$$

select * from tbProduto;


call inserirProduto(12345678910111, 'Agua Mineral', 1.99, 500);

call spUpdateProduto(12345678910119, '??gua Mineral', 2.99);

-- EX20

delimiter $$
	create trigger tgrHistoricoUpdate after update on tbProduto
		for each row
	begin
		insert into tbProdutoHistorico
			set CodBarras = old.CodBarras,
				Qtd = old.Qtd, 
				Nome = old.Nome,
				ValorUnitario = old.ValorUnitario,
				Atualizacao = current_timestamp(),
				Ocorrencia = 'Atualiza????o';
		insert into tbProdutoHistorico
			set CodBarras = new.CodBarras,
				Qtd = new.Qtd, 
				Nome = new.Nome,
				ValorUnitario = new.ValorUnitario,
				Atualizacao = current_timestamp(),
				Ocorrencia = 'Atualizado';
	end;
$$


call spInsertCompra('Revenda Chico Loco', 1245678937123, 11934567897);
/* call spInsertForn('Jos?? Faz Tudo S/A', 1345678937123, 11934567898);
call spInsertForn('Vadalto Entregas', 1445678937123, 11934567899);
call spInsertForn('Astrogildo das Estrela', 1545678937123, 11934567800);
call spInsertForn('Amoroso e Doce', 1645678937123, 11934567801);
call spInsertForn('Marcelo Dedal', 1745678937123, 11934567802);
call spInsertForn('Franciscano Cacha??a', 1845678937123, 11934567803);
call spInsertForn('Jo??ozinho Chupeta', 1945678937123, 11934567804); */

call spInsertCidade('Rio de Janeiro');
call spInsertCidade('S??o Carlos');
call spInsertCidade('Campinas');
call spInsertCidade('Franco da Rocha');
call spInsertCidade('Osasco');
call spInsertCidade('Pirituba');
call spInsertCidade('Lapa');
call spInsertCidade('Ponta Grossa');

call spInsertUF('SP');
call spInsertUF('RJ');
call spInsertUF('RS');

call spInsertBairro('Aclima????o');
call spInsertBairro('Cap??o Redondo');
call spInsertBairro('Pirituba');
call spInsertBairro('Liberdade');

call spInsertProduto('12345678910111', 'Rei de Papel Mache', '54.61', '120');
call spInsertProduto('12345678910112', 'Bolinha de Sab??o', '100.45', '120');
call spInsertProduto('12345678910113', 'Carro Bate Bate', '44.00', '120');
call spInsertProduto('12345678910114', 'Bola Furada', '10.00', '120');
call spInsertProduto('12345678910115', 'Ma???? Laranja', '99.44', '120');
call spInsertProduto('12345678910116', 'Boneco do Hitler', '124.00', '200');
call spInsertProduto('12345678910117', 'Farinha de Suru??', '50.00', '200');
call spInsertProduto('12345678910118', 'Zelador de Cemit??rio', '24.50', '100');
call inserirProduto(12345678910119, 'Agua Mineral', '1.99', '500');


call spInsertEndereco(12345050, 'Rua da Federal', 'Lapa', 'S??o Paulo', 'SP');
call spInsertEndereco(12345051, 'Av Brasil', 'Lapa', 'Campinas', 'SP');
call spInsertEndereco(12345052, 'Rua Liberdade', 'Consola????o', 'S??o Paulo', 'SP');
call spInsertEndereco(12345053, 'Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertEndereco(12345054, 'Rua Ximb??', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertEndereco(12345055, 'Rua Piu XI', 'Penha', 'Campina', 'SP');
call spInsertEndereco(12345056, 'Rua Chocolate', 'Aclima????o', 'Barra Mansa', 'RJ');
call spInsertEndereco(12345057, 'Rua P??o na Chapa', 'Barra Funda', 'Ponto Grossa', 'RS');

call spInsertCliente('Pimp??o', 325, null, 12345051, 12345678911, 12345678, 0, '2000-12-10', 'Av. Brasil', 'Lapa', 'Campinas', 'SP');
call spInsertCliente('Disney Chaplin', 89, 'Ap. 12', 12345053, 12345678912, 12345679, 0, '2001-11-21', 'Av. Paulista', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertCliente('Marciano', 744, null, 12345054, 12345678913, 12345680, 0, '2001-06-01', 'Rua Ximb??', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertCliente('Lan??a Perfume', 128, null, 12345059, 12345678914, 12345681, 'X', '2004-04-05', 'Rua Veia', 'Jardim Santa Isabel', 'Cuiab??', 'MT');
call spInsertCliente('Rem??dio Amargo', 2485, null, 12345058, 12345678915, 12345682, 0, '2002-07-15', 'Av. Nova', 'Jardim Santa Isabel', 'Cuiab??', 'MT');

call spInsertCliPJ('Paganada', 12345678912345, 98765432198, 12345051, 'Av. Brasil', 159, null, 'Lapa', 'Campinas', 'SP');
call spInsertCliPJ('Caloteando', 12345678912346, 98765432199, 12345053, 'Av. Paulista', 69, null, 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertCliPJ('Semgrana', 12345678912347, 98765432100, 12345060, 'Rua dos Amores', 189, null, 'Sei L??', 'Recife', 'PE');
call spInsertCliPJ('Cemreais', 12345678912348, 98765432101, 12345060, 'Rua dos Amores', 5024, 'Sala 23', 'Sei L??', 'Recife', 'PE');
call spInsertCliPJ('Durango', 12345678912349, 98765432102, 12345060, 'Rua dos Amores', 1254, null, 'Sei L??', 'Recife', 'PE');

call spInsertCompra(8459, 'Amoroso e Doce', '2018-05-01', 12345678910111, 22.22, 200, 700, 21944.00);
call spInsertCompra(2482, 'Revenda Chico Loco', '2020-04-22', 12345678910112, 40.50, 180, 180, 7290.00);
call spInsertCompra(21563, 'Marcelo Dedal', '2020-07-12', 12345678910113, 3.00, 300, 300, 900.00);
call spInsertCompra(8459, 'Amoroso e Doce', '2020-12-04', 12345678910114, 35.00, 500, 700, 21944.00);
call spInsertCompra(156354, 'Revenda Chico Loco', '2021-11-23', 12345678910115, 54.00, 350, 350, 18900.00);

call spInsertVenda(1, 'Pimp??o', '22/08/2022', 12345678910111, 54.61, 1, 54.61, null);
call spInsertVenda(2, 'Lan??a Perfume', '22/08/2022', 12345678910112, 100.45, 2, 200.90, null);
call spInsertVenda(3, 'Pimp??o', '22/08/2022', 12345678910113, 44.00, 1, 44.00, null);

call spInsertNF(359, 'Pimp??o', '29/08/2022');
call spInsertNF(360, 'Lan??a Perfume', '29/08/2022');

call spInsertProduto(12345678910130, 'Camiseta de Poli??ster', 35.61, 100);
call spInsertProduto(12345678910131, 'Blusa Frio Moletom', 200.00, 100);
call spInsertProduto(12345678910132, 'Vestido Decote Redondo', 144.00, 50);

call spDeleteProd(12345678910116);
call spDeleteProd(12345678910117);

call spUpdateProd(12345678910111, 'Rei de Papel Mache', 64.50);
call spUpdateProd(12345678910112, 'Bolinha de Sab??o', 120.00);
call spUpdateProd(12345678910113, 'Carro Bate Bate', 64.00);

call spInsertProduto(12345678910119, '??gua mineral', 1.99, 500);
call spUpdateProd(12345678910119, '??gua mineral', 2.99);

call spInsertVenda(2, 'Disney Chaplin', '19/09/2022', 12345678910111, 64.50, 1, 64.50, null);


select * from tbProdutoHistorico;
