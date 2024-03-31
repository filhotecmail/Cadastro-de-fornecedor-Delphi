unit view.empresa.crud;

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
  Data.DB,
  Vcl.Menus,
  JvComponentBase,
  JvEnterTab,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.DBCtrls,
  JvExStdCtrls,
  JvCombobox,
  JvDBCombobox,
  Vcl.ComCtrls,
  controller.abstract;

type
  TViewEmpresaCrud = class( TViewController )
    GroupBox2: TGroupBox;
    oEnterAsTab: TJvEnterAsTab;
    ods: TDataSource;
    oID: TDBEdit;
    oXFant: TDBEdit;
    oCnpj: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    oUfs: TJvDBComboBox;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    oBtConfirm: TButton;
    oBtCancel: TButton;
    oBtEdit: TButton;
    procedure oBtConfirmClick(Sender: TObject);
    procedure oBtCancelClick(Sender: TObject);
    procedure oBtEditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    procedure ControlStateButtons;
  public
    { Public declarations }
  end;

implementation
{$R *.dfm}

procedure TViewEmpresaCrud.oBtEditClick(Sender: TObject);
begin
 Controller.Edit;
 ControlStateButtons;
end;

procedure TViewEmpresaCrud.ControlStateButtons;
begin
 obtEdit.Enabled    := not ( Controller.Dataset.State in dsWriteModes );
 oBtConfirm.Enabled := Controller.Dataset.State in dsWriteModes;
 oBtCancel.Enabled  := Controller.Dataset.State in dsWriteModes;
end;

procedure TViewEmpresaCrud.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
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
        CanClose := False;
    finally
      TaskDialog.Free;
    end;
  end;

end;

procedure TViewEmpresaCrud.FormShow(Sender: TObject);
begin
 ControlStateButtons;
end;

procedure TViewEmpresaCrud.oBtCancelClick(Sender: TObject);
begin
 Controller.Cancel;
 ControlStateButtons;
end;

procedure TViewEmpresaCrud.oBtConfirmClick(Sender: TObject);
begin
 Controller.Post;
 ControlStateButtons;
end;

Initialization
  RegisterClassAlias( TViewEmpresaCrud, 'empresa crud' );
 Finalization
  UnRegisterClass( TViewEmpresaCrud );
end.
