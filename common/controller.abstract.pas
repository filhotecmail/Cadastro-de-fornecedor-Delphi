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
    property model: TModelAbstract read FModelName write SetModelName;   
    property ViewName: String read FViewName write SetViewName;
    property Dataset: TDataset read FDataset write SetDataset;
    property View: TViewController read FView write SetView;
    property ListenAction: TActionController read FListenAction write SetListenAction;
    property ListenDataset:TDataset read FListenDataset write SetListenDataset;
    property OutherDataset:TDataset read FOutherDataset write SetOutherDataset;
  end;    
 
  TControllerFactory = class
  public
    class function CreateController(const NomeRegistrado: string): TObject; overload;
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

procedure TViewController.SetController(const Value: TControllerAbstract);
begin
  FController := Value;
end;

end.
