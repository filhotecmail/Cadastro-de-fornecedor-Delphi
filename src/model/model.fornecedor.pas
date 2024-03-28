unit model.fornecedor;

interface

uses
  System.SysUtils,
  System.Classes,
  model.abstract,
  Datasnap.Provider, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TModelFornecedor = class( TModelAbstract )
    oEmpresas: TFDQuery;
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
 oEmpresas.Connection := oDataset.Connection;
end;

end.
