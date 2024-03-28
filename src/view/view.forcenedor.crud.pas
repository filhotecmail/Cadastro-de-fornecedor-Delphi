unit view.forcenedor.crud;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  JvExStdCtrls,
  JvCombobox,
  JvDBCombobox,
  Vcl.Mask,
  Vcl.DBCtrls,
  Data.DB,
  Vcl.Menus,
  JvComponentBase,
  JvEnterTab,
  Vcl.ComCtrls,
  JvExMask,
  JvToolEdit,
  JvMaskEdit,
  JvCheckedMaskEdit,
  JvDatePickerEdit,
  JvDBDatePickerEdit,
  controller.abstract;

type
  TViewFornecedorCrud = class( TViewController )
    StatusBar1: TStatusBar;
    oEnterAsTab: TJvEnterAsTab;
    ods: TDataSource;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    oID: TDBEdit;
    oXFant: TDBEdit;
    DBEdit1: TDBEdit;
    Label5: TLabel;
    JvDBDatePickerEdit1: TJvDBDatePickerEdit;
    Label6: TLabel;
    GroupBox1: TGroupBox;
    oBtConfirm: TButton;
    oBtCancel: TButton;
    oBtEdit: TButton;
    oComboEmpresas: TJvDBComboBox;
    oCnpj: TDBEdit;
    Label4: TLabel;
    procedure oBtCancelClick(Sender: TObject);
    procedure oBtConfirmClick(Sender: TObject);
    procedure oBtEditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure oCnpjKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ControlStateButtons;
  end;

implementation
{$R *.dfm}

 { TViewFornecedorCrud }

procedure TViewFornecedorCrud.ControlStateButtons;
var
  LDataset: TDataSet;
begin
 obtEdit.Enabled    := not ( Controller.Dataset.State in dsWriteModes );
 oBtConfirm.Enabled := Controller.Dataset.State in dsWriteModes;
 oBtCancel.Enabled  := Controller.Dataset.State in dsWriteModes;

 LDataset:= Controller.OutherDataset;
 LDataset.Open;

 oComboEmpresas.Items.Clear;
 oComboEmpresas.Values.Clear;

 LDataset.first;
 LDataset.DisableControls;
 while not LDataset.Eof do
  begin
    oComboEmpresas.Items.Add( LDataset.FieldByName('E003CNPJ').AsString + ' | '+ LDataset.FieldByName('E001XFANT').AsString );
    oComboEmpresas.Values.Add( LDataset.FieldByName('E003CNPJ').AsString );
    LDataset.Next;
  end;

end;

procedure TViewFornecedorCrud.FormShow(Sender: TObject);
begin
 ControlStateButtons;
end;

procedure TViewFornecedorCrud.oBtCancelClick(Sender: TObject);
begin
 Controller.Cancel;
 ControlStateButtons;
end;

procedure TViewFornecedorCrud.oBtConfirmClick(Sender: TObject);
begin
 Controller.Post;
 ControlStateButtons;
end;

procedure TViewFornecedorCrud.oBtEditClick(Sender: TObject);
begin
 Controller.Edit;
 ControlStateButtons;
end;

procedure TViewFornecedorCrud.oCnpjKeyPress(Sender: TObject; var Key: Char);
begin
 if not (Key in['0'..'9',Chr(8)]) then Key:= #0;
end;

Initialization
  RegisterClassAlias( TViewFornecedorCrud, 'view crud fornecedor' );
 Finalization
  UnRegisterClass( TViewFornecedorCrud );

end.
