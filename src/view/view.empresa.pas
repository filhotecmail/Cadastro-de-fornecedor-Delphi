unit view.empresa;

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
  Vcl.ComCtrls,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  JvExDBGrids,
  JvDBGrid,
  Vcl.StdCtrls;

type
  TViewEmpresa = class( TForm )
    MainMenu1: TMainMenu;
    oEnterAsTab: TJvEnterAsTab;
    GroupBox2: TGroupBox;
    oGrid: TJvDBGrid;
    ods: TDataSource;
    I1: TMenuItem;
    D1: TMenuItem;
    S1: TMenuItem;
    StatusBar1: TStatusBar;
    procedure I1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
{$R *.dfm}

uses controller.abstract;

 procedure TViewEmpresa.I1Click(Sender: TObject);
begin
  TControllerFactory.CreateController( 'controller empresa crud' );
end;

Initialization
  RegisterClassAlias( TViewEmpresa, 'empresa' );
 Finalization
  UnRegisterClass( TViewEmpresa );
end.


