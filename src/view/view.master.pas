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
  //
  controller.abstract,
  Data.DB,
  Vcl.ExtCtrls,
  JvExControls,
  JvButton,
  JvTransparentButton,
  Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  JvExDBGrids,
  JvDBGrid,
  JvExExtCtrls,
  JvExtComponent,
  JvPanel, dxGDIPlusClasses;

type
  TViewmaster = class( TViewController )
    MainMenu1: TMainMenu;
    M1: TMenuItem;
    C1: TMenuItem;
    I1: TMenuItem;
    S1: TMenuItem;
    oEnterAsTab: TJvEnterAsTab;
    oBar: TStatusBar;
    oAppEvents: TApplicationEvents;
    D1: TMenuItem;
    JvPanel1: TJvPanel;
    oDs: TDataSource;
    obtAddFornecedores: TJvTransparentButton;
    Shape1: TShape;
    obtAddEmpresa: TJvTransparentButton;
    oBtDoc: TJvTransparentButton;
    JvTransparentButton1: TJvTransparentButton;
    N1: TMenuItem;
    S2: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox2: TGroupBox;
    oGrid: TJvDBGrid;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Image1: TImage;
    oEdPesquisa: TEdit;
    oFooter: TStatusBar;
    TabSheet2: TTabSheet;
    GroupBox3: TGroupBox;
    JvDBGrid1: TJvDBGrid;
    GroupBox4: TGroupBox;
    lbFiltro: TLabel;
    oEdFilter: TEdit;
    StatusBar1: TStatusBar;
    oRdgFilter: TRadioGroup;
    oBtFilter: TButton;
    odsFilter: TDataSource;
    procedure C1Click(Sender: TObject);
    procedure I1Click(Sender: TObject);
    procedure oAppEventsException(Sender: TObject; E: Exception);
    procedure S1Click(Sender: TObject);
    procedure D1Click(Sender: TObject);
    procedure oEdPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure obtAddEmpresaClick(Sender: TObject);
    procedure obtAddFornecedoresClick(Sender: TObject);
    procedure JvTransparentButton1Click(Sender: TObject);
    procedure oBtDocClick(Sender: TObject);
    procedure S2Click(Sender: TObject);
    procedure oGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure oBtFilterClick(Sender: TObject);
  private
    { Private declarations }
    procedure DoActionShowDocApp;
    procedure DoActionShowDatabaseDoc;
    procedure DoActionCloseApp;
  public
    { Public declarations }
  end;

var
  Viewmaster: TViewmaster;

implementation
{$R *.dfm}

uses view.doc.database;

procedure TViewmaster.oBtFilterClick(Sender: TObject);
begin
 case oRdgFilter.ItemIndex of
   0: Controller.Filter('F004NOMERAZAO LIKE %s ', oEdFilter.Text);
   1: Controller.Filter('F002CPFCNPJ = %s', oEdFilter.Text);
   2: Controller.Filter('F001DATETIEMEC = %s', oEdFilter.Text);
 end;
end;

procedure TViewmaster.C1Click(Sender: TObject);
begin
 TControllerFactory.CreateController('controller empresa');
end;

procedure TViewmaster.D1Click(Sender: TObject);
begin
 DoActionShowDatabaseDoc;
end;

procedure TViewmaster.DoActionCloseApp;
var
  TaskDialog: TTaskDialog;
begin
   TaskDialog := TTaskDialog.Create(nil);
    try
      TaskDialog.Caption := 'Confirmação de Fechamento';
      TaskDialog.Text := 'Deseja encerrar e sair da aplicação?';
      TaskDialog.MainIcon := tdiWarning;
      TaskDialog.CommonButtons := [tcbYes, tcbNo];

      if TaskDialog.Execute then
      begin
        if TaskDialog.ModalResult = mrYes then
         begin
          Application.Terminate;
         end;
      end;
    finally
      TaskDialog.Free;
    end;
end;

