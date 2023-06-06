--Inserts pessoa

insert into pessoa (id, telefone, endereco, cidade, email) values (1, '91981-4451', 'Rua A, numero 01', 'Porto Alegre', 'pedro@gmail.com.br');
insert into pessoa (id, telefone, endereco, cidade, email) values (2, '92899-4452', 'Rua B, numero 02', 'Canoas',       'paulo@gmail.com.br');
insert into pessoa (id, telefone, endereco, cidade, email) values (3, '93981-4453', 'Rua C, numero 03', 'Cachoerinha',  'maria@gmail.com.br');
insert into pessoa (id, telefone, endereco, cidade, email) values (4, '94981-4454', 'Rua D, numero 04', 'Porto Alegre', 'daniela@gmail.com.br');
insert into pessoa (id, telefone, endereco, cidade, email) values (5, '95981-4455', 'Rua E, numero 05', 'Gravatai',     'vera@gmail.com.br');
insert into pessoa (id, telefone, endereco, cidade, email) values (6, '96981-4456', 'Rua F, numero 06', 'Alvorada',     'marcelo@gmail.com.br');
insert into pessoa (id, telefone, endereco, cidade, email) values (7, '98981-4458', 'Rua H, numero 07', 'Porto Alegre', 'vicente@gmail.com.br');
insert into pessoa (id, telefone, endereco, cidade, email) values (8, '99981-4459', 'Rua I, numero 08', 'Caxias',       'jose@gmail.com.br');
insert into pessoa (id, telefone, endereco, cidade, email) values (9, '91081-4410', 'Rua J, numero 09', 'Porto Alegre', 'andre@gmail.com.br');
insert into pessoa (id, telefone, endereco, cidade, email) values (10,'99081-5566', 'Rua K, numero 10', 'Caxias',       'israel@gmail.com.br');



--Inserts documento (1- RG, 2- CNH, 3- CPF, 4- CNPJ)

insert into documento (id, id_pessoa, numero, tipo, dt_emissao, dt_validade) values (1, 1, '25823277534',         '2', '2020-02-21', '2030-02-21');
insert into documento (id, id_pessoa, numero, tipo, dt_emissao, dt_validade) values (2, 2, '35823277535',         '2', '2021-03-15', '2031-03-15');
insert into documento (id, id_pessoa, numero, tipo, dt_emissao, dt_validade) values (3, 3, '4061849677',          '1', '1978-11-09', '2050-01-01');
insert into documento (id, id_pessoa, numero, tipo, dt_emissao, dt_validade) values (4, 4, '5061849678',          '1', '2020-02-21', '2050-01-01');
insert into documento (id, id_pessoa, numero, tipo, dt_emissao, dt_validade) values (5, 5, '51.220.675/0001-20',  '4', '2020-02-21', '2050-01-01');
insert into documento (id, id_pessoa, numero, tipo, dt_emissao, dt_validade) values (6, 6, '812.403.950-99',      '3', '2020-02-21', '2050-01-01');
insert into documento (id, id_pessoa, numero, tipo, dt_emissao, dt_validade) values (7, 7, '91.343.673/0001-08',  '4', '2020-02-21', '2050-01-01');
insert into documento (id, id_pessoa, numero, tipo, dt_emissao, dt_validade) values (8, 8, '87.874.715/0001-51',  '4', '2020-02-21', '2050-01-01');
insert into documento (id, id_pessoa, numero, tipo, dt_emissao, dt_validade) values (9, 9, '45823277536',         '2', '2021-05-12', '2026-05-12');
insert into documento (id, id_pessoa, numero, tipo, dt_emissao, dt_validade) values (10, 10,'55823277537',        '2', '2020-03-18', '2025-03-18');


--Inserts pessoa_fisica

insert into pessoa_fisica (id_pessoa, nome, dt_nascimento, genero) values (1, 'Pedro Sanches',      '1978-05-01', 'masculino');
insert into pessoa_fisica (id_pessoa, nome, dt_nascimento, genero) values (2, 'Paulo Soares',       '1986-08-02', 'masculino');
insert into pessoa_fisica (id_pessoa, nome, dt_nascimento, genero) values (3, 'Maria Sampaio',      '1960-07-28', 'feminino');
insert into pessoa_fisica (id_pessoa, nome, dt_nascimento, genero) values (4, 'Daniela Bitencourt', '1975-01-01', 'feminino');
insert into pessoa_fisica (id_pessoa, nome, dt_nascimento, genero) values (6, 'Marcelo Andrade',    '1998-10-05', 'masculino');
insert into pessoa_fisica (id_pessoa, nome, dt_nascimento, genero) values (9, 'Jose Aguiar',        '1955-12-05', 'masculino');
insert into pessoa_fisica (id_pessoa, nome, dt_nascimento, genero) values (10,'Andre Paludo',       '2000-05-07', 'masculino');

