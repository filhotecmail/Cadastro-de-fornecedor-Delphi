unit model.abstract;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  System.IoUtils,
  Winapi.Windows,
  ShellAPI,
  IniFiles,
  Datasnap.Provider,
  database.driver.abstract,
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
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script;

 const C_InifileConfigdatabase  = 'conf.ini';
 type
  TModelAbstract = class(TDataModule)
    oDataset: TFDQuery;
  protected
    procedure ConfiureFirebirdDriver(PInifile: TIniFile);
    procedure ConfiurePostgresDriver(PInifile: TIniFile); experimental;
    procedure ConfiureOracleDriver(PInifile: TIniFile); experimental;

   var FTDatabaseDriverAbstract : TDatabaseDriverAbstract;
  strict private
    FTablename: String;
    FAutoincField: String;
    FFields: TArray<String>;
    FGeneratorName: string;
    FWhereClausule: TArray<String>;
    procedure SetAutoincField(const Value: String);
    procedure SetFields(const Value: TArray<String>);
    procedure SetGeneratorName(const Value: string);
    procedure SetTablename(const Value: String);
    procedure SetWhereClausule(const Value: TArray<String>);
     { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    procedure BeforeDestruction; override;

    { Public declarations }
    property Tablename: String read FTablename write SetTablename;
    property GeneratorName: string read FGeneratorName write SetGeneratorName;
    property AutoincField:String read FAutoincField write SetAutoincField;
    property Fields: TArray<String> read FFields write SetFields;
    property WhereClausule: TArray<String> read FWhereClausule write SetWhereClausule;
    function GetDatasetbyName(ADatasetname: String):TDataset;
  end;
       
implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}

uses commom.system.logger;
{$R *.dfm}


{ TModelAbstract }
procedure TModelAbstract.BeforeDestruction;
begin
  inherited;
 logger.WriteLogDestructor(Self);
end;

procedure TModelAbstract.ConfiureFirebirdDriver(PInifile: TIniFile);
 var oParams: TStringList;
     LDatabasename: string;
begin
  oParams := TStringList.Create; 
  LDatabasename:= PIniFile.ReadString('FIREBIRD', 'DATABASE', '');

  if not FileExists( LDatabasename )  then
     raise Exception.CreateFmt('Banco de dados não existe na pasta %s',[ LDatabasename ]);

 try
  oParams.Add(Format('Server=%s'    , [PIniFile.ReadString('FIREBIRD', 'HOST', '')]));
  oParams.Add(Format('Database=%s'  , [PIniFile.ReadString('FIREBIRD', 'DATABASE', '')]));
  oParams.Add(Format('User_Name=%s' , [PIniFile.ReadString('FIREBIRD', 'USERNAME', '')]));
  oParams.Add(Format('Password=%s'  , [PIniFile.ReadString('FIREBIRD', 'PASSWORD', '')]));
  oParams.Add(Format('Protocol=%s'  , [PIniFile.ReadString('FIREBIRD', 'PROTOCOL', '')]));
  oParams.Add(Format('DriverID=%s'  , [PIniFile.ReadString('FIREBIRD', 'DRIVERID', '')]));
  oParams.Add(Format('Port=%s'      , [PIniFile.ReadString('FIREBIRD', 'PORT', '')]));
  oParams.Add(Format('VendorHome=%s', [PIniFile.ReadString('FIREBIRD', 'VENDORHOME', '')]));
  oParams.Add(Format('VendorLib=%s' , [PIniFile.ReadString('FIREBIRD', 'VENDORLIB', '')]));

  FTDatabaseDriverAbstract.ParamStr := oParams;
  oDataset.Connection := FTDatabaseDriverAbstract.Connection;
  logger.WriteLog( 'constríndo Parametos de conexão' );
  logger.WriteLog( oParams.Text );
  
 finally
  FreeAndNil( oParams );
 end;
end;

procedure TModelAbstract.ConfiureOracleDriver(PInifile: TIniFile);
begin
  raise ENotImplemented.Create('Não implementado nessa versão');
end;

procedure TModelAbstract.ConfiurePostgresDriver(PInifile: TIniFile);
begin
 raise ENotImplemented.Create('Não implementado nessa versão');
end;

constructor TModelAbstract.Create(AOwner: TComponent);
var
  LInifile: TInifile;
  LFileName: TFileName;
begin
  inherited;
  FTDatabaseDriverAbstract:= TDatabaseDriverAbstract.Create( AOwner );
  LFileName:= TPath.Combine( ExtractFilePath( ParamStr( 0 ) ), C_InifileConfigdatabase );
  LInifile := TIniFile.Create( LFileName );
  ConfiureFirebirdDriver( LInifile );
  logger.WriteLogConstrutor(Self);    
end;

function TModelAbstract.GetDatasetbyName(ADatasetname: String): TDataset;
begin
  Result:= Self.FindComponent(ADatasetname) as TDataset;
end;

procedure TModelAbstract.SetAutoincField(const Value: String);
begin
  FAutoincField := Value;
end;

procedure TModelAbstract.SetFields(const Value: TArray<String>);
begin
  FFields := Value;
end;

procedure TModelAbstract.SetGeneratorName(const Value: string);
begin
  FGeneratorName := Value;
end;

procedure TModelAbstract.SetTablename(const Value: String);
begin
  FTablename := Value;
end;

procedure TModelAbstract.SetWhereClausule(const Value: TArray<String>);
begin
  FWhereClausule := Value;
end;

end.
