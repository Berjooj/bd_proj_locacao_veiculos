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
    id_pessoa_fisica BIGINT NOT NULL UNIQUE,
    id_pessoa BIGINT NOT NULL UNIQUE
);

CREATE TABLE carro (
    id BIGINT NOT NULL,
    placa VARCHAR(255) NOT NULL UNIQUE,
    modelo VARCHAR(255) NOT NULL,
    ano INT NOT NULL,
    cor VARCHAR(255) NOT NULL,
    km_rodados NUMERIC(18, 2) NOT NULL,
    valor_diaria NUMERIC(8, 4),
    capacidade_tanque NUMERIC(8, 4) NOT NULL,
    situacao BOOLEAN
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
    km_rodados NUMERIC(18, 2),
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
    salario NUMERIC(8, 4) NOT NULL
);

COMMENT ON COLUMN funcionario.situacao IS '1- Ativo na empresa, 0- Despedido';

CREATE TABLE filial_carro (
    id_filial BIGINT NOT NULL,
    id_carro BIGINT NOT NULL
);

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