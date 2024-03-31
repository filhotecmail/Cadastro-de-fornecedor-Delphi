unit controller.fornecedor.crud;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Dialogs,
  Dateutils,
  Data.DB,
  controller.abstract,
  Datasnap.Provider,
  Vcl.ExtCtrls,
  System.ImageList,
  Vcl.ImgList,
  Vcl.Controls;

type
  TControllerFornecedorCrud = class( TControllerAbstract )
  private
    { Private declarations }
    procedure OnValidateDataNasc(Sender: TField; const Text: string);
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

procedure TControllerFornecedorCrud.OnValidateDataNasc(Sender: TField; const Text: string);
var
  LCnpj: string;
  Lispr: boolean;
  LDateDif: Integer;
begin
  OutherDataset.Open;

 if not OutherDataset.Locate('E003CNPJ', LCnpj ,[]) then exit;

  LCnpj := dataset.FieldByName('F002CPFCNPJ').AsString;
  Lispr := Uppercase(dataset.FieldByName('E002UF').AsString) = 'PR';
  LDateDif:= YearsBetween(now, TField(Sender).AsDateTime );

  if ( Lispr ) and ( LDateDif < 18 ) then
   with TTaskDialog.Create(nil) do
    begin
     Caption  := 'Erro de validação de campo';
     Text     := 'A empresa é do Paraná, não é permitido cadastrar um fornecedor pessoa física menor de idade';
     MainIcon :=  tdiError;
     CommonButtons := [tcbOk];
    if Execute  then
      if ModalResult= mrOk then
       begin
         TField(Sender).FocusControl;
         Free;
       end;
    end;

end;

procedure TControllerFornecedorCrud.ShowController;
begin

 dataset.Open;
 dataset.FieldByName('F001DATETIEMEC').OnSetText :=  OnValidateDataNasc;

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
