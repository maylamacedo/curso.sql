use softblue2;

CREATE TABLE Tipo (
					codigo integer unsigned not null auto_increment,
                    tipo varchar(32) not null,
                    primary key (codigo)
);
ALTER TABLE tipo CHANGE COLUMN id_c id_t integer unsigned not null auto_increment;

CREATE TABLE Curso (
					codigo integer unsigned not null auto_increment,
					curso varchar(32) not null,
					tipo integer unsigned not null,
                    valor double not null,
                    instrutor integer unsigned not null,
					primary key (codigo),
                    index fk_tipo(tipo),
                    index fk_instrutor(instrutor),
                    foreign key (tipo) references tipo (codigo),
                    foreign key (instrutor) references instrutor (codigo)
);
ALTER TABLE curso CHANGE COLUMN codigo id_c integer unsigned not null auto_increment;
ALTER TABLE curso CHANGE COLUMN tipo id_t integer unsigned not null;
ALTER TABLE curso CHANGE COLUMN instrutor id_i integer unsigned not null;

CREATE TABLE Aluno (
					codigo integer unsigned not null auto_increment,
					aluno varchar(64) not null,
					endereço varchar(230) not null,
                    email varchar(128) not null,
					primary key (codigo)
);
ALTER TABLE aluno CHANGE COLUMN codigo id_a integer unsigned not null auto_increment;
CREATE TABLE Pedido (
					codigo integer unsigned not null auto_increment,
					aluno integer unsigned not null,
                    datahora datetime not null,
					primary key (codigo),
                    index fk_aluno(aluno),
                    foreign key (aluno) references aluno (codigo)
);
ALTER TABLE pedido CHANGE COLUMN codigo id_p integer unsigned not null auto_increment;
ALTER TABLE pedido CHANGE COLUMN aluno id_a integer unsigned not null;

ALTER TABLE tipo CHANGE COLUMN tipo tipo_c varchar(32) not null;
ALTER TABLE tipo CHANGE COLUMN tipo_c tipo varchar(32) not null;

CREATE INDEX aluno ON Aluno (aluno(6));

ALTER TABLE aluno ADD COLUMN data_nascimento varchar(10); 
ALTER TABLE aluno CHANGE COLUMN data_nascimento nascimento date; 

ALTER TABLE instrutor ADD COLUMN email varchar(100); 

CREATE INDEX instrutor ON curso (instrutor);

ALTER TABLE instrutor DROP COLUMN email;

DELETE FROM tipo WHERE codigo = 1;
DELETE FROM tipo WHERE codigo = 2;
DELETE FROM tipo WHERE codigo = 3;

INSERT INTO tipo (codigo, tipo) values (1, 'Banco de dados');
INSERT INTO tipo (codigo, tipo) values (2, 'Programação');
INSERT INTO tipo (codigo, tipo) values (3, 'Modelagem de dados');

SELECT * FROM tipo; -- mostra a tabela 

INSERT INTO instrutor (instrutor, telefone) values ( 'André Milani', '1111-1111');
INSERT INTO instrutor (instrutor, telefone) values ( 'Carlos Tosin', '1212-1212');

SELECT * FROM curso;

INSERT INTO curso (curso, id_t, id_i, valor) VALUES ('Java Fundamentos', 2, 2, 270);
INSERT INTO curso (curso, id_t, id_i, valor) VALUES ('Java Avançado', 2, 2, 330);
INSERT INTO curso (curso, id_t, id_i, valor) VALUES ('SQL Completo', 1, 1, 170);
INSERT INTO curso (curso, id_t, id_i, valor) VALUES ('Php Básico', 2, 1, 270);

INSERT INTO aluno (aluno, endereço, email) VALUES ('José', 'Rua XV de Novembro 72', 'jose@softblue.com.br');
INSERT INTO aluno (aluno, endereço, email) VALUES ('Wagner', 'Av. Paulista', 'wagner@softblue.com.br');
INSERT INTO aluno (aluno, endereço, email) VALUES ('Emílio', 'Rua Lajes 103', 'emilio@softblue.com.br');
INSERT INTO aluno (aluno, endereço, email) VALUES ('Cris', 'Rua Tauney 22', 'cris@softblue.com.br');
INSERT INTO aluno (aluno, endereço, email) VALUES ('Regina', 'Rua Salles 305', 'regina@softblue.com.br');
INSERT INTO aluno (aluno, endereço, email) VALUES (' Fernando', 'Av. Central 30', 'fernando@softblue.com.br');

SELECT * FROM aluno;

