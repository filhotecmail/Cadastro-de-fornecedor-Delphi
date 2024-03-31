unit controller.fornecedor;

interface

uses
  System.SysUtils,
  System.Classes,
  controller.abstract, Datasnap.Provider, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.Controls;

type
  TControllerFornecedor = class( TControllerAbstract )
  private
   { Private declarations }
  public
   { Public declarations }
    procedure AfterConstruction; override;
    procedure ShowController; override;
  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}

uses model.fornecedor;
{$R *.dfm}

{ TControllerFornecedor }
procedure TControllerFornecedor.AfterConstruction;
begin
  inherited;
 Model    := TModelFornecedor.Create( Self );
 ViewName := 'fornecedor' ;
  OutherDataset:= model.GetDatasetbyName('oEmpresas');
end;


 procedure TControllerFornecedor.ShowController;
begin
  if OutherDataset <> nil then OutherDataset.Open;

  Dataset.Open;
  View.ShowModal;
end;

initialization
  RegisterClassAlias( TControllerFornecedor, 'controller fornecedor' );
 finalization
  UnRegisterClass( TControllerFornecedor );

end.
