/******************************************************************************/
/****                      Creating stored procedures                      ****/
/******************************************************************************/
SET TERM ^ ;

CREATE PROCEDURE PROC_VALID_CNPJ(
  CNPJ VARCHAR(30) /* COLLATE NONE - default */)
RETURNS (
  VALIDO SMALLINT)
AS
BEGIN
  SUSPEND;
END
^

CREATE PROCEDURE PROC_VALID_CPF(
  CPF CHAR(11) CHARACTER SET WIN1252 /* COLLATE WIN1252 - default */)
RETURNS (
  VALIDO SMALLINT)
AS
BEGIN
  SUSPEND;
END
^

CREATE PROCEDURE SP_GEN_EMPRESA_ID
RETURNS (
  ID INTEGER)
AS
BEGIN
  SUSPEND;
END
^

CREATE PROCEDURE SP_GEN_FORNECEDOR_ID
RETURNS (
  ID INTEGER)
AS
BEGIN
  SUSPEND;
END
^


/******************************************************************************/
/****                   Creating generators (sequences)                    ****/
/******************************************************************************/
SET TERM ; ^

CREATE GENERATOR GEN_EMPRESA_ID;

CREATE GENERATOR GEN_FORNECEDOR_ID;


/******************************************************************************/
/****              Creating tables (without computed fields)               ****/
/******************************************************************************/
CREATE TABLE EMPRESA (
    ID INTEGER NOT NULL,
    E001XFANT VARCHAR(60) NOT NULL /* COLLATE NONE - default */,
    E002UF VARCHAR(2) NOT NULL /* COLLATE NONE - default */,
    E003CNPJ VARCHAR(14) NOT NULL /* COLLATE NONE - default */);

CREATE TABLE FORNECEDOR (
    ID INTEGER NOT NULL,
    EMPRESA VARCHAR(14) NOT NULL /* COLLATE NONE - default */,
    F001DATETIEMEC TIMESTAMP NOT NULL,
    F002CPFCNPJ VARCHAR(14) NOT NULL /* COLLATE NONE - default */,
    F003FUNDDATANASC DATE NOT NULL,
    F004NOMERAZAO VARCHAR(60) NOT NULL /* COLLATE NONE - default */);


/******************************************************************************/
/****                   Creating primary key constraints                   ****/
/******************************************************************************/
RECONNECT;

ALTER TABLE EMPRESA ADD CONSTRAINT PK_EMPRESA PRIMARY KEY (ID);

ALTER TABLE FORNECEDOR ADD CONSTRAINT PK_FORNECEDOR PRIMARY KEY (ID);


/******************************************************************************/
/****                     Creating unique constraints                      ****/
/******************************************************************************/
RECONNECT;

ALTER TABLE EMPRESA ADD CONSTRAINT UNQ1_EMPRESA UNIQUE (E003CNPJ);

ALTER TABLE FORNECEDOR ADD CONSTRAINT UNQ1_FORNECEDOR UNIQUE (F002CPFCNPJ, EMPRESA);


/******************************************************************************/
/****                   Creating foreign key constraints                   ****/
/******************************************************************************/
RECONNECT;

ALTER TABLE FORNECEDOR ADD CONSTRAINT FK_FORNECEDOR_1 FOREIGN KEY (EMPRESA) REFERENCES EMPRESA (E003CNPJ) ON DELETE CASCADE;


/******************************************************************************/
/****                      Creating check constraints                      ****/
/******************************************************************************/
ALTER TABLE EMPRESA ADD CONSTRAINT CHK_EMPRESA_CNPJ CHECK((SELECT VALIDO FROM PROC_VALID_CNPJ(E003CNPJ ) ) =1);

ALTER TABLE EMPRESA ADD CONSTRAINT CHK_EMPRESA_UF CHECK(UPPER(E002UF) IN ('AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'));

ALTER TABLE FORNECEDOR ADD CONSTRAINT CHK_FORNECEDOR_DATANASC CHECK((
        CHARACTER_LENGTH(FORNECEDOR.F002CPFCNPJ) = 11 -- Verifica se é um CPF válido
        AND 
        DATEADD(YEAR, 18, FORNECEDOR.F003FUNDDATANASC) < CURRENT_DATE -- Verifica se o fornecedor tem menos de 18 anos
        AND
        (
            SELECT EMPRESA.E002UF
            FROM EMPRESA
            WHERE EMPRESA.E003CNPJ = FORNECEDOR.EMPRESA
        ) = 'PR'
    )
    OR
    CHARACTER_LENGTH(FORNECEDOR.F002CPFCNPJ) <> 11);

