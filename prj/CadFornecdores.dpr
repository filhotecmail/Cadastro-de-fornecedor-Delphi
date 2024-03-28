program CadFornecdores;

uses
  Vcl.Forms,
  view.master in '..\src\view\view.master.pas' {Viewmaster},
  dao.abstract in '..\common\dao.abstract.pas' {DaoAbstract: TDataModule},
  database.driver.abstract in '..\common\database.driver.abstract.pas' {DatabaseDriverAbstract: TDataModule},
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
  controller.fornecedor.crud in '..\src\controller\controller.fornecedor.crud.pas' {ControllerFornecedorCrud: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TViewmaster, Viewmaster);
  Application.Run;
end.
