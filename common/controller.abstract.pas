{*****************************************************************************}
{                                                                             }
{                          Unit Controller.Abstract                           }
{                        Developed by: Carlos Alberto                         }
{                        Email: filhotecmail@gmail.com                        }
{   GitHub: https://github.com/filhotecmail/Cadastro-de-fornecedor-Delphi     }
{               Objective: Create a simple MVC CRUD program                   }
{                                                                             }
{  Licensed under the Apache License, Version 2.0 (the "License");            }
{  you may not use this file except in compliance with the License.           }
{  You may obtain a copy of the License at                                    }
{                                                                             }
{      http://www.apache.org/licenses/LICENSE-2.0                             }
{                                                                             }
{  Unless required by applicable law or agreed to in writing, software        }
{  distributed under the License is distributed on an "AS IS" BASIS,          }
{  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   }
{  See the License for the specific language governing permissions and        }
{  limitations under the License.                                             }
{                                                                             }
{*****************************************************************************}

unit controller.abstract;

interface

uses
  System.SysUtils,
  System.Classes,
  Winapi.CommDlg,
  Winapi.Windows,
  Vcl.Dialogs,
  Vcl.Controls,
  Vcl.ComCtrls,
  Firedac.comp.client,
  Data.DB,
  Vcl.forms,
  model.abstract,
  Datasnap.Provider, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList;

 Type TActionController = (oActionNone,oActionAppend,oActionOpen);

 type
  TControllerAbstract = class;
  TControllerFactory  = class;
  TViewController     = class;

  /// <author>Carlos Alberto Dias da Silva Filho</author>
  /// <version>1.0</version>
  TControllerAbstract = class( TDataModule )
    oProvider: TDataSetProvider;
    oTimerStatus: TTimer;
    procedure oTimerStatusTimer(Sender: TObject);
  protected
    function ShowView( AviewName: String ): TForm;
  private
  { Private declarations }
    FModelName: TModelAbstract;
    FViewName: String;
    FDataset: TDataset;
    FView: TViewController;
    FClassView: TPersistentClass;
    FListenAction: TActionController;
    FListenDataset: TDataset;
    FOutherDataset: TDataset;
    procedure SetModelName( const Value: TModelAbstract );
    procedure SetViewName(const Value: String);
    procedure SetDataset(const Value: TDataset);
    procedure SetView(const Value: TViewController);
    procedure SetListenAction(const Value: TActionController);
    procedure SetListenDataset(const Value: TDataset);
    procedure SetOutherDataset(const Value: TDataset);
  public
   { Public declarations }
    procedure ShowController; virtual;
   {Controles}
    procedure Post;
    procedure Append;
    procedure Cancel;
    procedure Delete;
    procedure Refresh;
    procedure Edit;
    procedure Open(AValues: Array of variant); virtual;
    procedure Filter(ACondition: string; AValue: String); virtual;
    function AsFd:TFDQuery;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
   {Propriedades}
       ///  <summary>
      ///    Representa o modelo associado a este controlador.
      ///  </summary>
      ///  <remarks>
      ///    Utilize esta propriedade para acessar e manipular o modelo de dados associado a este controlador.
      ///  </remarks>
      ///  <seealso cref="TModelAbstract"/>
      property model: TModelAbstract read FModelName write SetModelName;

      ///  <summary>
      ///    Representa o nome da visualização associada a este controlador.
      ///  </summary>
      ///  <remarks>
      ///    Utilize esta propriedade para obter ou definir o nome da visualização associada a este controlador.
      ///  </remarks>
      property ViewName: String read FViewName write SetViewName;

      ///  <summary>
      ///    Representa o conjunto de dados associado a este controlador.
      ///  </summary>
      ///  <remarks>
      ///    Utilize esta propriedade para acessar e manipular o conjunto de dados associado a este controlador.
      ///  </remarks>
      ///  <seealso cref="TDataset"/>
      property Dataset: TDataset read FDataset write SetDataset;

      ///  <summary>
      ///    Representa a visualização associada a este controlador.
      ///  </summary>
      ///  <remarks>
      ///    Utilize esta propriedade para obter ou definir a visualização associada a este controlador.
      ///  </remarks>
      ///  <seealso cref="TViewController"/>
      property View: TViewController read FView write SetView;

      ///  <summary>
      ///    Representa a ação de escuta associada a este controlador.
      ///  </summary>
      ///  <remarks>
      ///    Utilize esta propriedade para obter ou definir a ação de escuta associada a este controlador.
      ///  </remarks>
      ///  <seealso cref="TActionController"/>
      property ListenAction: TActionController read FListenAction write SetListenAction;

      ///  <summary>
      ///    Representa o conjunto de dados de escuta associado a este controlador.
      ///  </summary>
      ///  <remarks>
      ///    Utilize esta propriedade para acessar e manipular o conjunto de dados de escuta associado a este controlador.
      ///  </remarks>
      ///  <seealso cref="TDataset"/>
      property ListenDataset: TDataset read FListenDataset write SetListenDataset;

      ///  <summary>
      ///    Representa outro conjunto de dados associado a este controlador.
      ///  </summary>
      ///  <remarks>
      ///    Utilize esta propriedade para acessar e manipular outro conjunto de dados associado a este controlador.
      ///  </remarks>
      ///  <seealso cref="TDataset"/>
      property OutherDataset: TDataset read FOutherDataset write SetOutherDataset;

  end;

  TControllerFactory = class
  public
  ///  <summary>Cria uma instância do controlador registrado especificado.</summary>
  ///  <param name="NomeRegistrado">O nome do controlador registrado a ser criado.</param>
  ///  <returns>Uma instância do controlador especificado.</returns>
  class function CreateController(const NomeRegistrado: string): TObject; overload;

  ///  <summary>Cria uma instância do controlador registrado especificado com ação e dependências.</summary>
  ///  <param name="NomeRegistrado">O nome do controlador registrado a ser criado.</param>
  ///  <param name="Action">Ação a ser associada ao controlador.</param>
  ///  <param name="ADeps">Dataset de dependências associado ao controlador.</param>
  ///  <returns>Uma instância do controlador especificado com ação e dependências.</returns>
  class function CreateController(const NomeRegistrado: string; Action: TActionController; ADeps: TDataset): TObject; overload;
  end;

  TViewController = class(TForm)
  private
    FController: TControllerAbstract;
    procedure SetController(const Value: TControllerAbstract);
  public
      property Controller: TControllerAbstract read FController write SetController;
 end;

 type TFieldHelper = class Helper for TField
      function FormatAsCnpj: String;
      function FormatAsCpf: String;
      function AsformatedDoc:String;
 end;

 {  --------------------------------------------------------------------------
  Classe: TExceptionHelper
  Resumo: Fornece métodos auxiliares para trabalhar com exceções.
  Descrição:
    Esta classe fornece métodos auxiliares para trabalhar com exceções, como a capacidade de verificar se uma
    exceção contém determinadas mensagens de erro e criar uma nova exceção com uma mensagem especificada
    e lançá-la imediatamente.
  ---------------------------------------------------------------------------
}
 type
  TExceptionHelper = class helper for Exception
    function Match(const Messages: array of string): Integer;
    function Panic(const PMessage: string):Exception;
  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}

uses commom.system.logger, dao.abstract;
{$R *.dfm}

function FormatCPF(const CPF: string): string;
begin

  if Length(CPF) <> 11 then
  begin
    Result := CPF;
    Exit;
  end;

  Result := Format('%s.%s.%s-%s', [Copy(CPF, 1, 3), Copy(CPF, 4, 3),
    Copy(CPF, 7, 3), Copy(CPF, 10, 2)]);
end;

function FormatCNPJ(const CNPJ: string): string;
begin

  if Length(CNPJ) <> 14 then
  begin
    Result := CNPJ;
    Exit;
  end;

  Result := Format('%s.%s.%s/%s-%s', [Copy(CNPJ, 1, 2), Copy(CNPJ, 3, 3),
    Copy(CNPJ, 6, 3), Copy(CNPJ, 9, 4), Copy(CNPJ, 13, 2)]);

end;

{ TControllerAbstract }

{  --------------------------------------------------------------------------
  Procedimento: TControllerAbstract.Append
  Resumo: Solicita confirmação antes de iniciar um novo registro na tabela.
  Descrição:
    Este procedimento exibe um diálogo de confirmação para o usuário antes de iniciar um novo registro na
    tabela associada ao controlador. O diálogo apresenta uma mensagem perguntando se o usuário deseja iniciar
    um novo registro. Se o usuário confirmar, um novo registro é iniciado na tabela.
  Parâmetros:
    Nenhum.
  Observações:
    O diálogo de confirmação é exibido com um ícone de escudo e botões "Sim" e "Não".
  ---------------------------------------------------------------------------
}
procedure TControllerAbstract.AfterConstruction;
begin
  inherited;
  oTimerStatus.Enabled := true;
  logger.WriteLogConstrutor( Self );
end;


{  --------------------------------------------------------------------------
  Procedimento: TControllerAbstract.Append
  Resumo: Executa a ação de inclusão de um novo registro.
  Descrição:
    Este procedimento exibe uma caixa de diálogo de confirmação para iniciar a inclusão de um novo registro na
    tabela associada. Se o usuário confirmar a ação, o método Dataset.Append é chamado para iniciar a inclusão
    do novo registro.
  Observações:
    Certifique-se de que o conjunto de dados (Dataset) associado ao controlador está devidamente configurado antes de
    chamar este método. A exibição da caixa de diálogo e a inclusão do registro são condicionadas à interação do usuário.
  ---------------------------------------------------------------------------
}
procedure TControllerAbstract.Append;
var
  TaskDialog: TTaskDialog;
begin

  TaskDialog := TTaskDialog.Create(nil);
  try
    TaskDialog.Caption  := 'Confirmação de inclusão de registro!';
    TaskDialog.Text     := 'Você deseja iniciar um novo registro na tabela?';
    TaskDialog.MainIcon :=  tdiShield;
    TaskDialog.CommonButtons := [tcbYes, tcbNo];

    if TaskDialog.Execute  then
      if TaskDialog.ModalResult= mrYes then
         Dataset.Append;

  finally
    TaskDialog.Free;
  end;
end;

{  --------------------------------------------------------------------------
  Procedimento: TControllerAbstract.Cancel
  Resumo: Solicita confirmação antes de cancelar a operação atual.
  Descrição:
    Este procedimento exibe um diálogo de confirmação para o usuário antes de cancelar a operação atual.
    O diálogo apresenta uma mensagem perguntando se o usuário realmente deseja cancelar a operação atual,
    alertando que os dados serão perdidos se confirmado. Se o usuário confirmar, a operação atual é cancelada.
  Parâmetros:
    Nenhum.
  Observações:
    O diálogo de confirmação é exibido com um ícone de escudo e botões "Sim" e "Não".
  ---------------------------------------------------------------------------
}
function TControllerAbstract.AsFd: TFDQuery;
begin
 Result:= TFDQuery(Dataset);
end;

{  --------------------------------------------------------------------------
  Procedimento: TControllerAbstract.BeforeDestruction
  Resumo: Executa ações antes da destruição do objeto.
  Descrição:
    Este procedimento é chamado automaticamente pelo sistema antes da destruição do objeto.
    Ele chama o método BeforeDestruction da classe pai e registra uma entrada de log indicando a destruição do objeto.
  Observações:
    Este procedimento é geralmente usado para executar limpezas finais ou ações de desalocação de recursos antes
    da destruição do objeto.
  ---------------------------------------------------------------------------
}
procedure TControllerAbstract.BeforeDestruction;
begin
  inherited;
 logger.WriteLogDestructor( Self );
end;

procedure TControllerAbstract.Cancel;
 var
  TaskDialog: TTaskDialog;
begin

  TaskDialog := TTaskDialog.Create(nil);
  try
    TaskDialog.Caption  := 'Confirmação de Cancelamento de operação!';
    TaskDialog.Text     := 'Você realmente cancelar a operação atual, atenção os dados serão perdidos!';
    TaskDialog.MainIcon :=  tdiShield;
    TaskDialog.CommonButtons := [tcbYes, tcbNo];

    if TaskDialog.Execute  then
      if TaskDialog.ModalResult= mrYes then
         Dataset.Cancel;

  finally
    TaskDialog.Free;
  end;
end;


{  --------------------------------------------------------------------------
  Procedimento: TControllerAbstract.Delete
  Resumo: Solicita confirmação antes de excluir o registro atual.
  Descrição:
    Este procedimento verifica se o conjunto de dados está vazio e, em seguida, exibe um diálogo de confirmação
    para o usuário antes de excluir o registro atual. O diálogo apresenta uma mensagem perguntando se o usuário
    realmente deseja excluir o registro atual, alertando que os dados serão perdidos se confirmado.
    Se o usuário confirmar, o registro atual é excluído.
  Parâmetros:
    Nenhum.
  Observações:
    O diálogo de confirmação é exibido com um ícone de escudo e botões "Sim" e "Não".
  ---------------------------------------------------------------------------
}
procedure TControllerAbstract.Delete;
var
  TaskDialog: TTaskDialog;
begin
  if Dataset.IsEmpty then Exit;

  TaskDialog := TTaskDialog.Create(nil);
  try
    TaskDialog.Caption  := 'Confirmação de exclusão de registro!';
    TaskDialog.Text     := 'Você realmente quer excluir o registro atual?, atenção os dados serão perdidos!';
    TaskDialog.MainIcon :=  tdiShield;
    TaskDialog.CommonButtons := [tcbYes, tcbNo];

    if TaskDialog.Execute  then
      if TaskDialog.ModalResult= mrYes then
         Dataset.Delete;

  finally
    TaskDialog.Free;
  end;
end;


{  --------------------------------------------------------------------------
  Procedimento: TControllerAbstract.Edit
  Resumo: Solicita confirmação antes de editar o registro atual.
  Descrição:
    Este procedimento verifica se o conjunto de dados está vazio e, em seguida, exibe um diálogo de confirmação
    para o usuário antes de editar o registro atual. O diálogo apresenta uma mensagem perguntando se o usuário
    realmente deseja editar o registro atual. Se o usuário confirmar, o registro atual é editado.
  Parâmetros:
    Nenhum.
  Observações:
    O diálogo de confirmação é exibido com um ícone de informação e botões "Sim" e "Não".
  ---------------------------------------------------------------------------
}
procedure TControllerAbstract.Edit;
var
  TaskDialog: TTaskDialog;
begin
  if Dataset.IsEmpty then Exit;

  TaskDialog := TTaskDialog.Create(nil);
  try
    TaskDialog.Caption  := 'Confirmação de Edição';
    TaskDialog.Text     := 'Você realmente deseja editar este registro?';
    TaskDialog.MainIcon :=  tdiInformation;
    TaskDialog.CommonButtons := [tcbYes, tcbNo];

    if TaskDialog.Execute  then
      if TaskDialog.ModalResult= mrYes then
         Dataset.Edit;

  finally
    TaskDialog.Free;
  end;
end;

procedure TControllerAbstract.Filter(ACondition, AValue: String);
begin
 raise ENotImplemented.Create('Não implementado!');
end;

procedure TControllerAbstract.Open(AValues: array of variant);
begin
//
end;

{  --------------------------------------------------------------------------
  Procedimento: TControllerAbstract.oTimerStatusTimer
  Resumo: Manipula o evento OnTimer do temporizador para atualizar informações na barra de status.
  Descrição:
    Este procedimento é chamado periodicamente pelo evento OnTimer de um temporizador para atualizar as
     informações exibidas na barra de status. Ele verifica se a visualização associada está disponível e se a
     barra de status está presente. Em seguida, configura o evento OnDrawPanel da barra de status para o método
     StatusBarDrawPanel, que é responsável por desenhar um ícone de status personalizado em um dos painéis da barra de
     status. Se não houver painéis na barra de status, adiciona os painéis necessários e configura seus textos iniciais.
     Caso contrário, atualiza o texto do segundo painel com a data e hora atual.
  Parâmetros:
    - Sender: O objeto que gerou o evento, neste caso, o temporizador.
  Observações:
    Certifique-se de que um objeto TStatusBar com o nome 'oBar' está presente na visualização associada a este
    controlador para que a atualização da barra de status ocorra corretamente.
  ---------------------------------------------------------------------------
}
procedure TControllerAbstract.oTimerStatusTimer(Sender: TObject);
var
  LStatusBar: TStatusBar;
begin

 if View = nil then Exit;

 LStatusBar:= View.FindComponent('oBar') as TStatusBar;

 if LStatusBar = nil then Exit;

 if LStatusBar.Panels.Count <= 0 then
  begin

    with LStatusBar.Panels.Add do
    begin
      Text  := 'Data e hora';
      Width := 120;
    end;

    with LStatusBar.Panels.Add do
    begin
      Text  := '';
      Width := 120;
      Text  := DateTimeToStr(now);
    end;

  end else
  begin

   with LStatusBar.Panels[1] do
        Text:= DateTimeToStr(now);

  end;

end;

{  --------------------------------------------------------------------------
  Procedimento: TControllerAbstract.Post
  Resumo: Solicita confirmação antes de gravar os dados na tabela.
  Descrição:
    Este procedimento exibe um diálogo de confirmação para o usuário antes de gravar os dados na tabela
    associada ao controlador. O diálogo apresenta uma mensagem perguntando se o usuário realmente deseja
    gravar os dados na tabela, com uma nota para revisar os dados antes de confirmar. Se o usuário confirmar,
    os dados são gravados na tabela.
  Parâmetros:
    Nenhum.
  Observações:
    O diálogo de confirmação é exibido com um ícone de escudo e botões "Sim" e "Não".
  ---------------------------------------------------------------------------
}
procedure TControllerAbstract.Post;
var
  TaskDialog: TTaskDialog;
begin

  TaskDialog := TTaskDialog.Create(nil);
  try
    TaskDialog.Caption  := 'Confirmação de gravação de registro!';
    TaskDialog.Text     := 'Você deseja gravar os dados na tabela?, revise os dados!';
    TaskDialog.MainIcon :=  tdiShield;
    TaskDialog.CommonButtons := [tcbYes, tcbNo];

    if TaskDialog.Execute  then
      if TaskDialog.ModalResult= mrYes then
         Dataset.Post;

  finally
    TaskDialog.Free;
  end;
end;


{  --------------------------------------------------------------------------
  Procedimento: TControllerAbstract.Refresh
  Resumo: Atualiza os dados na tabela.
  Descrição:
    Este procedimento atualiza os dados na tabela associada ao controlador. Isso significa que quaisquer alterações
    feitas em outros locais que afetam os dados na tabela serão refletidas na exibição atual.
  Parâmetros:
    Nenhum.
  ---------------------------------------------------------------------------
}
procedure TControllerAbstract.Refresh;
begin
 Dataset.Refresh;
end;

procedure TControllerAbstract.SetDataset(const Value: TDataset);
begin
  FDataset := Value;
end;


procedure TControllerAbstract.SetListenAction(const Value: TActionController);
begin
  FListenAction := Value;
end;

procedure TControllerAbstract.SetListenDataset(const Value: TDataset);
begin
  FListenDataset := Value;
end;

procedure TControllerAbstract.SetModelName( const Value: TModelAbstract );
begin
  FModelName := Value;
  oProvider.DataSet := model.oDataset;
end;

procedure TControllerAbstract.SetOutherDataset(const Value: TDataset);
begin
  FOutherDataset := Value;
end;

procedure TControllerAbstract.SetView(const Value: TViewController);
begin
  FView := Value;

end;

{  --------------------------------------------------------------------------
  Procedimento: TControllerAbstract.SetViewName
  Resumo: Define o nome da visualização e associa-a ao controlador.
  Descrição:
    Este procedimento define o nome da visualização e associa-a ao controlador. Ele também configura
    o DataSource da visualização para usar o conjunto de dados do provedor associado ao controlador.
    Além disso, o método associa o próprio controlador à visualização.
  Parâmetros:
    - Value: O nome da visualização a ser definido.
  Observações:
    A visualização deve ser uma instância de TForm e deve ter um componente TDatasource com o nome 'oDs'
    para ser associada corretamente ao controlador.
  ---------------------------------------------------------------------------
}
procedure TControllerAbstract.SetViewName(const Value: String);
var
  Lview: TForm;
  LDatasource: TDatasource;
begin
  FViewName := Value;
  Lview:= ShowView(FViewName);
  View:= TViewController(Lview);
  LDatasource:= (Lview.FindComponent('oDs') as TDatasource);
  if LDatasource <> nil then
     LDatasource.DataSet:= oProvider.DataSet;
  Dataset:=  LDatasource.DataSet;
  TViewController(Lview).Controller:= Self;
end;

procedure TControllerAbstract.ShowController;
begin
  raise ENotImplemented.Create( 'Não implementado na classe base!' );
end;


{  --------------------------------------------------------------------------
  Função: TControllerAbstract.ShowView
  Resumo: Exibe a visualização com o nome especificado.
  Descrição:
    Esta função tenta localizar e exibir uma visualização com o nome especificado. Se a visualização for
    encontrada e for uma instância de TForm, ela será criada e retornada. Caso contrário, retorna nil.
  Parâmetros:
    - AViewName: O nome da visualização a ser exibida.
  Retorno:
    Uma instância de TForm se a visualização for encontrada e criada com sucesso, caso contrário, nil.
  ---------------------------------------------------------------------------
}
function TControllerAbstract.ShowView( AviewName: String ): TForm;
begin
  Result := nil;
  FClassView := FindClass( AviewName );
  if ( FClassView <> nil ) and FClassView.InheritsFrom( TForm )
  then
  begin
    Result := TFormClass( FClassView ).Create( Self );
  end;

end;

{ TControllerFactory }

{  --------------------------------------------------------------------------
  Função: TControllerFactory.CreateController
  Resumo: Cria uma instância do controlador com o nome registrado especificado.
  Descrição:
    Esta função cria uma instância do controlador com o nome registrado especificado. Se o
    nome registrado for encontrado no registro de classes e corresponder a uma classe que herda de
    TComponent, uma instância desse controlador será criada e seu método ShowController será chamado.
    Se ocorrer algum problema durante a criação ou execução do controlador, uma exceção será lançada.
  Parâmetros:
    - NomeRegistrado: O nome registrado do controlador a ser criado.
  Retorno:
    Uma instância do controlador criada, ou nil se ocorrer um erro durante o processo.
  Observações:
    Se o nome registrado não for encontrado no registro de classes ou se não corresponder a uma classe que
    herda de TComponent, uma exceção será lançada.
  ---------------------------------------------------------------------------
}

class function TControllerFactory.CreateController(const NomeRegistrado: string): TObject;
var
  LClass: TPersistentClass;
  ControllerInstance: TControllerAbstract;
  const C_MessageA='Controller de nome %s não localizado no registro ';
  const CMessageB = 'Ocorreu um problema ao tentar criar a instância do controller %s , verifique o erro %s ';
begin
  Result := nil;

  try
    LClass := GetClass(NomeRegistrado);
    if (Assigned(LClass)) and (LClass.InheritsFrom(TComponent)) then
    begin
      Result := TComponentClass(LClass).Create(Application);

      if (Result is TControllerAbstract) then
      begin
        ControllerInstance := TControllerAbstract(Result);
        ControllerInstance.ShowController;
      end
      else FreeAndNil(Result);
    end else
     raise Exception.CreateFmt( C_MessageA ,[ NomeRegistrado ]);
  except
    on E: Exception do
      raise Exception.CreateFmt( CMessageB , [NomeRegistrado, E.Message]);

  end

end;


{  --------------------------------------------------------------------------
  Função: TControllerFactory.CreateController
  Resumo: Cria uma instância do controlador com o nome registrado especificado e associa ação e conjunto de dados.
  Descrição:
    Esta função cria uma instância do controlador com o nome registrado especificado e associa uma
    ação e um conjunto de dados a ele. Se o nome registrado for encontrado no registro de classes e
    corresponder a uma classe que herda de TComponent, uma instância desse controlador será criada e as
    propriedades ListenAction e ListenDataset serão atribuídas com os valores passados. Em seguida,
    o método ShowController será chamado. Se ocorrer algum problema durante a criação ou execução do controlador,
    uma exceção será lançada.
  Parâmetros:
    - NomeRegistrado: O nome registrado do controlador a ser criado.
    - Action: A ação associada ao controlador.
    - ADeps: O conjunto de dados associado ao controlador.
  Retorno:
    Uma instância do controlador criada, ou nil se ocorrer um erro durante o processo.
  Observações:
    Se o nome registrado não for encontrado no registro de classes ou se não corresponder a uma classe que
    herda de TComponent, uma exceção será lançada.
  ---------------------------------------------------------------------------
}
class function TControllerFactory.CreateController(const NomeRegistrado: string; Action: TActionController;
  ADeps: TDataset): TObject;
var
  LClass: TPersistentClass;
  ControllerInstance: TControllerAbstract;
  const C_MessageA='Controller de nome %s não localizado no registro ';
  const CMessageB = 'Ocorreu um problema ao tentar criar a instância do controller %s , verifique o erro %s ';
begin
  Result := nil;

  try
    LClass := GetClass(NomeRegistrado);
    if (Assigned(LClass)) and (LClass.InheritsFrom(TComponent)) then
    begin
      Result := TComponentClass(LClass).Create(nil);

      if (Result is TControllerAbstract) then
      begin
        ControllerInstance := TControllerAbstract(Result);

        ControllerInstance.ListenAction  := Action;
        ControllerInstance.ListenDataset := ADeps;

        ControllerInstance.ShowController;
      end
      else FreeAndNil(Result);
    end else
     raise Exception.CreateFmt( C_MessageA ,[ NomeRegistrado ]);
  except
    on E: Exception do
      raise Exception.CreateFmt( CMessageB , [NomeRegistrado, E.Message]);

  end

end;

{ TViewController }

{
  --------------------------------------------------------------------------
   Procedimento: TViewController.SetController
   Resumo: Define o controlador associado à visualização.
   Descrição:
    Este procedimento define o controlador associado à visualização.
    Ele atribui o valor do parâmetro Value à propriedade FController da visualização.

   Parâmetros:
   - Value: O controlador a ser associado à visualização.
  ---------------------------------------------------------------------------
}
procedure TViewController.SetController(const Value: TControllerAbstract);
begin
  FController := Value;
end;

{ TFieldHelper }

function TFieldHelper.AsformatedDoc: String;
begin
 if AsString.Trim.IsEmpty then Exit;

 if AsString.Length <= 11 then
    Result:= Self.FormatAsCpf
    else
    Result:= Self.FormatAsCnpj;

end;

function TFieldHelper.FormatAsCnpj: String;
begin
 Result:=  FormatCNPJ( Self.AsString );
end;

function TFieldHelper.FormatAsCpf: String;
begin
 Result:=  FormatCPF( Self.AsString );
end;

{ TExceptionHelper }

{  --------------------------------------------------------------------------
      Função: TExceptionHelper.Match
      Resumo: Verifica se a mensagem de exceção corresponde a uma das mensagens especificadas.
      Descrição:
        Este método verifica se a mensagem da exceção atual contém alguma das mensagens especificadas no array fornecido.
        Retorna o índice da primeira mensagem correspondente encontrada no array, ou -1 se nenhuma
        correspondência for encontrada.
      Parâmetros:
        - Messages: Um array de strings contendo as mensagens a serem verificadas na exceção.
      Retorno:
        O índice da primeira mensagem correspondente encontrada no array, ou -1 se nenhuma correspondência for encontrada.
      ---------------------------------------------------------------------------
    }
function TExceptionHelper.Match(const Messages: array of string): Integer;
 var
  ErrorMessage: string;
  Lidx: integer;
begin
  Result := -1;

  ErrorMessage := lowercase(Self.Message);
  for Lidx := Low( Messages) to High(Messages) do
    if Pos(lowercase(Messages[Lidx]), ErrorMessage) > 0 then
    begin
      Result:= Lidx;
      Exit;
    end;

end;

{  --------------------------------------------------------------------------
      Função: TExceptionHelper.Panic
      Resumo: Cria uma nova exceção com a mensagem especificada e a lança imediatamente.
      Descrição:
        Este método cria uma nova exceção com a mensagem especificada e a lança imediatamente.
        É útil para gerar exceções de pânico em situações críticas.
      Parâmetros:
        - PMessage: A mensagem a ser atribuída à nova exceção.
      Retorno:
        A exceção recém-criada e lançada.
      ---------------------------------------------------------------------------
    }
function TExceptionHelper.Panic(const PMessage: string): Exception;
begin
 Result:= Exception.Create(PMessage);
 raise Result;
end;

end.