ALTER TABLE FORNECEDOR ADD CONSTRAINT CHK_FORNECEDOR_ISVALIDDOC CHECK(
       IIF( CHARACTER_LENGTH( FORNECEDOR.F002CPFCNPJ) < 14 , ( SELECT VALIDO
                                                               FROM PROC_VALID_CPF(F002CPFCNPJ)  ),

                                                               (select VALIDO
                                                               from PROC_VALID_CNPJ(F002CPFCNPJ)
                                                               )) =1

      );


/******************************************************************************/
/****                          Creating triggers                           ****/
/******************************************************************************/
SET TERM ^ ;

CREATE TRIGGER EMPRESA_BI FOR EMPRESA
ACTIVE
BEFORE INSERT
POSITION 0 
AS
BEGIN
  IF (NEW.ID IS NULL) THEN
    NEW.ID = GEN_ID(GEN_EMPRESA_ID,1);
END
^

CREATE TRIGGER FORNECEDOR_BI FOR FORNECEDOR
ACTIVE
BEFORE INSERT
POSITION 0 
AS
BEGIN
  IF (NEW.ID IS NULL) THEN
    NEW.ID = GEN_ID(GEN_FORNECEDOR_ID,1);
END
^


/******************************************************************************/
/****                      Altering stored procedures                      ****/
/******************************************************************************/
ALTER PROCEDURE PROC_VALID_CNPJ(
  CNPJ VARCHAR(30) /* COLLATE NONE - default */)
RETURNS (
  VALIDO SMALLINT)
AS
declare variable TMP_CNPJ varchar(30);
declare variable I integer;
declare variable L integer;
declare variable T integer;
BEGIN
  -- código da comunidade show delphi, adaptado por Giovani Da Cruz
  CNPJ = TRIM(:CNPJ);
 
  /* DIGITOS IDENTICOS */
  IF (
  (CHARACTER_LENGTH(CNPJ) <> 14) OR
  (CNPJ = '00000000000000') OR (CNPJ = '11111111111111') OR
  (CNPJ = '22222222222222') OR (CNPJ = '33333333333333') OR (CNPJ = '44444444444444')OR
  (CNPJ = '55555555555555') OR (CNPJ = '66666666666666') OR (CNPJ = '77777777777777')OR
  (CNPJ = '88888888888888') OR (CNPJ = '99999999999999')
  ) THEN
  BEGIN
    VALIDO = 0;
 
    SUSPEND;
    Exit;
  END
 
  I = 1;
  TMP_CNPJ = '';
  while (I <= CHAR_LENGTH(CNPJ)) do
  BEGIN
    IF (SUBSTRING(CNPJ FROM I FOR 1) BETWEEN '0' AND '9') THEN
      TMP_CNPJ = TMP_CNPJ || SUBSTRING(CNPJ FROM I FOR 1);
    I = I + 1;
  END
 
  IF (CHAR_LENGTH(TMP_CNPJ) <> 14) THEN
  BEGIN
    VALIDO = 0;
    suspend;
    exit;
  END
 
  L = 0;
  while (L < 2) do
  BEGIN
    I = 1;
    T = 0;
    while (I < 13 + L) do
    BEGIN
      T = T + (MOD(20 - I + L, 8) + 2) * CAST(SUBSTRING(TMP_CNPJ FROM I FOR 1) AS INTEGER);
      I = I + 1;
    END
    T = MOD(T, 11);
    IF (T < 2) THEN
    BEGIN
      T = 0;
    END
    ELSE
    BEGIN
      T = 11 - T;
    END
 
    IF (T <> CAST(SUBSTRING(TMP_CNPJ FROM 13 + L FOR 1) AS INTEGER)) THEN
    BEGIN
      VALIDO = 0;
      suspend;
      exit;
    END
 
    L = L + 1;
  END
 
  VALIDO = 1;
  suspend;
END
^

ALTER PROCEDURE PROC_VALID_CPF(
  CPF CHAR(11) CHARACTER SET WIN1252 /* COLLATE WIN1252 - default */)
RETURNS (
  VALIDO SMALLINT)
