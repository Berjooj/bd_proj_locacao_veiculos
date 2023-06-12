CREATE TABLE documento (
    id BIGINT NOT NULL UNIQUE,
    id_pessoa BIGINT NOT NULL,
    numero VARCHAR(255) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    dt_emissao TIMESTAMP NOT NULL,
    dt_validade TIMESTAMP
);

COMMENT ON COLUMN documento.tipo IS 'RG, CNH, CPF, CNPJ; Alvará; PPCI';

CREATE TABLE pessoa (
    id BIGINT NOT NULL UNIQUE,
    telefone VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    cidade VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE pessoa_fisica (
    id_pessoa BIGINT NOT NULL UNIQUE,
    nome VARCHAR(255) NOT NULL,
    dt_nascimento TIMESTAMP NOT NULL,
    genero VARCHAR(255)
);

CREATE TABLE pessoa_juridica (
    id_pessoa BIGINT NOT NULL UNIQUE,
    nome_fantasia VARCHAR(255) NOT NULL,
    razao_social VARCHAR(255),
    dt_abertura TIMESTAMP NOT NULL
);

CREATE TABLE motorista (
    id BIGINT NOT NULL UNIQUE,
    id_pessoa_fisica BIGINT NOT NULL,
    id_pessoa BIGINT NOT NULL
);

CREATE TABLE carro (
    id BIGINT NOT NULL,
    placa VARCHAR(255) NOT NULL UNIQUE,
    modelo VARCHAR(255) NOT NULL,
    ano INT NOT NULL,
    cor VARCHAR(255) NOT NULL,
    km_rodados NUMERIC(18, 2) DEFAULT 0 NOT NULL,
    valor_diaria NUMERIC(8, 4),
    capacidade_tanque NUMERIC(8, 4) NOT NULL,
    situacao BOOLEAN,
    id_filial BIGINT NOT NULL
);

COMMENT ON COLUMN carro.situacao IS 'Disponibilidade para locação';

CREATE TABLE locacao (
    id BIGINT NOT NULL UNIQUE,
    id_carro BIGINT NOT NULL,
    id_motorista BIGINT NOT NULL,
    id_funcionario BIGINT NOT NULL,
    dt_locacao TIMESTAMP,
    dt_devolucao TIMESTAMP,
    avaria BOOLEAN DEFAULT FALSE,
    km_rodados NUMERIC(18, 2) DEFAULT 0,
    valor_estimado NUMERIC(8, 4),
    valor_total NUMERIC(8, 4)
);

CREATE TABLE filial (
    id BIGINT NOT NULL UNIQUE,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    cidade VARCHAR(255) NOT NULL,
    telefone VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    capacidade INT NOT NULL
);

CREATE TABLE funcionario (
    id_pessoa_fisica BIGINT NOT NULL,
    matricula VARCHAR(255) NOT NULL,
    data_admissao TIMESTAMP NOT NULL,
    situacao BOOLEAN NOT NULL DEFAULT true,
    cargo VARCHAR(255) NOT NULL,
    salario NUMERIC(8, 4) NOT NULL,
    id_filial BIGINT NOT NULL
);

COMMENT ON COLUMN funcionario.situacao IS '1- Ativo na empresa, 0- Despedido';

CREATE TABLE filial_documento (
    id_filial BIGINT NOT NULL,
    id_documento BIGINT NOT NULL
);

CREATE TABLE seguro (
    id BIGINT NOT NULL UNIQUE,
    descricao TEXT NOT NULL,
    valor NUMERIC(8, 4) NOT NULL,
    dt_inicio TIMESTAMP NOT NULL DEFAULT NOW(),
    dt_fim TIMESTAMP NOT NULL
);

CREATE TABLE carro_seguro (
    id_carro BIGINT NOT NULL,
    id_seguro BIGINT NOT NULL
);

-- EXECUTA OS ALTER TABLES PARA FKs e PKs
ALTER TABLE seguro ADD PRIMARY KEY (id);
ALTER TABLE motorista ADD PRIMARY KEY (id);
ALTER TABLE documento ADD PRIMARY KEY(id);
ALTER TABLE pessoa ADD PRIMARY KEY(id);
ALTER TABLE pessoa_fisica ADD PRIMARY KEY(id_pessoa);
ALTER TABLE pessoa_juridica ADD PRIMARY KEY(id_pessoa);
ALTER TABLE filial ADD PRIMARY KEY (id);
ALTER TABLE funcionario ADD PRIMARY KEY (id_pessoa_fisica);
ALTER TABLE locacao ADD PRIMARY KEY (id);
ALTER TABLE carro ADD PRIMARY KEY (id);

ALTER TABLE carro_seguro ADD PRIMARY KEY (id_seguro, id_carro);
ALTER TABLE filial_documento ADD PRIMARY KEY (id_filial, id_documento);

ALTER TABLE carro_seguro ADD FOREIGN KEY (id_seguro) REFERENCES seguro(id) ON DELETE CASCADE;
ALTER TABLE carro_seguro ADD FOREIGN KEY (id_carro) REFERENCES carro(id) ON DELETE CASCADE;

ALTER TABLE carro ADD FOREIGN KEY (id_filial) REFERENCES filial(id) ON DELETE CASCADE;

ALTER TABLE filial_documento ADD FOREIGN KEY (id_filial) REFERENCES filial(id) ON DELETE CASCADE;
ALTER TABLE filial_documento ADD FOREIGN KEY (id_documento) REFERENCES documento(id) ON DELETE CASCADE;

ALTER TABLE pessoa_fisica ADD FOREIGN KEY (id_pessoa) REFERENCES pessoa(id) ON DELETE CASCADE;
ALTER TABLE pessoa_juridica ADD FOREIGN KEY (id_pessoa) REFERENCES pessoa(id) ON DELETE CASCADE;

ALTER TABLE motorista ADD FOREIGN KEY (id_pessoa) REFERENCES pessoa(id) ON DELETE CASCADE;
ALTER TABLE motorista ADD FOREIGN KEY (id_pessoa_fisica) REFERENCES pessoa_fisica(id_pessoa) ON DELETE CASCADE;

ALTER TABLE funcionario ADD FOREIGN KEY (id_pessoa_fisica) REFERENCES pessoa_fisica(id_pessoa) ON DELETE CASCADE;

ALTER TABLE locacao ADD FOREIGN KEY (id_carro) REFERENCES carro(id) ON DELETE CASCADE;
ALTER TABLE locacao ADD FOREIGN KEY (id_motorista) REFERENCES motorista(id) ON DELETE CASCADE;
ALTER TABLE locacao ADD FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_pessoa_fisica) ON DELETE CASCADE;
ALTER TABLE funcionario ADD FOREIGN KEY (id_filial) REFERENCES filial(id) ON DELETE CASCADE;

