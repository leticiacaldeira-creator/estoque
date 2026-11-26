CREATE DATABASE IF NOT EXISTS estoque
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE estoque;

CREATE TABLE IF NOT EXISTS usuarios (
    id      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50)  NOT NULL UNIQUE,
    senha   VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS produtos (
    id             INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome           VARCHAR(100)  NOT NULL,
    preco          DECIMAL(10,2) NOT NULL DEFAULT 0,
    quantidade     INT UNSIGNED  NOT NULL DEFAULT 0,
    estoque_minimo INT UNSIGNED  NOT NULL DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS movimentacoes (
    id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    produto_id INT UNSIGNED NOT NULL,
    usuario_id INT UNSIGNED NOT NULL,
    tipo       ENUM('entrada', 'saida') NOT NULL,
    quantidade INT UNSIGNED NOT NULL,
    criado_em  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (produto_id) REFERENCES produtos (id) ON DELETE CASCADE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
) ENGINE=InnoDB;

-- Usuário inicial: admin / admin123 (troque a senha antes de usar de verdade)
INSERT IGNORE INTO usuarios (usuario, senha)
VALUES ('admin', '$2y$10$ZN7nXgSxTE9NV70vVjHi0efki3bbRold.qiJe5skEC8IpVHJCIi0m')