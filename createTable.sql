CREATE TABLE documento (
    id INT,
    numero VARCHAR(255),
    tipo VARCHAR(255),
    dt_emissao DATE,
    dt_validade DATE
);

CREATE TABLE pessoa (
    id INT,
    telefone VARCHAR(255),
    endereco VARCHAR(255),
    cidade VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE pessoa_documento (
    id_pessoa INT,
    id_documento INT
);

CREATE TABLE pessoa_fisica (
    id_pessoa INT,
    nome VARCHAR(255),
    dt_nascimento DATE,
    genero VARCHAR(255)
);

CREATE TABLE pessoa_juridica (
    id_pessoa INT,
    nome_fantasia VARCHAR(255),
    razao_social VARCHAR(255),
    dt_abertura DATE
);

CREATE TABLE motorista (
    id_pessoa_fisica INT, --aqui--
    id_pessoa INT
);

CREATE TABLE carro (
    id INT,
    placa VARCHAR(255),
    modelo VARCHAR(255),
    ano INT,
    cor VARCHAR(255),
    km_rodados FLOAT,
    valor_diaria NUMERIC(8, 4),
    capacidade_tanque FLOAT,
    situacao VARCHAR(255)
);

CREATE TABLE locacao (
    id INT,
    id_carro INT,
    id_motorista INT, --aqui
    id_funcionario INT,
    dt_locacao DATE,
    dt_devolucao DATE,
    valor_estimado NUMERIC(8, 4),
    valor_total NUMERIC(8, 4)
);

CREATE TABLE filial (
    id INT,
    nome VARCHAR(255),
    endereco VARCHAR(255),
    cidade VARCHAR(255),
    telefone VARCHAR(255),
    email VARCHAR(255),
    capacidade INT
);

CREATE TABLE funcionario (
    id INT, 
    id_pessoa_fisica INT, --aqui
    matricula VARCHAR(255),
    data_admissao DATE,
    situacao VARCHAR(255),
    cargo VARCHAR(255),
    salario NUMERIC(8, 4)
);

CREATE TABLE filial_carro (
    id_filial INT,
    id_carro INT
);

CREATE TABLE filial_documento (
    id_filial INT,
    id_documento INT
);

CREATE TABLE seguro (
    id INT,
    id_filial INT,
    id_carro INT,
    valor NUMERIC(8, 4),
    dt_inicio DATE,
    dt_fim DATE
);
