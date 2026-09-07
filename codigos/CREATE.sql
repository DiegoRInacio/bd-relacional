CREATE TABLE pessoa(
	nome varchar(50),
	endereco varchar(100),
	cpf varchar(15),
	sexo char(1),
 	CONSTRAINT pk_pessoa PRIMARY KEY (cpf)
);

CREATE TABLE venda(
	codigo integer,
	nome_cliente varchar(50),
	valor_total numeric,
	valor_desconto numeric,
	CONSTRAINT pk_vendas PRIMARY KEY (codigo)
);

CREATE TABLE vendedor(
	matricula integer,
	nome_vendedor varchar(50),
	total_vendas numeric,
	CONSTRAINT pk_vendedor PRIMARY KEY(matricula)
);

INSERT INTO pessoa(nome, endereco, cpf, sexo) VALUES('Zé das Coves', 'Rua 10', '78985234500', 'M');
INSERT INTO pessoa(nome, cpf, sexo) VALUES('Zé da Manga', '789852456', 'M');
INSERT INTO pessoa(nome, endereco, cpf, sexo) VALUES('Zé das Coves', 'Rua 10', '32165498700', 'M');

DELETE FROM pessoa WHERE nome = 'Zé das Coves';

UPDATE pessoa SET nome = 'Zé da Manga' WHERE cpf = '32165498700';

SELECT * FROM pessoa