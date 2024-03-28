unit database.driver.abstract;

interface

uses
  System.SysUtils,
  System.Classes,
  dao.abstract;

type
  TDatabaseDriverAbstract = class sealed(TDataModule)
  private
    FParamStr: string;
    FDao: TDaoAbstract;
    procedure SetParamStr(const Value: string);
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
    property ParamStr: string read FParamStr write SetParamStr;

  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

{ TDatabaseDriverAbstract }

constructor TDatabaseDriverAbstract.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TDatabaseDriverAbstract.SetParamStr(const Value: string);
begin
  FParamStr := Value;

end;

end.