--Inserts pessoa_juridica

insert into pessoa_juridica (id_pessoa, nome_fantasia, razao_social, dt_abertura) values (5, 'Planimec', 'Planimec Assessores Ltda.', '1960-08-01');
insert into pessoa_juridica (id_pessoa, nome_fantasia, razao_social, dt_abertura) values (7, 'Dorinho', 'Dorinho Beer Pub S/A.', '1980-05-02');
insert into pessoa_juridica (id_pessoa, nome_fantasia, razao_social, dt_abertura) values (8, 'Augustos', 'Agusto Restaurante Ltda.', '2000-07-10');


--Inserts motorista

insert into motorista (id_pessoa_fisica, id_pessoa) values (1, 1);
insert into motorista (id_pessoa_fisica, id_pessoa) values (2, 2);
insert into motorista (id_pessoa_fisica, id_pessoa) values (9, 9);
insert into motorista (id_pessoa_fisica, id_pessoa) values (10, 10);


--Inserts carro

insert into carro (id, placa, modelo, ano, cor, km_rodados, valor_diaria, capacidade_tanque, situacao) values (1, 'IUU3022', 'Gol',     '2022', 'branco', 15000.00, 110.0000, 55.0000, true);
insert into carro (id, placa, modelo, ano, cor, km_rodados, valor_diaria, capacidade_tanque, situacao) values (2, 'IZZ1515', 'Polo',    '2023', 'preto',  10000.00, 115.0000, 40.0000, true);
insert into carro (id, placa, modelo, ano, cor, km_rodados, valor_diaria, capacidade_tanque, situacao) values (3, 'IRS5022', 'Spacefox','2020', 'amarelo',18000.00, 120.0000, 45.0000, true);
insert into carro (id, placa, modelo, ano, cor, km_rodados, valor_diaria, capacidade_tanque, situacao) values (4, 'IZK8799', 'Fox',     '2021', 'rosa',   22000.00, 130.0000, 55.0000, true);
insert into carro (id, placa, modelo, ano, cor, km_rodados, valor_diaria, capacidade_tanque, situacao) values (5, 'ILM5789', 'Amarok',  '2021', 'marron', 85000.00, 110.0000, 75.0000, true);
insert into carro (id, placa, modelo, ano, cor, km_rodados, valor_diaria, capacidade_tanque, situacao) values (6, 'IOP8759', 'Zafira',  '2022', 'azul',   12000.00, 110.0000, 55.0000, true);
insert into carro (id, placa, modelo, ano, cor, km_rodados, valor_diaria, capacidade_tanque, situacao) values (7, 'IPR8782', 'Uno',     '2019', 'ocre',   90000.00, 145.0000, 55.0000, true);
insert into carro (id, placa, modelo, ano, cor, km_rodados, valor_diaria, capacidade_tanque, situacao) values (8, 'ILP2136', 'Passat',  '2018', 'perola', 41000.00, 120.0000, 55.0000, true);
insert into carro (id, placa, modelo, ano, cor, km_rodados, valor_diaria, capacidade_tanque, situacao) values (9, 'IPP7858', 'Ecosport','2010', 'preto',  25000.00, 120.0000, 55.0000, true);
insert into carro (id, placa, modelo, ano, cor, km_rodados, valor_diaria, capacidade_tanque, situacao) values (10,'IXL7896', 'Fusca',   '1986', 'branco', 11000.00, 110.0000, 45.0000, false);

--Inserts funcionario

insert into funcionario (id_pessoa_fisica, matricula, data_admissao, situacao, cargo, salario) values (3, '500600700', '2020-05-01', true, 'Vendedor', 5000.0000);
insert into funcionario (id_pessoa_fisica, matricula, data_admissao, situacao, cargo, salario) values (4, '600700800', '2021-07-02', true, 'Vendedor', 5000.0000);
insert into funcionario (id_pessoa_fisica, matricula, data_admissao, situacao, cargo, salario) values (9, '700800900', '2022-08-03', true, 'Gerente', 7000.0000);


--Inserts locacao

