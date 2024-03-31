unit controller.empresa;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.forms,
  Data.DB,
  controller.abstract, Datasnap.Provider, Vcl.ExtCtrls;

type
  TControllerEmpresa = class( TControllerAbstract )
  private
   { Private declarations }
  public
   { Public declarations }
    procedure ShowController; override;
    procedure AfterConstruction; override;
  end;


implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}

uses model.empresa;
{$R *.dfm}

{ TControllerEmpresa }

procedure TControllerEmpresa.AfterConstruction;
begin
  inherited;
 model    := TModelEmpresa.Create( Self );
 ViewName := 'empresa';
end;

procedure TControllerEmpresa.ShowController;
begin
 DataSet.Open;
 View.ShowModal;
end;

initialization
  RegisterClassAlias( TControllerEmpresa, 'controller empresa' );
 finalization
  UnRegisterClass( TControllerEmpresa );
end.
