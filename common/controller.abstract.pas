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
      ///    Representa o nome da visualiza��o associada a este controlador.
      ///  </summary>
      ///  <remarks>
      ///    Utilize esta propriedade para obter ou definir o nome da visualiza��o associada a este controlador.
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
      ///    Representa a visualiza��o associada a este controlador.
      ///  </summary>
      ///  <remarks>
      ///    Utilize esta propriedade para obter ou definir a visualiza��o associada a este controlador.
      ///  </remarks>
      ///  <seealso cref="TViewController"/>
      property View: TViewController read FView write SetView;

      ///  <summary>
      ///    Representa a a��o de escuta associada a este controlador.
      ///  </summary>
      ///  <remarks>
      ///    Utilize esta propriedade para obter ou definir a a��o de escuta associada a este controlador.
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
  ///  <summary>Cria uma inst�ncia do controlador registrado especificado.</summary>
  ///  <param name="NomeRegistrado">O nome do controlador registrado a ser criado.</param>
  ///  <returns>Uma inst�ncia do controlador especificado.</returns>
  class function CreateController(const NomeRegistrado: string): TObject; overload;

  ///  <summary>Cria uma inst�ncia do controlador registrado especificado com a��o e depend�ncias.</summary>
  ///  <param name="NomeRegistrado">O nome do controlador registrado a ser criado.</param>
  ///  <param name="Action">A��o a ser associada ao controlador.</param>
  ///  <param name="ADeps">Dataset de depend�ncias associado ao controlador.</param>
  ///  <returns>Uma inst�ncia do controlador especificado com a��o e depend�ncias.</returns>
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
  Resumo: Fornece m�todos auxiliares para trabalhar com exce��es.
  Descri��o:
    Esta classe fornece m�todos auxiliares para trabalhar com exce��es, como a capacidade de verificar se uma
    exce��o cont�m determinadas mensagens de erro e criar uma nova exce��o com uma mensagem especificada
    e lan��-la imediatamente.
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
  Resumo: Solicita confirma��o antes de iniciar um novo registro na tabela.
  Descri��o:
    Este procedimento exibe um di�logo de confirma��o para o usu�rio antes de iniciar um novo registro na
    tabela associada ao controlador. O di�logo apresenta uma mensagem perguntando se o usu�rio deseja iniciar
    um novo registro. Se o usu�rio confirmar, um novo registro � iniciado na tabela.
  Par�metros:
    Nenhum.
  Observa��es:
    O di�logo de confirma��o � exibido com um �cone de escudo e bot�es "Sim" e "N�o".
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
  Resumo: Executa a a��o de inclus�o de um novo registro.
  Descri��o:
    Este procedimento exibe uma caixa de di�logo de confirma��o para iniciar a inclus�o de um novo registro na
    tabela associada. Se o usu�rio confirmar a a��o, o m�todo Dataset.Append � chamado para iniciar a inclus�o
    do novo registro.
  Observa��es:
    Certifique-se de que o conjunto de dados (Dataset) associado ao controlador est� devidamente configurado antes de
    chamar este m�todo. A exibi��o da caixa de di�logo e a inclus�o do registro s�o condicionadas � intera��o do usu�rio.
  ---------------------------------------------------------------------------
}
procedure TControllerAbstract.Append;
var
  TaskDialog: TTaskDialog;
begin

  TaskDialog := TTaskDialog.Create(nil);
  try
    TaskDialog.Caption  := 'Confirma��o de inclus�o de registro!';
    TaskDialog.Text     := 'Voc� deseja iniciar um novo registro na tabela?';
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
  Resumo: Solicita confirma��o antes de cancelar a opera��o atual.
  Descri��o:
    Este procedimento exibe um di�logo de confirma��o para o usu�rio antes de cancelar a opera��o atual.
    O di�logo apresenta uma mensagem perguntando se o usu�rio realmente deseja cancelar a opera��o atual,
    alertando que os dados ser�o perdidos se confirmado. Se o usu�rio confirmar, a opera��o atual � cancelada.
  Par�metros:
    Nenhum.
  Observa��es:
    O di�logo de confirma��o � exibido com um �cone de escudo e bot�es "Sim" e "N�o".
  ---------------------------------------------------------------------------
}
function TControllerAbstract.AsFd: TFDQuery;
begin
 Result:= TFDQuery(Dataset);
