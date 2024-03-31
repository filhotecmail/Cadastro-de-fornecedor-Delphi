object ViewEmpresaCrud: TViewEmpresaCrud
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Formulario de cadastro e controles da empresa'
  ClientHeight = 317
  ClientWidth = 548
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 528
    Height = 278
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alClient
    Caption = 'Formulario de cadastro da empresa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 26
      Width = 12
      Height = 16
      Caption = 'ID'
    end
    object Label2: TLabel
      Left = 87
      Top = 26
      Width = 154
      Height = 16
      Caption = 'Nome fantasia da empresa'
    end
    object Label3: TLabel
      Left = 24
      Top = 90
      Width = 15
      Height = 16
      Caption = 'UF'
    end
    object Label4: TLabel
      Left = 280
      Top = 90
      Width = 96
      Height = 16
      Caption = 'Documento CNPJ'
    end
    object oID: TDBEdit
      Left = 24
      Top = 48
      Width = 57
      Height = 27
      Hint = 
        'Campo Preenchido automaticamente pelo banco de dados ele control' +
        'a a ordem numeral de inser'#231#227'o no banco de dados .'
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'id'
      DataSource = ods
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 0
    end
    object oXFant: TDBEdit
      Left = 87
      Top = 48
      Width = 418
      Height = 27
      Hint = 'Informe o Nome fantasia da empresa, * campo obrigat'#243'rio'
      CharCase = ecUpperCase
      DataField = 'E001XFANT'
      DataSource = ods
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object oCnpj: TDBEdit
      Left = 280
      Top = 112
      Width = 225
      Height = 27
      Hint = 'Informe o documento CNPJ da empresa. * Campo Obrigat'#243'rio'
      CharCase = ecUpperCase
      DataField = 'E003CNPJ'
      DataSource = ods
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object oUfs: TJvDBComboBox
      Left = 24
      Top = 112
      Width = 250
      Height = 27
      DataField = 'E002UF'
      DataSource = ods
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      Items.Strings = (
        'AC - Acre'
        'AL - Alagoas'
        'AP - Amap'#225
        'AM - Amazonas'
        'BA - Bahia'
        'CE - Cear'#225
        'DF - Distrito Federal'
        'ES - Esp'#237'rito Santo'
        'GO - Goi'#225's'
        'MA - Maranh'#227'o'
        'MT - Mato Grosso'
        'MS - Mato Grosso do Sul'
        'MG - Minas Gerais'
        'PA - Par'#225
        'PB - Para'#237'ba'
        'PR - Paran'#225
        'PE - Pernambuco'
        'PI - Piau'#237
        'RJ - Rio de Janeiro'
        'RN - Rio Grande do Norte'
        'RS - Rio Grande do Sul'
        'RO - Rond'#244'nia'
        'RR - Roraima'
        'SC - Santa Catarina'
        'SP - S'#227'o Paulo'
        'SE - Sergipe'
        'TO - Tocantins')
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Values.Strings = (
        'AC'
        'AL'
        'AP'
        'AM'
        'BA'
        'CE'
        'DF'
        'ES'
        'GO'
        'MA'
        'MT'
        'MS'
        'MG'
        'PA'
        'PB'
        'PR'
        'PE'
        'PI'
        'RJ'
        'RN'
        'RS'
        'RO'
        'RR'
        'SC'
        'SP'
        'SE'
        'TO')
      ListSettings.OutfilteredValueFont.Charset = DEFAULT_CHARSET
      ListSettings.OutfilteredValueFont.Color = clRed
      ListSettings.OutfilteredValueFont.Height = -11
      ListSettings.OutfilteredValueFont.Name = 'Tahoma'
      ListSettings.OutfilteredValueFont.Style = []
    end
    object GroupBox1: TGroupBox
      Left = 2
      Top = 214
      Width = 524
      Height = 62
      Align = alBottom
      TabOrder = 4
      object oBtConfirm: TButton
        Left = 147
        Top = 16
        Width = 125
        Height = 33
        Caption = 'Gravar os dados'
        Enabled = False
        TabOrder = 0
        OnClick = oBtConfirmClick
      end
      object oBtCancel: TButton
        Left = 278
        Top = 16
        Width = 125
        Height = 33
        Caption = 'Cancelar'
        Enabled = False
        TabOrder = 1
        OnClick = oBtCancelClick
      end
    end
    object oBtEdit: TButton
      Left = 24
      Top = 157
      Width = 125
      Height = 33
      Caption = 'Editar os dados'
      TabOrder = 5
      OnClick = oBtEditClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 298
    Width = 548
    Height = 19
    Panels = <>
    SizeGrip = False
  end
  object oEnterAsTab: TJvEnterAsTab
    Left = 32
    Top = 224
  end
  object ods: TDataSource
    AutoEdit = False
    Left = 99
    Top = 229
  end
end
