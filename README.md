# Projeto Power BI com Moskit CRM API

Este projeto consiste em uma série de consultas Power BI utilizando a linguagem M/Power Query para extrair e transformar dados da API do Moskit CRM.

## Estrutura do Projeto

O projeto está dividido em duas pastas principais:

### powerbi_project
Contém os arquivos `.pbip` e seus auxiliares, que são utilizados para armazenar em modo de versionamento um arquivo do Power BI.

### M_queries
Armazena o código em linguagem M de cada tabela criada no Power Query para melhor visualização. As tabelas estão organizadas em subpastas conforme a sua função no processo de ETL (Extract, Transform, Load).

- #### Staging
    Tabelas com as consultas de extração de dados diretamente da API do Moskit.

- #### Marts
    Tabelas com a transformação dos dados para serem utilizados nos relatórios.

## Como Usar
Abrir o arquivo moskit_api.pbip e alterar os parâmetros de consulta com a API key do usuário.

# Power BI Project with Moskit CRM API

This project consists of a series of Power BI queries using M language/Power Query to extract and transform data from the Moskit CRM API.

## Project Structure

The project is divided into two main folders:

### powerbi_project
Contains the `.pbip` files and their helpers, which are used to store a Power BI file in version control mode.

### M_queries
Stores the M language code for each table created in Power Query for better visualization. The tables are organized into subfolders according to their role in the ETL (Extract, Transform, Load) process.

- #### Staging
    Tables with data extraction queries directly from the Moskit API.

- #### Marts
    Tables with data transformation to be used in reports.

## How to Use
Open the moskit_api.pbip file and change the query parameters with the user's API key.
