unit commom.system.logger;

interface

uses
  system.SysUtils,
  system.Classes,
  System.Diagnostics,
  Vcl.Consts,
  System.RegularExpressions,
  Rtti,
  TypInfo,
  system.SysConst,
  system.IOUtils,
  system.JSON,
  system.Types,
  PsAPI,
  IPHlpApi,
  WinSock2,
  Vcl.ExtCtrls,
  WinApi.Windows,
  Vcl.Forms,
  Vcl.StdCtrls,
  DateUtils,
  JclSysUtils,
  //
  JclDebug,
  //
  IdContext,
  IdComponent,
  IdBaseComponent,
  IdCustomTCPServer,
  IdThreadSafe,
  IdTCPConnection,
  IdYarn,
  IdTCPServer,
  Web.HTTPApp,
  Registry,
  //
  commom.websocket;

type
  TOptionsLog = class( TComponent )
  private
    FHeaderLog  : String;
    FFileNameLog: String;
    FSocketPort : DWORD64;
    FUseSocket  : Boolean;
    procedure SetFileNameLog( const Value: String );
    procedure SetHeaderLog( const Value: String );
    procedure SetSocketPort( const Value: DWORD64 );
    procedure SetUseSocket( const Value: Boolean );
  published
    property HeaderLog  : String read FHeaderLog write SetHeaderLog;
    property FileNameLog: String read FFileNameLog write SetFileNameLog;
    property UseSocket  : Boolean read FUseSocket write SetUseSocket;
    property SocketPort : DWORD64 read FSocketPort write SetSocketPort;
  end;

type
  ILogger = interface
    ['{410E0242-BFA3-492B-90BA-A43B20EB0E58}']
    function WriteLog( const AText: string ): ILogger; overload;
    function WriteLog( const AText: string; const AArgs: array of const ): ILogger; overload;
    function WriteLog( Aobject: TClass;AMethodAddress: String; Arg: TProc ): ILogger; overload;
    function WriteLogApp( const AText: string; const AArgs: array of const ): ILogger;
    function WriteLogConstrutor( const Ainstance: TObject ): ILogger;
    function WriteLogDestructor( const Ainstance: TObject ): ILogger;
    function WriteException( const AException: Exception ): ILogger;
    function Trace( AInstance: TObject; const Arg: TProc ): ILogger;
    function WriteTest(AInstance: TObject; const Arg: TProc): ILogger; overload;
    function WriteTest(AInstance: TObject; ATestName: string; Arg: Boolean ): ILogger; overload;
    function Options: TOptionsLog;
    function GetFLoad: ILogger;
    function GetUnload: ILogger;
    property Load: ILogger read GetFLoad;
    property Unload: ILogger read GetUnload;
    function ReadMemory: ILogger;
  end;

  TLogger = class( TComponent, ILogger )
  strict private
    FOptions    : TOptionsLog;
    FServer     : TWebSocketServer;
    FIo         : TWebSocketIOHandlerHelper;
    FContextList: TArray<TWebSocketIOHandlerHelper>;
    FLoad       : Boolean;
    procedure CreateSocket;
    procedure DoInternalLoad;
    procedure DoUnload;
    procedure Connect( AContext: TIdContext );
    procedure Disconnect( AContext: TIdContext );
    procedure Execute( AContext: TIdContext );
  private
    FLogs    : TStringList;
    FFileName: string;
    procedure InternalWriteLog( const Amessage: String );
    function GetFLoad: ILogger;
    function GetUnload: ILogger;
  public
    destructor Destroy; override;
    function WriteLog( const AText: string ): ILogger; overload;
    function WriteLog( Aobject: TClass;AMethodAddress: String; Arg: TProc ): ILogger; overload;
    function WriteLog( const AText: string; const AArgs: array of const ): ILogger; overload;
    function WriteLogApp( const AText: string; const AArgs: array of const ): ILogger;
    function WriteLogConstrutor( const Ainstance: TObject ): ILogger;
    function WriteLogDestructor( const Ainstance: TObject ): ILogger;
    function WriteException( const AException: Exception ): ILogger;
    function Trace(  AInstance: TObject; const Arg: TProc ): ILogger;
    function WriteTest(AInstance: TObject; const Arg: TProc): ILogger; overload;
    function WriteTest( AInstance: TObject; ATestName: string; Arg: Boolean ): ILogger; overload;

    function ReadMemory: ILogger;
    property Load: ILogger read GetFLoad;
    property Unload: ILogger read GetUnload;
    function Options: TOptionsLog;
    class function New: ILogger; overload;
    class function New(DefaultPort: word): ILogger; overload;
  end;

 type
  ExceptionHelper = class helper for Exception
  public
    function Describe: string;
    class procedure RaiseNotImplementedException(const aClass: TClass; const aMethodName: string);
    class function GetStackTrace: string;
  end;

