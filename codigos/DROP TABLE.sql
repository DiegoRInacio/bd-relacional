-- Criação das tabelas
CREATE TABLE livros (
    id_livro SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    ano_publicacao INT NOT NULL
);

CREATE TABLE emprestimos (
    id_emprestimo SERIAL PRIMARY KEY,
    id_livro INT NOT NULL,
    data_emprestimo DATE NOT NULL,
    data_devolucao DATE,
    nome_usuario VARCHAR(255) NOT NULL,
    CONSTRAINT fk_livro FOREIGN KEY (id_livro) REFERENCES livros(id_livro)
);

CREATE TABLE log_operacoes (
    id_log SERIAL PRIMARY KEY,
    tabela_afetada VARCHAR(50) NOT NULL,
    tipo_operacao VARCHAR(10) NOT NULL,
    dados_antigos TEXT,
    dados_novos TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Criação da função de trigger
CREATE OR REPLACE FUNCTION registrar_operacoes()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO log_operacoes (tabela_afetada, tipo_operacao, dados_novos)
        VALUES (TG_TABLE_NAME, TG_OP, row_to_json(NEW)::text);
        RETURN NEW;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO log_operacoes (tabela_afetada, tipo_operacao, dados_antigos, dados_novos)
        VALUES (TG_TABLE_NAME, TG_OP, row_to_json(OLD)::text, row_to_json(NEW)::text);
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO log_operacoes (tabela_afetada, tipo_operacao, dados_antigos)
        VALUES (TG_TABLE_NAME, TG_OP, row_to_json(OLD)::text);
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Criação das triggers
CREATE TRIGGER trg_livros_operacoes
AFTER INSERT OR UPDATE OR DELETE ON livros
FOR EACH ROW EXECUTE FUNCTION registrar_operacoes();

CREATE TRIGGER trg_emprestimos_operacoes
AFTER INSERT OR UPDATE OR DELETE ON emprestimos
FOR EACH ROW EXECUTE FUNCTION registrar_operacoes();

-- Inserções na tabela livros
INSERT INTO livros (titulo, autor, ano_publicacao) VALUES
('1984', 'George Orwell', 1949),
('O Senhor dos Anéis', 'J.R.R. Tolkien', 1954),
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 1943),
('Dom Quixote', 'Miguel de Cervantes', 1605),
('Guerra e Paz', 'Liev Tolstói', 1869);

-- Inserções na tabela emprestimos
INSERT INTO emprestimos (id_livro, data_emprestimo, data_devolucao, nome_usuario) VALUES
(1, '2023-01-15', '2023-01-25', 'Maria Silva'),
(2, '2023-02-20', '2023-03-01', 'João Pereira'),
(3, '2023-03-10', NULL, 'Ana Souza'),
(4, '2023-04-05', '2023-04-15', 'Carlos Oliveira'),
(5, '2023-05-01', NULL, 'Fernanda Lima');

-- Consultar livros
SELECT * FROM livros;

-- Consultar emprestimos
SELECT * FROM emprestimos;

-- Consultar log_operacoes
SELECT * FROM log_operacoes;
