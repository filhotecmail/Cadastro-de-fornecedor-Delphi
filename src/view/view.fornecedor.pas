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
    oEnterAsTab: TJvEnterAsTab;
    GroupBox2: TGroupBox;
    oGrid: TJvDBGrid;
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


{  --------------------------------------------------------------------------
  Procedimento: TViewFornecedor.Button1Click
  Resumo: Manipula o evento de clique no botão de adição na visualização de fornecedores.
  Descrição:
    Este procedimento é chamado quando o botão de adição na visualização de fornecedores é clicado.
    Ele cria uma instância do controlador responsável pelo CRUD de fornecedores e associa a ação de adição e
    o conjunto de dados do grid ao controlador. Em seguida, o método Refresh do controlador é chamado
    para atualizar os dados. Se ocorrer algum problema durante a criação ou execução do controlador,
    uma exceção será lançada.
  ---------------------------------------------------------------------------
}
 procedure TViewFornecedor.Button1Click(Sender: TObject);
 var
  LController: TObject;
begin

  if Controller.OutherDataset.RecordCount <= 0 then
     raise Exception.Create('Não existem empresas cadastradas no sistema!');

 try
  LController:=  TControllerFactory.CreateController( 'controller crud fornecedor', oActionAppend , ods.Dataset );
  Controller.Refresh;
 finally
  FreeAndNil( LController );
 end;

end;


{  --------------------------------------------------------------------------
  Procedimento: TViewFornecedor.oEditarClick
  Resumo: Manipula o evento de clique no botão de edição na visualização de fornecedores.
  Descrição:
    Este procedimento é chamado quando o botão de edição na visualização de fornecedores é clicado.
    Ele cria uma instância do controlador responsável pelo CRUD de fornecedores e associa a ação de
    abertura e o conjunto de dados do grid ao controlador. Em seguida, o método Refresh do controlador é
    chamado para atualizar os dados. Se ocorrer algum problema durante a criação ou execução do controlador,
    uma exceção será lançada.
  ---------------------------------------------------------------------------
}
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

{  --------------------------------------------------------------------------
  Procedimento: TViewFornecedor.oExluirClick
  Resumo: Manipula o evento de clique no botão de exclusão na visualização de fornecedores.
  Descrição:
    Este procedimento é chamado quando o botão de exclusão na visualização de fornecedores é clicado.
    Ele chama o método Delete do controlador associado à visualização para excluir o registro atual.
    Se o controlador não estiver definido ou se ocorrer algum problema durante a exclusão, uma exceção pode ser lançada.
  ---------------------------------------------------------------------------
}
procedure TViewFornecedor.oExluirClick(Sender: TObject);
begin
 Controller.Delete;
end;

{  --------------------------------------------------------------------------
  Procedimento: TViewFornecedor.oGridDblClick
  Resumo: Manipula o evento de clique duplo no grid de fornecedores.
  Descrição:
    Este procedimento é chamado quando ocorre um clique duplo no grid de fornecedores.
    Ele cria uma instância do controlador responsável pelo CRUD de fornecedores e associa a
    ação de abertura e o conjunto de dados do grid ao controlador. Em seguida, o método Refresh
    do controlador é chamado para atualizar os dados. Se ocorrer algum problema durante a criação ou
    execução do controlador, uma exceção será lançada.
  ---------------------------------------------------------------------------
}

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
