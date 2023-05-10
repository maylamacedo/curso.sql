USE softblue2;

CREATE TABLE pedidos
(
	id int unsigned not null auto_increment,
    descrição varchar(100) not null,
    vlor double not null default '0',
    pago varchar(3) not null default 'Não',
    PRIMARY KEY (id)
);

INSERT INTO pedidos (descrição, vlor) VALUES ('TV', 3000);
INSERT INTO pedidos (descrição, vlor) VALUES ('Geldeira', 1400);
INSERT INTO pedidos (descrição, vlor) VALUES ('DVD', 300);

CREATE TABLE estoque
(
	id int unsigned not null auto_increment,
    descrição varchar(50) not null,
    quantidade int not null,
    PRIMARY KEY (id)
);

CREATE TRIGGER gat_limpa_pedidos
BEFORE INSERT 
ON estoque 
FOR EACH ROW 
CALL limpa_pedidos(); 

INSERT INTO estoque(descrição, quantidade) VALUES ('fogão', 5);

UPDATE pedidos SET pago = 'Sim' WHERE id = 8;

INSERT INTO estoque(descrição, quantidade) VALUES ('forno', 3);

SELECT * FROM pedidos;
SELECT * FROM estoque;
CALL limpa_pedidos();
