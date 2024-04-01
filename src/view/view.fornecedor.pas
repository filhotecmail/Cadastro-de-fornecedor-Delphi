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
  Resumo: Manipula o evento de clique no bot�o de adi��o na visualiza��o de fornecedores.
  Descri��o:
    Este procedimento � chamado quando o bot�o de adi��o na visualiza��o de fornecedores � clicado.
    Ele cria uma inst�ncia do controlador respons�vel pelo CRUD de fornecedores e associa a a��o de adi��o e
    o conjunto de dados do grid ao controlador. Em seguida, o m�todo Refresh do controlador � chamado
    para atualizar os dados. Se ocorrer algum problema durante a cria��o ou execu��o do controlador,
    uma exce��o ser� lan�ada.
  ---------------------------------------------------------------------------
}
 procedure TViewFornecedor.Button1Click(Sender: TObject);
 var
  LController: TObject;
begin

  if Controller.OutherDataset.RecordCount <= 0 then
     raise Exception.Create('N�o existem empresas cadastradas no sistema!');

 try
  LController:=  TControllerFactory.CreateController( 'controller crud fornecedor', oActionAppend , ods.Dataset );
  Controller.Refresh;
 finally
  FreeAndNil( LController );
 end;

end;


{  --------------------------------------------------------------------------
  Procedimento: TViewFornecedor.oEditarClick
  Resumo: Manipula o evento de clique no bot�o de edi��o na visualiza��o de fornecedores.
  Descri��o:
    Este procedimento � chamado quando o bot�o de edi��o na visualiza��o de fornecedores � clicado.
    Ele cria uma inst�ncia do controlador respons�vel pelo CRUD de fornecedores e associa a a��o de
    abertura e o conjunto de dados do grid ao controlador. Em seguida, o m�todo Refresh do controlador �
    chamado para atualizar os dados. Se ocorrer algum problema durante a cria��o ou execu��o do controlador,
    uma exce��o ser� lan�ada.
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
  Resumo: Manipula o evento de clique no bot�o de exclus�o na visualiza��o de fornecedores.
  Descri��o:
    Este procedimento � chamado quando o bot�o de exclus�o na visualiza��o de fornecedores � clicado.
    Ele chama o m�todo Delete do controlador associado � visualiza��o para excluir o registro atual.
    Se o controlador n�o estiver definido ou se ocorrer algum problema durante a exclus�o, uma exce��o pode ser lan�ada.
  ---------------------------------------------------------------------------
}
procedure TViewFornecedor.oExluirClick(Sender: TObject);
begin
 Controller.Delete;
end;

{  --------------------------------------------------------------------------
  Procedimento: TViewFornecedor.oGridDblClick
  Resumo: Manipula o evento de clique duplo no grid de fornecedores.
  Descri��o:
    Este procedimento � chamado quando ocorre um clique duplo no grid de fornecedores.
    Ele cria uma inst�ncia do controlador respons�vel pelo CRUD de fornecedores e associa a
    a��o de abertura e o conjunto de dados do grid ao controlador. Em seguida, o m�todo Refresh
    do controlador � chamado para atualizar os dados. Se ocorrer algum problema durante a cria��o ou
    execu��o do controlador, uma exce��o ser� lan�ada.
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
