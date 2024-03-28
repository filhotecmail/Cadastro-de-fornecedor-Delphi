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
  Vcl.StdCtrls,
  controller.abstract, System.ImageList, Vcl.ImgList;

type
  TViewEmpresa = class( TViewController )
    MainMenu1: TMainMenu;
    oEnterAsTab: TJvEnterAsTab;
    GroupBox2: TGroupBox;
    oGrid: TJvDBGrid;
    ods: TDataSource;
    I1: TMenuItem;
    D1: TMenuItem;
    S1: TMenuItem;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    oEditar: TButton;
    oExluir: TButton;
    ImageList1: TImageList;
    Button1: TButton;
    procedure I1Click(Sender: TObject);
    procedure oGridDblClick(Sender: TObject);
    procedure oExluirClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
{$R *.dfm}

procedure TViewEmpresa.Button1Click(Sender: TObject);
var
  LController: TObject;
begin
 try
  LController:=  TControllerFactory.CreateController( 'controller empresa crud', oActionAppend , ods.Dataset );
  Controller.Refresh;
 finally
  FreeAndNil( LController );
 end;

end;

procedure TViewEmpresa.I1Click(Sender: TObject);
var
  LController: TObject;
begin
 try
  LController:=  TControllerFactory.CreateController( 'controller empresa crud', oActionAppend , ods.Dataset );
 finally
  FreeAndNil( LController );
 end;
end;

procedure TViewEmpresa.oExluirClick(Sender: TObject);
begin
 Controller.Delete;

end;

procedure TViewEmpresa.oGridDblClick(Sender: TObject);
  var
  LController: TObject;
begin
 if ods.DataSet.IsEmpty then exit;

begin
 try
  LController:=  TControllerFactory.CreateController( 'controller empresa crud', oActionOpen , ods.Dataset );
  Controller.Refresh;
 finally
  FreeAndNil( LController );
 end;

end;

end;

Initialization
  RegisterClassAlias( TViewEmpresa, 'empresa' );
 Finalization
  UnRegisterClass( TViewEmpresa );
end.


