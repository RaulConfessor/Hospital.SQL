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
);----------+-------------------------+------+-----+---------+----------------+
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
	ID_PACINTE INT NOT NULL,
	ID_MEDICO INT NOT NULL,
	ID_HOSPITAL INT NOT NULL,
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



SELECT IDPACIENTE, NOME, CPF, NASCIMENTO, NUMERO, TIPO
FROM PACIENTE
INNER JOIN CONTATO
ON IDPACIENTE = ID_PACIENTE;

+------------+----------------+----------------+------------+-----------+------+
| IDPACIENTE | NOME           | CPF            | NASCIMENTO | NUMERO    | TIPO |
+------------+----------------+----------------+------------+-----------+------+
|          1 | João Silva     | 123.456.789-01 | 1990-05-15 | 1234-5678 | RES  |
|          2 | Maria Oliveira | 987.654.321-02 | 1985-08-22 | 9876-5432 | TEL  |
|          2 | Maria Oliveira | 987.654.321-02 | 1985-08-22 | 555-1234  | TEL  |
|          3 | Carlos Souza   | 456.789.012-03 | 1995-03-10 | 555-1234  | COM  |
|          3 | Carlos Souza   | 456.789.012-03 | 1995-03-10 | 8888-9999 | TEL  |
|          4 | Ana Pereira    | 789.012.345-04 | 1980-11-27 | 8888-9999 | RES  |
|          5 | Pedro Santos   | 234.567.890-05 | 2000-07-08 | 4444-3333 | COM  |
+------------+----------------+----------------+------------+-----------+------+

SELECT IDPACIENTE, P.NOME,M.NOME AS MEDICO,H.NOME AS HOSPITAL, DIAGNOSTICO, IFNULL(ENTRADA, '-----') AS INTERACAO
FROM CONSULTA
INNER JOIN PACIENTE P 
ON IDPACIENTE = ID_PACINTE
INNER JOIN MEDICO M 
ON IDMEDICO = ID_MEDICO
INNER JOIN HOSPITAL H
ON IDHOSPITAL = ID_HOSPITAL
LEFT JOIN INTERNACAO
ON IDCONSULTA = ID_CONSULTA;

+------------+----------------+--------------+--------------------+--------------------+---------------------+
| IDPACIENTE | NOME           | MEDICO       | HOSPITAL           | DIAGNOSTICO        | INTERACAO           |
+------------+----------------+--------------+--------------------+--------------------+---------------------+
|          1 | João Silva     | Dr. Silva    | Hospital Central   | Nova consulta      | -----               |
|          1 | João Silva     | Dr. Silva    | Hospital Central   | Consulta de rotina | -----               |
|          2 | Maria Oliveira | Dra. Santos  | Hospital Regional  | Dor no joelho      | 2024-02-15 08:30:00 |
|          3 | Carlos Souza   | Dr. Oliveira | Hospital Municipal | Exame de sangue    | -----               |
|          4 | Ana Pereira    | Dra. Pereira | Hospital Municipal | Vacinação          | -----               |
+------------+----------------+--------------+--------------------+--------------------+---------------------+

SELECT IDPACIENTE, P.NOME, H.NOME, ESTADO
FROM CONSULTA
INNER JOIN PACIENTE P 
ON IDPACIENTE = ID_PACINTE
INNER JOIN HOSPITAL H 
ON IDHOSPITAL = ID_HOSPITAL
WHERE ESTADO = 'MG';

+------------+--------------+--------------------+--------+
| IDPACIENTE | NOME         | NOME               | ESTADO |
+------------+--------------+--------------------+--------+
|          3 | Carlos Souza | Hospital Municipal | MG     |
|          4 | Ana Pereira  | Hospital Municipal | MG     |
+------------+--------------+--------------------+--------+