ALTER TABLE documento ADD FOREIGN KEY (id_pessoa) REFERENCES pessoa(id) ON DELETE CASCADE;

-- CRIA AS SEQUENCIAS
CREATE SEQUENCE documento_id_seq
INCREMENT 1
START 1
CACHE 1;

ALTER TABLE documento ALTER COLUMN id SET DEFAULT NEXTVAL('documento_id_seq');

CREATE SEQUENCE pessoa_id_seq
INCREMENT 1
START 1
CACHE 1;

ALTER TABLE pessoa ALTER COLUMN id SET DEFAULT NEXTVAL('pessoa_id_seq');

CREATE SEQUENCE carro_id_seq
INCREMENT 1
START 1
CACHE 1;

ALTER TABLE carro ALTER COLUMN id SET DEFAULT NEXTVAL('carro_id_seq');

CREATE SEQUENCE locacao_id_seq
INCREMENT 1
START 1
CACHE 1;

ALTER TABLE locacao ALTER COLUMN id SET DEFAULT NEXTVAL('locacao_id_seq');

CREATE SEQUENCE filial_id_seq
INCREMENT 1
START 1
CACHE 1;

ALTER TABLE filial ALTER COLUMN id SET DEFAULT NEXTVAL('filial_id_seq');

CREATE SEQUENCE seguro_id_seq
INCREMENT 1
START 1
CACHE 1;

