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


### A Entidade Relacional

![image](https://github.com/filhotecmail/Cadastro-de-fornecedor-Delphi/assets/18727307/7b92c523-8908-44ba-9a9a-1d0eb6b228cd)

# Tabela EMPRESA

A tabela **EMPRESA** é uma entidade fundamental em um sistema ERP (Enterprise Resource Planning), pois armazena informações sobre as empresas que utilizam o sistema.

## Pontos Importantes

### Armazenamento de Informações da Empresa
- **E001XFANT**: Nome fantasia da empresa.
- **E002UF**: Sigla do estado onde a empresa está localizada.
- **E003CNPJ**: Número de CNPJ da empresa.

Essas informações são cruciais para identificar e diferenciar as empresas cadastradas no sistema.

### Garantia de Integridade dos Dados
- A restrição `UNQ1_EMPRESA` garante que cada CNPJ seja único na tabela, evitando a inserção de empresas duplicadas com o mesmo CNPJ.

### Validação de Dados
- As restrições `CHK1_EMPRESA` e `CHK2_EMPRESA` aplicam validações nos dados inseridos na tabela. A primeira restrição garante que a sigla do estado esteja dentro de um conjunto pré-definido de valores válidos, enquanto a segunda restrição verifica se o CNPJ informado é válido por meio de uma função externa (`PROC_VALID_CNPJ`).

### Chave Primária e Identificador Único
- A coluna **ID** é uma chave primária autoincrementada que garante a unicidade de cada registro na tabela. 
- O gatilho `EMPRESA_BI` é responsável por gerar valores para o campo **ID** antes de inserir um novo registro na tabela.

### Descrição dos Campos
- A tabela inclui comentários que descrevem cada campo, fornecendo informações adicionais sobre o propósito e o formato dos dados armazenados em cada coluna.

# Tabela FORNECEDOR

A entidade **FORNECEDOR** desempenha um papel fundamental em um sistema ERP (Enterprise Resource Planning) e em processos de negócios em geral.

## Abastecimento de Recursos
- Os fornecedores são fontes externas de recursos, materiais e serviços que uma empresa precisa para operar. Eles fornecem matérias-primas, componentes, equipamentos, serviços e outros itens essenciais para a produção ou prestação de serviços da empresa.

## Relacionamento Comercial
- O relacionamento com os fornecedores é vital para o sucesso de uma empresa. Um sistema ERP armazena informações detalhadas sobre os fornecedores, incluindo dados de contato, histórico de transações, contratos, termos de pagamento e outros detalhes importantes que ajudam a manter e gerenciar esse relacionamento.

## Gestão de Compras e Estoque
- A entidade fornecedor permite que as empresas gerenciem eficientemente suas compras e estoques. Os sistemas ERP usam informações de fornecedores para realizar cotações, ordens de compra, recebimentos de mercadorias, controle de estoque e outras atividades relacionadas à cadeia de suprimentos.

## Qualidade e Confiabilidade
- Selecionar fornecedores confiáveis e de alta qualidade é essencial para garantir a qualidade dos produtos e serviços oferecidos pela empresa. O sistema ERP pode manter registros detalhados de desempenho do fornecedor, incluindo avaliações de qualidade, conformidade com regulamentações, histórico de entregas e feedbacks de clientes.

## Gestão Financeira
- A gestão financeira eficaz depende de informações precisas sobre os custos de materiais e serviços fornecidos pelos fornecedores. Os sistemas ERP integram informações financeiras relacionadas a fornecedores, como faturas, pagamentos, termos de crédito e relatórios de desempenho financeiro.

## Análise e Tomada de Decisão
- Os dados relacionados aos fornecedores são essenciais para análises e tomadas de decisão estratégicas. As empresas podem usar informações sobre desempenho de fornecedores, tendências de preços, condições de mercado e outros fatores para otimizar suas operações, reduzir custos, identificar oportunidades de melhoria e mitigar riscos.

## Descrição dos Campos

- **ID**: Identificador único para cada registro de fornecedor na tabela.
- **EMPRESA**: CNPJ da empresa fornecedora, relacionado à tabela EMPRESA.
- **F001DATETIEMEC**: Data e hora da inclusão do registro no sistema.
- **F002CPFCNPJ**: Documento CPF ou CNPJ do fornecedor.
- **F003FUNDDATANASC**: Data de fundação ou data de nascimento do fornecedor.
- **F004NOMERAZAO**: Razão Social ou Nome do fornecedor.

## Restrições e Relacionamentos

- Restrição `CHK_FORNECEDOR_DATANASC`: Garante que o fornecedor seja maior de idade se a empresa associada estiver localizada no estado do Paraná.
- Restrição `CHK_FORNECEDOR_ISVALIDDOC`: Verifica se o documento CPF/CNPJ é válido.
- Restrição `UNQ1_FORNECEDOR`: Garante a unicidade do CPF/CNPJ de cada fornecedor associado a uma empresa.
- Chave Estrangeira `FK_FORNECEDOR_1`: Estabelece uma relação entre a tabela de fornecedores e a tabela de empresas (EMPRESA), garantindo que cada fornecedor esteja associado a uma empresa válida.

Essas restrições e relacionamentos garantem a consistência e a integridade dos dados na tabela de fornecedores, essenciais para um funcionamento adequado do sistema ERP.

# Micro Framework Controller

O Micro Framework Controller é uma estrutura simples para gerenciar controladores em aplicativos Delphi. Ele fornece uma maneira fácil de criar e manipular controladores que lidam com modelos de dados e visualizações.

## Classes Principais

### TControllerAbstract

A classe `TControllerAbstract` é a base para todos os controladores. Ela gerencia a conexão entre o modelo de dados e a visualização, bem como a lógica de negócios associada.

#### Propriedades

- **model**: Representa o modelo associado a este controlador.
- **ViewName**: Representa o nome da visualização associada a este controlador.
- **Dataset**: Representa o conjunto de dados associado a este controlador.
- **View**: Representa a visualização associada a este controlador.
- **ListenAction**: Representa a ação de escuta associada a este controlador.
- **ListenDataset**: Representa o conjunto de dados de escuta associado a este controlador.
- **OutherDataset**: Representa outro conjunto de dados associado a este controlador.

#### Métodos Principais

- **Append**: Inicia um novo registro.
- **Cancel**: Cancela a operação atual.
- **Delete**: Exclui o registro atual.
- **Edit**: Edita o registro atual.
- **Open**: Abre a visualização com valores específicos.
- **Filter**: Aplica um filtro aos dados.
- **Refresh**: Atualiza os dados.
- **Post**: Grava os dados no conjunto de dados.

### TControllerFactory

A classe `TControllerFactory` é responsável por criar instâncias de controladores registrados.

#### Métodos

- **CreateController**: Cria uma instância do controlador registrado especificado.

### TViewController

A classe `TViewController` representa a visualização associada a um controlador.

## Helpers

### TFieldHelper

O helper `TFieldHelper` fornece métodos de formatação para campos de dados.

#### Métodos

- **FormatAsCnpj**: Formata o campo como um CNPJ.
- **FormatAsCpf**: Formata o campo como um CPF.
- **AsformatedDoc**: Formata o campo como um documento.

### TExceptionHelper

O helper `TExceptionHelper` fornece métodos auxiliares para trabalhar com exceções.

#### Métodos

- **Match**: Verifica se a mensagem de exceção corresponde a uma das mensagens especificadas.
- **Panic**: Cria uma nova exceção com a mensagem especificada e a lança imediatamente.

## Exemplos de Uso

```delphi
// Criar uma instância do controlador
var
  Controller: TControllerAbstract;
begin
  Controller := TControllerFactory.CreateController('NomeDoControlador');
  Controller.Append;
end;
// Formatando um campo como CNPJ
var
  Field: TField;
  FormatedCnpj: String;
begin
  FormatedCnpj := Field.FormatAsCnpj;
end;
// Lidando com exceções
try
  // Algum código que possa gerar uma exceção
except
  on E: Exception do
  begin
    if E.Match(['Error 1', 'Error 2']) >= 0 then
    begin
      // Tratar a exceção
    end
    else
    begin
      E.Panic('Erro crítico ocorreu!');
    end;
  end;
end;

