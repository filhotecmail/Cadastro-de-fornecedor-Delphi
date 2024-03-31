unit dao.abstract;

interface

uses
  System.SysUtils,
  System.Classes,
  Winapi.Windows,
  vcl.forms,
  Vcl.Dialogs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Moni.Base,
  FireDAC.Moni.Custom,
  FireDAC.Moni.FlatFile,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdTelnet, Vcl.ExtCtrls;

type
  TDaoAbstract = class( TDataModule )
    oCon: TFDConnection;
    oMonitor: TFDMoniCustomClientLink;
    procedure oMonitorOutput(ASender: TFDMoniClientLinkBase; const AClassName, AObjName, AMessage: string);
    procedure oConAfterCommit(Sender: TObject);
    procedure oConAfterConnect(Sender: TObject);
    procedure oConAfterDisconnect(Sender: TObject);
    procedure oConAfterRollback(Sender: TObject);
    procedure oConAfterStartTransaction(Sender: TObject);
    procedure oConBeforeCommit(Sender: TObject);
    procedure oConBeforeConnect(Sender: TObject);
    procedure oConBeforeDisconnect(Sender: TObject);
    procedure oConBeforeRollback(Sender: TObject);
    procedure oConBeforeStartTransaction(Sender: TObject);
    procedure oConError(ASender, AInitiator: TObject; var AException: Exception);
    procedure oConLogin(AConnection: TFDCustomConnection; AParams: TFDConnectionDefParams);
    procedure oConLost(Sender: TObject);
    procedure oConRecover(ASender, AInitiator: TObject; AException: Exception;
      var AAction: TFDPhysConnectionRecoverAction);
    procedure oConRestored(Sender: TObject);
  strict private
    FInRelease: Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure BeforeDestruction; override;
    procedure AfterConstruction; override;
  end;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}
uses commom.system.logger;
{$R *.dfm}

procedure TrimAppMemorySize;
var
  MainHandle: THandle;
begin
  try
    MainHandle := OpenProcess( PROCESS_ALL_ACCESS, false, GetCurrentProcessID );
    SetProcessWorkingSetSize( MainHandle, $FFFFFFFF, $FFFFFFFF );
    CloseHandle( MainHandle );
  except
  end;

end;

{ TDaoAbstract }
procedure TDaoAbstract.AfterConstruction;
begin
  inherited;
  TrimAppMemorySize;
  logger.WriteLogConstrutor(Self);
end;

procedure TDaoAbstract.BeforeDestruction;
begin
  inherited;
  FInRelease:= true;
  TrimAppMemorySize;
  logger.WriteLogDestructor(Self);
end;

procedure TDaoAbstract.oConAfterCommit(Sender: TObject);
begin
 logger.WriteLog( 'Commit realizado com sucesso no database , %s ',[Self.ClassName] );
end;

procedure TDaoAbstract.oConAfterConnect(Sender: TObject);
begin
 logger.WriteLog( 'Conectado no database , %s ',[Self.ClassName] );
end;

procedure TDaoAbstract.oConAfterDisconnect(Sender: TObject);
begin
 logger.WriteLog( 'Desconectado do database , %s ',[Self.ClassName] );
end;

procedure TDaoAbstract.oConAfterRollback(Sender: TObject);
begin
 logger.WriteLog( 'Rollback efetuado com sucesso! , %s ',[Self.ClassName] );
end;

procedure TDaoAbstract.oConAfterStartTransaction(Sender: TObject);
begin
 logger.WriteLog( 'Transacao aberta no database , %s ',[Self.ClassName] );
end;

procedure TDaoAbstract.oConBeforeCommit(Sender: TObject);
begin
 logger.WriteLog( 'Tentando gravar no database, %s ',[Self.ClassName] );
end;

procedure TDaoAbstract.oConBeforeConnect(Sender: TObject);
begin
 logger.WriteLog( 'Tentando conectar ao database, %s ',[Self.ClassName] );
end;

procedure TDaoAbstract.oConBeforeDisconnect(Sender: TObject);
begin
 logger.WriteLog( 'Tentando desconectar da sessao do database, %s ',[Self.ClassName] );
end;

procedure TDaoAbstract.oConBeforeRollback(Sender: TObject);
begin
 logger.WriteLog( 'Rollback realizado %s ',[Self.ClassName] );
end;

procedure TDaoAbstract.oConBeforeStartTransaction(Sender: TObject);
begin
 logger.WriteLog( 'Iniciando transacao %s ',[Self.ClassName] );
end;

procedure TDaoAbstract.oConError(ASender, AInitiator: TObject; var AException: Exception);
begin
 if AException.Message.Contains('[FireDAC][Phys][FB]invalid database handle (no active connection)') then Exit;

 logger.WriteLog( 'Erro de conexao %s -> %s ',[Self.ClassName,AException.Message ] );
end;

procedure TDaoAbstract.oConLogin(AConnection: TFDCustomConnection; AParams: TFDConnectionDefParams);
begin
 logger.WriteLog( 'Efetuando login %s ',[Self.ClassName] );
end;

procedure TDaoAbstract.oConLost(Sender: TObject);
begin
 logger.WriteLog( 'conexao perdida %s ',[Self.ClassName] );
end;

procedure TDaoAbstract.oConRecover(ASender, AInitiator: TObject; AException: Exception;
  var AAction: TFDPhysConnectionRecoverAction);
begin
  logger.WriteLog( 'conexao recuperada %s ',[Self.ClassName] );
end;

procedure TDaoAbstract.oConRestored(Sender: TObject);
begin
 logger.WriteLog( 'conexao restaurada %s ',[Self.ClassName] );
end;

procedure TDaoAbstract.oMonitorOutput(ASender: TFDMoniClientLinkBase; const AClassName, AObjName, AMessage: string);
begin
 if Pos('Ping',AMessage) <> 0 then Exit;
  if AMessage.Contains('fb_ping') then Exit;
   if AMessage.Contains('ERROR: invalid database handle (no active connection)') then Exit;
   if AMessage.Contains('[FireDAC][Phys][FB]invalid database handle (no active connection)') then Exit;
      logger.WriteLog( AMessage );

end;

end.