ALTER TABLE seguro ALTER COLUMN id SET DEFAULT NEXTVAL('seguro_id_seq');

CREATE SEQUENCE motorista_id_seq
INCREMENT 1
START 1
CACHE 1;

ALTER TABLE motorista ALTER COLUMN id SET DEFAULT NEXTVAL('motorista_id_seq');

-- 1) Função para cadastrar uma filial, caso não seja informado um CNPJ, retornar um erro
-- Caso algum documento esteja vencido, retornar um erro
-- Por fim, retornar o ID da filial cadastrada
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

INSERT INTO pessoa (id, telefone, endereco, cidade, email) values (10, '99999-9999', 'Rua AAA, Num 201', 'Porto Alegre', 'empresa.super.nova.tec@email.com.br');
INSERT INTO pessoa_juridica (id_pessoa, nome_fantasia, razao_social, dt_abertura) values (10, 'Super Nova Tec', 'Super Nova Tecnologia LTDA', '2010-01-01');
INSERT INTO documento (id, id_pessoa, tipo, numero, dt_emissao, dt_validade) values (20, 10, 'CNPJ', '12345678901234', '2010-01-01', null);
INSERT INTO documento (id, id_pessoa, tipo, numero, dt_emissao, dt_validade) values (21, 10, 'ALVARA', '12345678901234', '2020-12-05', '2024-06-05');

INSERT INTO pessoa (id, telefone, endereco, cidade, email) values (11, '99999-9999', 'Rua BBB, Num 333', 'Porto Alegre', 'empresa.super.velha.tec@email.com.br');
INSERT INTO pessoa_juridica (id_pessoa, nome_fantasia, razao_social, dt_abertura) values (11, 'Super Velha Tec', 'Super Velha Tecnologia LTDA', '2002-10-01');
INSERT INTO documento (id, id_pessoa, tipo, numero, dt_emissao, dt_validade) values (22, 11, 'CNPJ', '12345678901234', '2002-10-01', null);
INSERT INTO documento (id, id_pessoa, tipo, numero, dt_emissao, dt_validade) values (23, 11, 'PPIC', '12345678901234', '2004-07-23', '2022-06-05');

-- Sucesso, documento 20 é um CNPJ e o 21 está dentro do prazo de validade
SELECT * FROM f_cadastra_filial('Filial 1 - Correta', 'Rua ABC, Num 10', 'Porto Alegre', '99999-9999', 'email@filia.1.com', 50, ARRAY[20, 21]);

-- Erro, documento 22 é um CNPJ, mas o 23 está vencido
SELECT * FROM f_cadastra_filial('Filial 2 - Erro', 'Rua ABC, Num 10', 'Porto Alegre', '99999-9999', 'email@filia.2.com', 50, ARRAY[22, 23]);

-- 2) Função que valida se o carro está disponível para aluguel, caso não esteja, retorna uma mensagem de erro
-- caso esteja disponívelm calcula o valor estimado da locação e insere na tabela locacao
CREATE OR REPLACE FUNCTION alugar(id_carro BIGINT, id_motorista BIGINT, id_funcionario BIGINT, dt_locacao TIMESTAMP, dt_devolucao TIMESTAMP) RETURNS BIGINT AS
$$
DECLARE
	carro record;
	dias int;
	id_locacao BIGINT;
