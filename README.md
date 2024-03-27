# Cadastro de fornecedor Delphi
 Repositório criado para exemplificar o teste de cadastro de fornecedor e uma base local, fornecendo regras explícitas e implícitas para validações de dados.

### Especificações de Cadastro de Fornecedores

#### Empresa:
- UF
- Nome Fantasia
- CNPJ

#### Fornecedor:
- Empresa
- Nome
- CPF ou CNPJ
- Data/hora de cadastro
- Telefone (Quantidade de telefones é variável)

#### Regras:
- O campo ‘Empresa’ será um cadastro à parte
- Caso a empresa seja do Paraná, não permitir cadastrar um fornecedor pessoa física menor de idade
- Caso o fornecedor seja pessoa física, também é necessário cadastrar o RG e a data de nascimento

#### Listagem de Fornecedores:
- Deverá conter filtros por Nome, CPF/CNPJ e data de cadastro
