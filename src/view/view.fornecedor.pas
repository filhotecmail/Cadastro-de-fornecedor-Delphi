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
  Vcl.ComCtrls,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  JvExDBGrids,
  JvDBGrid,
  Vcl.StdCtrls,
  controller.abstract, System.ImageList, Vcl.ImgList;

type
  TViewFornecedor = class( TViewController )
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    M1: TMenuItem;
    C1: TMenuItem;
    I1: TMenuItem;
    S1: TMenuItem;
    oEnterAsTab: TJvEnterAsTab;
    GroupBox2: TGroupBox;
    oGrid: TJvDBGrid;
    MainMenu2: TMainMenu;
    MenuItem1: TMenuItem;
    D1: TMenuItem;
    MenuItem2: TMenuItem;
    ods: TDataSource;
    StatusBar2: TStatusBar;
    ImageList1: TImageList;
    GroupBox1: TGroupBox;
    oEditar: TButton;
    oExluir: TButton;
    Button1: TButton;

    procedure Button1Click(Sender: TObject);
    procedure oGridDblClick(Sender: TObject);
    procedure oExluirClick(Sender: TObject);
    procedure oEditarClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

 procedure TViewFornecedor.Button1Click(Sender: TObject);
 var
  LController: TObject;
begin

begin
 try
  LController:=  TControllerFactory.CreateController( 'controller crud fornecedor', oActionAppend , ods.Dataset );
  Controller.Refresh;
 finally
  FreeAndNil( LController );
 end;

end;

end;


procedure TViewFornecedor.oEditarClick(Sender: TObject);
var
  LController: TObject;
begin
 if ods.DataSet.IsEmpty then exit;

begin
 try
  LController:=  TControllerFactory.CreateController( 'controller crud fornecedor', oActionOpen , ods.Dataset );
  Controller.Refresh;
 finally
  FreeAndNil( LController );
 end;

end;

end;

procedure TViewFornecedor.oExluirClick(Sender: TObject);
begin
 Controller.Delete;
end;

procedure TViewFornecedor.oGridDblClick(Sender: TObject);
var
  LController: TObject;
begin
 if ods.DataSet.IsEmpty then exit;

begin
 try
  LController:=  TControllerFactory.CreateController( 'controller crud fornecedor', oActionOpen , ods.Dataset );
  Controller.Refresh;
 finally
  FreeAndNil( LController );
 end;

end;

end;

Initialization
  RegisterClassAlias( TViewFornecedor, 'fornecedor' );
 Finalization
  UnRegisterClass( TViewFornecedor );
end.