function logger: ILogger;
function loggerDef(DefaultPort: int64): ILogger;

implementation
 uses System.RTLConsts;

  var GlobalInstance: ILogger;
  type EStackTraceException = class(Exception);

function GetSizeSuffix(Bytes: Int64): string;
const
  KB = 1024;
  MB = KB * 1024;
  GB = MB * 1024;
begin
  if Bytes >= GB then
    Result := Format('%.2f GB', [Bytes / GB])
  else if Bytes >= MB then
    Result := Format('%.2f MB', [Bytes / MB])
  else if Bytes >= KB then
    Result := Format('%.2f KB', [Bytes / KB])
  else
    Result := Format('%d B', [Bytes]);
end;

procedure SaveGlobalInstanceToRegistry;
var
  Reg        : TRegistry;
  InstancePtr: Pointer;
begin

  InstancePtr := Pointer( GlobalInstance );
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey( '\Software\logger', True )
    then
    begin
      Reg.WriteBinaryData( '_lref', InstancePtr, SizeOf( Pointer ) );
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;


function logger: ILogger;
begin
  Result := TLogger.New;
end;

function loggerDef(DefaultPort: int64): ILogger;
begin
 Result:= TLogger.New( DefaultPort );
end;


type
  THardDiskRecord = record
    TotalNumberOfBytes: string;
    FreeBytesAvailable: string;
  end;

function GetExceptionMethodName: string;
var
  MethodAddr: Pointer;
begin
  MethodAddr := ExceptAddr;
  Result := TObject( MethodAddr ).QualifiedClassName;
end;

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

function GetPageFaultsAppProcessStr( const ProcessID: DWORD ): string;
var
  ProcessHandle: THandle;
  MemCounters  : TProcessMemoryCounters;
  PageFaults   : Int64;
  UnitIndex    : Integer;
  Units        : array [ 0 .. 3 ] of string;
begin
  Result := '';
  ProcessHandle := OpenProcess( PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, false, ProcessID );
  if ProcessHandle <> 0
  then
  begin
    try
      if GetProcessMemoryInfo( ProcessHandle, @MemCounters, SizeOf( MemCounters ) )
      then
      begin
        PageFaults := MemCounters.PageFaultCount;
        Units[ 0 ] := 'B';
        Units[ 1 ] := 'KB';
        Units[ 2 ] := 'MB';
        Units[ 3 ] := 'GB';
        UnitIndex := 0;
        while ( PageFaults >= 1024 ) and ( UnitIndex < High( Units ) ) do
        begin
          Inc( UnitIndex );
          PageFaults := PageFaults div 1024;
        end;
        Result := IntToStr( PageFaults ) + ' ' + Units[ UnitIndex ];
      end;
    finally
      CloseHandle( ProcessHandle );
    end;
  end;
end;

function GetHardDiskSizeStr: THardDiskRecord;
var
  FreeBytesAvailable, TotalNumberOfBytes, TotalNumberOfFreeBytes: Int64;
  Drive: string;
begin
  Drive := ExtractFileDrive( GetCurrentDir );
  Result.TotalNumberOfBytes := Format( '%d GB', [ 0 ] );
  Result.FreeBytesAvailable := Format( '%d GB', [ 0 ] );

  if not GetDiskFreeSpaceEx( PChar( Drive ), FreeBytesAvailable, TotalNumberOfBytes, @TotalNumberOfFreeBytes )
  then
    exit;

  Result.TotalNumberOfBytes := Format( '%d GB', [ TotalNumberOfBytes div 1024 div 1024 div 1024 ] );
  Result.FreeBytesAvailable := Format( '%d GB', [ FreeBytesAvailable div 1024 div 1024 div 1024 ] );

