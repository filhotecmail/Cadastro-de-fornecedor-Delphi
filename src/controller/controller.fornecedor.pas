unit controller.fornecedor;

interface

uses
  System.SysUtils,
  System.Classes,
  controller.abstract, Datasnap.Provider;

type
  TControllerFornecedor = class( TControllerAbstract )
  private
   { Private declarations }
  public
   { Public declarations }
    procedure AfterConstruction; override;
  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}

uses model.fornecedor;
{$R *.dfm}

{ TControllerFornecedor }
procedure TControllerFornecedor.AfterConstruction;
begin
  inherited;
 Model:= TModelFornecedor.Create( Self );
end;


 initialization
  RegisterClassAlias( TControllerFornecedor, 'controller fornecedor' );
 finalization
  UnRegisterClass( TControllerFornecedor );

end.