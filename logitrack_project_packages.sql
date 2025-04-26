set serveroutput on

-- FUNCTIONS

CREATE OR REPLACE FUNCTION verificar_cliente(v_id_cliente NUMBER)
    RETURN BOOLEAN IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Clientes
    WHERE id_clie = v_id_cliente;
    
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Cliente não existe');
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END;  

CREATE OR REPLACE FUNCTION verificar_entrega(v_id_entrega NUMBER)
    RETURN BOOLEAN IS 
    v_count NUMBER;
    v_status VARCHAR2(35);
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Entregas
    WHERE id_ent = v_id_entrega;
        
    IF v_count > 0 THEN
        SELECT status INTO v_status
        FROM Status_entregas
        WHERE id_ent = v_id_entrega;
        
        IF v_status = 'Entrega dentro do prazo' THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Erro: ENTREGA NÃO EXISTE'); 
    END IF;
END;

-- PROCEDURES

CREATE OR REPLACE PROCEDURE registrar_entrega (
    v_id_clie NUMBER,
    v_tipo_entrega VARCHAR2
) IS 
    v_count NUMBER;
BEGIN
    
    IF NOT verificar_cliente(v_id_clie) THEN
        DBMS_OUTPUT.PUT_LINE('Erro: CLIENTE NÃO EXISTE'); 
    ELSE
        INSERT INTO Entregas (id_ent, tipo, veiculo, fk_cliente) VALUES (seq_entregas.NEXTVAL, v_tipo_entrega, null, v_id_clie);
        INSERT INTO Status_entregas (id_ent, status) VALUES (seq_entregas.CURVAL + 1, null);
                DBMS_OUTPUT.PUT_LINE('ENTREGA REGISTRADA COM SUCESSO!');
                
        COMMIT;
    END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;

CREATE OR REPLACE PROCEDURE atribuir_veiculo_entrega (
    v_id_entrega     NUMBER,
    v_tipo_entrega   VARCHAR2
) IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Entregas
    WHERE id_ent = v_id_entrega AND tipo = v_tipo_entrega;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ENTREGA NÃO ENCONTRADA');
    ELSE
    
        IF NOT verificar_entrega(v_id_entrega) THEN
            DBMS_OUTPUT.PUT_LINE('Erro: ENTREGA JÁ ESTÁ COM STATUS DE ATRASADA - NÃO PODE CADASTRAR NOVAMENTE'); 
        ELSE
            IF v_tipo_entrega = 'Entrega Rápida' THEN
                UPDATE Entregas SET veiculo = 'Tipo A' WHERE id_ent = v_id_entrega;
                DBMS_OUTPUT.PUT_LINE('Veículo atribuído com sucesso.');
            ELSE
                UPDATE Entregas SET veiculo = 'Tipo B' WHERE id_ent = v_id_entrega;
                DBMS_OUTPUT.PUT_LINE('Veículo atribuído com sucesso.');
            END IF;
        END IF;

    END IF;

    COMMIT;
END;




EXEC registrar_entrega(1, 'Entrega Rápida');

EXEC atribuir_veiculo_entrega(1, 'Entrega Rápida');











