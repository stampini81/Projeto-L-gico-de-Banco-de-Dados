# Projeto Lógico de Banco de Dados para E-commerce

Este repositório contém a solução para o Desafio de Projeto "Construindo seu Primeiro Projeto Lógico de Banco de Dados" da DIO.

## Descrição do Cenário

O projeto consiste na modelagem e implementação de um banco de dados para um cenário de e-commerce. O esquema foi refinado para atender a requisitos específicos, como a diferenciação entre clientes Pessoa Física (PF) e Pessoa Jurídica (PJ), a possibilidade de múltiplos métodos de pagamento e o rastreamento de entregas com status e código.

## Modelo Lógico 💾

O modelo lógico foi desenvolvido para representar as seguintes entidades e seus relacionamentos:

-   **Clientes (Clients)**: 👤 Armazena informações gerais dos clientes. A especialização em PF e PJ é feita através de tabelas separadas (`NaturalPerson` e `LegalPerson`) que se relacionam com a tabela principal de clientes.
-   **Produtos (Products)**: 📦 Contém os detalhes dos produtos à venda.
-   **Pedidos (Orders)**: 🛒 Registra os pedidos feitos pelos clientes, incluindo status do pedido e informações de entrega.
-   **Pagamentos (Payments)**: 💳 Gerencia as formas de pagamento associadas a cada pedido.
-   **Fornecedores (Suppliers)**: 🚚 Cadastra os fornecedores dos produtos.
-   **Vendedores Terceirizados (Sellers)**: 🤝 Cadastra vendedores parceiros.
-   **Estoque (Stock)**: Warehouse Controla a localização e quantidade de produtos em estoque.

As relações entre essas entidades (como produtos em um pedido, produtos fornecidos por um fornecedor, etc.) são gerenciadas por tabelas associativas.

## Scripts SQL 📜

O arquivo `ecommerce_schema.sql` contém todo o código SQL para:
1.  **Criação do Esquema**: `CREATE TABLE` para todas as entidades e seus relacionamentos, com a definição de chaves primárias, estrangeiras e constraints.
2.  **Persistência de Dados**: `INSERT INTO` para popular o banco de dados com dados de exemplo, permitindo a execução de testes e consultas.
3.  **Queries (Consultas)**: Uma série de `SELECT` statements para extrair informações relevantes do banco de dados, utilizando cláusulas como `JOIN`, `WHERE`, `GROUP BY`, `HAVING` e `ORDER BY` para responder a perguntas de negócio.

---

## Autor

*   **Leandro da Silva Stampini**
*   **LinkedIn:** [https://www.linkedin.com/in/leandro-da-silva-stampini-07b04aa3/](https://www.linkedin.com/in/leandro-da-silva-stampini-07b04aa3/)
