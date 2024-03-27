unit controller.abstract;

interface

uses
  System.SysUtils,
  System.Classes,
  model.abstract;

type
  TControllerAbstract = class( TDataModule )
  private
    FModelName: TModelAbstract;
    procedure SetModelName(const Value: TModelAbstract);
    { Private declarations }
  public
    { Public declarations }
    property ModelName: TModelAbstract read FModelName write SetModelName;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

{ TControllerAbstract }

procedure TControllerAbstract.SetModelName(const Value: TModelAbstract);
begin
  FModelName := Value;
end;

end.