AS
DECLARE variable SOMA INTEGER;
DECLARE variable RESTO SMALLINT;
DECLARE variable CONT SMALLINT;
BEGIN
  -- código da comunidade show delphi, adaptado por Giovani Da Cruz
 
  /* DIGITOS IDENTICOS */
  IF (
  (CHARACTER_LENGTH(CPF) <> 11) OR
  (CPF = '00000000000') OR (CPF = '11111111111') OR
  (CPF = '22222222222') OR (CPF = '33333333333') OR (CPF = '44444444444')OR
  (CPF = '55555555555') OR (CPF = '66666666666') OR (CPF = '77777777777')OR
  (CPF = '88888888888') OR (CPF = '99999999999')
  ) THEN
  BEGIN
    VALIDO = 0;
 
    SUSPEND;
    Exit;
  END
 
  /* INICIALIZA VARIÁVEIS */
  CONT=1;
  SOMA=0;
  RESTO=0;
 
  /* SOMA OS DÍGITOS MULTIPLICADOS E CALCULA O RESTO */
  WHILE (CONT<=9) DO
  BEGIN
    SOMA = SOMA + CAST( SUBSTRING(CPF FROM :CONT FOR 1) AS SMALLINT) * (11 - :CONT);
    CONT = CONT + 1;
  END
  RESTO=MOD(SOMA,11);
 
  /* TRATA O CASO DE RESTO INFERIOR A 2 */
  IF ( (RESTO < 2) AND (SUBSTRING(CPF FROM 10 FOR 1) <> '0') )THEN
  BEGIN
    VALIDO = 0;
  END
  ELSE
  BEGIN
    /*VERIFICA SE O PRIMEIRO DIGITO CONFERE*/
    IF (11-:RESTO<>CAST(SUBSTRING(CPF FROM 10 FOR 1) AS INTEGER)) THEN
    BEGIN
      VALIDO=0;
    END
    ELSE
    BEGIN
      CONT=1;
      SOMA=0;
 
      /*MULTIPLICA, SOMA E CALCULA O RESTO*/
      WHILE (CONT<=10) DO
      BEGIN
        SOMA = SOMA + CAST(SUBSTRING(CPF FROM :CONT FOR 1) AS SMALLINT) * (12-:CONT);
        CONT = CONT + 1;
      END
      RESTO = MOD(:SOMA,11);
 
      /*VERIFICA O SEGUNDO DÍGITO*/
      IF ((RESTO < 2) AND (SUBSTRING(CPF FROM 11 FOR 1) <> '0')) THEN
      BEGIN
        VALIDO=0;
      END
      ELSE
      BEGIN
        IF (11 - :RESTO <> CAST(SUBSTRING(CPF FROM 11 FOR 1) AS INTEGER)) THEN
        BEGIN
          VALIDO = 0;
        END
        ELSE
        BEGIN
          VALIDO = 1;
        END
      END
    END
  END
 
  SUSPEND;
END
^

ALTER PROCEDURE SP_GEN_EMPRESA_ID
RETURNS (
  ID INTEGER)
AS
BEGIN
  ID = GEN_ID(GEN_EMPRESA_ID, 1);
  SUSPEND;
END
^

ALTER PROCEDURE SP_GEN_FORNECEDOR_ID
RETURNS (
  ID INTEGER)
AS
BEGIN
  ID = GEN_ID(GEN_FORNECEDOR_ID, 1);
  SUSPEND;
END
^


/******************************************************************************/
/****                       Updating object comments                       ****/
/******************************************************************************/
SET TERM ; ^

COMMENT ON TABLE EMPRESA IS
'A tabela EMPRESA é uma entidade fundamental em um sistema
ERP (Enterprise Resource Planning),pois armazena informações sobre as empresas
que utilizam o sistema.

Aqui estão alguns pontos importantes sobre a tabela e sua importância para um
sistema ERP:

Armazenamento de informações da empresa: A tabela EMPRESA armazena dados
importantes sobre as empresas, como o nome fantasia (E001XFANT), a sigla do
estado (E002UF) e o CNPJ (E003CNPJ). Essas informações são cruciais para identificar
e diferenciar as empresas cadastradas no sistema.

Garantia de integridade dos dados: A restrição UNQ1_EMPRESA garante que cada
CNPJ seja único na tabela, evitando a inserção de empresas duplicadas com o mesmo CNPJ.

Validação de dados: As restrições CHK1_EMPRESA e CHK2_EMPRESA aplicam validações
nos dados inseridos na tabela. A primeira restrição garante que a sigla do
estado esteja dentro de um conjunto pré-definido de valores válidos, enquanto a
segunda restrição verifica se o CNPJ informado é válido por meio de uma função
externa (PROC_VALID_CNPJ).

