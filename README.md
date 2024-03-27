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

### Fachada de Objetos

O padrão Facade é um padrão de design estrutural que fornece uma interface simplificada para um conjunto complexo de classes, estruturas ou sistemas. Ele oculta a complexidade subjacente e fornece uma única interface unificada para interagir com o sistema.

Em termos simples, o Facade atua como uma camada de abstração sobre um conjunto de subsistemas, fornecendo uma interface mais fácil de usar e compreender para os clientes que desejam interagir com esses subsistemas.

## Os benefícios

- **Interface simplificada**: O Facade fornece uma interface simplificada que oculta a complexidade do sistema subjacente. Em vez de lidar diretamente com múltiplas classes ou subsistemas, os clientes interagem apenas com o Facade.

- **Coordenação de subsistemas**: Internamente, o Facade coordena as interações entre os subsistemas que compõem o sistema mais complexo. Ele direciona os pedidos dos clientes para as classes apropriadas e pode realizar operações mais complexas coordenando múltiplas chamadas de método.

- **Encapsulamento de complexidade**: Uma das principais razões para usar o Facade é encapsular a complexidade do sistema. Isso melhora a modularidade, a manutenção e a legibilidade do código, já que os detalhes complexos são escondidos atrás de uma interface mais simples e coesa.

- **Promoção de práticas de design limpo**: O Facade promove a prática de design limpo, isolando o cliente da complexidade interna do sistema. Isso facilita a adição de novos recursos ou a alteração da implementação interna do sistema sem afetar os clientes existentes.

- **Melhoria na legibilidade e na compreensão**: O uso do Facade pode melhorar significativamente a legibilidade e a compreensão do código, especialmente em sistemas complexos. Ao fornecer uma interface clara e concisa, os desenvolvedores podem entender facilmente como interagir com o sistema e quais funcionalidades estão disponíveis.


