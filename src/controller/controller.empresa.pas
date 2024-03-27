unit controller.empresa;

interface

uses
  System.SysUtils,
  System.Classes,
  controller.abstract;

type
  TControllerEmpresa = class( TControllerAbstract )
  private
   { Private declarations }
  public
   { Public declarations }
    procedure AfterConstruction; override;
  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

{ TControllerEmpresa }
procedure TControllerEmpresa.AfterConstruction;
begin
  inherited;

end;

end.