BEGIN

	SELECT * FROM carro INTO carro WHERE id = id_carro AND situacao = false;

	IF carro IS NULL THEN
 		RAISE EXCEPTION 'O carro está indisponível';
	END IF;

    dias := EXTRACT(DAY FROM dt_devolucao - dt_locacao);

    INSERT INTO locacao
        (id_carro, id_motorista, id_funcionario, dt_locacao , dt_devolucao , valor_estimado) VALUES
        (id_carro, id_motorista, id_funcionario, dt_locacao , dt_devolucao, (dias * carro.valor_diaria)) RETURNING id INTO id_locacao;

    UPDATE carro SET situacao = TRUE WHERE id = id_carro;

    RETURN id_locacao;
END;
$$
LANGUAGE plpgsql;

INSERT INTO pessoa (id, telefone, endereco, cidade, email) values (15, '99999-9999', 'Rua CCC, Num 300', 'Porto Alegre', 'pessoaaleatoria@email.com');
INSERT INTO pessoa (id, telefone, endereco, cidade, email) values (16, '98888-8888', 'Rua DDD, Num 400', 'Canoas', 'pessoaaleatoria2@email.com');
INSERT INTO pessoa_fisica (id_pessoa, nome, dt_nascimento, genero) values (15, 'João Pedro', '2000-03-10', 'M');
INSERT INTO pessoa_fisica (id_pessoa, nome, dt_nascimento, genero) values (16, 'Joaquim', '1980-05-23', 'M');
INSERT INTO filial (id, nome, endereco, cidade, telefone, email, capacidade) values (5, 'Filial 3', 'Rua EEE, Num 555', 'Canoas', '97777-7777', 'filial3@email.com', 50);
INSERT INTO funcionario (id_pessoa_fisica, matricula, data_admissao, situacao, cargo, salario, id_filial) values (16, '00002', '2020-02-13', true, 'Vendedor', 3000, 5);
INSERT INTO motorista (id, id_pessoa_fisica, id_pessoa) values (15, 15, 15);
INSERT INTO carro (id, placa, modelo, ano, cor, km_rodados, valor_diaria, capacidade_tanque, situacao,id_filial) values (6, 'IBC123', 'UNO', 2000, 'Azul', 1000, 150, 100, FALSE,5);

-- Sucesso
-- (id_carro, id_motorista, id_funcionario, dt_locacao, dt_devolucao)
SELECT alugar(6, 15, 16, '2023-06-09', '2023-07-09');
SELECT * FROM locacao l;

-- Erro, pois o carro 6 já está alugado
SELECT alugar(6, 15, 16, '2023-06-09', '2023-07-09');

-- 3) Trigger para barrar a inserção de CNH vencida
CREATE OR REPLACE FUNCTION verificar_cnh_vencida()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo = 'CNH' AND NEW.dt_validade < now() THEN
       RAISE EXCEPTION 'A CNH está vencida para o documento com ID %', NEW.id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Gatilho "documento"
CREATE TRIGGER cnh_vencida_trigger
BEFORE INSERT OR UPDATE ON documento
FOR EACH ROW
EXECUTE FUNCTION verificar_cnh_vencida();

insert into pessoa (id, telefone, endereco, cidade, email) values (1, '91981-4451', 'Rua A, numero 01', 'Porto Alegre', 'pedro@gmail.com.br');
insert into pessoa_fisica (id_pessoa, nome, dt_nascimento, genero) values (1, 'Pedro Sanches', '1978-05-01', 'masculino');

-- Errado
insert into documento (id, id_pessoa, numero, tipo, dt_emissao, dt_validade) values (1, 1, '25823277534', 'CNH', '2015-02-21', '2020-02-21');

-- Certo
insert into documento (id, id_pessoa, numero, tipo, dt_emissao, dt_validade) values (1, 1, '25823277534', 'CNH', '2015-02-21', '2025-02-21');

