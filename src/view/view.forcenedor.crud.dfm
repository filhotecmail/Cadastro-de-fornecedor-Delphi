object ViewFornecedorCrud: TViewFornecedorCrud
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Formulario de cadastro de fornecedores do sistema'
  ClientHeight = 334
  ClientWidth = 912
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object StatusBar1: TStatusBar
    Left = 0
    Top = 315
    Width = 912
    Height = 19
    Panels = <>
    SizeGrip = False
    ExplicitTop = 285
    ExplicitWidth = 757
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 892
    Height = 295
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
    TabOrder = 1
    ExplicitWidth = 737
    ExplicitHeight = 265
    object Label1: TLabel
      Left = 24
      Top = 26
      Width = 12
      Height = 16
      Caption = 'ID'
    end
    object Label2: TLabel
      Left = 24
      Top = 98
      Width = 197
      Height = 16
      Caption = 'Nome/Raz'#227'o social do fornecedor '
    end
    object Label3: TLabel
      Left = 692
      Top = 98
      Width = 173
      Height = 16
      Caption = 'Data de nascimento/Funda'#231#227'o'
    end
    object Label5: TLabel
      Left = 95
      Top = 26
      Width = 47
      Height = 16
      Caption = 'Inclus'#227'o'
    end
    object Label6: TLabel
      Left = 263
      Top = 26
      Width = 165
      Height = 16
      Caption = 'Selecione a empresa na lista'
    end
    object Label4: TLabel
      Left = 479
      Top = 98
      Width = 142
      Height = 16
      Caption = 'CPF/CNPJ do Fornecedor'
    end
    object oID: TDBEdit
      Left = 24
      Top = 48
      Width = 65
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
      ReadOnly = True
      TabOrder = 0
    end
    object oXFant: TDBEdit
      Left = 24
      Top = 120
      Width = 449
      Height = 27
      Hint = 
        'Informe o Nome ou a Raz'#227'o social do fornecedo caso seja uma pess' +
        'oa jur'#237'dica. * Campo obrigat'#243'rio no sistema'
      CharCase = ecUpperCase
      DataField = 'F004NOMERAZAO'
      DataSource = ods
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object DBEdit1: TDBEdit
      Left = 95
      Top = 48
      Width = 162
      Height = 27
      Hint = 
        'Data e hora da inclus'#227'o no sistema, Campo Preenchido automaticam' +
        'ente pelo banco de dados.'
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'F001DATETIEMEC'
      DataSource = ods
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
    object JvDBDatePickerEdit1: TJvDBDatePickerEdit
      Left = 692
      Top = 120
      Width = 173
      Height = 27
      AllowNoDate = True
      DataField = 'F003FUNDDATANASC'
      DataSource = ods
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object GroupBox1: TGroupBox
      Left = 2
      Top = 231
      Width = 888
      Height = 62
      Align = alBottom
      TabOrder = 6
      ExplicitTop = 201
      ExplicitWidth = 733
      object oBtConfirm: TButton
        Left = 236
        Top = 16
        Width = 125
        Height = 33
        Caption = 'Gravar os dados'
        TabOrder = 0
        OnClick = oBtConfirmClick
      end
      object oBtCancel: TButton
        Left = 367
        Top = 16
        Width = 125
        Height = 33
        Caption = 'Cancelar'
        TabOrder = 1
        OnClick = oBtCancelClick
      end
    end
    object oBtEdit: TButton
      Left = 24
      Top = 173
      Width = 125
      Height = 33
      Caption = 'Editar os dados'
      TabOrder = 7
      OnClick = oBtEditClick
    end
    object oComboEmpresas: TJvDBComboBox
      Left = 263
      Top = 48
      Width = 602
      Height = 27
      DataField = 'EMPRESA'
      DataSource = ods
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ListSettings.OutfilteredValueFont.Charset = DEFAULT_CHARSET
      ListSettings.OutfilteredValueFont.Color = clRed
      ListSettings.OutfilteredValueFont.Height = -11
      ListSettings.OutfilteredValueFont.Name = 'Tahoma'
      ListSettings.OutfilteredValueFont.Style = []
    end
    object oCnpj: TDBEdit
      Left = 479
      Top = 120
      Width = 207
      Height = 27
      Hint = 'Documento CPF/CNPJ do fornecedor, campo obrigat'#243'rio!'
      CharCase = ecUpperCase
      DataField = 'F002CPFCNPJ'
      DataSource = ods
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnKeyPress = oCnpjKeyPress
    end
  end
  object oEnterAsTab: TJvEnterAsTab
    Left = 528
    Top = 184
  end
  object ods: TDataSource
    AutoEdit = False
    Left = 579
    Top = 189
  end
end
