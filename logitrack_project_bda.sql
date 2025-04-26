DROP TABLE Clientes CASCADE CONSTRAINTS;
DROP TABLE Entregas CASCADE CONSTRAINTS;
DROP TABLE Historico_entregas CASCADE CONSTRAINTS;
DROP TABLE Motoristas CASCADE CONSTRAINTS;
DROP TABLE Status_entregas CASCADE CONSTRAINTS;
DROP TABLE Veiculos CASCADE CONSTRAINTS;
DROP SEQUENCE seq_entregas;
DROP PROCEDURE registrar_entrega;
DROP PROCEDURE atribuir_veiculo_entrega;
DROP PROCEDURE verificar_status;
DROP FUNCTION verificar_cliente;
DROP FUNCTION atribuir_veiculo_entrega;
DROP TRIGGER Historico_entregas;


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
    
CREATE TABLE Historico_entregas( 
    id_status           NUMBER(4)       CONSTRAINT hist_ent_id_pk_nn NOT NULL,
    data_status         DATE            CONSTRAINT data_status_nn NOT NULL, 
    status              VARCHAR2 (35)   CONSTRAINT status_fk NOT NULL,
    operacao            VARCHAR  (35) NOT NULL
    ) 

CREATE TABLE Motoristas ( 
     id_mot          NUMBER (4)     CONSTRAINT motorista_id_pk_nn PRIMARY KEY NOT NULL , 
     nome_mot        VARCHAR2 (45)  CONSTRAINT nome_motorista_nn NOT NULL, 
     carteira_mot    CHAR (1)       CONSTRAINT carteira_motorista_nn NOT NULL , 
     fk_veiculo      NUMBER (4)     CONSTRAINT veiculo_motorista_fk REFERENCES Veiculos
    ) 

CREATE SEQUENCE seq_entregas START WITH 1 INCREMENT BY 1; --CRIANDO UMA SEQUENCIA PARA INCREMENTAR OS IDs

-- CLIENTES
INSERT INTO Clientes values (1, 'Dom Julio', '12345678900000', 'alimenticio');

-- VEÍCULOS
INSERT INTO Veiculos values (1, 'Tipo A', 2020);
INSERT INTO Veiculos values (2, 'Tipo B', 2025);

-- INSERTS E UPDATES PARA TESTAR A TRIGGERS DE AUDITORIA DE ENTREGAS
INSERT INTO Status_entregas values (4, 'Entrega dentro do prazo');
UPDATE Status_entregas SET status = 'Entrega Atrasada' WHERE id_ent = 4;
INSERT INTO Status_entregas values (2, 'Entrega Atrasada');

-- SELECTS NECESSÁRIOS PARRA VISUALIZAÇÃO
select * from Clientes;
select * from Entregas;
select * from Status_entregas;
select * from Historico_entregas

