
DROP TABLE Clientes CASCADE CONSTRAINTS;
DROP TABLE Entregas CASCADE CONSTRAINTS;
DROP TABLE Historico_entrega CASCADE CONSTRAINTS;
DROP TABLE Motorista CASCADE CONSTRAINTS;
DROP TABLE Status_entregas CASCADE CONSTRAINTS;
DROP TABLE Veiculos CASCADE CONSTRAINTS;


CREATE TABLE Clientes ( 
    id_clie       NUMBER (4)    CONSTRAINT cliente_id_pk_nn  PRIMARY KEY NOT NULL ,
    nome_clie     VARCHAR2 (35) CONSTRAINT cliente_nome_nn   NOT NULL , 
    CNPJ_clie     VARCHAR2 (14) CONSTRAINT cliente_cnpj_nn NOT NULL , 
    segmento_clie VARCHAR2 (45) CONSTRAINT cliente_seg NOT NULL
    );

CREATE TABLE Entregas( 
    id_ent           NUMBER (4)    CONSTRAINT entregas_id_pk_nn PRIMARY KEY NOT NULL, 
    tipo             VARCHAR2 (15) CONSTRAINT entregas_tipo_nn NOT NULL, 
    fk_cliente       NUMBER (4)    CONSTRAINT fk_cliente_id REFERENCES Clientes
    );

CREATE TABLE Historico_entrega( 
    id_ent              NUMBER(4)       CONSTRAINT hist_ent_id_pk_nn PRIMARY KEY NOT NULL,
    data_status         DATE            CONSTRAINT data_status_nn NOT NULL, 
    status              VARCHAR2 (35)   CONSTRAINT status_fk REFERENCES Status_entregas,
    CONSTRAINT fk_id_ent FOREIGN KEY (id_ent) REFERENCES Entregas(id_ent)
    ) 

CREATE TABLE Motoristas ( 
     id_mot          NUMBER (4)     CONSTRAINT motorista_id_pk_nn PRIMARY KEY NOT NULL , 
     nome_mot        VARCHAR2 (45)  CONSTRAINT nome_motorista_nn NOT NULL, 
     carteira_mot    CHAR (1)       CONSTRAINT carteira_motorista_nn NOT NULL , 
     fk_veiculo      NUMBER (4)     CONSTRAINT veiculo_motorista_fk REFERENCES Veiculos
    ) 

CREATE TABLE Status_entregas( 
     status VARCHAR2 (35)   CONSTRAINT status_pk_nn PRIMARY KEY NOT NULL 
    )
    
CREATE TABLE Veiculos( 
     id_vei   NUMBER (4)    CONSTRAINT veiculos_id_pk_nn PRIMARY KEY NOT NULL , 
     tipo_vei VARCHAR2 (35) CONSTRAINT veiculos_tipo_nn NOT NULL, 
     ano_vei  NUMBER (4)    CONSTRAINT veiculos_ano_nn  NOT NULL,
     fk_entregas NUMBER (4) CONSTRAINT veiculos_entregas_fk REFERENCES Entregas
    ) 



