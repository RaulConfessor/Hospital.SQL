CREATE DATABASE HOSPITAL;

USE HOSPITAL;

CREATE TABLE PACIENTE(
	IDPACIENTE INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	CPF VARCHAR(20) UNIQUE,
	SEXO CHAR(1) NOT NULL,
	NASCIMENTO DATE
);

+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| IDPACIENTE | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME       | varchar(30) | NO   |     | NULL    |                |
| CPF        | varchar(20) | YES  | UNI | NULL    |                |
| SEXO       | char(1)     | NO   |     | NULL    |                |
| NASCIMENTO | date        | YES  |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+

CREATE TABLE CONTATO(
	IDCONTATO INT PRIMARY KEY AUTO_INCREMENT,
	TIPO ENUM('RES','TEL','COM') NOT NULL,
	NUMERO VARCHAR(20) NOT NULL,
	ID_PACIENTE INT
);

+-------------+-------------------------+------+-----+---------+----------------+
| Field       | Type                    | Null | Key | Default | Extra          |
+-------------+-------------------------+------+-----+---------+----------------+
| IDCONTATO   | int(11)                 | NO   | PRI | NULL    | auto_increment |
| TIPO        | enum('RES','TEL','COM') | NO   |     | NULL    |                |
| NUMERO      | varchar(20)             | NO   |     | NULL    |                |
| ID_PACIENTE | int(11)                 | YES  | MUL | NULL    |                |
+-------------+-------------------------+------+-----+---------+----------------+

ALTER TABLE CONTATO ADD CONSTRAINT FK_CONTATO_PACIENTE
FOREIGN KEY(ID_PACIENTE) REFERENCES PACIENTE(IDPACIENTE);

CREATE TABLE MEDICO(
	IDMEDICO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	CPF VARCHAR(20) NOT NULL UNIQUE,
	FUNCIONARIO ENUM('S','N')
);

+-------------+---------------+------+-----+---------+----------------+
| Field       | Type          | Null | Key | Default | Extra          |
+-------------+---------------+------+-----+---------+----------------+
| IDMEDICO    | int(11)       | NO   | PRI | NULL    | auto_increment |
| NOME        | varchar(30)   | NO   |     | NULL    |                |
| CPF         | varchar(20)   | NO   | UNI | NULL    |                |
| FUNCIONARIO | enum('S','N') | YES  |     | NULL    |                |
+-------------+---------------+------+-----+---------+----------------+

CREATE TABLE ESPECIALIDADE(
	IDESPECIALIDADE INT PRIMARY KEY AUTO_INCREMENT,
	ESPECIALIDADE VARCHAR(20) NOT NULL UNIQUE,
	ID_MEDICO INT
);

+-----------------+-------------+------+-----+---------+----------------+
| Field           | Type        | Null | Key | Default | Extra          |
+-----------------+-------------+------+-----+---------+----------------+
| IDESPECIALIDADE | int(11)     | NO   | PRI | NULL    | auto_increment |
| ESPECIALIDADE   | varchar(20) | NO   | UNI | NULL    |                |
| ID_MEDICO       | int(11)     | YES  | MUL | NULL    |                |
+-----------------+-------------+------+-----+---------+----------------+

ALTER TABLE ESPECIALIDADE ADD CONSTRAINT FK_ESPECIALIDADE_MEDICO
FOREIGN KEY(ID_MEDICO) REFERENCES MEDICO(IDMEDICO);

CREATE TABLE HOSPITAL(
	IDHOSPITAL INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(25) NOT NULL,
	BAIRRO VARCHAR(30) NOT NULL,
	CIDADE VARCHAR(15) NOT NULL,
	ESTADO CHAR(2) NOT NULL
);

+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| IDHOSPITAL | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME       | varchar(25) | NO   |     | NULL    |                |
| BAIRRO     | varchar(30) | NO   |     | NULL    |                |
| CIDADE     | varchar(15) | NO   |     | NULL    |                |
| ESTADO     | char(2)     | NO   |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+

CREATE TABLE CONSULTA(
	IDCONSULTA INT PRIMARY KEY AUTO_INCREMENT,
	ID_PACINTE INT NOT NULL UNIQUE,
	ID_MEDICO INT NOT NULL UNIQUE,
	ID_HOSPITAL INT NOT NULL UNIQUE,
	DATA DATETIME,
	DIAGNOSTICO VARCHAR(50)
);

+-------------+-------------+------+-----+---------+----------------+
| Field       | Type        | Null | Key | Default | Extra          |
+-------------+-------------+------+-----+---------+----------------+
| IDCONSULTA  | int(11)     | NO   | PRI | NULL    | auto_increment |
| ID_PACINTE  | int(11)     | NO   | UNI | NULL    |                |
| ID_MEDICO   | int(11)     | NO   | UNI | NULL    |                |
| ID_HOSPITAL | int(11)     | NO   | UNI | NULL    |                |
| DATA        | datetime    | YES  |     | NULL    |                |
| DIAGNOSTICO | varchar(50) | YES  |     | NULL    |                |
+-------------+-------------+------+-----+---------+----------------+

ALTER TABLE CONSULTA ADD CONSTRAINT FK_CONSULTA_PACIENTE
FOREIGN KEY(ID_PACIENTE) REFERENCES PACIENTE(IDPACIENTE);

ALTER TABLE CONSULTA ADD CONSTRAINT FK_CONSULTA_MEDICO
FOREIGN KEY(ID_MEDICO) REFERENCES MEDICO(IDMEDICO);

ALTER TABLE CONSULTA ADD CONSTRAINT FK_CONSULTA_HOSPITAL
FOREIGN KEY(ID_HOSPITAL) REFERENCES HOSPITAL(IDHOSPITAL);

CREATE TABLE INTERNACAO(
	IDINTERNACAO INT PRIMARY KEY AUTO_INCREMENT,
	ENTRADA DATETIME NOT NULL,
	QUARTO INT NOT NULL,
	SAIDA DATETIME NOT NULL,
	ID_CONSULTA INT
);

+--------------+----------+------+-----+---------+----------------+
| Field        | Type     | Null | Key | Default | Extra          |
+--------------+----------+------+-----+---------+----------------+
| IDINTERNACAO | int(11)  | NO   | PRI | NULL    | auto_increment |
| ENTRADA      | datetime | NO   |     | NULL    |                |
| QUARTO       | int(11)  | NO   |     | NULL    |                |
| SAIDA        | datetime | NO   |     | NULL    |                |
| ID_CONSULTA  | int(11)  | YES  | MUL | NULL    |                |
+--------------+----------+------+-----+---------+----------------+

ALTER TABLE INTERNACAO ADD CONSTRAINT FK_INTERNACAO_CONSULTA
FOREIGN KEY(ID_CONSULTA) REFERENCES CONSULTA(IDCONSULTA);

INSERT INTO PACIENTE (NOME, CPF, SEXO, NASCIMENTO) VALUES
    ('João Silva', '123.456.789-01', 'M', '1990-05-15'),
    ('Maria Oliveira', '987.654.321-02', 'F', '1985-08-22'),
    ('Carlos Souza', '456.789.012-03', 'M', '1995-03-10'),
    ('Ana Pereira', '789.012.345-04', 'F', '1980-11-27'),
    ('Pedro Santos', '234.567.890-05', 'M', '2000-07-08');