end;

function GetOperatingSystemName: string;
const
OS_VERSIONS:
array [ 0 .. 10 ] of record MajorVersion: DWORD;
MinorVersion:
DWORD;
BuildNumber:
DWORD;
Name:
string;
end
= ( ( MajorVersion: 11; MinorVersion: 0; BuildNumber: 22000; Name: 'Windows 11' ), ( MajorVersion: 10; MinorVersion: 0; BuildNumber: 22000; Name: 'Windows 10' ),
  ( MajorVersion: 6; MinorVersion: 3; BuildNumber: 0; Name: 'Windows 8.1' ), ( MajorVersion: 6; MinorVersion: 2; BuildNumber: 0; Name: 'Windows 8' ), ( MajorVersion: 6;
    MinorVersion: 1; BuildNumber: 0; Name: 'Windows 7' ), ( MajorVersion: 6; MinorVersion: 0; BuildNumber: 0; Name: 'Windows Vista' ), ( MajorVersion: 5; MinorVersion: 2;
    BuildNumber: 0; Name: 'Windows Server 2003' ), ( MajorVersion: 5; MinorVersion: 1; BuildNumber: 0; Name: 'Windows XP' ), ( MajorVersion: 5; MinorVersion: 0;
    BuildNumber: 0; Name: 'Windows 2000' ), ( MajorVersion: 4; MinorVersion: 90; BuildNumber: 0; Name: 'Windows ME' ), ( MajorVersion: 4; MinorVersion: 10; BuildNumber: 0;
    Name: 'Windows 98' ) );

var
  osVersionInfo : TOSVersionInfoEx;
  osVersionIndex: Integer;
begin
  ZeroMemory( @osVersionInfo, SizeOf( TOSVersionInfoEx ) );
  osVersionInfo.dwOSVersionInfoSize := SizeOf( TOSVersionInfoEx );
  if GetVersionEx( POSVersionInfo( @osVersionInfo )^ )
  then
  begin
    for osVersionIndex := Low( OS_VERSIONS ) to High( OS_VERSIONS ) do
    begin
      if ( osVersionInfo.dwMajorVersion = OS_VERSIONS[ osVersionIndex ].MajorVersion ) and ( osVersionInfo.dwMinorVersion = OS_VERSIONS[ osVersionIndex ].MinorVersion ) and
        ( osVersionInfo.dwBuildNumber >= OS_VERSIONS[ osVersionIndex ].BuildNumber )
      then
      begin
        Result := OS_VERSIONS[ osVersionIndex ].Name;
        exit;
      end;
    end;
    Result := 'Unknown Windows Version';
  end
  else
    Result := 'Unable to determine Windows version';
end;

function GetCurrentHdLetterApp: Char;
var
  ModuleFileName: array [ 0 .. MAX_PATH ] of Char;
begin
  GetModuleFileName( 0, ModuleFileName, Length( ModuleFileName ) );
  Result := ExtractFileDrive( ModuleFileName )[ 1 ];
end;

function GetCurrentProcessID: DWORD; stdcall; external 'kernel32.dll' name 'GetCurrentProcessId';

function GetCurrentProcessIdStr: String;
var
  PID: DWORD;
begin
  PID := GetCurrentProcessID;
  Result := IntToStr( PID );
end;

function GetFreeMemory: string;
var
  MemoryStatus: TMemoryStatusEx;
begin
  MemoryStatus.dwLength := SizeOf( TMemoryStatusEx );
  GlobalMemoryStatusEx( MemoryStatus );
  Result := Format( '%.2f GB', [ MemoryStatus.ullAvailPhys / ( 1024 * 1024 * 1024 ) ] );
end;

function GetCardinalMemoryUsageApp: Int64;
var
  ProcessHandle        : THandle;
  ProcessMemoryCounters: PROCESS_MEMORY_COUNTERS;
begin
  Result := 0;
  ProcessHandle := GetCurrentProcess;
  try
    if GetProcessMemoryInfo( ProcessHandle, @ProcessMemoryCounters, SizeOf( ProcessMemoryCounters ) )
    then
      Result :=  ProcessMemoryCounters.WorkingSetSize
    else
      RaiseLastOSError;
  finally
    CloseHandle( ProcessHandle );
  end;
