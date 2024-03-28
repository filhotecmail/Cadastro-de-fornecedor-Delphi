unit view.master;

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
  Vcl.Menus,
  Vcl.ComCtrls,
  JvComponentBase,
  JvEnterTab;

type
  TViewmaster = class( TForm )
    MainMenu1: TMainMenu;
    M1: TMenuItem;
    C1: TMenuItem;
    I1: TMenuItem;
    S1: TMenuItem;
    oEnterAsTab: TJvEnterAsTab;
    StatusBar1: TStatusBar;
    procedure C1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Viewmaster: TViewmaster;

implementation
{$R *.dfm}

uses controller.abstract;

procedure TViewmaster.C1Click(Sender: TObject);
begin
 TControllerFactory.CreateController('controller empresa');
end;


end.