INSERT INTO pedido (id_a, datahora) VALUES (2, '2010-04-15 11:23:32'); -- 15/04/2010, 11:23:32 trocar formato
INSERT INTO pedido (id_a, datahora) VALUES (2, '2010-04-15 14:36:21');
INSERT INTO pedido (id_a, datahora) VALUES (3, '2010-04-16 11:17:45');
INSERT INTO pedido (id_a, datahora) VALUES (4, '2010-04-17 14:27:22');
INSERT INTO pedido (id_a, datahora) VALUES (5, '2010-04-18 11:18:19');
INSERT INTO pedido (id_a, datahora) VALUES (6, '2010-04-19 13:47:35');
INSERT INTO pedido (id_a, datahora) VALUES (6, '2010-04-20 18:13:44');

SELECT curso, valor from curso c WHERE c.valor > 200;
SELECT curso, valor from curso c WHERE c.valor > 200 AND c.valor < 300;
-- OU: SELECT curso, valor from curso WHERE valor BETWEEN 200 AND 300;

SELECT * from pedido p WHERE datahora > '2010-04-15' AND datahora < '2010-04-18';
-- OU: SELECT * from pedido p WHERE datahora BETWEEN '2010-04-15' AND '2010-04-18';

SELECT * FROM pedido p WHERE date(datahora) = '2010-04-15';

UPDATE aluno SET endereço = 'Av. Brasil 778' WHERE id_a = 1;
UPDATE aluno SET email = 'cris@softblue.com.br' WHERE aluno = 'Cris';
UPDATE curso SET valor = ROUND(valor * 1.1, 2) WHERE valor < 300;
SET SQL_SAFE_UPDATES = 0;
UPDATE curso SET curso = 'Php Fundamentos' WHERE curso = 'Php Básico';

SELECT * FROM curso;
SELECT * FROM tipo;

SELECT curso.curso, tipo.tipo FROM curso INNER JOIN tipo ON curso.id_c = tipo.id_t;
SELECT curso.curso, tipo.tipo, instrutor.instrutor, instrutor.telefone FROM curso INNER JOIN tipo ON curso.id_c = tipo.id_t INNER JOIN instrutor ON curso.id_c = instrutor.id_i;
SELECT pedido.id_p, pedido.datahora, curso.id_c FROM pedido INNER JOIN curso ON pedido.id_p = curso.id_c;
SELECT pedido.id_p, pedido.datahora, curso.curso FROM pedido INNER JOIN curso ON pedido.id_p = curso.id_c;
SELECT pedido.id_p, pedido.datahora, curso.curso, aluno.aluno FROM pedido INNER JOIN curso ON pedido.id_p = curso.id_c INNER JOIN aluno ON aluno.id_a = pedido.id_p;

CREATE VIEW CP AS SELECT curso, valor FROM curso INNER JOIN tipo ON curso.id_c = tipo.id_t WHERE tipo.tipo = 'Programação';
DROP VIEW cursos_programação;
select * from cp;

CREATE VIEW nome_ins AS
SELECT curso.curso, tipo.tipo, instrutor.instrutor FROM curso 
INNER JOIN tipo ON curso.id_c = tipo.id_t 
INNER JOIN instrutor ON instrutor.id_i = tipo.id_t;

select * from nome_ins;

CREATE VIEW ped_alu AS
SELECT pedido.id_p, aluno.aluno, pedido.datahora FROM pedido
INNER JOIN aluno ON aluno.id_a = pedido.id_p;

select * from ped_alu;

SELECT * FROM tipo LEFT JOIN pedido ON tipo.id_t = pedido.id_a;

SELECT DISTINCT aluno FROM aluno;
SELECT aluno.aluno FROM pedido INNER JOIN aluno ON pedido.id_p = aluno.id_a ORDER BY datahora ASC LIMIT 1;
SELECT aluno.aluno FROM pedido INNER JOIN aluno ON pedido.id_p = aluno.id_a ORDER BY datahora DESC LIMIT 1;
SELECT aluno.aluno FROM pedido INNER JOIN aluno ON pedido.id_p = aluno.id_a ORDER BY datahora LIMIT 1 OFFSET 2;
SELECT COUNT(*) FROM pedido;
SELECT MAX(Valor) FROM curso;
SELECT MIN(Valor) FROM curso;
SELECT instrutor.instrutor, COUNT(*) FROM curso INNER JOIN instrutor ON curso.id_c = instrutor.id_i GROUP BY instrutor;
SELECT aluno, endereço FROM aluno WHERE endereço LIKE 'Av%';
SELECT curso FROM curso WHERE curso LIKE '%java%';

SELECT curso.curso, tipo.tipo FROM curso INNER JOIN tipo ON tipo.id_t = curso.id_c WHERE tipo IN ('Programação');
SELECT curso FROM curso WHERE EXISTS (SELECT tipo FROM tipo WHERE tipo.id_t = curso.id_c AND tipo.tipo = 'Programação');

