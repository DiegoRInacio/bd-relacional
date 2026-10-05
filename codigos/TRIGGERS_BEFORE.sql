-- Exemplo de trigger BEFORE 
-- (executa ANTES da operação e pode alterar ou cancelar a linha)

CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco NUMERIC(10, 2) NOT NULL,
    estoque INT NOT NULL DEFAULT 0
);

-- Função para INSERT: valida o preço e padroniza o nome antes de gravar
CREATE OR REPLACE FUNCTION validar_produto_insert()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.preco <= 0 THEN
        RAISE EXCEPTION 'Preço deve ser maior que zero (informado: %)', NEW.preco;
    END IF;

    NEW.nome := UPPER(NEW.nome);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Função para UPDATE: impede redução de preço superior a 50%
CREATE OR REPLACE FUNCTION validar_produto_update()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.preco <= 0 THEN
        RAISE EXCEPTION 'Preço deve ser maior que zero (informado: %)', NEW.preco;
    END IF;

    IF NEW.preco < OLD.preco * 0.5 THEN
        RAISE EXCEPTION 'Redução de preço maior que a metade do valor atual não é permitida';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_validar_produto_insert
BEFORE INSERT ON produtos
FOR EACH ROW
EXECUTE FUNCTION validar_produto_insert();

CREATE TRIGGER trigger_validar_produto_update
BEFORE UPDATE ON produtos
FOR EACH ROW
EXECUTE FUNCTION validar_produto_update();

-- Testando Triggers BEFORE
INSERT INTO produtos (nome, preco, estoque) VALUES ('notebook', 3500.00, 10);
-- O nome foi gravado como 'NOTEBOOK' pela trigger

UPDATE produtos SET preco = 3000.00 WHERE id = 1;
-- Permitido: redução de aproximadamente 14%

-- Os próximos comandos geram erro de propósito (a trigger cancela a operação):
-- UPDATE produtos SET preco = 1000.00 WHERE id = 1;   -- redução maior que 50%
-- INSERT INTO produtos (nome, preco, estoque) VALUES ('mouse', 0, 5);   -- preço inválido

SELECT * FROM produtos;
