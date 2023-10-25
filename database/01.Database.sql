CREATE DATABASE appstore;
USE appstore;

CREATE TABLE categorias (
	idcategoria 	INT PRIMARY KEY AUTO_INCREMENT,
	categoria 		VARCHAR(30)	NOT NULL,
	create_at 		DATETIME		DEFAULT NOW(),
	update_at		DATETIME		NULL,
	inactive_at		DATETIME		NULL
)ENGINE = INNODB;

ALTER TABLE categorias MODIFY inactive_at DATETIME NULL;

CREATE TABLE productos(
	idproducto		INT PRIMARY KEY AUTO_INCREMENT,
	idcategoria 	INT 				NOT NULL,
	descripcion 	VARCHAR(150)	NOT NULL,
	precio			FLOAT(7,2)		NOT NULL,
	garantia		TINYINT 		NOT NULL,
	fotografia		VARCHAR(200)	NULL,
	create_at 		DATETIME		DEFAULT NOW(),
	update_at		DATETIME		NULL,
	inactive_at		DATETIME	 	NULL,
	CONSTRAINT fk_idcategoria FOREIGN KEY (idcategoria) REFERENCES categorias(idcategoria)
)ENGINE = INNODB;

CREATE TABLE roles(
	idrol			INT 			PRIMARY KEY AUTO_INCREMENT,
    rol				CHAR(3) 		NOT NULL, -- ADMINISTRADO => ADM | INVITADO => INV
    create_at 		DATETIME		DEFAULT NOW(),
	update_at		DATETIME		NULL,
	inactive_at		DATETIME	 	NULL
)ENGINE = INNODB;

CREATE TABLE nacionalidades(
	idnacionalidad 	INT 			PRIMARY KEY AUTO_INCREMENT,
    nombrepais		VARCHAR(50)		NOT NULL,
    nombrecorto		CHAR(3)			NOT NULL,
    create_at 		DATETIME		DEFAULT NOW(),
	update_at		DATETIME		NULL,
	inactive_at		DATETIME	 	NULL
)ENGINE = INNODB;


CREATE TABLE usuarios(
	idusuario		INT 			PRIMARY KEY AUTO_INCREMENT,
    idrol 			INT 			NOT NULL, -- FK
    idnacionalidad	INT				NOT NULL,
    avatar			VARCHAR(200)	NULL,
    apellidos		VARCHAR(30)		NOT NULL,
    nombres 		VARCHAR(30)		NOT NULL,
    email			VARCHAR(50)		NOT NULL,
    claveacceso		VARCHAR(100) 	NOT NULL,
    create_at 		DATETIME		DEFAULT NOW(),
	update_at		DATETIME		NULL,
	inactive_at		DATETIME	 	NULL,
    CONSTRAINT fk_idrol_usu			FOREIGN KEY(idrol) REFERENCES roles (idrol),
    CONSTRAINT fk_idnacionalidad_usu FOREIGN KEY(idnacionalidad) REFERENCES nacionalidades (idnacionalidad),
    CONSTRAINT uk_email_usu			UNIQUE(email)
)ENGINE = INNODB;

ALTER TABLE productos MODIFY garantia TINYINT NOT NULL;
ALTER TABLE productos MODIFY fotografia VARCHAR(200) NULL;
ALTER TABLE productos MODIFY inactive_at DATETIME NULL;
ALTER TABLE nacionalidades MODIFY nombrepais VARCHAR(50) NOT NULL;
