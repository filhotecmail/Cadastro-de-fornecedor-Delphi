unit model.abstract;

interface

uses
  System.SysUtils,
  System.Classes,
  Datasnap.Provider;

type
  TModelAbstract = class(TDataModule)
    oProvider: TDataSetProvider;
  private
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
    { Public declarations }
    property Tablename: String read FTablename write SetTablename;
    property GeneratorName: string read FGeneratorName write SetGeneratorName;
    property AutoincField:String read FAutoincField write SetAutoincField;
    property Fields: TArray<String> read FFields write SetFields;
    property WhereClausule: TArray<String> read FWhereClausule write SetWhereClausule;
  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

{ TModelAbstract }

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
