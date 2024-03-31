program CadFornecdores;

uses
  Vcl.Forms,
  view.master in '..\src\view\view.master.pas' {Viewmaster},
  dao.abstract in '..\common\dao.abstract.pas' {DaoAbstract: TDataModule},
  model.abstract in '..\common\model.abstract.pas' {ModelAbstract: TDataModule},
  model.empresa in '..\src\model\model.empresa.pas' {ModelEmpresa: TDataModule},
  model.fornecedor in '..\src\model\model.fornecedor.pas' {ModelFornecedor: TDataModule},
  controller.abstract in '..\common\controller.abstract.pas' {ControllerAbstract: TDataModule},
  controller.empresa in '..\src\controller\controller.empresa.pas' {ControllerEmpresa: TDataModule},
  controller.fornecedor in '..\src\controller\controller.fornecedor.pas' {ControllerFornecedor: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  view.empresa in '..\src\view\view.empresa.pas' {ViewEmpresa},
  view.fornecedor in '..\src\view\view.fornecedor.pas' {ViewFornecedor},
  view.empresa.crud in '..\src\view\view.empresa.crud.pas' {ViewEmpresaCrud},
  controller.empresa.crud in '..\src\controller\controller.empresa.crud.pas' {ControllerEmpresaCrud: TDataModule},
  view.forcenedor.crud in '..\src\view\view.forcenedor.crud.pas' {ViewFornecedorCrud},
  controller.fornecedor.crud in '..\src\controller\controller.fornecedor.crud.pas' {ControllerFornecedorCrud: TDataModule},
  view.doc.database in '..\src\view\view.doc.database.pas' {ViewDocDatabase},
  model.master in '..\src\model\model.master.pas' {ModelMaster: TDataModule},
  controller.view.master in '..\src\controller\controller.view.master.pas' {ControllerMasterView: TDataModule},
  Web.Sockets.WebSocketServer in '..\common\Web.Sockets.WebSocketServer.pas',
  commom.system.logger in '..\common\commom.system.logger.pas',
  commom.websocket in '..\common\commom.websocket.pas',
  database.driver.abstract in '..\common\database.driver.abstract.pas' {DatabaseDriverAbstract: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
 { Cria a instância do Logger da Aplicação }
  logger.Options.UseSocket := true;
  logger.Options.SocketPort:= 5557;
  logger.Load;

 { Cria o Controller da Visão principal }
  TControllerFactory.CreateController('controller view.master');
  Application.Run;

end.
