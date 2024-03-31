unit model.master;

interface

uses
  System.SysUtils,
  System.Classes,
  model.abstract,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.UI.Intf,
  FireDAC.Comp.ScriptCommands,
  FireDAC.Stan.Util,
  FireDAC.Comp.Script;

type
  TModelMaster = class(TModelAbstract)
    oFiltered: TFDQuery;
  private
    { Private declarations }
  public
   { Public declarations }
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}

uses commom.system.logger;
{$R *.dfm}

{ TModelMaster }

procedure TModelMaster.AfterConstruction;
begin
  inherited;
  logger.WriteLogConstrutor(Self);
  oFiltered.Connection := oDataset.Connection;
end;

procedure TModelMaster.BeforeDestruction;
begin
  inherited;
  logger.WriteLogDestructor(Self);
end;

end.
