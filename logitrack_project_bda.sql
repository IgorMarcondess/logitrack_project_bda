DROP TABLE Clientes CASCADE CONSTRAINTS;
DROP TABLE Entregas CASCADE CONSTRAINTS;
DROP TABLE Historico_entrega CASCADE CONSTRAINTS;
DROP TABLE Motoristas CASCADE CONSTRAINTS;
DROP TABLE Status_entregas CASCADE CONSTRAINTS;
DROP TABLE Veiculos CASCADE CONSTRAINTS;
DROP SEQUENCE seq_entregas;
DROP PROCEDURE registrar_entrega;
DROP FUNCTION verificar_cliente;
DROP FUNCTION atribuir_veiculo_entrega


CREATE TABLE Clientes ( 
    id_clie       NUMBER (4)    CONSTRAINT cliente_id_pk_nn  PRIMARY KEY NOT NULL ,
    nome_clie     VARCHAR2 (35) CONSTRAINT cliente_nome_nn   NOT NULL , 
    CNPJ_clie     VARCHAR2 (14) CONSTRAINT cliente_cnpj_nn NOT NULL , 
    segmento_clie VARCHAR2 (45) CONSTRAINT cliente_seg NOT NULL
    );

CREATE TABLE Entregas( 
    id_ent           NUMBER (4)    CONSTRAINT entregas_id_pk_nn PRIMARY KEY NOT NULL, 
    tipo             VARCHAR2 (15) CONSTRAINT entregas_tipo_nn NOT NULL, 
    veiculo          VARCHAR2 (35) CONSTRAINT entregas_veiculos NULL,
    fk_cliente       NUMBER (4)    CONSTRAINT fk_cliente_id REFERENCES Clientes
    );
    
CREATE TABLE Status_entregas( 
     id_ent            NUMBER(4)       CONSTRAINT status_ent_id_pk_nn PRIMARY KEY NOT NULL,
     status            VARCHAR2 (35)   CONSTRAINT status_pk_nn NOT NULL,
     CONSTRAINT fk_id_ent FOREIGN KEY (id_ent) REFERENCES Entregas(id_ent)
    )

CREATE TABLE Veiculos( 
     id_vei   NUMBER (4)    CONSTRAINT veiculos_id_pk_nn PRIMARY KEY NOT NULL , 
     tipo_vei VARCHAR2 (35) CONSTRAINT veiculos_tipo_nn NOT NULL, 
     ano_vei  NUMBER (4)    CONSTRAINT veiculos_ano_nn  NOT NULL
    ) 
    
CREATE TABLE Historico_entrega( 
    id_status           NUMBER(4)       CONSTRAINT hist_ent_id_pk_nn REFERENCES Status_entregas,
    data_status         DATE            CONSTRAINT data_status_nn NOT NULL, 
    status              VARCHAR2 (35)   CONSTRAINT status_fk NOT NULL
    ) 

CREATE TABLE Motoristas ( 
     id_mot          NUMBER (4)     CONSTRAINT motorista_id_pk_nn PRIMARY KEY NOT NULL , 
     nome_mot        VARCHAR2 (45)  CONSTRAINT nome_motorista_nn NOT NULL, 
     carteira_mot    CHAR (1)       CONSTRAINT carteira_motorista_nn NOT NULL , 
     fk_veiculo      NUMBER (4)     CONSTRAINT veiculo_motorista_fk REFERENCES Veiculos
    ) 

CREATE SEQUENCE seq_entregas START WITH 1 INCREMENT BY 1; --CRIANDO UMA SEQUENCIA PARA INCREMENTAR OS IDs

INSERT INTO Clientes values (1, 'Dom Julio', '12345678900000', 'alimenticio');

INSERT INTO Veiculos values (1, 'Tipo A', 2020);
INSERT INTO Veiculos values (2, 'Tipo B', 2025);

INSERT INTO Entregas values (1, 'Entrega Rápida', null, 1);
INSERT INTO Entregas values (2, 'Entrega Rápida', null, 1);

INSERT INTO Status_entregas values (1, 'Entrega dentro do prazo');
INSERT INTO Status_entregas values (2, 'Entrega Atrasada');


select * from Clientes;
select * from Entregas;
select * from Status_entregas