end;

function GetMemoryUsageApp: string;
var
  ProcessHandle        : THandle;
  ProcessMemoryCounters: PROCESS_MEMORY_COUNTERS;
begin
  ProcessHandle := GetCurrentProcess;
  try
    if GetProcessMemoryInfo( ProcessHandle, @ProcessMemoryCounters, SizeOf( ProcessMemoryCounters ) )
    then
      Result := Format( '%.2f MB', [ ProcessMemoryCounters.WorkingSetSize / ( 1024 * 1024 ) ] )
    else
      RaiseLastOSError;
  finally
    CloseHandle( ProcessHandle );
  end;
end;

function GetTotalMemory: string;
var
  MemInfo   : MEMORYSTATUSEX;
  TotalMem  : Int64;
  SizeSuffix: string;
begin
  MemInfo.dwLength := SizeOf( MemInfo );
  GlobalMemoryStatusEx( MemInfo );
  TotalMem := MemInfo.ullTotalPhys div ( 1024 * 1024 ); // Total de memória em MB

  if TotalMem >= 1024
  then
  begin
    TotalMem := TotalMem div 1024;
    SizeSuffix := 'GB';
  end
  else if TotalMem >= 1
  then
    SizeSuffix := 'MB'
  else
  begin
    TotalMem := MemInfo.ullTotalPhys;
    SizeSuffix := 'B';
  end;
  Result := Format( '%d %s', [ TotalMem, SizeSuffix ] );
end;

{ TLogger }
function GetAppVersion: string;
var
  LSize, LHandle                : DWORD;
  LPBuffer                      : Pointer;
  LBuffer                       : array [ 0 .. 1023 ] of Char;
  LFileInfo                     : PVSFixedFileInfo;
  LFileVersionMS, LFileVersionLS: DWORD;
