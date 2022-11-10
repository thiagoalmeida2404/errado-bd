
CREATE TABLE hr.cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo NUMERIC(8,2),
                salario_maximo NUMERIC(8,2),
                CONSTRAINT cargos PRIMARY KEY (id_cargo)
);


CREATE UNIQUE INDEX __ak__
 ON hr.cargos
 ( cargo );

CREATE TABLE hr.regioes (
                id_regiao: INTEGER NOT NULL,
                nome VARCHAR(25) NOT NULL,
                CONSTRAINT id_regiao__integer_not_null PRIMARY KEY (id_regiao:)
);
COMMENT ON TABLE hr.regioes IS 'id_regiao: integer not null (PK)
nome: varchar(25) not null (AK)';


CREATE UNIQUE INDEX __ak__
 ON hr.regioes
 ( nome );

CREATE TABLE hr.paises (
                id_pais CHAR(2) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                id_regiao INTEGER,
                CONSTRAINT paises PRIMARY KEY (id_pais)
);


CREATE UNIQUE INDEX __ak__
 ON hr.paises
 ( nome );

CREATE TABLE hr.localizaçoes (
                id_localizaçao INTEGER NOT NULL,
                endereço VARCHAR(50) NOT NULL,
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_pais CHAR(2),
                CONSTRAINT localiza_oes PRIMARY KEY (id_localizaçao)
);


CREATE TABLE hr.departamentos (
                id_departamentos INTEGER NOT NULL,
                nome VARCHAR(50),
                id_localizaçao INTEGER,
                id_gerente INTEGER,
                CONSTRAINT departamentos PRIMARY KEY (id_departamentos)
);


CREATE UNIQUE INDEX __ak__
 ON hr.departamentos
 ( nome );

CREATE TABLE hr.empregados (
                id_empregado INTEGER NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario NUMERIC(8,2),
                comissao NUMERIC(4,2),
                id_departamentos INTEGER,
                id_supervisor INTEGER,
                CONSTRAINT empregados PRIMARY KEY (id_empregado)
);


CREATE UNIQUE INDEX __ak__
 ON hr.empregados
 ( email );

CREATE TABLE hr.historico_cargos (
                id_empregado INTEGER NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_departamento INTEGER NOT NULL,
                id_cargo VARCHAR NOT NULL,
                id_departamentos INTEGER NOT NULL,
                CONSTRAINT historico_cargos PRIMARY KEY (id_empregado, data_inicial)
);


ALTER TABLE hr.historico_cargos ADD CONSTRAINT cargos_historico_cargos_fk
FOREIGN KEY (id_cargo)
REFERENCES hr.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES hr.cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (id_regiao)
REFERENCES hr.regioes (id_regiao:)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.localizaçoes ADD CONSTRAINT paises_localiza_oes_fk
FOREIGN KEY (id_pais)
REFERENCES hr.paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.departamentos ADD CONSTRAINT localiza_oes_departamentos_fk
FOREIGN KEY (id_localizaçao)
REFERENCES hr.localizaçoes (id_localizaçao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT departamentos_historico_cargos_fk
FOREIGN KEY (id_departamentos)
REFERENCES hr.departamentos (id_departamentos)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamentos)
REFERENCES hr.departamentos (id_departamentos)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE hr.historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES hr.empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
