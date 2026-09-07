CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    idade INT CHECK (idade >= 0),
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE funcionarios (
    id SERIAL PRIMARY KEY,
    cargo VARCHAR(100) NOT NULL,
    salario NUMERIC(10, 2) NOT NULL,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE log_funcionarios (
    id SERIAL PRIMARY KEY,
    operacao VARCHAR(10) NOT NULL,
    funcionario_id INT,
    cargo VARCHAR(100),
    salario NUMERIC(10, 2),
    user_id INT,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (nome, idade, email) VALUES
('Alice', 30, 'alice@example.com'),
('Bob', 25, 'bob@example.com');

INSERT INTO funcionarios (cargo, salario, user_id) VALUES
('Desenvolvedor', 5000.00, 1),
('Analista de Dados', 4500.00, 2);

CREATE OR REPLACE FUNCTION log_funcionario_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_funcionarios (operacao, funcionario_id, cargo, salario, user_id)
    VALUES ('INSERT', NEW.id, NEW.cargo, NEW.salario, NEW.user_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_funcionario_update()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_funcionarios (operacao, funcionario_id, cargo, salario, user_id)
    VALUES ('UPDATE', NEW.id, NEW.cargo, NEW.salario, NEW.user_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_funcionario_delete()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_funcionarios (operacao, funcionario_id, cargo, salario, user_id)
    VALUES ('DELETE', OLD.id, OLD.cargo, OLD.salario, OLD.user_id);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_log_funcionario_insert
AFTER INSERT ON funcionarios
FOR EACH ROW
EXECUTE FUNCTION log_funcionario_insert();

CREATE TRIGGER trigger_log_funcionario_update
AFTER UPDATE ON funcionarios
FOR EACH ROW
EXECUTE FUNCTION log_funcionario_update();

CREATE TRIGGER trigger_log_funcionario_delete
AFTER DELETE ON funcionarios
FOR EACH ROW
EXECUTE FUNCTION log_funcionario_delete();

-- Testando Triggers
INSERT INTO funcionarios (cargo, salario, user_id) VALUES ('Gerente', 8000.00, 1);

UPDATE funcionarios SET salario = 8500.00 WHERE id = 1;

DELETE FROM funcionarios WHERE id = 1;

SELECT * FROM log_funcionarios;






