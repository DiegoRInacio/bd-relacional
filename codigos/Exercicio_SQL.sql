-- Crie um novo Database
-- Crie duas tabelas que irá receber os nomes

-- cliente
	-- colunas: nome, cpf, endereco, telefone
	-- defina cpf como primary key
-- venda
	-- colunas: id, cpf_cliente, valor_venda, cpf_vededor, desconto, comissao
	-- defina id como primary key

-- realize a inserção dos dados que já estão vinculados nesse script SQL
INSERT INTO cliente (nome, cpf, endereco, telefone)
SELECT
  'Nome ' || id,
  'CPF ' || id,
  'Endereço ' || id,
  'Telefone ' || id
FROM generate_series(1, 2000) AS id;

INSERT INTO venda_1 (id, cpf_cliente, valor_venda, cpf_vendedor, desconto, comissao)
SELECT
  id,
  (SELECT cpf FROM cliente ORDER BY random() LIMIT 1),
  random() * 1000 + 10,  -- Valor da venda entre 10 e 1000
  'CPF Vendedor ' || id,
  random() * 50,         -- Desconto entre 0 e 50
  random() * 100         -- Comissão entre 0 e 100
FROM generate_series(1, 1000) AS id;

-- Realize a verificação da quantidade de registros em cada uma das tabelas
-- Verifique qual foi o venderdor que mais recebeu desconto
-- Realize o join left, right e inner entre as tabelas
-- quantos casos exostentes na tabela cliente não estão contidos na tabela venda?

-- OBS.: Apresente todos os dados através de script e print