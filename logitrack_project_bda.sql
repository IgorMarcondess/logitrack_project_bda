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
    id_ent        NUMBER(4)  PRIMARY KEY NOT NULL,
    data_status         DATE NOT NULL, 
    status              VARCHAR2 (35) REFERENCES Status_entregas,
    CONSTRAINT fk_id_ent FOREIGN KEY (id_ent) REFERENCES Entregas(id_ent)
    ) 

CREATE TABLE Motoristas ( 
     id_mot          NUMBER (4) PRIMARY KEY NOT NULL , 
     nome_mot        VARCHAR2 (45) , 
     carteira_mot    CHAR (1) , 
     fk_veiculo      NUMBER (4) REFERENCES Veiculos
    ) 

CREATE TABLE Status_entregas( 
     status VARCHAR2 (35) PRIMARY KEY NOT NULL 
    )
    
CREATE TABLE Veiculos( 
     id_vei   NUMBER (4) PRIMARY KEY NOT NULL , 
     tipo_vei VARCHAR2 (35) , 
     ano_vei  NUMBER (4),
     fk_entregas NUMBER (4) REFERENCES Entregas
    ) 



