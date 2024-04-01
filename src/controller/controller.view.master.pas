unit controller.view.master;

interface

uses
  System.SysUtils,
  System.Classes,
  System.ImageList,
  Vcl.ExtCtrls,
  Vcl.ImgList,
  Vcl.Controls,
  Datasnap.Provider,
  FireDAC.Stan.Param,
  //
  TestFramework,
  //
  controller.abstract;

type
  TControllerMasterView = class(TControllerAbstract)
  private
   { Private declarations }
  public
   { Public declarations }
    procedure AfterConstruction; override;
    procedure ShowController; override;
    procedure Open(AValues: array of Variant); override;
    procedure Filter(ACondition: string; AValue: string); override;

  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}

uses model.master;
{$R *.dfm}

{ TControllerMasterView }
procedure TControllerMasterView.AfterConstruction;
begin
  inherited;
  model    := TModelMaster.Create( Self );
  ViewName := 'viewmaster';
  OutherDataset := model.GetDatasetbyName('oFiltered');
end;

procedure TControllerMasterView.Filter(ACondition, AValue: string);
var
  FilterValue: String;
begin
 OutherDataset.Open;
 OutherDataset.Filtered:= false;

 if ACondition.Contains('LIKE') then
   FilterValue := '%' + UpperCase(AValue) + '%'
   else
   FilterValue:= AValue;

 OutherDataset.Filter  := Format( ACondition ,[ QuotedStr( FilterValue ) ]);
 OutherDataset.Filtered:= True;
end;

procedure TControllerMasterView.Open(AValues: array of Variant);
begin
  with AsFd do
  begin
    close;
    ParamByName('P').AsString := AValues[0];
    Open;
  end;

end;

procedure TControllerMasterView.ShowController;
begin
 View.ShowModal;
end;

initialization
  RegisterClassAlias( TControllerMasterView, 'controller view.master' );
 Finalization
  UnRegisterClass( TControllerMasterView );

end.
