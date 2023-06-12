@startuml
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

entity filial_carro {
    id_filial <<FK>>
    id_carro <<FK>>
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

carro_seguro "1..n" -- "n..1" seguro
carro_seguro "1..n" -- "n..1" carro

filial_carro "1..n" -- "n..0" filial
filial_carro "n..1" -- "0..1" carro

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

documento "n..1" -- "1..n" pessoa

@enduml