begin
  LSize := GetFileVersionInfoSize( PChar( ParamStr( 0 ) ), LHandle );
  if LSize > 0
  then
  begin
    LPBuffer := @LBuffer[ 0 ];
    if GetFileVersionInfo( PChar( ParamStr( 0 ) ), LHandle, LSize, LPBuffer )
    then
    begin
      if VerQueryValue( LPBuffer, '\', Pointer( LFileInfo ), LSize )
      then
      begin
        LFileVersionMS := LFileInfo.dwFileVersionMS;
        LFileVersionLS := LFileInfo.dwFileVersionLS;
        Result := Format( '%d.%d.%d.%d',
          [ HiWord( LFileVersionMS ), LoWord( LFileVersionMS ), HiWord( LFileVersionLS ), LoWord( LFileVersionLS ) ] );
      end;
    end;
  end;
end;

procedure TLogger.Connect( AContext: TIdContext );
var
  Lobj    : TWebSocketIOHandlerHelper;
  LAppName: string;
begin
  TrimAppMemorySize;
  LAppName := TPath.GetFileNameWithoutExtension( ParamStr( 0 ) );
  Lobj := TWebSocketIOHandlerHelper( AContext.Connection.IOHandler );

  Lobj.WriteString( 'Bem vindo ao Log do aplicativo' + #13#10 );
  Lobj.WriteString( Format( '> Log da aplicação %s version %s ', [ LAppName, GetAppVersion ] ) + #13#10 );
  Lobj.WriteString( Format( '> Total ram memory %s livre %s ', [ GetTotalMemory, GetFreeMemory ] ) + #13#10 );
  Lobj.WriteString( Format( '> Total process usage %s ProcessID %s ', [ GetMemoryUsageApp, GetCurrentProcessIdStr ] ) + #13#10 );
  Lobj.WriteString( Format( '> HardDisk Size %s avaliable %s ', [ GetHardDiskSizeStr.TotalNumberOfBytes, GetHardDiskSizeStr.FreeBytesAvailable ] ) + #13#10 );
  Lobj.WriteString( Format( '> Operational System %s | pageFaults %s  ', [ GetOperatingSystemName, GetPageFaultsAppProcessStr( GetCurrentProcessID ) ] ) + #13#10 );
  Lobj.WriteString( '> ................................................................... ' + #13#10 );
  FLogs.Add( '> ' + #13#10 );
  Insert( Lobj, FContextList, Length( FContextList ) + 1 );

end;

procedure TLogger.CreateSocket;
begin
  if FServer = nil
  then
    FServer := TWebSocketServer.Create;

  FServer.DefaultPort := FOptions.SocketPort;
  FServer.OnExecute := Execute;
  FServer.OnConnect := Connect;
  FServer.OnDisconnect := Disconnect;
  FServer.Active := True;
end;

destructor TLogger.Destroy;
begin
  DoUnload;
  inherited;
end;

procedure TLogger.Disconnect( AContext: TIdContext );
begin
  //
end;

procedure TLogger.DoInternalLoad;
var
  LAppName: string;
begin
  FLogs := TStringList.Create;
  if FOptions = nil
  then
    FOptions := TOptionsLog.Create( Self );

  LAppName := TPath.GetFileNameWithoutExtension( ParamStr( 0 ) );
  FFileName := FOptions.FileNameLog;

  if FOptions.FileNameLog.Trim.IsEmpty
  then
    FFileName := TPath.Combine( ExtractFilePath( ParamStr( 0 ) ),
      LAppName + FormatDateTime( ' DDMMYYYY', now ) + '.log' );

  if FileExists( FFileName )
  then
    FLogs.LoadFromFile( FFileName );

  if FLogs.Count <= 0
  then
  begin
    FLogs.Add( '> ' + FOptions.HeaderLog );
    FLogs.Add( Format( '> Log da aplicação %s version %s ', [ LAppName, GetAppVersion ] ) );
    FLogs.Add( Format( '> Listen on port %d', [ FOptions.SocketPort ] ) );
    FLogs.Add( '> ................................................................... ' );
    FLogs.Add( Format( '> Total ram memory %s livre %s ', [ GetTotalMemory, GetFreeMemory ] ) );
    FLogs.Add( Format( '> Total process usage %s ProcessID %s ', [ GetMemoryUsageApp, GetCurrentProcessIdStr ] ) );
    FLogs.Add( Format( '> HardDisk Size %s avaliable %s ', [ GetHardDiskSizeStr.TotalNumberOfBytes, GetHardDiskSizeStr.FreeBytesAvailable ] ) );
    FLogs.Add( Format( '> Operational System %s | pageFaults %s  ', [ GetOperatingSystemName, GetPageFaultsAppProcessStr( GetCurrentProcessID ) ] ) );
    FLogs.Add( '> ................................................................... ' );
  end
  else
    FLogs.Add( ' > .................................................................. ' );

end;

procedure TLogger.DoUnload;
var
  LFileStream: TFileStream;
begin
  // Salva o log em um arquivo na pasta do executável
  LFileStream := TFileStream.Create( FFileName, fmCreate );
  try
    FLogs.SaveToStream( LFileStream );
  finally
    LFileStream.Free;
  end;
  FServer.Active := false;
end;

procedure TLogger.Execute( AContext: TIdContext );
var
  msg: string;
begin
  FIo := TWebSocketIOHandlerHelper( AContext.Connection.IOHandler );
  FIo.CheckForDataOnSource( 10 );
  msg := FIo.ReadString;
  if msg = ''
  then
    exit;

end;

function TLogger.GetFLoad: ILogger;
begin
  Result := Self;
  if FLoad then
     exit;

  DoInternalLoad;
  if Options.UseSocket then
    CreateSocket;

  FLoad := True;
end;

function TLogger.GetUnload: ILogger;
begin
  if not FLoad then
      exit;

  DoUnload;

  FLoad := false;
end;

procedure TLogger.InternalWriteLog( const Amessage: String );
var
  LMessage: string;
  I: Integer;
begin
  if not FLoad then
    Load;

  LMessage := Format( '%s> %s', [ FormatDateTime( 'DDMMYYYY HH:MM:SS', now ), Amessage ] );
  FLogs.Add( LMessage );
  if FServer = nil then  exit;
  if not FServer.Active then  exit;
  for I := Low( FContextList ) to High( FContextList ) do
    FContextList[ I ].WriteString( LMessage + #13#10 );

end;

class function TLogger.New(DefaultPort: word): ILogger;
begin
  if not Assigned( GlobalInstance )
  then
  begin
    Result := TLogger.Create( Application );
    GlobalInstance := Result;
    GlobalInstance.Options.HeaderLog := 'Log da aplicação .: ' + ExtractFileName( ParamStr( 0 ) ) + ' Listen on port: '+ DefaultPort.ToString ;
    GlobalInstance.Options.UseSocket := True;
    GlobalInstance.Options.SocketPort := DefaultPort;
  end
  else
    Result := GlobalInstance;
  SaveGlobalInstanceToRegistry;
end;

class function TLogger.New: ILogger;
begin
  if not Assigned( GlobalInstance )
  then
  begin
    Result := TLogger.Create( Application );
    GlobalInstance := Result;
    GlobalInstance.Options.HeaderLog := 'Log da aplicação .: ' + ExtractFileName( ParamStr( 0 ) );
    GlobalInstance.Options.UseSocket := true;
    GlobalInstance.Options.SocketPort := 825002;
  end
  else
    Result := GlobalInstance;
  SaveGlobalInstanceToRegistry;

end;

function TLogger.Options: TOptionsLog;
begin
  if FOptions = nil then FOptions := TOptionsLog.Create( Self );
  Result := FOptions;
end;

function TLogger.ReadMemory: ILogger;
begin
 TrimAppMemorySize;
 WriteLog(Format( '> Total process usage %s ProcessID %s ', [ GetMemoryUsageApp, GetCurrentProcessIdStr ] ) + #13#10);
end;

function TLogger.Trace(AInstance: TObject; const Arg: TProc): ILogger;
var
  StartTime, EndTime: TDateTime;
begin
  StartTime := Now;
  try
    WriteLog(' %s ',[ EmptyStr ]);
    WriteLog('Iniciando rastreamento da pilha %s ',[ AInstance.ClassName ]);
    Arg;
    WriteLog('Terminando execução do método da instância %s ',[ AInstance.ClassName ]);
  Except
    on E: Exception do
    begin
      WriteException( E );
      raise;
    end;
  end;
  EndTime := Now;

  // Calcula a diferença de tempo em segundos
  WriteLog('Tempo de execução: %.2f segundos', [MilliSecondsBetween(EndTime, StartTime) / 1000]);
end;

function TLogger.WriteLog( const AText: string; const AArgs: array of const ): ILogger;
begin
  Result := Self;
  if Length( AArgs ) > 0 then  InternalWriteLog( Format( AText, AArgs ) )
  else InternalWriteLog( Atext );
end;

function FormatByteSize(const Bytes: Int64): string;
const
  KB = 1024;
  MB = KB * 1024;
  GB = Int64(KB) * 1024 * 1024; // Use Int64 para evitar estouro
  TB = Int64(GB) * 1024; // Use Int64 para evitar estouro
var
  Size: Double;
begin
  if Bytes < KB then
    Result := Format('%d B', [Bytes])
  else if Bytes < MB then
  begin
    Size := Bytes / KB;
    Result := Format('%.2f KB', [Size]);
  end
  else if Bytes < GB then
  begin
    Size := Bytes / MB;
    Result := Format('%.2f MB', [Size]);
  end
  else if Bytes < TB then
  begin
    Size := Bytes / GB;
    Result := Format('%.2f GB', [Size]);
  end
  else
  begin
    Size := Bytes / TB;
    Result := Format('%.2f TB', [Size]);
  end;
end;


function GetMethodName(AClass: TClass; MethodAddress: String): string;
var
  Context: TRttiContext;
  Method: TRttiMethod;
  TypeInfo: PTypeInfo;
  MethodKindName: string;
begin
  Context := TRttiContext.Create;
  try
    TypeInfo := Context.GetType(AClass).Handle;
    Method := Context.GetType(TypeInfo).GetMethod(MethodAddress);

    case Method.MethodKind of
     mkProcedure: MethodKindName := 'procedure';
     mkFunction: MethodKindName := 'function';
     mkConstructor: MethodKindName := 'constructor';
     mkDestructor: MethodKindName := 'destructor';
     mkClassProcedure: MethodKindName := 'class procedure';
     mkClassFunction: MethodKindName := 'class function';
     mkClassConstructor: MethodKindName := 'class constructor';
     mkClassDestructor: MethodKindName := 'class destructor';
     mkOperatorOverload: MethodKindName := 'operator overload';
     mkSafeProcedure: MethodKindName := 'safe procedure';
     mkSafeFunction: MethodKindName := 'safe function';
    end;

    if Assigned(Method) then
      Result := Method.Name
                 +sLineBreak
                 +sLineBreak
                 +'          unidade      : '+Context.GetType(TypeInfo).QualifiedName
                 +sLineBreak
                 +'          tipo         : '+MethodKindName
                 +sLineBreak
                 +'          returntype   : ' +Method.ReturnType.QualifiedName
                 +sLineBreak
                 +'          typeSize     : ' +FormatByteSize(Context.GetType(TypeInfo).TypeSize)
                 +sLineBreak

    else
      Result := 'UnknownMethod';
  finally
    Context.Free;
  end;
end;

function TLogger.WriteLog(AObject: TClass; AMethodAddress: String; Arg: TProc): ILogger;
var
  Stopwatch: TStopwatch;
begin
  Result := Self;

  WriteLog('..........................................................');
  Stopwatch := TStopwatch.StartNew;
 try
  try
    WriteLog(Format('Executando método %s', [GetMethodName(AObject, AMethodAddress )]));
    if Assigned(Arg) then
      Arg;
  finally
    Stopwatch.Stop;
    WriteLog(Format('Término do método %s - Tempo de execução: %d ms',
      [AMethodAddress, Stopwatch.ElapsedMilliseconds]));
  end;
 except
  on E: Exception do
  begin
    WriteException( E );
    raise
  end;

 end;

  WriteLog('..........................................................');
end;


function TLogger.WriteLogApp(const AText: string; const AArgs: array of const): ILogger;
begin
 Result := WriteLog('[ Application ] '+AText,AArgs);
end;

function TLogger.WriteLogConstrutor(const Ainstance: TObject): ILogger;
var
  ClassName: string;
begin
  ClassName := Ainstance.ClassName;
  Result:= WriteLog('[ Application | Constructor ] Constríndo a instância da classe %s ',[ ClassName ] );
end;

function TLogger.WriteLogDestructor(const Ainstance: TObject): ILogger;
var
  ClassName: string;
begin
 try
  ClassName := Ainstance.ClassName;
  Result:= WriteLog('[ Application | Destructor ] Destruíndo a instância da classe %s ',[ ClassName ] );
 Except
  on E: Exception do
  WriteException(E);
 end;

end;

function TLogger.WriteTest(AInstance: TObject; ATestName: string; Arg: Boolean): ILogger;
var
  StartTime, EndTime: TDateTime;
  StartMemory, EndMemory: Int64;
begin
  StartTime := Now;
  StartMemory := GetCardinalMemoryUsageApp;
  EndMemory:= 0;
  try
    WriteLog(' %s ', [EmptyStr]);
    WriteLog('Iniciando teste %s ',[ ATestName ]);
    WriteLog('[ Teste | Start ] Iniciando rastreamento da pilha %s ', [AInstance.ClassName]);

    Assert( Arg , Format(' [ Teste | Result ] O Teste %s falhou!',[ATestName]));

    WriteLog( ' [ Teste | Result ] O Teste %s passou!',[ATestName] );

    WriteLog('[ Teste | Stop ] Terminando execução do método da instância %s ', [AInstance.ClassName]);
    EndMemory := GetCardinalMemoryUsageApp;

    EndTime := Now;

    WriteLog('Tempo de execução: %.2f segundos', [MilliSecondsBetween(EndTime, StartTime) / 1000]);
    WriteLog('Uso de memória inicial: %d bytes', [StartMemory]);
    WriteLog('Uso de memória final: %d bytes', [EndMemory]);
    WriteLog('Diferença de memória: %d bytes', [EndMemory - StartMemory]);

  Except
    on E: Exception do
    begin
       WriteLog('[ Teste | Status ] Falha: %s', [E.Message]);
       EndTime := Now;
       WriteLog('Tempo de execução: %.2f segundos', [MilliSecondsBetween(EndTime, StartTime) / 1000]);
       WriteLog('Uso de memória inicial: %d bytes', [StartMemory]);
       WriteLog('Uso de memória final: %d bytes', [EndMemory]);
       WriteLog('Diferença de memória: %d bytes', [EndMemory - StartMemory]);
      raise;
    end;
  end;

  Result := Self;

end;

function TLogger.WriteTest(AInstance: TObject; const Arg: TProc): ILogger;
var
  StartTime, EndTime: TDateTime;
  StartMemory, EndMemory: Int64;
begin
  StartTime := Now;
  StartMemory := GetCardinalMemoryUsageApp;
  EndMemory := 0;

  try
    WriteLog(' %s ', [EmptyStr]);
    WriteLog('[ Teste | Start ] Iniciando rastreamento da pilha %s ', [AInstance.ClassName]);
    Arg;
    WriteLog('[ Teste | Stop ] Terminando execução do método da instância %s ', [AInstance.ClassName]);
    EndMemory := GetCardinalMemoryUsageApp;

    EndTime := Now;

    WriteLog('Tempo de execução: %.2f segundos', [MilliSecondsBetween(EndTime, StartTime) / 1000]);
    WriteLog('Uso de memória inicial: %d bytes', [StartMemory]);
    WriteLog('Uso de memória final: %d bytes', [EndMemory]);
    WriteLog('Diferença de memória: %d bytes', [EndMemory - StartMemory]);
  Except
    on E: Exception do
    begin
       WriteLog('[ Teste | Status ] Falha: %s', [E.Message]);
       EndTime := Now;
       WriteLog('Tempo de execução: %.2f segundos', [MilliSecondsBetween(EndTime, StartTime) / 1000]);
       WriteLog('Uso de memória inicial: %d bytes', [StartMemory]);
       WriteLog('Uso de memória final: %d bytes', [EndMemory]);
       WriteLog('Diferença de memória: %d bytes', [EndMemory - StartMemory]);
      raise;
    end;
  end;

  Result := Self;

end;

function TLogger.WriteException( const AException: Exception ): ILogger;
begin
  Result := Self;
  WriteLog( Format( '[ Application | Error ]  StackTrace  %s exception Message %s ',
  [ Copy( AException.StackTrace, 0, 150 ), AException.ToString ] ) + #13#10 );
end;

function TLogger.WriteLog( const AText: string ): ILogger;
begin
  Result := WriteLog( '[ Application ] '+ AText, [ ] );
end;

{ TOptionsLog }

procedure TOptionsLog.SetFileNameLog( const Value: String );
begin
  FFileNameLog := Value;
end;

procedure TOptionsLog.SetHeaderLog( const Value: String );
begin
  FHeaderLog := Value;
end;

procedure TOptionsLog.SetSocketPort( const Value: DWORD64 );
begin
  FSocketPort := Value;
end;

procedure TOptionsLog.SetUseSocket( const Value: Boolean );
begin
  FUseSocket := Value;
end;

{ ExceptionHelper }
function ExceptionHelper.Describe: string;
var
  lStackTrace: string;
begin
  Result := inherited ToString();
  if Self is EInOutError then
    if Result = System.RTLConsts.SInvalidKnownFilename then
      Result := System.RTLConsts.SInvalidKnownFilename;
  if Assigned(StackInfo) then
    lStackTrace := StackTrace
  else
    lStackTrace := 'empty';
  Result := Format('Exception'#13#10'%s at $%p: %s'#13#10'with StackTrace'#13#10'%s', [ClassName, ExceptAddr, Result, lStackTrace]);
  logger.WriteException( Self );
end;

class function ExceptionHelper.GetStackTrace: string;
begin
  try
    Result := 'Get StackTrace via Exception.';
    raise EStackTraceException.Create(Result) at ReturnAddress;
  except
    on E: EStackTraceException do
      Result := E.StackTrace;
  end;
end;

class procedure ExceptionHelper.RaiseNotImplementedException(const aClass: TClass; const aMethodName: string);
begin
  raise ENotImplemented.CreateFmt('Method %s.%s is not implemented.', [aClass.ClassName, aMethodName]);
end;

initialization
 RegisterClassAlias( TLogger, 'BB20CE43-E84B-450C-9E4F-2D0D22E633DD' );
Finalization
 UnRegisterClasses( [ TLogger ] );

end.
