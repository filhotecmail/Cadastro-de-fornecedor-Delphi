unit view.doc.database;

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
  Vcl.Dialogs, Vcl.OleCtrls, SHDocVw;

type
  TViewDocDatabase = class(TForm)
    oWb: TWebBrowser;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
{$R *.dfm}

procedure TViewDocDatabase.FormShow(Sender: TObject);
var
  HTMLFilePath: string;
begin
  HTMLFilePath := ExtractFilePath(ParamStr(0));
  HTMLFilePath := HTMLFilePath + 'doc\Result.html';
  oWb.Navigate('file:///' + HTMLFilePath);

end;

end.