end;

{  --------------------------------------------------------------------------
  Procedimento: TControllerAbstract.BeforeDestruction
  Resumo: Executa a��es antes da destrui��o do objeto.
  Descri��o:
    Este procedimento � chamado automaticamente pelo sistema antes da destrui��o do objeto.
    Ele chama o m�todo BeforeDestruction da classe pai e registra uma entrada de log indicando a destrui��o do objeto.
  Observa��es:
    Este procedimento � geralmente usado para executar limpezas finais ou a��es de desaloca��o de recursos antes
    da destrui��o do objeto.
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
    TaskDialog.Caption  := 'Confirma��o de Cancelamento de opera��o!';
    TaskDialog.Text     := 'Voc� realmente cancelar a opera��o atual, aten��o os dados ser�o perdidos!';
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
  Resumo: Solicita confirma��o antes de excluir o registro atual.
  Descri��o:
    Este procedimento verifica se o conjunto de dados est� vazio e, em seguida, exibe um di�logo de confirma��o
    para o usu�rio antes de excluir o registro atual. O di�logo apresenta uma mensagem perguntando se o usu�rio
    realmente deseja excluir o registro atual, alertando que os dados ser�o perdidos se confirmado.
    Se o usu�rio confirmar, o registro atual � exclu�do.
  Par�metros:
    Nenhum.
  Observa��es:
    O di�logo de confirma��o � exibido com um �cone de escudo e bot�es "Sim" e "N�o".
  ---------------------------------------------------------------------------
}
procedure TControllerAbstract.Delete;
var
  TaskDialog: TTaskDialog;
begin
  if Dataset.IsEmpty then Exit;

  TaskDialog := TTaskDialog.Create(nil);
  try
    TaskDialog.Caption  := 'Confirma��o de exclus�o de registro!';
    TaskDialog.Text     := 'Voc� realmente quer excluir o registro atual?, aten��o os dados ser�o perdidos!';
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
  Resumo: Solicita confirma��o antes de editar o registro atual.
  Descri��o:
    Este procedimento verifica se o conjunto de dados est� vazio e, em seguida, exibe um di�logo de confirma��o
    para o usu�rio antes de editar o registro atual. O di�logo apresenta uma mensagem perguntando se o usu�rio
    realmente deseja editar o registro atual. Se o usu�rio confirmar, o registro atual � editado.
  Par�metros:
    Nenhum.
  Observa��es:
    O di�logo de confirma��o � exibido com um �cone de informa��o e bot�es "Sim" e "N�o".
  ---------------------------------------------------------------------------
}
procedure TControllerAbstract.Edit;
var
  TaskDialog: TTaskDialog;
begin
  if Dataset.IsEmpty then Exit;

  TaskDialog := TTaskDialog.Create(nil);
  try
    TaskDialog.Caption  := 'Confirma��o de Edi��o';
    TaskDialog.Text     := 'Voc� realmente deseja editar este registro?';
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
 raise ENotImplemented.Create('N�o implementado!');
end;

procedure TControllerAbstract.Open(AValues: array of variant);
begin
//
end;

