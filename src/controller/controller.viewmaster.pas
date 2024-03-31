unit controller.viewmaster;

interface

uses
  System.SysUtils,
  System.Classes,
  Json,
  controller.abstract,
  Datasnap.Provider;

type
  TControllerViewMaster = class(TControllerAbstract)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowController; override;
    procedure AfterConstruction; override;
    procedure Open(AValues: array of Variant); override;

  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}

uses model.master;
{$R *.dfm}

 { TControllerViewMaster }
procedure TControllerViewMaster.AfterConstruction;
begin
  inherited;
  ViewName:= 'viewmaster';
  model:= TModelMaster.Create( Self );
end;

procedure TControllerViewMaster.Open(AValues: array of Variant);
begin
 with AsFd do
 begin
   ParamByName('P').AsString := AValues[0];
   Open;
 end;
end;

procedure TControllerViewMaster.ShowController;
begin
  View.ShowModal;
end;

initialization
 RegisterClassAlias( TControllerViewMaster, 'controller viewmaster' );
 Finalization
 UnRegisterClass( TControllerViewMaster );

end.
