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
  Vcl.Dialogs, Data.DB, Vcl.Menus, JvComponentBase, JvEnterTab, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, JvExStdCtrls,
  JvCombobox, JvDBCombobox, Vcl.ComCtrls;

type
  TViewEmpresaCrud = class( TForm )
    GroupBox2: TGroupBox;
    oEnterAsTab: TJvEnterAsTab;
    MainMenu1: TMainMenu;
    I1: TMenuItem;
    D1: TMenuItem;
    S1: TMenuItem;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

 Initialization
  RegisterClassAlias( TViewEmpresaCrud, 'empresa crud' );
 Finalization
  UnRegisterClass( TViewEmpresaCrud );
end.