{  --------------------------------------------------------------------------
  Procedimento: TControllerAbstract.oTimerStatusTimer
  Resumo: Manipula o evento OnTimer do temporizador para atualizar informa��es na barra de status.
  Descri��o:
    Este procedimento � chamado periodicamente pelo evento OnTimer de um temporizador para atualizar as
     informa��es exibidas na barra de status. Ele verifica se a visualiza��o associada est� dispon�vel e se a
     barra de status est� presente. Em seguida, configura o evento OnDrawPanel da barra de status para o m�todo
     StatusBarDrawPanel, que � respons�vel por desenhar um �cone de status personalizado em um dos pain�is da barra de
     status. Se n�o houver pain�is na barra de status, adiciona os pain�is necess�rios e configura seus textos iniciais.
     Caso contr�rio, atualiza o texto do segundo painel com a data e hora atual.
  Par�metros:
    - Sender: O objeto que gerou o evento, neste caso, o temporizador.
  Observa��es:
    Certifique-se de que um objeto TStatusBar com o nome 'oBar' est� presente na visualiza��o associada a este
    controlador para que a atualiza��o da barra de status ocorra corretamente.
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
  Resumo: Solicita confirma��o antes de gravar os dados na tabela.
  Descri��o:
    Este procedimento exibe um di�logo de confirma��o para o usu�rio antes de gravar os dados na tabela
    associada ao controlador. O di�logo apresenta uma mensagem perguntando se o usu�rio realmente deseja
    gravar os dados na tabela, com uma nota para revisar os dados antes de confirmar. Se o usu�rio confirmar,
    os dados s�o gravados na tabela.
  Par�metros:
    Nenhum.
  Observa��es:
    O di�logo de confirma��o � exibido com um �cone de escudo e bot�es "Sim" e "N�o".
  ---------------------------------------------------------------------------
}
procedure TControllerAbstract.Post;
var
  TaskDialog: TTaskDialog;
begin

  TaskDialog := TTaskDialog.Create(nil);
  try
    TaskDialog.Caption  := 'Confirma��o de grava��o de registro!';
    TaskDialog.Text     := 'Voc� deseja gravar os dados na tabela?, revise os dados!';
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
  Descri��o:
    Este procedimento atualiza os dados na tabela associada ao controlador. Isso significa que quaisquer altera��es
    feitas em outros locais que afetam os dados na tabela ser�o refletidas na exibi��o atual.
  Par�metros:
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
  Resumo: Define o nome da visualiza��o e associa-a ao controlador.
  Descri��o:
    Este procedimento define o nome da visualiza��o e associa-a ao controlador. Ele tamb�m configura
    o DataSource da visualiza��o para usar o conjunto de dados do provedor associado ao controlador.
    Al�m disso, o m�todo associa o pr�prio controlador � visualiza��o.
  Par�metros:
    - Value: O nome da visualiza��o a ser definido.
  Observa��es:
    A visualiza��o deve ser uma inst�ncia de TForm e deve ter um componente TDatasource com o nome 'oDs'
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
  raise ENotImplemented.Create( 'N�o implementado na classe base!' );
end;


{  --------------------------------------------------------------------------
  Fun��o: TControllerAbstract.ShowView
  Resumo: Exibe a visualiza��o com o nome especificado.
  Descri��o:
    Esta fun��o tenta localizar e exibir uma visualiza��o com o nome especificado. Se a visualiza��o for
    encontrada e for uma inst�ncia de TForm, ela ser� criada e retornada. Caso contr�rio, retorna nil.
  Par�metros:
    - AViewName: O nome da visualiza��o a ser exibida.
  Retorno:
    Uma inst�ncia de TForm se a visualiza��o for encontrada e criada com sucesso, caso contr�rio, nil.
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
  Fun��o: TControllerFactory.CreateController
  Resumo: Cria uma inst�ncia do controlador com o nome registrado especificado.
  Descri��o:
    Esta fun��o cria uma inst�ncia do controlador com o nome registrado especificado. Se o
    nome registrado for encontrado no registro de classes e corresponder a uma classe que herda de
    TComponent, uma inst�ncia desse controlador ser� criada e seu m�todo ShowController ser� chamado.
    Se ocorrer algum problema durante a cria��o ou execu��o do controlador, uma exce��o ser� lan�ada.
  Par�metros:
    - NomeRegistrado: O nome registrado do controlador a ser criado.
  Retorno:
    Uma inst�ncia do controlador criada, ou nil se ocorrer um erro durante o processo.
  Observa��es:
    Se o nome registrado n�o for encontrado no registro de classes ou se n�o corresponder a uma classe que
    herda de TComponent, uma exce��o ser� lan�ada.
  ---------------------------------------------------------------------------
}

