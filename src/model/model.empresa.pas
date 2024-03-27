unit model.empresa;

interface

uses
  System.SysUtils,
  System.Classes,
  model.abstract,
  Datasnap.Provider;

type
  TModelEmpresa = class( TModelAbstract )
  private
    { Private declarations }
  public
    procedure AfterConstruction; override;
    { Public declarations }

  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

{ TModelEmpresa }

procedure TModelEmpresa.AfterConstruction;
begin
  inherited;
  Tablename     := '';
  GeneratorName := '';
  AutoincField  := '';
  Fields        := [];
  WhereClausule := [];
end;

end.
