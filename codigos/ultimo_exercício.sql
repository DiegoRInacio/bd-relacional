CREATE TABLE Vendedor (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    loja VARCHAR(100),
    salario DECIMAL(10, 2)
);

CREATE TABLE Produto (
    id SERIAL PRIMARY KEY,
    id_vendedor INT REFERENCES Vendedor(id),
    valor DECIMAL(10, 2),
    estoque INT
);

CREATE TABLE Vendas (
    id SERIAL PRIMARY KEY,
    id_produto INT REFERENCES Produto(id),
    valor_venda DECIMAL(10, 2),
    id_user INT
);

CREATE TABLE LogProduto (
    id SERIAL PRIMARY KEY,
    id_vendedor INT,
    id_produto INT,
    valor DECIMAL(10, 2),
    estoque INT,
    mensagem VARCHAR(255),
    data TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_venda() RETURNS TRIGGER AS $$
DECLARE
    v_estoque INT;
    v_valor DECIMAL(10, 2);
    v_mensagem VARCHAR(255);
BEGIN
    -- Obtém o estoque atual do produto
    SELECT estoque, valor INTO v_estoque, v_valor
    FROM Produto
    WHERE id = NEW.id_produto;

    -- Atualiza o estoque
    v_estoque := v_estoque - 1;

    -- Atualiza a mensagem de log
    IF v_estoque <= 0 THEN
        v_mensagem := 'Produto em falta no estoque';
    ELSE
        v_mensagem := 'Produto disponível';
    END IF;

    -- Insere no log
    INSERT INTO LogProduto (id_vendedor, id_produto, valor, estoque, mensagem)
    VALUES ((SELECT id_vendedor FROM Produto WHERE id = NEW.id_produto), NEW.id_produto, NEW.valor_venda, v_estoque, v_mensagem);

    -- Atualiza o estoque do produto na tabela Produto
    UPDATE Produto
    SET estoque = v_estoque
    WHERE id = NEW.id_produto;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_venda
AFTER INSERT ON Vendas
FOR EACH ROW
EXECUTE FUNCTION log_venda();



------------
SELECT 
    p.id_vendedor,
    p.id AS id_produto,
    COUNT(v.id) AS quantidade_vendida,
    SUM(v.valor_venda) AS total_vendido
FROM 
    Vendas v
JOIN 
    Produto p ON v.id_produto = p.id
GROUP BY 
    p.id_vendedor, p.id;

-----------------------------------------------------

INSERT INTO pessoa(nome, endereco, cpf, sexo) VALUES('Zé das Coves', 'Rua 10', '78985234500', 'M');
INSERT INTO pessoa(nome, cpf, sexo) VALUES('Zé da Manga', '789852456', 'M');
INSERT INTO pessoa(nome, endereco, cpf, sexo) VALUES('Zé das Coves', 'Rua 10', '32165498700', 'M');