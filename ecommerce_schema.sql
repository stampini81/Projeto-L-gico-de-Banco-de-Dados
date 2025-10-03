-- Desafio de Projeto: Construindo seu Primeiro Projeto Lógico de Banco de Dados
-- Aluno: Leandro da Silva Stampini
-- Descrição: Script SQL para criação do esquema de banco de dados de um e-commerce,
-- inserção de dados de exemplo e consultas complexas.

-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- -----------------------------------------------------
-- Tabela: Clients (Clientes)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Clients (
  idClient INT NOT NULL AUTO_INCREMENT,
  FirstName VARCHAR(45) NOT NULL,
  LastName VARCHAR(45) NOT NULL,
  Address VARCHAR(255) NULL,
  ClientType ENUM('PF', 'PJ') NOT NULL,
  PRIMARY KEY (idClient)
);

-- -----------------------------------------------------
-- Tabela: NaturalPerson (Pessoa Física)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS NaturalPerson (
  idNaturalPerson INT NOT NULL,
  CPF CHAR(11) NOT NULL,
  PRIMARY KEY (idNaturalPerson),
  UNIQUE INDEX CPF_UNIQUE (CPF ASC),
  CONSTRAINT fk_NaturalPerson_Clients
    FOREIGN KEY (idNaturalPerson)
    REFERENCES Clients (idClient)
    ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Tabela: LegalPerson (Pessoa Jurídica)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS LegalPerson (
  idLegalPerson INT NOT NULL,
  CNPJ CHAR(14) NOT NULL,
  CompanyName VARCHAR(255) NOT NULL,
  PRIMARY KEY (idLegalPerson),
  UNIQUE INDEX CNPJ_UNIQUE (CNPJ ASC),
  CONSTRAINT fk_LegalPerson_Clients
    FOREIGN KEY (idLegalPerson)
    REFERENCES Clients (idClient)
    ON DELETE CASCADE
);

-- -----------------------------------------------------
-- Tabela: Products (Produtos)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Products (
  idProduct INT NOT NULL AUTO_INCREMENT,
  ProductName VARCHAR(255) NOT NULL,
  Category VARCHAR(45) NOT NULL,
  Description VARCHAR(255) NULL,
  Price DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (idProduct)
);

-- -----------------------------------------------------
-- Tabela: Orders (Pedidos)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Orders (
  idOrder INT NOT NULL AUTO_INCREMENT,
  idOrderClient INT NOT NULL,
  OrderStatus ENUM('Processing', 'Shipped', 'Delivered', 'Canceled') NOT NULL DEFAULT 'Processing',
  OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ShippingValue DECIMAL(10,2) NULL,
  DeliveryStatus VARCHAR(45) NULL,
  TrackingCode VARCHAR(45) NULL,
  PRIMARY KEY (idOrder),
  CONSTRAINT fk_Orders_Clients
    FOREIGN KEY (idOrderClient)
    REFERENCES Clients (idClient)
);

-- -----------------------------------------------------
-- Tabela: Product_Order (Produtos em Pedido)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Product_Order (
  idPO_Product INT NOT NULL,
  idPO_Order INT NOT NULL,
  Quantity INT NOT NULL,
  PRIMARY KEY (idPO_Product, idPO_Order),
  CONSTRAINT fk_Product_Order_Product
    FOREIGN KEY (idPO_Product)
    REFERENCES Products (idProduct),
  CONSTRAINT fk_Product_Order_Order
    FOREIGN KEY (idPO_Order)
    REFERENCES Orders (idOrder)
);

-- -----------------------------------------------------
-- Tabela: Payments (Pagamentos)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Payments (
  idPayment INT NOT NULL AUTO_INCREMENT,
  idPaymentOrder INT NOT NULL,
  PaymentType ENUM('Credit Card', 'Debit Card', 'Bank Slip', 'PIX') NOT NULL,
  PaymentValue DECIMAL(10,2) NOT NULL,
  PaymentStatus ENUM('Pending', 'Approved', 'Rejected') NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (idPayment),
  CONSTRAINT fk_Payments_Orders
    FOREIGN KEY (idPaymentOrder)
    REFERENCES Orders (idOrder)
);

-- -----------------------------------------------------
-- Tabela: Stock (Estoque)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Stock (
  idStock INT NOT NULL AUTO_INCREMENT,
  Location VARCHAR(255) NOT NULL,
  PRIMARY KEY (idStock)
);

-- -----------------------------------------------------
-- Tabela: Product_Stock (Produtos em Estoque)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Product_Stock (
  idPS_Product INT NOT NULL,
  idPS_Stock INT NOT NULL,
  Quantity INT NOT NULL,
  PRIMARY KEY (idPS_Product, idPS_Stock),
  CONSTRAINT fk_Product_Stock_Product
    FOREIGN KEY (idPS_Product)
    REFERENCES Products (idProduct),
  CONSTRAINT fk_Product_Stock_Stock
    FOREIGN KEY (idPS_Stock)
    REFERENCES Stock (idStock)
);

-- -----------------------------------------------------
-- Tabela: Suppliers (Fornecedores)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Suppliers (
  idSupplier INT NOT NULL AUTO_INCREMENT,
  CompanyName VARCHAR(255) NOT NULL,
  CNPJ CHAR(14) NOT NULL,
  Contact VARCHAR(45) NULL,
  PRIMARY KEY (idSupplier),
  UNIQUE INDEX CNPJ_UNIQUE_SUPPLIER (CNPJ ASC)
);

-- -----------------------------------------------------
-- Tabela: Product_Supplier (Produtos por Fornecedor)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Product_Supplier (
  idPSup_Supplier INT NOT NULL,
  idPSup_Product INT NOT NULL,
  PRIMARY KEY (idPSup_Supplier, idPSup_Product),
  CONSTRAINT fk_Product_Supplier_Supplier
    FOREIGN KEY (idPSup_Supplier)
    REFERENCES Suppliers (idSupplier),
  CONSTRAINT fk_Product_Supplier_Product
    FOREIGN KEY (idPSup_Product)
    REFERENCES Products (idProduct)
);

-- -----------------------------------------------------
-- Tabela: Sellers (Vendedores Terceirizados)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Sellers (
  idSeller INT NOT NULL AUTO_INCREMENT,
  CompanyName VARCHAR(255) NOT NULL,
  CNPJ CHAR(14) NULL,
  CPF CHAR(11) NULL,
  Contact VARCHAR(45) NULL,
  PRIMARY KEY (idSeller),
  UNIQUE INDEX CNPJ_UNIQUE_SELLER (CNPJ ASC),
  UNIQUE INDEX CPF_UNIQUE_SELLER (CPF ASC)
);

-- -----------------------------------------------------
-- Tabela: Product_Seller (Produtos por Vendedor)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Product_Seller (
  idPSell_Seller INT NOT NULL,
  idPSell_Product INT NOT NULL,
  Quantity INT NOT NULL,
  PRIMARY KEY (idPSell_Seller, idPSell_Product),
  CONSTRAINT fk_Product_Seller_Seller
    FOREIGN KEY (idPSell_Seller)
    REFERENCES Sellers (idSeller),
  CONSTRAINT fk_Product_Seller_Product
    FOREIGN KEY (idPSell_Product)
    REFERENCES Products (idProduct)
);

-- -----------------------------------------------------
-- SEÇÃO DE PERSISTÊNCIA DE DADOS (INSERTS)
-- -----------------------------------------------------

-- Inserindo Clientes
INSERT INTO Clients (FirstName, LastName, Address, ClientType) VALUES
('Maria', 'Silva', 'Rua das Flores, 123', 'PF'),
('João', 'Santos', 'Avenida Principal, 456', 'PF'),
('Tech Solutions', 'Ltda', 'Rua da Tecnologia, 789', 'PJ'),
('Ana', 'Pereira', 'Travessa dos Sonhos, 101', 'PF');

-- Inserindo Pessoas Físicas
INSERT INTO NaturalPerson (idNaturalPerson, CPF) VALUES
(1, '12345678901'),
(2, '98765432109'),
(4, '11122233344');

-- Inserindo Pessoas Jurídicas
INSERT INTO LegalPerson (idLegalPerson, CNPJ, CompanyName) VALUES
(3, '12345678000199', 'Tech Solutions Ltda');

-- Inserindo Produtos
INSERT INTO Products (ProductName, Category, Description, Price) VALUES
('Smartphone', 'Eletrônicos', 'Smartphone de última geração', 1999.99),
('Notebook', 'Eletrônicos', 'Notebook para trabalho e estudo', 3499.50),
('Livro de SQL', 'Livros', 'Aprenda SQL do básico ao avançado', 89.90),
('Camiseta', 'Vestuário', 'Camiseta de algodão', 49.99);

-- Inserindo Fornecedores
INSERT INTO Suppliers (CompanyName, CNPJ, Contact) VALUES
('Eletrônicos Global', '22334455000188', 'contato@global.com'),
('Editora Saber', '66778899000177', 'vendas@saber.com');

-- Inserindo Vendedores
INSERT INTO Sellers (CompanyName, CNPJ, CPF, Contact) VALUES
('Vende Tudo', '33445566000122', NULL, 'comercial@vendetudo.com'),
('João Vendedor', NULL, '55566677788', 'joao.vendedor@email.com');

-- Inserindo Produtos por Fornecedor
INSERT INTO Product_Supplier (idPSup_Supplier, idPSup_Product) VALUES
(1, 1), (1, 2), (2, 3);

-- Inserindo Produtos por Vendedor
INSERT INTO Product_Seller (idPSell_Seller, idPSell_Product, Quantity) VALUES
(1, 1, 10), (2, 4, 50);

-- Inserindo Estoques
INSERT INTO Stock (Location) VALUES ('São Paulo'), ('Rio de Janeiro');

-- Inserindo Produtos em Estoque
INSERT INTO Product_Stock (idPS_Product, idPS_Stock, Quantity) VALUES
(1, 1, 100), (2, 1, 50), (3, 2, 200), (4, 2, 300);

-- Inserindo Pedidos
INSERT INTO Orders (idOrderClient, OrderStatus, ShippingValue, DeliveryStatus, TrackingCode) VALUES
(1, 'Delivered', 15.50, 'Delivered to recipient', 'BR123456789'),
(2, 'Shipped', 12.00, 'In transit', 'BR987654321'),
(3, 'Processing', 25.00, NULL, NULL),
(1, 'Processing', 10.00, NULL, NULL);

-- Inserindo Produtos nos Pedidos
INSERT INTO Product_Order (idPO_Order, idPO_Product, Quantity) VALUES
(1, 1, 1), (1, 3, 2), (2, 2, 1), (3, 1, 1), (4, 4, 3);

-- Inserindo Pagamentos
INSERT INTO Payments (idPaymentOrder, PaymentType, PaymentValue, PaymentStatus) VALUES
(1, 'Credit Card', 2105.39, 'Approved'),
(2, 'PIX', 3511.50, 'Approved'),
(3, 'Bank Slip', 2024.99, 'Pending');


-- -----------------------------------------------------
-- SEÇÃO DE QUERIES (CONSULTAS)
-- -----------------------------------------------------

-- Pergunta 1: Quantos pedidos foram feitos por cada cliente?
-- Recuperação simples com SELECT, JOIN e agregação com COUNT e GROUP BY.
SELECT 
    c.idClient,
    CONCAT(c.FirstName, ' ', c.LastName) AS ClientName,
    COUNT(o.idOrder) AS NumberOfOrders
FROM Clients c
LEFT JOIN Orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient, ClientName
ORDER BY NumberOfOrders DESC;


-- Pergunta 2: Algum vendedor também é fornecedor?
-- Utiliza JOIN e WHERE para comparar CNPJs entre as tabelas de Vendedores e Fornecedores.
SELECT 
    s.CompanyName AS SellerName,
    sup.CompanyName AS SupplierName,
    s.CNPJ
FROM Sellers s
JOIN Suppliers sup ON s.CNPJ = sup.CNPJ;


-- Pergunta 3: Relação de produtos, fornecedores e estoques.
-- Junção de múltiplas tabelas para criar uma visão complexa.
SELECT 
    p.ProductName,
    p.Category,
    s.CompanyName AS SupplierName,
    st.Location AS StockLocation,
    ps.Quantity AS StockQuantity
FROM Products p
JOIN Product_Supplier psup ON p.idProduct = psup.idPSup_Product
JOIN Suppliers s ON psup.idPSup_Supplier = s.idSupplier
JOIN Product_Stock ps ON p.idProduct = ps.idPS_Product
JOIN Stock st ON ps.idPS_Stock = st.idStock
ORDER BY p.ProductName;


-- Pergunta 4: Relação de nomes dos fornecedores e nomes dos produtos.
-- JOIN simples para listar produtos e seus fornecedores.
SELECT 
    s.CompanyName AS SupplierName,
    p.ProductName
FROM Suppliers s
JOIN Product_Supplier psup ON s.idSupplier = psup.idPSup_Supplier
JOIN Products p ON psup.idPSup_Product = p.idProduct
ORDER BY s.CompanyName, p.ProductName;


-- Pergunta 5: Qual o valor total de pedidos por cliente que foram aprovados?
-- Utiliza JOIN, WHERE para filtrar status, GROUP BY para agrupar e HAVING para filtrar o resultado da agregação.
-- Também cria um atributo derivado (TotalValue).
SELECT 
    c.idClient,
    CONCAT(c.FirstName, ' ', c.LastName) AS ClientName,
    SUM(p.Price * po.Quantity) + o.ShippingValue AS TotalValue
FROM Clients c
JOIN Orders o ON c.idClient = o.idOrderClient
JOIN Product_Order po ON o.idOrder = po.idPO_Order
JOIN Products p ON po.idPO_Product = p.idProduct
JOIN Payments pay ON o.idOrder = pay.idPaymentOrder
WHERE pay.PaymentStatus = 'Approved'
GROUP BY c.idClient, ClientName, o.ShippingValue
HAVING TotalValue > 100
ORDER BY TotalValue DESC;
