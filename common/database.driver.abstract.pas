unit database.driver.abstract;

interface

uses
  System.SysUtils,
  System.Classes,
  dao.abstract,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Phys.FBDef,
  FireDAC.Phys,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.FB;

type
  TDatabaseDriverAbstract = class sealed(TDataModule)
    oFbDriver: TFDPhysFBDriverLink;
    procedure oFbDriverDriverCreated(Sender: TObject);
    procedure oFbDriverDriverDestroying(Sender: TObject);
  private
    FParamStr: TStringList;
    FDao: TDaoAbstract;
    FConnection: TFDCustomConnection;
    procedure SetParamStr(const Value: TStringList);
    procedure SetConnection(const Value: TFDCustomConnection);
    function getFConnection: TFDCustomConnection;
    { Private declarations }
  public
   { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure BeforeDestruction; override;
    property ParamStr: TStringList read FParamStr write SetParamStr;
    property Connection: TFDCustomConnection read getFConnection write SetConnection;
  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}

uses commom.system.logger;
{$R *.dfm}

{ TDatabaseDriverAbstract }

procedure TDatabaseDriverAbstract.BeforeDestruction;
begin
  inherited;
  logger.WriteLogConstrutor(Self);
end;

constructor TDatabaseDriverAbstract.Create(AOwner: TComponent);
begin
  inherited;
  FDao:= TDaoAbstract.Create( Self );
  logger.WriteLogConstrutor(Self);
end;

function TDatabaseDriverAbstract.getFConnection: TFDCustomConnection;
begin
 Result := FDao.oCon;
end;

procedure TDatabaseDriverAbstract.oFbDriverDriverCreated(Sender: TObject);
begin
 logger.WriteLog('Criando o driver de conexao %s',[ Sender.ClassName ]);
end;

procedure TDatabaseDriverAbstract.oFbDriverDriverDestroying(Sender: TObject);
begin
 logger.WriteLog('Destruíndo o driver de conexao %s',[ Sender.ClassName ]);
end;

procedure TDatabaseDriverAbstract.SetConnection(const Value: TFDCustomConnection);
begin
  FConnection := Value;

end;

procedure TDatabaseDriverAbstract.SetParamStr(const Value: TStringList);
var
  I: Integer;
begin
  FParamStr:= Value;
  FDao.oCon.Params.Clear;

  for I := 0 to Value.Count - 1 do
    FDao.oCon.Params.Values[Value.Names[I]] := Value.ValueFromIndex[I];

   FDao.oCon.Params.Add('MonitorBy=Custom');
   //FDao.oCon.ConnectionIntf.Tracing := True;

  FDao.oCon.Connected := True;

end;


end.
