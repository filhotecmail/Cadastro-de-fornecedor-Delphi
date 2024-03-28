unit view.master;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ShellAPI,
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
  JvEnterTab,
  Vcl.AppEvnts,
  Vcl.OleCtrls,
  SHDocVw;

type
  TViewmaster = class( TForm )
    MainMenu1: TMainMenu;
    M1: TMenuItem;
    C1: TMenuItem;
    I1: TMenuItem;
    S1: TMenuItem;
    oEnterAsTab: TJvEnterAsTab;
    StatusBar1: TStatusBar;
    oAppEvents: TApplicationEvents;
    oWb: TWebBrowser;
    procedure C1Click(Sender: TObject);
    procedure I1Click(Sender: TObject);
    procedure oAppEventsException(Sender: TObject; E: Exception);
    procedure FormShow(Sender: TObject);
    procedure S1Click(Sender: TObject);
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



procedure TViewmaster.FormShow(Sender: TObject);
var
  HTMLFilePath: string;
begin
  HTMLFilePath := ExtractFilePath(ParamStr(0));
  HTMLFilePath := HTMLFilePath + 'doc\Result.html';
  oWb.Navigate('file:///' + HTMLFilePath);
end;

procedure TViewmaster.I1Click(Sender: TObject);
begin
 TControllerFactory.CreateController('controller fornecedor');
end;

procedure TViewmaster.oAppEventsException(Sender: TObject; E: Exception);
begin

 if E.Message.Contains('CHK_EMPRESA_CNPJ') then
    with TTaskDialog.Create(Self) do
  begin
    try
      Caption := 'Erro - CNPJ inv�lido';
      Title := 'Data Error';
      Text := 'O CNPJ informado � inv�lido ou est� em um padr�o que n�o corresponde a um CNPJ .';
      MainIcon := tdiError;
      CommonButtons := [tcbOk];
      Execute;
    finally
      Free;
    end;
  end else
   if E.Message.Contains('UNQ1_EMPRESA') then
    with TTaskDialog.Create(Self) do
  begin
    try
      Caption := 'Erro - Pessoa F�sica ';
      Title := 'Data Error';
      Text := 'A data de nascimento informada, relata que o portador deste documento CPF � menor de idade portanto o '
             +'estado do Paran� n�o permite a inclus�o deste fornecedor no cadastro .';
      MainIcon := tdiError;
      CommonButtons := [tcbOk];
      Execute;
    finally
      Free;
    end;
  end else

   if E.Message.Contains('CHK_FORNECEDOR_DATANASC') then
    with TTaskDialog.Create(Self) do
  begin
    try
      Caption := 'Erro - Registro j� existe no cadastro!';
      Title := 'Data Error';
      Text := 'O CNPJ Informado corresponde a um CNPJ de um registro j� existente no banco de dados.';
      MainIcon := tdiError;
      CommonButtons := [tcbOk];
      Execute;
    finally
      Free;
    end;
  end else

  with TTaskDialog.Create(Self) do
  begin
    try
      Caption := 'Erro - CNPJ inv�lido';
      Title := 'Data Error';
      Text := E.Message;
      MainIcon := tdiError;
      CommonButtons := [tcbOk];
      Execute;
    finally
      Free;
    end;
  end;

end;

procedure TViewmaster.S1Click(Sender: TObject);
begin
  ShellExecute(Handle,
               'open',
               'https://github.com/filhotecmail/Cadastro-de-fornecedor-Delphi',
               nil,
               nil,
               SW_SHOWMAXIMIZED);

end;

end.
