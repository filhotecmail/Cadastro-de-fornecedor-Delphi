unit model.abstract;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IoUtils,
  IniFiles,
  Datasnap.Provider,
  database.driver.abstract;

 type TODriverTecnology = ( oDefaultDriver , oFirebirdDriver , oPostgresDriver ,  oOracleDriver );
 type TODriverTecnologyHelper = record helper for TODriverTecnology
      function ITerateStr(PValue: String): TODriverTecnology;
 end;
 const C_InifileConfigdatabase  = 'conf.ini';
 type
  TModelAbstract = class(TDataModule)
    oProvider: TDataSetProvider;
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
    FConnectionDriver: TODriverTecnology;
    procedure SetAutoincField(const Value: String);
    procedure SetFields(const Value: TArray<String>);
    procedure SetGeneratorName(const Value: string);
    procedure SetTablename(const Value: String);
    procedure SetWhereClausule(const Value: TArray<String>);
    procedure SetConnectionDriver(const Value: TODriverTecnology);
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
    property Tablename: String read FTablename write SetTablename;
    property GeneratorName: string read FGeneratorName write SetGeneratorName;
    property AutoincField:String read FAutoincField write SetAutoincField;
    property Fields: TArray<String> read FFields write SetFields;
    property WhereClausule: TArray<String> read FWhereClausule write SetWhereClausule;
    property ConnectionDriver: TODriverTecnology read FConnectionDriver write SetConnectionDriver;
  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

{ TModelAbstract }

procedure TModelAbstract.ConfiureFirebirdDriver(PInifile: TIniFile);
 var oParams: TStrings;
begin
  oParams := TStringList.Create;
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
  FTDatabaseDriverAbstract.ParamStr := oParams.Text;
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
  LParams: TStrings;
begin
  inherited;
  FTDatabaseDriverAbstract:= TDatabaseDriverAbstract.Create( AOwner );
  ConnectionDriver:= oDefaultDriver;

  LFileName:= TPath.Combine( ExtractFilePath( ParamStr( 0 ) ), C_InifileConfigdatabase );
  LInifile := TIniFile.Create( LFileName );
  ConnectionDriver.IterateStr( LInifile.ReadString('ACTIVE DATABASE', 'database_name', ''));

  case ConnectionDriver of
    oFirebirdDriver: ConfiureFirebirdDriver( LInifile );
    oPostgresDriver: ConfiurePostgresDriver( LInifile );
    oOracleDriver  : ConfiureOracleDriver  ( LInifile );
  end;

end;

procedure TModelAbstract.SetAutoincField(const Value: String);
begin
  FAutoincField := Value;
end;

procedure TModelAbstract.SetConnectionDriver(const Value: TODriverTecnology);
var
  LInifile: TInifile;
  LFileName: TFileName;
  LParams: TStrings;
begin
  FConnectionDriver := Value;

  LParams := TStringList.Create;
  LFileName:= TPath.Combine( ExtractFilePath( ParamStr( 0 ) ), C_InifileConfigdatabase );
  LInifile := TIniFile.Create( LFileName );

  FConnectionDriver.IterateStr( LInifile.ReadString('ACTIVE DATABASE', 'database_name', ''));
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

{ TODriverTecnologyHelper }

function TODriverTecnologyHelper.ITerateStr(PValue: String): TODriverTecnology;
 const C_Firebird = 'FIREBIRD';
 const C_Postgres = 'POSTGRES';
 const C_Oracle   = 'ORACLE';
begin
 Result:= oDefaultDriver;

 if PValue.Trim.IsEmpty then Exit;
 
 if PValue = C_Firebird then Result:= oFirebirdDriver;
 if PValue = C_Postgres then Result:= oPostgresDriver;
 if PValue = C_Oracle   then Result:= oOracleDriver;

end;

end.
