-- 1)
INSERT INTO pessoa (id, telefone, endereco, cidade, email) values (10, '99999-9999', 'Rua AAA, Num 201', 'Porto Alegre', 'empresa.super.nova.tec@email.com.br');
INSERT INTO pessoa_juridica (id_pessoa, nome_fantasia, razao_social, dt_abertura) values (10, 'Super Nova Tec', 'Super Nova Tecnologia LTDA', '2010-01-01');
INSERT INTO documento (id, id_pessoa, tipo, numero, dt_emissao, dt_validade) values (20, 10, 'CNPJ', '12345678901234', '2010-01-01', null);
INSERT INTO documento (id, id_pessoa, tipo, numero, dt_emissao, dt_validade) values (21, 10, 'ALVARA', '12345678901234', '2020-12-05', '2024-06-05');

INSERT INTO pessoa (id, telefone, endereco, cidade, email) values (11, '99999-9999', 'Rua BBB, Num 333', 'Porto Alegre', 'empresa.super.velha.tec@email.com.br');
INSERT INTO pessoa_juridica (id_pessoa, nome_fantasia, razao_social, dt_abertura) values (11, 'Super Velha Tec', 'Super Velha Tecnologia LTDA', '2002-10-01');
INSERT INTO documento (id, id_pessoa, tipo, numero, dt_emissao, dt_validade) values (22, 11, 'CNPJ', '12345678901234', '2002-10-01', null);
INSERT INTO documento (id, id_pessoa, tipo, numero, dt_emissao, dt_validade) values (23, 11, 'PPIC', '12345678901234', '2004-07-23', '2022-06-05');

CREATE OR REPLACE FUNCTION f_cadastra_filial (
    nome VARCHAR(255),
    endereco VARCHAR(255),
    cidade VARCHAR(255),
    telefone VARCHAR(255),
    email VARCHAR(255),
    capacidade INT,
    id_documentos BIGINT[]
    ) RETURNS BIGINT AS
$$
	DECLARE
        documento RECORD;
        possui_cnpj BOOLEAN;
        id_filial BIGINT;
	BEGIN

        possui_cnpj := FALSE;

        FOR documento IN SELECT d.* FROM documento d WHERE d.id = ANY(id_documentos) LOOP
            IF documento.tipo = 'CNPJ' THEN
                possui_cnpj := TRUE;
            END IF;

            IF documento.dt_validade IS NOT NULL AND documento.dt_validade < now() THEN
                RAISE EXCEPTION 'Documento % está vencido', documento.numero;
            END IF;
        END LOOP;

        IF possui_cnpj = FALSE THEN
            RAISE EXCEPTION 'Para cadastrar uma filial é necessário informar um CNPJ';
        END IF;

        INSERT INTO filial (nome, endereco, cidade, telefone, email, capacidade) VALUES (nome, endereco, cidade, telefone, email, capacidade) RETURNING id INTO id_filial;

        RETURN id_filial;
	END;
$$
LANGUAGE plpgsql;

SELECT * FROM f_cadastra_filial('Filial 1 - Correta', 'Rua ABC, Num 10', 'Porto Alegre', '99999-9999', 'email@filia.1.com', 50, ARRAY[20, 21]);

SELECT f_cadastra_filial('Filial 2 - Erro', 'Rua ABC, Num 10', 'Porto Alegre', '99999-9999', 'email@filia.2.com', 50, ARRAY[22, 23]);



