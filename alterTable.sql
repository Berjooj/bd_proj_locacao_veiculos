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