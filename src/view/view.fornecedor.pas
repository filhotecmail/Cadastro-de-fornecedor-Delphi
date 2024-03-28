unit view.fornecedor;

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
  JvComponentBase,
  JvEnterTab,
  Vcl.Menus,
  Vcl.ComCtrls;

type
  TViewFornecedor = class( TForm )
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    M1: TMenuItem;
    C1: TMenuItem;
    I1: TMenuItem;
    S1: TMenuItem;
    oEnterAsTab: TJvEnterAsTab;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

 Initialization
  RegisterClassAlias( TViewFornecedor, 'fornecedor' );
 Finalization
  UnRegisterClass( TViewFornecedor );
end.
