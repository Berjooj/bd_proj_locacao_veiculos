ALTER TABLE documento ADD PRIMARY KEY(id);

ALTER TABLE pessoa ADD PRIMARY KEY(id);

ALTER TABLE pessoa_documento ADD FOREIGN KEY (id_pessoa) REFERENCES pessoa(id);
ALTER TABLE pessoa_documento ADD FOREIGN KEY (id_documento) REFERENCES documento(id);

ALTER TABLE pessoa_fisica ADD FOREIGN KEY (id_pessoa) REFERENCES pessoa(id);

ALTER TABLE pessoa_juridica ADD FOREIGN KEY (id_pessoa) REFERENCES pessoa(id);

ALTER TABLE motorista ADD FOREIGN KEY (id_pessoa) REFERENCES pessoa(id);
--ALTER TABLE motorista ADD FOREIGN KEY (id_pessoa_fisica) REFERENCES pessoa_fisica(id); linha 37

ALTER TABLE carro ADD PRIMARY KEY (id);

ALTER TABLE locacao ADD PRIMARY KEY (id);
ALTER TABLE locacao ADD FOREIGN KEY (id_carro) REFERENCES carro(id);
--ALTER TABLE locacao ADD FOREIGN KEY (id_motorista) REFERENCES carro(id); linha 56
ALTER TABLE locacao ADD FOREIGN KEY (id_id_funcionario) REFERENCES carro(id);

ALTER TABLE filial ADD PRIMARY KEY (id);

ALTER TABLE funcionario ADD PRIMARY KEY (id);
--ALTER TABLE funcionario ADD FOREIGN KEY (id_pessoa_fisica) REFERENCES pessoa(id); linha 76

ALTER TABLE filial_carro ADD FOREIGN KEY (id_filial) REFERENCES filial(id);
ALTER TABLE filial_carro ADD FOREIGN KEY (id_carro) REFERENCES carro(id);

ALTER TABLE filial_documento ADD FOREIGN KEY (id_filial) REFERENCES filial(id);
ALTER TABLE filial_documento ADD FOREIGN KEY (id_documento)	REFERENCES documento(id);

ALTER TABLE seguro ADD PRIMARY KEY (id);
ALTER TABLE seguro ADD FOREIGN KEY (id_filial) REFERENCES filial(id);
ALTER TABLE seguro ADD FOREIGN KEY (id_carro) REFERENCES carro(id);

--Nas linhas comentadas têm a linha de refencia do código do físico para consultar