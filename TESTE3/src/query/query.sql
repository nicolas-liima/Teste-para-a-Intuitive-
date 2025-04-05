
DROP TABLE IF EXISTS demonstracoes_temp;
CREATE EXTENSION IF NOT EXISTS unaccent;


CREATE TABLE IF NOT EXISTS operadoras (
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

CREATE TABLE IF NOT EXISTS demonstracoes_contabeis (
    id SERIAL PRIMARY KEY,
	data DATE,
    registro_ans VARCHAR(20) NOT NULL,
    cd_conta_contabil VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    vl_saldo_inicial DECIMAL(18,2) NOT NULL,
    vl_saldo_final DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (registro_ans) REFERENCES operadoras(registro_ans) ON DELETE CASCADE
);

CREATE TEMP TABLE demonstracoes_temp (
    data TEXT,
    registro_ans VARCHAR(20),
    cd_conta_contabil VARCHAR(100),
    descricao TEXT,
    vl_saldo_inicial TEXT,
    vl_saldo_final TEXT
);


\COPY operadoras(registro_ans, cnpj, razao_social, nome_fantasia, modalidade, logradouro, numero, complemento, bairro, cidade, uf, cep, ddd, telefone, fax, email, representante, cargo_representante, regiao_comercializacao, data_registro_ans) FROM 'C:/Users/Nicolas liima/Desktop/Intuitive/TESTE3/src/relatorio/Relatorio_cadop.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';


-- === 1T2023 ===
\COPY demonstracoes_temp FROM 'Intuitive/TESTE3/src/dados/1T2023.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
INSERT INTO demonstracoes_contabeis (data, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SELECT
    (CASE
        WHEN data ~ '^\d{4}-\d{2}-\d{2}$'
        THEN TO_DATE(data, 'YYYY-MM-DD')
        ELSE NULL
    END),
    registro_ans,
    cd_conta_contabil,
    descricao,
    REPLACE(vl_saldo_inicial, ',', '.')::DECIMAL,
    REPLACE(vl_saldo_final, ',', '.')::DECIMAL
FROM demonstracoes_temp
WHERE
    LENGTH(data) = 10
    AND data ~ '^\d{4}-\d{2}-\d{2}$'
    AND EXISTS (
        SELECT 1
        FROM operadoras o
        WHERE o.registro_ans = demonstracoes_temp.registro_ans
    );

-- === 2T2023 ===
\COPY demonstracoes_temp FROM 'Intuitive/TESTE3/src/dados/2T2023.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
INSERT INTO demonstracoes_contabeis (data, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SELECT
    TO_DATE(dt.data, 'YYYY-MM-DD'),
    dt.registro_ans,
    dt.cd_conta_contabil,
    dt.descricao,
    REPLACE(dt.vl_saldo_inicial, ',', '.')::DECIMAL,
    REPLACE(dt.vl_saldo_final, ',', '.')::DECIMAL
FROM demonstracoes_temp dt
JOIN operadoras o ON o.registro_ans = dt.registro_ans
WHERE
    dt.data ~ '^\d{4}-\d{2}-\d{2}$';
	
-- === 3T2023 ===
\COPY demonstracoes_temp FROM 'Intuitive/TESTE3/src/dados/3T2023.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
INSERT INTO demonstracoes_contabeis (data, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SELECT
    TO_DATE(dt.data, 'YYYY-MM-DD'),
    dt.registro_ans,
    dt.cd_conta_contabil,
    dt.descricao,
    REPLACE(dt.vl_saldo_inicial, ',', '.')::DECIMAL,
    REPLACE(dt.vl_saldo_final, ',', '.')::DECIMAL
FROM demonstracoes_temp dt
JOIN operadoras o ON o.registro_ans = dt.registro_ans
WHERE
    dt.data ~ '^\d{4}-\d{2}-\d{2}$';

-- === 4T2023 ===
\COPY demonstracoes_temp FROM 'Intuitive/TESTE3/src/dados/4T2023.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
INSERT INTO demonstracoes_contabeis (data, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SELECT
    TO_DATE(dt.data, 'YYYY-MM-DD'),
    dt.registro_ans,
    dt.cd_conta_contabil,
    dt.descricao,
    REPLACE(dt.vl_saldo_inicial, ',', '.')::DECIMAL,
    REPLACE(dt.vl_saldo_final, ',', '.')::DECIMAL
FROM demonstracoes_temp dt
JOIN operadoras o ON o.registro_ans = dt.registro_ans
WHERE
    dt.data ~ '^\d{4}-\d{2}-\d{2}$';
	
-- === 1T2024 ===
\COPY demonstracoes_temp FROM 'Intuitive/TESTE3/src/dados/1T2024.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
INSERT INTO demonstracoes_contabeis (data, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SELECT
    TO_DATE(dt.data, 'YYYY-MM-DD'),
    dt.registro_ans,
    dt.cd_conta_contabil,
    dt.descricao,
    REPLACE(dt.vl_saldo_inicial, ',', '.')::DECIMAL,
    REPLACE(dt.vl_saldo_final, ',', '.')::DECIMAL
FROM demonstracoes_temp dt
JOIN operadoras o ON o.registro_ans = dt.registro_ans
WHERE
    dt.data ~ '^\d{4}-\d{2}-\d{2}$';
	
-- === 2T2024 ===
\COPY demonstracoes_temp FROM 'Intuitive/TESTE3/src/dados/2T2024.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
INSERT INTO demonstracoes_contabeis (data, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SELECT
    TO_DATE(dt.data, 'YYYY-MM-DD'),
    dt.registro_ans,
    dt.cd_conta_contabil,
    dt.descricao,
    REPLACE(dt.vl_saldo_inicial, ',', '.')::DECIMAL,
    REPLACE(dt.vl_saldo_final, ',', '.')::DECIMAL
FROM demonstracoes_temp dt
JOIN operadoras o ON o.registro_ans = dt.registro_ans
WHERE
    dt.data ~ '^\d{4}-\d{2}-\d{2}$';
	
-- === 3T2024 ===
\COPY demonstracoes_temp FROM 'Intuitive/TESTE3/src/dados/3T2024.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
INSERT INTO demonstracoes_contabeis (data, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SELECT
    TO_DATE(dt.data, 'YYYY-MM-DD'),
    dt.registro_ans,
    dt.cd_conta_contabil,
    dt.descricao,
    REPLACE(dt.vl_saldo_inicial, ',', '.')::DECIMAL,
    REPLACE(dt.vl_saldo_final, ',', '.')::DECIMAL
FROM demonstracoes_temp dt
JOIN operadoras o ON o.registro_ans = dt.registro_ans
WHERE
    dt.data ~ '^\d{4}-\d{2}-\d{2}$';

-- === 4T2024 ===
\COPY demonstracoes_temp FROM 'Intuitive/TESTE3/src/dados/4T2024.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
INSERT INTO demonstracoes_contabeis (data, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SELECT
    TO_DATE(dt.data, 'YYYY-MM-DD'),
    dt.registro_ans,
    dt.cd_conta_contabil,
    dt.descricao,
    REPLACE(dt.vl_saldo_inicial, ',', '.')::DECIMAL,
    REPLACE(dt.vl_saldo_final, ',', '.')::DECIMAL
FROM demonstracoes_temp dt
JOIN operadoras o ON o.registro_ans = dt.registro_ans
WHERE
    dt.data ~ '^\d{4}-\d{2}-\d{2}$';
	

SELECT
    o.razao_social,
    d.data,
    SUM(d.vl_saldo_final) AS total_despesas
FROM demonstracoes_contabeis d
JOIN operadoras o ON d.registro_ans = o.registro_ans
WHERE
    d.data >= (SELECT DATE_TRUNC('quarter', MAX(data)) FROM demonstracoes_contabeis)
    AND unaccent(d.descricao) ILIKE '%sinistros%'
    AND unaccent(d.descricao) ILIKE '%assistencia%'
    AND unaccent(d.descricao) ILIKE '%medico%'
    AND unaccent(d.descricao) ILIKE '%hospitalar%'
GROUP BY o.razao_social, d.data
ORDER BY total_despesas DESC
LIMIT 10;


SELECT
    o.razao_social,
    d.data,
    SUM(d.vl_saldo_final) AS total_despesas
FROM demonstracoes_contabeis d
JOIN operadoras o ON d.registro_ans = o.registro_ans
WHERE
    d.data >= (SELECT DATE_TRUNC('year', MAX(data)) FROM demonstracoes_contabeis)
    AND unaccent(d.descricao) ILIKE '%sinistros%'
    AND unaccent(d.descricao) ILIKE '%assistencia%'
    AND unaccent(d.descricao) ILIKE '%medico%'
    AND unaccent(d.descricao) ILIKE '%hospitalar%'
GROUP BY o.razao_social, d.data
ORDER BY total_despesas DESC
LIMIT 10;
