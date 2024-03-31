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
    GroupBox1: TGroupBox;
    oBtConfirm: TButton;
    oBtCancel: TButton;
    oInfo: TGroupBox;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    oComboEmpresas: TJvDBComboBox;
    oXFant: TDBEdit;
    oCnpj: TDBEdit;
    oTel2: TDBEdit;
    oTel1: TDBEdit;
    GroupBox5: TGroupBox;
    Label3: TLabel;
    Label7: TLabel;
    oRg: TDBEdit;
    oDataNasc: TJvDBDatePickerEdit;
    oBtEdit: TButton;
    oXFantEmpresa: TEdit;
    oCnpjEmpresa: TEdit;
    oUfEmpresa: TEdit;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    procedure oBtCancelClick(Sender: TObject);
    procedure oBtConfirmClick(Sender: TObject);
    procedure oBtEditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure oCnpjKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure oComboEmpresasChange(Sender: TObject);
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
  LCnpj: string;
  LXFant: string;
  Luf: string;
begin
 obtEdit.Enabled    := not ( Controller.Dataset.State in dsWriteModes );
 oBtConfirm.Enabled := Controller.Dataset.State in dsWriteModes;
 oBtCancel.Enabled  := Controller.Dataset.State in dsWriteModes;
 oDataNasc.Enabled  := Controller.Dataset.State in dsWriteModes;

 LDataset:= Controller.OutherDataset;
 LDataset.Open;

 oComboEmpresas.Items.Clear;
 oComboEmpresas.Values.Clear;

 LDataset.first;
 LDataset.DisableControls;
  while not LDataset.Eof do
  begin
    LCnpj := LDataset.FieldByName('E003CNPJ').AsString;
    LXFant:= LDataset.FieldByName('E001XFANT').AsString;
    Luf   := LDataset.FieldByName('E002UF').AsString;

    oComboEmpresas.Items.Add( LCnpj + ' | '+ LXFant + ' | '+Luf );
    oComboEmpresas.Values.Add( LCnpj );

    LDataset.Next;
  end;

end;

procedure TViewFornecedorCrud.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  TaskDialog: TTaskDialog;
begin
  CanClose := not (Controller.Dataset.State in dsWriteModes);
  if not CanClose then
  begin
    TaskDialog := TTaskDialog.Create(nil);
    try
      TaskDialog.Caption := 'Confirmação de Fechamento';
      TaskDialog.Text := 'Existem registros não salvos. Deseja continuar e descartar as alterações?';
      TaskDialog.MainIcon := tdiWarning;
      TaskDialog.CommonButtons := [tcbYes, tcbNo];

      if TaskDialog.Execute then
      begin
        if TaskDialog.ModalResult = mrYes then
         begin
           Controller.Dataset.Cancel;
           ControlStateButtons;
         end;
      end
      else
        CanClose := False; // Evita que o formulário seja fechado se o diálogo for cancelado
    finally
      TaskDialog.Free;
    end;
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
var
  LEhCpf: Boolean;
begin

  if not (CharInSet(Key, ['0'..'9', '.', '-', Chr(8)])) then
  Key := #0;
  LEhCpf := Length(oCnpj.Text) <= 11;

  oRg.Enabled       := LEhCpf;
  oDataNasc.Enabled := LEhCpf;

  if not LEhCpf then  oRg.Text := EmptyStr;

end;


procedure TViewFornecedorCrud.oComboEmpresasChange(Sender: TObject);
begin

 Controller.OutherDataset.Open;
 Controller.OutherDataset.Locate('E003CNPJ',oComboEmpresas.Values[oComboEmpresas.ItemIndex],[]);
 oXFantEmpresa.Text := Controller.OutherDataset.FieldByName('E001XFANT').AsString;
 oCnpjEmpresa.Text  := Controller.OutherDataset.FieldByName('E003CNPJ').AsString;
 oUfEmpresa.Text    := Controller.OutherDataset.FieldByName('E002UF').AsString;
end;

Initialization
  RegisterClassAlias( TViewFornecedorCrud, 'view crud fornecedor' );
 Finalization
  UnRegisterClass( TViewFornecedorCrud );

end.
