-- Criação do Banco de Dados
CREATE DATABASE BancoClientes;
USE BancoClientes;

-- Criação das Tabelas

-- Tabela de Clientes
CREATE TABLE Clientes (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    CPF VARCHAR(11) UNIQUE,
    data_nascimento DATE
);

-- Tabela de Contas Correntes
CREATE TABLE ContasCorrentes (
    idConta INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    saldo DECIMAL(10, 2),
    limiteCredito DECIMAL(10, 2) DEFAULT 0,
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
);

-- Tabela de Movimentações Financeiras
CREATE TABLE Movimentacoes (
    idMovimentacao INT AUTO_INCREMENT PRIMARY KEY,
    idConta INT,
    tipoMovimentacao ENUM('Deposito', 'Saque'),
    valor DECIMAL(10, 2),
    data DATE,
    FOREIGN KEY (idConta) REFERENCES ContasCorrentes(idConta)
);

-- Criação dos Usuários

-- Usuário Administrador
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'senhaAdmin';
GRANT ALL PRIVILEGES ON BancoClientes.* TO 'admin'@'localhost';

-- Usuário Correntista
CREATE USER 'correntista'@'localhost' IDENTIFIED BY 'senhaCorrentista';
GRANT SELECT, INSERT ON BancoClientes.* TO 'correntista'@'localhost';

-- Popular o Banco com 4 Clientes

-- Cliente 1 (Conta Especial)
INSERT INTO Clientes (nome, CPF, data_nascimento) 
VALUES ('João da Silva', '12345678901', '1990-05-15');

-- Conta Corrente do Cliente 1
INSERT INTO ContasCorrentes (idCliente, saldo, limiteCredito) 
VALUES (1, 1000.00, 5000.00);

-- Movimentações do Cliente 1
INSERT INTO Movimentacoes (idConta, tipoMovimentacao, valor, data) 
VALUES (1, 'Deposito', 1000.00, '2025-01-10');

INSERT INTO Movimentacoes (idConta, tipoMovimentacao, valor, data) 
VALUES (1, 'Saque', 500.00, '2025-01-12');

INSERT INTO Movimentacoes (idConta, tipoMovimentacao, valor, data) 
VALUES (1, 'Deposito', 2000.00, '2025-01-15');

-- Cliente 2 (Conta Convencional)
INSERT INTO Clientes (nome, CPF, data_nascimento) 
VALUES ('Maria Souza', '23456789012', '1985-03-22');

-- Conta Corrente do Cliente 2
INSERT INTO ContasCorrentes (idCliente, saldo, limiteCredito) 
VALUES (2, 1500.00, 0.00);

-- Movimentações do Cliente 2
INSERT INTO Movimentacoes (idConta, tipoMovimentacao, valor, data) 
VALUES (2, 'Saque', 200.00, '2025-02-10');

INSERT INTO Movimentacoes (idConta, tipoMovimentacao, valor, data) 
VALUES (2, 'Deposito', 1500.00, '2025-02-12');

INSERT INTO Movimentacoes (idConta, tipoMovimentacao, valor, data) 
VALUES (2, 'Saque', 800.00, '2025-02-15');

-- Cliente 3 (Conta Convencional)
INSERT INTO Clientes (nome, CPF, data_nascimento) 
VALUES ('Carlos Pereira', '34567890123', '1992-07-08');

-- Conta Corrente do Cliente 3
INSERT INTO ContasCorrentes (idCliente, saldo, limiteCredito) 
VALUES (3, 3000.00, 0.00);

-- Movimentações do Cliente 3
INSERT INTO Movimentacoes (idConta, tipoMovimentacao, valor, data) 
VALUES (3, 'Deposito', 1500.00, '2025-03-05');

INSERT INTO Movimentacoes (idConta, tipoMovimentacao, valor, data) 
VALUES (3, 'Saque', 1000.00, '2025-03-10');

INSERT INTO Movimentacoes (idConta, tipoMovimentacao, valor, data) 
VALUES (3, 'Saque', 500.00, '2025-03-12');

-- Cliente 4 (Conta Convencional)
INSERT INTO Clientes (nome, CPF, data_nascimento) 
VALUES ('Ana Oliveira', '45678901234', '1998-11-25');

-- Conta Corrente do Cliente 4
INSERT INTO ContasCorrentes (idCliente, saldo, limiteCredito) 
VALUES (4, 500.00, 0.00);

-- Movimentações do Cliente 4
INSERT INTO Movimentacoes (idConta, tipoMovimentacao, valor, data) 
VALUES (4, 'Saque', 100.00, '2025-04-01');

INSERT INTO Movimentacoes (idConta, tipoMovimentacao, valor, data) 
VALUES (4, 'Deposito', 800.00, '2025-04-03');

INSERT INTO Movimentacoes (idConta, tipoMovimentacao, valor, data) 
VALUES (4, 'Saque', 200.00, '2025-04-07');

-- Commit para garantir que as alterações sejam aplicadas
COMMIT;

SELECT user, host FROM mysql.user;

SHOW GRANTS FOR 'admin'@'localhost';

SHOW GRANTS FOR 'correntista'@'localhost';

SELECT * FROM Movimentacoes WHERE idConta = 1;

SELECT c.nome, cc.saldo, cc.limiteCredito, m.tipoMovimentacao, m.valor, m.data
FROM Clientes c
JOIN ContasCorrentes cc ON c.idCliente = cc.idCliente
JOIN Movimentacoes m ON cc.idConta = m.idConta
ORDER BY c.nome, m.data;


SELECT nome, limiteCredito, saldo FROM Clientes c
JOIN ContasCorrentes cc ON c.idCliente = cc.idCliente
WHERE cc.limiteCredito > 0;




























