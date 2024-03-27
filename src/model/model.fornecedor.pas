unit model.fornecedor;

interface

uses
  System.SysUtils,
  System.Classes,
  model.abstract,
  Datasnap.Provider;

type
  TModelFornecedor = class( TModelAbstract )
  private
    { Private declarations }
  public
    procedure AfterConstruction; override;
    { Public declarations }

  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

{ TModelFornecedor }
procedure TModelFornecedor.AfterConstruction;
begin
  inherited;
  Tablename     := '';
  GeneratorName := '';
  AutoincField  := '';
  Fields        := [];
  WhereClausule := [];
end;

end.
