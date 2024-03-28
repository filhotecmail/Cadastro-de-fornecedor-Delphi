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

 type
  TModelAbstract = class(TDataModule)
    oProvider: TDataSetProvider;
  protected
    FConfigureDriverFirebird : TProc<TODriverTecnology,TInifile>;
    FConfigureDriverPostgres : TProc<TODriverTecnology,TInifile>;
    FConfigureDriverOracle   : TProc<TODriverTecnology,TInifile>;
    FTDatabaseDriverAbstract : TDatabaseDriverAbstract;
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

constructor TModelAbstract.Create(AOwner: TComponent);
begin
  inherited;
  FTDatabaseDriverAbstract:= TDatabaseDriverAbstract.Create( AOwner );
  ConnectionDriver:= oDefaultDriver;
end;

procedure TModelAbstract.SetAutoincField(const Value: String);
begin
  FAutoincField := Value;
end;

procedure TModelAbstract.SetConnectionDriver(const Value: TODriverTecnology);
var
  LInifile: TInifile;
begin
  FConnectionDriver := Value;

  FConfigureDriverFirebird:= procedure(PDriver: TODriverTecnology; Pnifile: TInifile)
                             begin
                              if PDriver <> oFirebirdDriver  then Exit;


                             end;

  FConfigureDriverPostgres:= procedure(PDriver: TODriverTecnology; Pnifile: TInifile)
                             begin
                              if PDriver <> oPostgresDriver  then Exit;

                             end;

  FConfigureDriverOracle  := procedure(PDriver: TODriverTecnology; Pnifile: TInifile)
                             begin
                              if PDriver <> oOracleDriver  then Exit;

                             end;

  FConfigureDriverFirebird(FConnectionDriver,LInifile);
  FConfigureDriverPostgres(FConnectionDriver,LInifile);
  FConfigureDriverOracle(FConnectionDriver,LInifile);

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
