SELECT COUNT(*) FROM tabela_exemplo;

SELECT COUNT(*) FROM tabela_exemplo WHERE condição;

SELECT SUM(valor) FROM vendas;

SELECT SUM(valor) FROM vendas WHERE condição;

- Aplicando condições -

SELECT COUNT(*) FROM vendas WHERE valor > 100;

SELECT SUM(valor) FROM vendas WHERE produto_id = 123;

SELECT * FROM tabela_exemplo WHERE condicao1 OR condicao2;

SELECT * FROM tabela_exemplo WHERE condicao1 AND condicao2;

SELECT * FROM tabela_exemplo WHERE (condicao1 OR condicao2) AND condicao3;

-join-
SELECT *
FROM tabela_esquerda
LEFT JOIN tabela_direita ON tabela_esquerda.chave = tabela_direita.chave;

SELECT *
FROM tabela_esquerda
INNER JOIN tabela_direita ON tabela_esquerda.chave = tabela_direita.chave;

SELECT *
FROM tabela_esquerda
RIGHT JOIN tabela_direita ON tabela_esquerda.chave = tabela_direita.chave;
