@startuml LocacaoCarros

entity documento{
    id <<PK>>
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

entity pessoa_documento {
    id_pessoa <<FK>>
    id_documento <<FK>>
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
    id_pessoa_fisica <<FK>> --! pessoa física não tem id. tirar? --
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
    id <<PK>>
    id_pessoa_fisica <<FK>>
    matricula
    data_admissao
    situacao
    cargo
    salario
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
    id_filial <<FK>>
    id_carro <<FK>>
    valor
    dt_inicio
    dt_fim
}

pessoa -- pessoa_documento
documento -- pessoa_documento

pessoa -- pessoa_fisica
pessoa -- pessoa_juridica

motorista -- pessoa_fisica
motorista -- pessoa

pessoa_fisica -- funcionario

carro -- filial_carro
filial -- filial_carro

carro -- seguro

carro -- locacao
motorista -- locacao
funcionario -- locacao

filial -- funcionario

filial -- filial_documento
documento -- filial_documento


@enduml
