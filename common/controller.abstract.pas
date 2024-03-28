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
  Data.DB,
  Vcl.forms,
  model.abstract,
  Datasnap.Provider;

 Type TActionController = (oActionNone,oActionAppend,oActionOpen); 

 type
  TControllerAbstract = class;
  TControllerFactory  = class;
  TViewController     = class;    

  TControllerAbstract = class( TDataModule )
    oProvider: TDataSetProvider;
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
  published
      property Controller: TControllerAbstract read FController write SetController;
 end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

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
procedure TControllerAbstract.Append;
var
  TaskDialog: TTaskDialog;
  TaskDialogButtonItem: TTaskDialogBaseButtonItem;
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
procedure TControllerAbstract.Cancel;
 var
  TaskDialog: TTaskDialog;
  TaskDialogButtonItem: TTaskDialogBaseButtonItem;
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
  TaskDialogButtonItem: TTaskDialogBaseButtonItem;
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
  TaskDialogButtonItem: TTaskDialogBaseButtonItem;
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
  TaskDialogButtonItem: TTaskDialogBaseButtonItem;
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
      Result := TComponentClass(LClass).Create(nil);

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

{  --------------------------------------------------------------------------
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

end.
