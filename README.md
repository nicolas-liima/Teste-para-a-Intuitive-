# Teste Técnico - Processo Seletivo

Este repositório contém a implementação das soluções para os desafios técnicos realizados durante o processo seletivo da vaga de estagio para a empresa Intuitive-care.

---

## 🧪 Teste 1 - Web Scraping

Foi desenvolvido um script de scraping para extrair informações públicas da web, estruturando os dados de forma organizada em arquivos CSV.

### Tecnologias:
- Java

---

## 📊 Teste 2 - Extração e Transformação de Dados da ANS

Neste teste, trabalhei com a **extração de dados em PDF** disponibilizado pela ANS, realizando transformações e limpeza dos dados, com posterior salvamento em `.csv` e compactação em `.zip`.

Inicialmente comecei o projeto em **Java**, mas após algumas dificuldades com a manipulação de dados, optei por reescrever a solução em **Python**, o que permitiu uma abordagem mais ágil, simples e eficaz.

### Desafios:
- Conversão de PDF para dados tabulares
- Substituição de abreviações e padronização de colunas
- Organização da estrutura do projeto

### Tecnologias:
- Python

---

## 🧮 Teste 3 - Carga de Dados no PostgreSQL

Neste teste, os dados extraídos foram inseridos em um banco de dados PostgreSQL, utilizando duas tabelas: `operadoras` e `demonstracoes_contabeis`.

### Funcionalidades:
- Importação de dados via `COPY`
- Modelagem simples e relacional
- Scripts SQL para consultas analíticas

### Desafios:
Tive certa dificuldade na construção das **queries SQL**, especialmente na filtragem correta por colunas como `descricao`. Após inspeção mais detalhada dos dados e testes incrementais, consegui construir as consultas esperadas, incluindo filtros com `ILIKE`, junções e agrupamentos.

---

## 🌐 Teste 4 - API com Python + Frontend em Vue.js

Neste teste, desenvolvi uma API em **Python** (com `pandas`) para fornecer dados tratados da ANS via uma rota `GET`, e criei um front-end com **Vue.js** para consumir e exibir essas informações de forma amigável ao usuário.

### Backend:
- Implementação de rota `/buscar` para buscar os dados de um arquivo CSV
- Utilizando `pandas` para leitura do arquivo. 

### Frontend:
- Aplicação Vue com layout simples
- Chamada à API usando `axios`
- Exibição dos dados em uma tabela interativa

### Tecnologias:
- Python (`pandas`)
- Vue.js
- Axios

---

## ✅ Considerações Finais

Apesar de encontrar obstáculos em alguns pontos, especialmente no **Teste 2** e **Teste 3**, consegui contornar as dificuldades com pesquisa e prática. Optei por adaptar tecnologias conforme a necessidade (como trocar Java por Python), buscando sempre o caminho mais eficiente para manipulação de dados.

O projeto foi estruturado de forma limpa e objetiva, prezando pela clareza e organização do código.

---

**Desenvolvido por:** Nícolas Lima  
**Contato:** Nicolastoledolima18@icloud.com