insert into locacao (id, id_carro, id_motorista, id_funcionario, dt_locacao, dt_devolucao, valor_estimado, valor_total) values (1, 1, 1, 3, '2023-01-01', '2023-01-15', 1540.00, 1540.00);
insert into locacao (id, id_carro, id_motorista, id_funcionario, dt_locacao, dt_devolucao, valor_estimado, valor_total) values (2, 2, 2, 4, '2023-02-01', '2023-02-10', 1035.00, 1035.00);
insert into locacao (id, id_carro, id_motorista, id_funcionario, dt_locacao, dt_devolucao, valor_estimado, valor_total) values (3, 3, 9, 9, '2023-03-01', '2023-03-05',  480.00,  480.00);
insert into locacao (id, id_carro, id_motorista, id_funcionario, dt_locacao, dt_devolucao, valor_estimado, valor_total) values (4, 4, 10, 3, '2023-04-01', '2023-04-03',   260.00, 260.00);
insert into locacao (id, id_carro, id_motorista, id_funcionario, dt_locacao, dt_devolucao, valor_estimado, valor_total) values (5, 5, 1, 4, '2023-05-01', '2023-05-08',   770.00, 770.00);
insert into locacao (id, id_carro, id_motorista, id_funcionario, dt_locacao, dt_devolucao, valor_estimado, valor_total) values (6, 6, 2, 9, '2023-01-01', '2023-01-09',   880.00, 880.00);
insert into locacao (id, id_carro, id_motorista, id_funcionario, dt_locacao, dt_devolucao, valor_estimado, valor_total) values (7, 7, 9, 3, '2023-02-01', '2023-02-05',   580.00, 580.00);
insert into locacao (id, id_carro, id_motorista, id_funcionario, dt_locacao, dt_devolucao, valor_estimado, valor_total) values (8, 8, 10, 4, '2023-03-01', '2023-03-03',   240.00, 240.00);
insert into locacao (id, id_carro, id_motorista, id_funcionario, dt_locacao, dt_devolucao, valor_estimado, valor_total) values (9, 8, 1, 9, '2023-04-01', '2023-04-02',   120.00, 120.00);

--Inserts filial

insert into filial (id, nome, endereco, cidade, telefone, email, capacidade) values (1, 'Localiza Sertorio', 'Av. Sertorio 1010', 'Porto Alegre','51-33786200', 'locaser@localiza.com.br', 100);
insert into filial (id, nome, endereco, cidade, telefone, email, capacidade) values (2, 'Localiza Viamao',   'Av. Salgado Filho, 5200', 'Viamao','51-33778899', 'locavia@localiza.com.br', 70);
insert into filial (id, nome, endereco, cidade, telefone, email, capacidade) values (3, 'Localiza Brasil',   'Av. Brasil 580', 'Porto Alegre','51-33780000', 'locabraz@localiza.com.br', 80);


--Inserts filial_carro

insert into filial_carro (id_filial, id_carro) values (1,1);
insert into filial_carro (id_filial, id_carro) values (2,2);
insert into filial_carro (id_filial, id_carro) values (3,3);
insert into filial_carro (id_filial, id_carro) values (1,4);
insert into filial_carro (id_filial, id_carro) values (2,5);
insert into filial_carro (id_filial, id_carro) values (3,6);
insert into filial_carro (id_filial, id_carro) values (1,7);
insert into filial_carro (id_filial, id_carro) values (2,8);
insert into filial_carro (id_filial, id_carro) values (3,9);
insert into filial_carro (id_filial, id_carro) values (1,10);


--Inserts filial_documento

insert into filial_documento (id_filial, id_documento) values (1,1);
insert into filial_documento (id_filial, id_documento) values (2,2);
insert into filial_documento (id_filial, id_documento) values (3,3);
insert into filial_documento (id_filial, id_documento) values (1,4);
insert into filial_documento (id_filial, id_documento) values (2,5);
insert into filial_documento (id_filial, id_documento) values (3,6);



--Inserts seguro

insert into seguro (id, descricao, valor, dt_inicio, dt_fim) values (1,'total', 300.0000, '2023-06-05', '2024-06-05');
insert into seguro (id, descricao, valor, dt_inicio, dt_fim) values (2,'total', 500.0000, '2023-06-05', '2024-06-05');
insert into seguro (id, descricao, valor, dt_inicio, dt_fim) values (3,'total', 700.0000, '2023-06-05', '2024-06-05');

--Inserts carro_seguro

insert into carro_seguro (id_carro, id_seguro) values (1,1);
insert into carro_seguro (id_carro, id_seguro) values (2,2);
insert into carro_seguro (id_carro, id_seguro) values (3,3);
insert into carro_seguro (id_carro, id_seguro) values (4,1);
insert into carro_seguro (id_carro, id_seguro) values (5,2);
insert into carro_seguro (id_carro, id_seguro) values (6,3);
insert into carro_seguro (id_carro, id_seguro) values (7,1);
insert into carro_seguro (id_carro, id_seguro) values (8,2);
insert into carro_seguro (id_carro, id_seguro) values (9,3);
insert into carro_seguro (id_carro, id_seguro) values (10,1);