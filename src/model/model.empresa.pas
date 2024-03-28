unit model.empresa;

interface

uses
  System.SysUtils,
  System.Classes,
  model.abstract,
  Datasnap.Provider, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TModelEmpresa = class( TModelAbstract )
  private
   { Private declarations }
  public
   { Public declarations }
    procedure AfterConstruction; override;
  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

{ TModelEmpresa }
procedure TModelEmpresa.AfterConstruction;
begin
  inherited;

end;

end.
