unit dao.abstract;

interface

uses
  System.SysUtils,
  System.Classes,
  Winapi.Windows, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client;

type
  TDaoAbstract = class(TDataModule)
    oCon: TFDConnection;
  private
    { Private declarations }
  public
    procedure BeforeDestruction; override;
    procedure AfterConstruction; override;
    { Public declarations }


  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TrimAppMemorySize;
var
  MainHandle: THandle;
begin
  try
    MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false, GetCurrentProcessID);
    SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF);
    CloseHandle(MainHandle);
  except
  end;

end;

{ TDaoAbstract }
procedure TDaoAbstract.AfterConstruction;
begin
  inherited;
 TrimAppMemorySize;
end;

procedure TDaoAbstract.BeforeDestruction;
begin
  inherited;
  TrimAppMemorySize;
end;

end.