Chave primária e identificador único: A coluna ID é uma chave primária
autoincrementada que garante a unicidade de cada registro na tabela. O gatilho
EMPRESA_BI é responsável por gerar valores para o campo ID antes de inserir um
novo registro na tabela.

Descrição dos campos: A tabela inclui comentários que descrevem cada campo,
fornecendo informações adicionais sobre o propósito e o formato dos dados
armazenados em cada coluna.';

COMMENT ON COLUMN EMPRESA.ID IS
'ID Auto incremento da tabela , de ordem sequencial';

COMMENT ON COLUMN EMPRESA.E001XFANT IS
'Nome fantasia da Empresa';

COMMENT ON COLUMN EMPRESA.E002UF IS
'Sigla da UF';

COMMENT ON COLUMN EMPRESA.E003CNPJ IS
'Informar o CNPJ da empresa, deverão ser informados com os zeros 
não significativos.';

COMMENT ON TABLE FORNECEDOR IS
'A entidade "Fornecedor" desempenha um papel fundamental em um sistema ERP
(Enterprise Resource Planning) e em processos de negócios em geral.

Abastecimento de Recursos: Os fornecedores são fontes externas de recursos,
materiais e serviços que uma empresa precisa para operar. Eles fornecem matérias-primas,
componentes, equipamentos, serviços e outros itens essenciais para a produção
ou prestação de serviços da empresa.

Relacionamento Comercial: O relacionamento com os fornecedores é vital para o
 sucesso de uma empresa. Um sistema ERP armazena informações detalhadas sobre
 os fornecedores, incluindo dados de contato, histórico de transações, contratos,
 termos de pagamento e outros detalhes importantes que ajudam a manter e
 gerenciar esse relacionamento.

Gestão de Compras e Estoque: A entidade fornecedor permite que as empresas
gerenciem eficientemente suas compras e estoques. Os sistemas ERP usam informações de
fornecedores para realizar cotações, ordens de compra, recebimentos de
mercadorias, controle de estoque e outras atividades relacionadas à cadeia de
suprimentos.

Qualidade e Confiabilidade: Selecionar fornecedores confiáveis e de alta qualidade
é essencial para garantir a qualidade dos produtos e serviços oferecidos pela empresa.

O sistema ERP pode manter registros detalhados de desempenho do fornecedor,
incluindo avaliações de qualidade, conformidade com regulamentações, histórico
de entregas e feedbacks de clientes.

Gestão Financeira: A gestão financeira eficaz depende de informações precisas
sobre os custos de materiais e serviços fornecidos pelos fornecedores.

Os sistemas ERP integram informações financeiras relacionadas a fornecedores,
como faturas, pagamentos, termos de crédito e relatórios de desempenho financeiro.

Análise e Tomada de Decisão: Os dados relacionados aos fornecedores são
essenciais para análises e tomadas de decisão estratégicas.

As empresas podem usar informações sobre desempenho de fornecedores, tendências
de preços, condições de mercado e outros fatores para otimizar suas operações,
reduzir custos, identificar oportunidades de melhoria e mitigar riscos.


ID: É um identificador único para cada registro de fornecedor na tabela.
EMPRESA: Representa o CNPJ da empresa fornecedora. Essa referência é importante
         para vincular o fornecedor a uma empresa específica no sistema.

F001DATETIEMEC: Indica a data e hora em que o registro do fornecedor foi criado no sistema.
                Isso é útil para fins de auditoria e controle.

F002CPFCNPJ: Armazena o documento CPF ou CNPJ do fornecedor. Essa informação é
             crucial para identificar o fornecedor de forma única e para fins legais e fiscais.

F003FUNDDATANASC: Representa a data de fundação ou data de nascimento do fornecedor.
                  Esta data é relevante para verificar se o fornecedor é menor de idade,
                  especialmente se for uma pessoa física.

F004NOMERAZAO: Contém o nome ou razão social do fornecedor. É fundamental
               para identificar o fornecedor de forma legível e para fins
               de comunicação e negociação.

Restrição de Verificação (CHECK CONSTRAINT):

Garante que o documento CPF/CNPJ seja válido, verificando se o tamanho do documento
está correto e se o CPF/CNPJ passa em uma validação específica.

Verifica se o fornecedor é menor de idade (menos de 18 anos) e se a empresa associada
está localizada no estado do Paraná. Isso é feito para garantir que não sejam cadastrados
fornecedores pessoa física menores de idade do Paraná.

