unit controller.empresa.crud;

interface

uses
  System.SysUtils,
  System.Classes,
  controller.abstract,
  Datasnap.Provider;



type
  TControllerEmpresaCrud = class( TControllerAbstract )
  private
   { Private declarations }
  public
   { Public declarations }
    procedure AfterConstruction; override;
    procedure ShowController; override;
  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}
uses model.empresa;
{$R *.dfm}

{ TControllerEmpresaCrud }
procedure TControllerEmpresaCrud.AfterConstruction;
begin
  inherited;
  model    := TModelEmpresa.Create( Self );
  ViewName := 'empresa crud';
end;

procedure TControllerEmpresaCrud.ShowController;
begin
 dataset.Open;

 case ListenAction of
   oActionNone: View.ShowModal;

   oActionAppend: begin
                   Dataset.Append;
                   View.ShowModal;
                  end;

   oActionOpen: begin
                 Dataset.Locate('ID',ListenDataset.FieldByName('ID').AsInteger,[]);
                 View.ShowModal;
                end;

 end;


end;

Initialization
RegisterClassAlias( TControllerEmpresaCrud, 'controller empresa crud' );
Finalization
UnRegisterClass( TControllerEmpresaCrud );

end.
