CREATE TABLE operadoras (
                            id SERIAL PRIMARY KEY,
                            registro_ans VARCHAR(20) UNIQUE NOT NULL,
                            cnpj VARCHAR(18) NOT NULL,
                            razao_social VARCHAR(255) NOT NULL,
                            nome_fantasia VARCHAR(255),
                            modalidade VARCHAR(100) NOT NULL,
                            logradouro VARCHAR(255),
                            numero VARCHAR(20),
                            complemento VARCHAR(255),
                            bairro VARCHAR(255),
                            cidade VARCHAR(255),
                            uf CHAR(2) NOT NULL,
                            cep VARCHAR(10),
                            ddd VARCHAR(5),
                            telefone VARCHAR(20),
                            fax VARCHAR(20),
                            email VARCHAR(255),
                            representante VARCHAR(255),
                            cargo_representante VARCHAR(255),
                            regiao_comercializacao INT,
                            data_registro_ans DATE
);

CREATE TABLE demonstracoes_contabeis (
                                         id SERIAL PRIMARY KEY,
                                         registro_ans VARCHAR(20) NOT NULL,
                                         data DATE NOT NULL,
                                         cd_conta_contabil VARCHAR(20) NOT NULL,
                                         descricao TEXT NOT NULL,
                                         vl_saldo_inicial DECIMAL(18,2) NOT NULL,
                                         vl_saldo_final DECIMAL(18,2) NOT NULL,
                                         FOREIGN KEY (registro_ans) REFERENCES operadoras(registro_ans) ON DELETE CASCADE
);

COPY operadoras(registro_ans, cnpj, razao_social, nome_fantasia, modalidade, logradouro, numero, complemento, bairro, cidade, uf, cep, ddd, telefone, fax, email, representante, cargo_representante, regiao_comercializacao, data_registro_ans)
    FROM 'TESTE3\src\relatorio\Relatorio_cadop.csv'
    DELIMITER ';'
    CSV HEADER ENCODING 'LATIN1';

COPY demonstracoes_contabeis(registro_ans, data, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
    FROM 'TESTE\src\dados\1T2023.csv'
    DELIMITER ';'
    CSV HEADER ENCODING 'LATIN1';

COPY demonstracoes_contabeis(registro_ans, data, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
    FROM 'TESTE3\src\dados\2T2023.csv'
    DELIMITER ';'
    CSV HEADER ENCODING 'LATIN1';

COPY demonstracoes_contabeis(registro_ans, data, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
    FROM 'TESTE3\src\dados\3T2023.csv'
    DELIMITER ';'
    CSV HEADER ENCODING 'LATIN1';

COPY demonstracoes_contabeis(registro_ans, data, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
    FROM 'TESTE\src\dados\4T2023.csv'
    DELIMITER ';'
    CSV HEADER ENCODING 'LATIN1';

COPY demonstracoes_contabeis(registro_ans, data, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
    FROM 'TESTE3\src\dados\1T2024.csv'
    DELIMITER ';'
    CSV HEADER ENCODING 'LATIN1';

COPY demonstracoes_contabeis(registro_ans, data, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
    FROM 'TESTE3\src\dados\2T2024.csv'
    DELIMITER ';'
    CSV HEADER ENCODING 'LATIN1';

COPY demonstracoes_contabeis(registro_ans, data, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
    FROM 'TESTE3\src\dados\3T2024.csv'
    DELIMITER ';'
    CSV HEADER ENCODING 'LATIN1';

COPY demonstracoes_contabeis(registro_ans, data, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
    FROM 'TESTE3\src\dados\4T2024.csv'
    DELIMITER ';'
    CSV HEADER ENCODING 'LATIN1';

SELECT o.razao_social, d.data, SUM(d.vl_saldo_final) AS total_despesas
FROM demonstracoes_contabeis d
         JOIN operadoras o ON d.registro_ans = o.registro_ans
WHERE d.data >= (SELECT DATE_TRUNC('quarter', MAX(data)) FROM demonstracoes_contabeis)
  AND d.descricao ILIKE '%SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
GROUP BY o.razao_social, d.data
ORDER BY total_despesas DESC
    LIMIT 10;

SELECT o.razao_social, EXTRACT(YEAR FROM d.data) AS ano, SUM(d.vl_saldo_final) AS total_despesas
FROM demonstracoes_contabeis d
         JOIN operadoras o ON d.registro_ans = o.registro_ans
WHERE d.data >= (SELECT DATE_TRUNC('year', MAX(data)) FROM demonstracoes_contabeis)
  AND d.descricao ILIKE '%SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
GROUP BY o.razao_social, ano
ORDER BY total_despesas DESC
    LIMIT 10;