-- 4) Devolução
-- Realiza o cálculo dos acréscimos do valor a devolver
-- Se o tanque não estiver cheio, cobra-se o valor da gasolina (valor_gasolina * (capacidade_tanque - tanque_atual))
-- Se houver avarias, cobra-se o valor do seguro informado pelo tipo da avaria
-- Saldo final: valor estimado das diárias + valor_gasolina + valor_seguro
CREATE OR REPLACE FUNCTION calcular_acrescimos(id_carro_devolucao BIGINT, tanque_atual NUMERIC, preco_gasolina NUMERIC, tipo_avaria varchar[]) RETURNS numeric AS
$$
DECLARE
	preco_total NUMERIC;
	preco_diaria NUMERIC;
	preco_seguro NUMERIC;
	capacidade_tanque NUMERIC;
	locacao TIMESTAMP;
	devolucao TIMESTAMP;
	alugado boolean;
BEGIN
	SELECT situacao INTO alugado FROM carro WHERE id = id_carro_devolucao;

	IF alugado = TRUE
	THEN
		SELECT c.capacidade_tanque
		INTO capacidade_tanque
		FROM carro c
		WHERE c.id = id_carro_devolucao;

		SELECT l.valor_estimado, l.dt_locacao, l.dt_devolucao
		INTO preco_diaria, locacao, devolucao
		FROM locacao l
		WHERE l.id_carro = id_carro_devolucao
		ORDER BY l.id DESC LIMIT 1;

		preco_total := preco_diaria + (abs(capacidade_tanque - tanque_atual) * preco_gasolina);

		IF array_length(tipo_avaria, 1) > 0
		THEN
			SELECT sum(s.valor)
			INTO preco_seguro
			FROM carro c
			INNER JOIN carro_seguro cs ON c.id = cs.id_carro
			INNER JOIN seguro s ON cs.id_seguro = s.id AND s.descricao = ANY(tipo_avaria)
			WHERE c.id = id_carro_devolucao;

			preco_total := preco_total + preco_seguro;

			UPDATE locacao
			SET avaria = TRUE
			WHERE id =
			(
                SELECT l.id
                FROM locacao l
                WHERE l.id_carro = id_carro_devolucao
                ORDER BY l.id DESC LIMIT 1
			);
		ELSE
			UPDATE locacao
			SET avaria = FALSE
			WHERE id =
			(
                SELECT l.id
                FROM locacao l
                WHERE l.id_carro = id_carro_devolucao
                ORDER BY l.id DESC LIMIT 1
			);
		END if;

	UPDATE locacao
	SET valor_total = preco_total
	WHERE id =
	(
        SELECT l.id
        FROM locacao l
        WHERE l.id_carro = id_carro_devolucao
        ORDER BY l.id DESC LIMIT 1
	);
	RAISE NOTICE 'Custos totais de utilizacao do Carro % é %',id_carro_devolucao,preco_total;
	RETURN preco_total;
	ELSE
		RAISE EXCEPTION 'Carro não está alugado para calcular acrescimos';
	END IF;
END;
$$
LANGUAGE plpgsql;

-- 5) Calculo atualiza km rodados, o valor final da locacao e atualiza a situacao do carro para disponivel
CREATE OR REPLACE FUNCTION devolver_carro(id_carro_devolucao BIGINT, tanque_atual NUMERIC,preco_gasolina NUMERIC,kilometragem_utilizada NUMERIC, tipo_avaria varchar[]) RETURNS void AS
$$
DECLARE
	kilometragem_carro NUMERIC;
	alugado boolean;
BEGIN

	SELECT situacao INTO alugado FROM carro WHERE id = id_carro_devolucao;

	IF alugado = TRUE
	THEN

	perform calcular_acrescimos(id_carro_devolucao, tanque_atual,preco_gasolina,tipo_avaria);

	UPDATE locacao
	SET km_rodados = kilometragem_utilizada
	WHERE id =
	(
        SELECT l.id
        FROM locacao l
        WHERE l.id_carro = id_carro_devolucao
        ORDER BY l.id DESC LIMIT 1
	);

	UPDATE carro
	SET km_rodados = km_rodados + kilometragem_utilizada, situacao = FALSE
	WHERE id = id_carro_devolucao;
	RAISE NOTICE 'Carro Devolvido';
	ELSE
		RAISE EXCEPTION 'Carro não está alugado para ser devolvido';
	END IF;
