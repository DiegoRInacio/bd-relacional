-- Linguagem de definição de DDL - Data Definition Language

CREATE TABLE Funcionarios (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(100),
    Cargo VARCHAR(100),
    Salario NUMERIC(10, 2)
);

-- Altera a estrutura de uma tabela, adicionando uma nova coluna
ALTER TABLE Funcionarios
ADD COLUMN Data_nascimento DATE;

-- Exclui uma tabela do banco de dados
DROP TABLE Funcionarios;

INSERT INTO Funcionarios (Nome, Cargo, Data_nascimento, Salario)
VALUES
    ('João Silva', 'Analista de Dados', '1990-05-15', 5000.00),
    ('Maria Santos', 'Desenvolvedora Web', '1985-10-20', 5500.00),
    ('Carlos Oliveira', 'Gerente de Projetos', '1978-03-08', 7000.00),
    ('Ana Lima', 'Designer Gráfico', '1992-07-25', 4800.00),
    ('Pedro Souza', 'Analista de Sistemas', '1982-12-12', 6000.00);

-- Truncate
TRUNCATE TABLE Funcionarios;

-- Faria o mesmo resultado
DELETE FROM Funcionarios WHERE Salario >= 7000.00;

CREATE TABLE backup_table_funcionarios AS SELECT * FROM Funcionarios;

SELECT * FROM Funcionarios;