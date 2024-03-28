unit controller.abstract;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  Vcl.forms,
  model.abstract, Datasnap.Provider;

type
  TControllerAbstract = class( TDataModule )
    oProvider: TDataSetProvider;
  protected
    function ShowView( AviewName: String ): TForm;
  private
  { Private declarations }
   FModelName: TModelAbstract;
    FViewName: String;
    FDataset: TDataset;
    FView: TForm;
    FClassView: TPersistentClass;
   procedure SetModelName( const Value: TModelAbstract );
    procedure SetViewName(const Value: String);
    procedure SetDataset(const Value: TDataset);
    procedure SetView(const Value: TForm);
  public
    { Public declarations }
    property model: TModelAbstract read FModelName write SetModelName;
    property ViewName: String read FViewName write SetViewName;
    property Dataset: TDataset read FDataset write SetDataset;
    property View: TForm read FView write SetView;
    procedure ShowController; virtual;
  end;

 type
  TControllerFactory = class
  public
    class function CreateController(const NomeRegistrado: string): TObject;
  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

{ TControllerAbstract }
procedure TControllerAbstract.SetDataset(const Value: TDataset);
begin
  FDataset := Value;
end;

procedure TControllerAbstract.SetModelName( const Value: TModelAbstract );
begin
  FModelName := Value;
  oProvider.DataSet := model.oDataset;
end;

procedure TControllerAbstract.SetView(const Value: TForm);
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
  View:= Lview;
  LDatasource:= (Lview.FindComponent('oDs') as TDatasource);
  if LDatasource <> nil then
     LDatasource.DataSet:= oProvider.DataSet; 
  Dataset:=  LDatasource.DataSet;     
end;

procedure TControllerAbstract.ShowController;
begin
  raise ENotImplemented.Create( 'Não implementado na classe base!' );
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



end.