END;
$$
LANGUAGE plpgsql;

-- Insert dos seguros
INSERT INTO seguro (id, descricao, valor, dt_inicio, dt_fim) values (1,'FURTO', 300.0000, '2023-06-05', '2024-06-05');
INSERT INTO seguro (id, descricao, valor, dt_inicio, dt_fim) values (2,'DANO', 500.0000, '2023-06-05', '2024-06-05');
INSERT INTO seguro (id, descricao, valor, dt_inicio, dt_fim) values (3,'ACIDENTE', 1500.0000, '2023-06-05', '2024-06-05');

-- Vincula o seguro ao carro
INSERT INTO carro_seguro (id_carro, id_seguro) values (6, 1);
INSERT INTO carro_seguro (id_carro, id_seguro) values (6, 2);
INSERT INTO carro_seguro (id_carro, id_seguro) values (6, 3);

SELECT l.* FROM locacao l;

-- Devolve um carro danificado e com acidente
-- (id_carro_devolucao, tanque_atual, preco_gasolina, kilometragem_utilizada, tipo_avaria)
SELECT devolver_carro(6, 15, 5.34, 5000, ARRAY['DANO', 'ACIDENTE']);

SELECT l.* FROM locacao l;

@startuml LocacaoCarros

entity documento{
    id <<PK>>
    id_pessoa <<FK>>
    numero
    tipo
    dt_emissao
    dt_validade
}

entity pessoa {
    id <<PK>>
    telefone
    endereco
    cidade
    email
}

entity pessoa_fisica {
    id_pessoa <<FK>>
    nome
    dt_nascimento
    genero
}

entity pessoa_juridica {
    id_pessoa <<FK>>
    nome_fantasia
    razao_social
    dt_abertura
}

entity motorista {
    id <<PK>>
    id_pessoa_fisica <<FK>>
    id_pessoa <<FK>>
}

entity carro {
    id <<PK>>
    id_filial <<FK>>
    placa
    modelo
    ano
    cor
    km_rodados
    valor_diaria
    capacidade_tanque
    situacao
}

entity locacao {
    id <<PK>>
    id_carro <<FK>>
    id_motorista <<FK>>
    id_funcionario <<FK>>
    dt_locacao
    dt_devolucao
    valor_estimado
    valor_total
}

entity filial {
    id <<PK>>
    nome
    endereco
    cidade
    telefone
    email
    capacidade
}

entity funcionario {
    id_pessoa_fisica <<FK>>
    matricula
    data_admissao
    situacao
    cargo
    salario
    id_filial <<FK>>
}

entity filial_documento {
    id_filial <<FK>>
    id_documento <<FK>>
}

entity seguro {
    id <<PK>>
    descricao
    valor
    dt_inicio
    dt_fim
}

entity carro_seguro {
    id_carro <<FK>>,
    id_seguro <<FK>>
}

carro_seguro "1..1" -- "1..1" seguro
carro_seguro "1..n" -- "n..1" carro

carro "1..1" -- "0..1" filial

filial_documento "n..1" -- "1..n" filial
filial_documento "1..n" -- "n..1" documento

pessoa_fisica "1..1" -- "0..1" pessoa
pessoa_juridica "1..1" -- "0..1" pessoa

motorista "1..1" -- "n..1" pessoa
motorista "1..1" -- "n..1" pessoa_fisica

funcionario "1..1" -- "n..1" pessoa_fisica
funcionario "1..1" -- "n..1" filial

locacao "1..1" -- "n..1" carro
locacao "1..1" -- "n..1" motorista
locacao "1..1" -- "n..1" funcionario

documento "1..1" -- "1..1" pessoa

@enduml