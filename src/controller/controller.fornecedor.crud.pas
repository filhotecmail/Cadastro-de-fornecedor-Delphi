unit controller.fornecedor.crud;

interface

uses
  System.SysUtils,
  System.Classes,
  controller.abstract,
  Datasnap.Provider;

type
  TControllerFornecedorCrud = class( TControllerAbstract )
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AfterConstruction; override;
    procedure ShowController; override;
  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

uses model.fornecedor;

{ TControllerFornecedorCrud }
procedure TControllerFornecedorCrud.AfterConstruction;
begin
  inherited;
  model         := TModelFornecedor.Create( Self );
  ViewName      := 'view crud fornecedor';
  OutherDataset := model.GetDatasetByName('oEmpresas');
end;

procedure TControllerFornecedorCrud.ShowController;
begin
 dataset.Open;

 case ListenAction of
   oActionNone: View.ShowModal;

   oActionAppend: begin
                   Dataset.Append;
                   Dataset.FieldByName('F001DATETIEMEC').AsDateTime := now;
                   View.ShowModal;
                  end;

   oActionOpen: begin
                 Dataset.Locate('ID',ListenDataset.FieldByName('ID').AsInteger,[]);
                 View.ShowModal;
                end;

 end;
end;

initialization
RegisterClassAlias( TControllerFornecedorCrud, 'controller crud fornecedor' );
finalization
UnRegisterClass( TControllerFornecedorCrud );

end.