procedure TViewmaster.DoActionShowDatabaseDoc;
begin
 with TViewDocDatabase.Create( nil ) do
  begin
     ShowModal;
     Free;
  end;
end;

procedure TViewmaster.DoActionShowDocApp;
begin
 ShellExecute(Handle,
               'open',
               'https://github.com/filhotecmail/Cadastro-de-fornecedor-Delphi',
               nil,
               nil,
               SW_SHOWMAXIMIZED);
end;

procedure TViewmaster.FormShow(Sender: TObject);
begin
  Controller.Open(['']);
  oFooter.Panels[1].Text := Controller.Dataset.RecordCount.ToString;
  odsFilter.DataSet      := Controller.OutherDataset;
end;

procedure TViewmaster.I1Click(Sender: TObject);
begin
  TControllerFactory.CreateController('controller fornecedor');
end;

procedure TViewmaster.JvTransparentButton1Click(Sender: TObject);
begin
 DoActionShowDatabaseDoc;
end;

procedure TViewmaster.oAppEventsException(Sender: TObject; E: Exception);
const
  ErrInvalidCNPJ = 'O CNPJ informado é inválido ou está em um padrão que não corresponde a um CNPJ.';
  ErrUnderage = 'A data de nascimento informada relata que o portador deste documento CPF é menor de idade, portanto o '
                +'estado do Paraná não permite a inclusão deste fornecedor no cadastro.';
  ErrDuplicateRecord = 'O CNPJ Informado corresponde a um CNPJ de um registro já existente no banco de dados.';
  ErrInvalidDocument = 'O Documento CPF/CNPJ informado no cadastro não é um documento válido.';

  C_ErrorPatterns: array[0..3] of string = ('CHK_EMPRESA_CNPJ', 'FORNECEDOR_CHECK_DATENASC', 'UNIQUE',
                                            'CHK_FORNECEDOR_ISVALIDDOC');

var
  ErrorMessage: string;
begin

 case E.Match( C_ErrorPatterns ) of
  0: ErrorMessage := ErrInvalidCNPJ;
  1: ErrorMessage := ErrUnderage;
  2: ErrorMessage := ErrDuplicateRecord;
  3: ErrorMessage := ErrInvalidDocument;
  else
    ErrorMessage := E.Message;
 end;

  with TTaskDialog.Create(Self) do
  begin
    try
      Caption := 'Erro';
      Title := 'Erro';
      Text := ErrorMessage;
      MainIcon := tdiError;
      CommonButtons := [tcbOk];
      Execute;
    finally
      Free;
    end;
  end;

end;

procedure TViewmaster.obtAddEmpresaClick(Sender: TObject);
begin
 TControllerFactory.CreateController('controller empresa');
end;

procedure TViewmaster.obtAddFornecedoresClick(Sender: TObject);
begin
 try
  TControllerFactory.CreateController('controller fornecedor');
 finally
  Controller.Refresh;
 end;
end;

procedure TViewmaster.oBtDocClick(Sender: TObject);
begin
 DoActionCloseApp;
end;

procedure TViewmaster.oEdPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 Controller.Open([oEdPesquisa.Text]);
 oFooter.Panels[1].Text := Controller.Dataset.RecordCount.ToString;
end;

procedure TViewmaster.oGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  CNPJ: string;
begin
  if ( Column.FieldName = 'E003CNPJ' ) or
     ( Column.FieldName = 'F002CPFCNPJ' ) then
  begin
    CNPJ := Column.Field.AsformatedDoc;
    oGrid.Canvas.FillRect(Rect);
    oGrid.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, CNPJ);
  end;

end;

procedure TViewmaster.S1Click(Sender: TObject);
begin
  DoActionShowDocApp;
end;

 procedure TViewmaster.S2Click(Sender: TObject);
begin
 DoActionCloseApp;
end;

initialization
  RegisterClassAlias( TViewmaster, 'viewmaster' );
 Finalization
  UnRegisterClass( TViewmaster );

end.
