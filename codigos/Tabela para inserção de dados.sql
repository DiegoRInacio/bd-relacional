CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    endereco TEXT NOT NULL,
    telefone VARCHAR(20) NOT NULL
);

CREATE TABLE venda (
    id SERIAL PRIMARY KEY,
    cpf_cliente VARCHAR(14) NOT NULL,
    valor_venda DECIMAL(10, 2) NOT NULL,
    cpf_vendedor VARCHAR(14) NOT NULL,
    desconto DECIMAL(10, 2) NOT NULL,
    comissao DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf)
);