class function TControllerFactory.CreateController(const NomeRegistrado: string): TObject;
var
  LClass: TPersistentClass;
  ControllerInstance: TControllerAbstract;
  const C_MessageA='Controller de nome %s n�o localizado no registro ';
  const CMessageB = 'Ocorreu um problema ao tentar criar a inst�ncia do controller %s , verifique o erro %s ';
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
  Fun��o: TControllerFactory.CreateController
  Resumo: Cria uma inst�ncia do controlador com o nome registrado especificado e associa a��o e conjunto de dados.
  Descri��o:
    Esta fun��o cria uma inst�ncia do controlador com o nome registrado especificado e associa uma
    a��o e um conjunto de dados a ele. Se o nome registrado for encontrado no registro de classes e
    corresponder a uma classe que herda de TComponent, uma inst�ncia desse controlador ser� criada e as
    propriedades ListenAction e ListenDataset ser�o atribu�das com os valores passados. Em seguida,
    o m�todo ShowController ser� chamado. Se ocorrer algum problema durante a cria��o ou execu��o do controlador,
    uma exce��o ser� lan�ada.
  Par�metros:
    - NomeRegistrado: O nome registrado do controlador a ser criado.
    - Action: A a��o associada ao controlador.
    - ADeps: O conjunto de dados associado ao controlador.
  Retorno:
    Uma inst�ncia do controlador criada, ou nil se ocorrer um erro durante o processo.
  Observa��es:
    Se o nome registrado n�o for encontrado no registro de classes ou se n�o corresponder a uma classe que
    herda de TComponent, uma exce��o ser� lan�ada.
  ---------------------------------------------------------------------------
}
class function TControllerFactory.CreateController(const NomeRegistrado: string; Action: TActionController;
  ADeps: TDataset): TObject;
var
  LClass: TPersistentClass;
  ControllerInstance: TControllerAbstract;
  const C_MessageA='Controller de nome %s n�o localizado no registro ';
  const CMessageB = 'Ocorreu um problema ao tentar criar a inst�ncia do controller %s , verifique o erro %s ';
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
   Resumo: Define o controlador associado � visualiza��o.
   Descri��o:
    Este procedimento define o controlador associado � visualiza��o.
    Ele atribui o valor do par�metro Value � propriedade FController da visualiza��o.

   Par�metros:
   - Value: O controlador a ser associado � visualiza��o.
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
      Fun��o: TExceptionHelper.Match
      Resumo: Verifica se a mensagem de exce��o corresponde a uma das mensagens especificadas.
      Descri��o:
        Este m�todo verifica se a mensagem da exce��o atual cont�m alguma das mensagens especificadas no array fornecido.
        Retorna o �ndice da primeira mensagem correspondente encontrada no array, ou -1 se nenhuma
        correspond�ncia for encontrada.
      Par�metros:
        - Messages: Um array de strings contendo as mensagens a serem verificadas na exce��o.
      Retorno:
        O �ndice da primeira mensagem correspondente encontrada no array, ou -1 se nenhuma correspond�ncia for encontrada.
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
      Fun��o: TExceptionHelper.Panic
      Resumo: Cria uma nova exce��o com a mensagem especificada e a lan�a imediatamente.
      Descri��o:
        Este m�todo cria uma nova exce��o com a mensagem especificada e a lan�a imediatamente.
        � �til para gerar exce��es de p�nico em situa��es cr�ticas.
      Par�metros:
        - PMessage: A mensagem a ser atribu�da � nova exce��o.
      Retorno:
        A exce��o rec�m-criada e lan�ada.
      ---------------------------------------------------------------------------
    }
function TExceptionHelper.Panic(const PMessage: string): Exception;
begin
 Result:= Exception.Create(PMessage);
 raise Result;
end;

end.
