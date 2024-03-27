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

### O Sistema MVC

![image](https://github.com/filhotecmail/Cadastro-de-fornecedor-Delphi/assets/18727307/1c352bdc-6acc-445a-a058-2a8736b6b77f)

## O padrão MVC (Model-View-Controller)

O padrão MVC é uma arquitetura de software que divide uma aplicação em três componentes principais: o **Modelo (Model)**, a **Visão (View)** e o **Controlador (Controller)**. Cada um desses componentes tem responsabilidades bem definidas, o que ajuda a organizar o código e facilita a manutenção e o desenvolvimento de software.

### Modelo (Model):

- O modelo representa os dados e a lógica de negócios da aplicação.
- Ele é responsável por acessar, manipular e persistir os dados.
- Normalmente, o modelo é independente da interface do usuário, o que significa que ele pode ser reutilizado em diferentes partes da aplicação ou mesmo em diferentes aplicações.

### Visão (View):

- A visão é responsável pela apresentação dos dados ao usuário.
- Ela exibe a interface do usuário e interage com o usuário.
- A visão geralmente é passiva, ou seja, não contém lógica de negócios significativa. Em vez disso, ela se concentra em exibir os dados fornecidos pelo modelo de uma maneira compreensível para o usuário.

### Controlador (Controller):

- O controlador atua como intermediário entre a visão e o modelo.
- Ele interpreta as entradas do usuário e as transforma em comandos para o modelo ou para a visão.
- O controlador também é responsável por atualizar o modelo conforme necessário e por controlar o fluxo da aplicação.

A importância do padrão MVC em uma arquitetura de projeto é significativa por várias razões:

- **Separação de preocupações**: O MVC permite separar as preocupações relacionadas aos dados, à apresentação e ao controle da aplicação. Isso facilita a manutenção do código, uma vez que cada componente pode ser modificado ou substituído independentemente dos outros.

- **Reutilização de código**: Como o modelo é independente da interface do usuário, ele pode ser reutilizado em diferentes partes da aplicação ou mesmo em diferentes projetos. Da mesma forma, as visões podem ser modificadas ou substituídas sem afetar a lógica de negócios subjacente.

- **Testabilidade**: O padrão MVC facilita a criação de testes unitários, pois cada componente pode ser testado separadamente. Isso ajuda a garantir a qualidade do código e a identificar e corrigir erros com mais facilidade.

- **Escalabilidade**: O MVC é altamente escalável, o que significa que é adequado para projetos de diferentes tamanhos e complexidades. Ele fornece uma estrutura organizacional que pode ser expandida e adaptada conforme necessário.

