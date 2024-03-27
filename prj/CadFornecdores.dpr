program CadFornecdores;

uses
  Vcl.Forms,
  view.master in '..\src\view\view.master.pas' {Form11};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm11, Form11);
  Application.Run;
end.