Restrição de Unicidade (UNIQUE CONSTRAINT):

Garante que não haja fornecedores duplicados na tabela com base no documento
CPF/CNPJ e na empresa associada.

Chave Estrangeira (FOREIGN KEY CONSTRAINT):

Estabelece uma relação entre a tabela de fornecedores e a tabela de empresas (EMPRESA),
garantindo que cada fornecedor esteja associado a uma empresa válida.

Essas restrições e relações garantem a consistência e a integridade dos dados na
tabela de fornecedores, essenciais para um funcionamento adequado do sistema ERP.

O cadastro correto e completo de fornecedores é crucial para o bom funcionamento
de operações de compras, estoque e gestão financeira em um negócio.';

COMMENT ON COLUMN FORNECEDOR.ID IS
'ID Auto incremento da tabela, controlador de ordem numérica';

COMMENT ON COLUMN FORNECEDOR.EMPRESA IS
'Documento CNPJ da empresa relacional a Tabela EMPRESA';

COMMENT ON COLUMN FORNECEDOR.F001DATETIEMEC IS
'Data e hora da inclusao do registro no sistema';

COMMENT ON COLUMN FORNECEDOR.F002CPFCNPJ IS
'Documento CPF/CNPJ do Fornecedor';

COMMENT ON COLUMN FORNECEDOR.F003FUNDDATANASC IS
'Fundação ou Data de nascimento caso seja informado um CPF.
Caso a empresa seja do Paraná, não permitir cadastrar um fornecedor 
pessoa física menor de idade;';

COMMENT ON COLUMN FORNECEDOR.F004NOMERAZAO IS
'Razão Social ou Nome do fornecedor';

COMMENT ON PROCEDURE PROC_VALID_CNPJ IS
'Essa stored procedure é uma rotina armazenada em um banco de dados Firebird, que
tem a finalidade de validar se um CNPJ (Cadastro Nacional da Pessoa Jurídica) é
válido. Ela verifica se o CNPJ tem 14 dígitos numéricos e se está de acordo com
as regras de formação desse documento no Brasil.

Atribuição e tratamento do CNPJ: O CNPJ é recebido como parâmetro e é removido
de possíveis espaços em branco no início e no fim utilizando a função TRIM.

Verificação de dígitos idênticos: A primeira verificação feita é para garantir
que o CNPJ não seja composto apenas de dígitos idênticos, como ''00000000000000'',
''11111111111111'', etc. Se o CNPJ tiver essa característica, a variável VALIDO é
definida como 0 e a execução da stored procedure é interrompida.

Limpeza e validação do CNPJ: O próximo passo é remover quaisquer caracteres que
não sejam dígitos numéricos do CNPJ e garantir que o CNPJ tenha exatamente 14
dígitos após essa limpeza. Se o CNPJ não tiver 14 dígitos após essa etapa, a
variável VALIDO é definida como 0 e a execução é interrompida.

Validação dos dígitos verificadores: Em seguida, a stored procedure valida os
dígitos verificadores do CNPJ. O algoritmo utilizado para isso segue as regras
estabelecidas pela Receita Federal do Brasil para verificar a validade do CNPJ.

Os dígitos verificadores são calculados e comparados com os dígitos informados no
CNPJ. Se os dígitos verificadores não corresponderem, a variável VALIDO é
definida como 0 e a execução é interrompida.

Resultado da validação: Se todas as etapas de validação forem concluídas com
sucesso, a variável VALIDO é definida como 1, indicando que o CNPJ é válido.
A execução da stored procedure é então suspensa e o resultado da validação é
retornado.

Esta stored procedure é utilizada para garantir a integridade dos dados em um
banco de dados Firebird, permitindo que o sistema valide se os CNPJs fornecidos
são válidos de acordo com as regras estabelecidas.';


/******************************************************************************/
/****                     Granting missing privileges                      ****/
/******************************************************************************/
GRANT EXECUTE ON PROCEDURE PROC_VALID_CPF TO SYSDBA;

GRANT EXECUTE ON PROCEDURE PROC_VALID_CNPJ TO SYSDBA;

GRANT EXECUTE ON PROCEDURE SP_GEN_EMPRESA_ID TO SYSDBA;

GRANT EXECUTE ON PROCEDURE SP_GEN_FORNECEDOR_ID TO SYSDBA;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON FORNECEDOR TO SYSDBA WITH GRANT OPTION;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON EMPRESA TO SYSDBA WITH GRANT OPTION;

