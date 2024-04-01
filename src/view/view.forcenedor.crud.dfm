object ViewFornecedorCrud: TViewFornecedorCrud
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Formulario de cadastro de fornecedores do sistema'
  ClientHeight = 578
  ClientWidth = 865
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object StatusBar1: TStatusBar
    Left = 0
    Top = 559
    Width = 865
    Height = 19
    Panels = <>
    SizeGrip = False
  end
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 845
    Height = 539
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alClient
    Caption = 'Formulario de cadastro do fornecedor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 2
      Top = 475
      Width = 841
      Height = 62
      Align = alBottom
      TabOrder = 0
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
    object oInfo: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 21
      Width = 835
      Height = 100
      Align = alTop
      Caption = 'Dados da empresa selecionada'
      TabOrder = 1
      object Label8: TLabel
        Left = 16
        Top = 34
        Width = 252
        Height = 16
        Caption = 'Nome/Raz'#227'o social da empresa selecionada'
      end
      object Label10: TLabel
        Left = 415
        Top = 34
        Width = 28
        Height = 16
        Caption = 'CNPJ'
      end
      object Label11: TLabel
        Left = 595
        Top = 34
        Width = 15
        Height = 16
        Caption = 'UF'
      end
      object oXFantEmpresa: TEdit
        Left = 16
        Top = 56
        Width = 393
        Height = 24
        Enabled = False
        ReadOnly = True
        TabOrder = 0
      end
      object oCnpjEmpresa: TEdit
        Left = 415
        Top = 56
        Width = 174
        Height = 24
        Enabled = False
        ReadOnly = True
        TabOrder = 1
      end
      object oUfEmpresa: TEdit
        Left = 595
        Top = 56
        Width = 54
        Height = 24
        Enabled = False
        ReadOnly = True
        TabOrder = 2
      end
    end
    object GroupBox4: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 127
      Width = 835
      Height = 345
      Align = alClient
      Caption = '...'
      TabOrder = 2
      object Label5: TLabel
        Left = 24
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
      object Label2: TLabel
        Left = 24
        Top = 98
        Width = 197
        Height = 16
        Caption = 'Nome/Raz'#227'o social do fornecedor '
      end
      object Label4: TLabel
        Left = 595
        Top = 98
        Width = 142
        Height = 16
        Caption = 'CPF/CNPJ do Fornecedor'
      end
      object Label9: TLabel
        Left = 595
        Top = 178
        Width = 114
        Height = 16
        Caption = 'Telefone de contato'
      end
      object Label1: TLabel
        Left = 400
        Top = 178
        Width = 109
        Height = 16
        Caption = 'Telefone comercial'
      end
      object DBEdit1: TDBEdit
        Left = 24
        Top = 48
        Width = 233
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
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 0
      end
      object oComboEmpresas: TJvDBComboBox
        Left = 263
        Top = 48
        Width = 554
        Height = 27
        Hint = 
          'Selecione uma empresa cadastrada na lista suspensa , este campo ' +
          #233' obrigat'#243'rio '
        DataField = 'EMPRESA'
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
        ListSettings.OutfilteredValueFont.Charset = DEFAULT_CHARSET
        ListSettings.OutfilteredValueFont.Color = clRed
        ListSettings.OutfilteredValueFont.Height = -11
        ListSettings.OutfilteredValueFont.Name = 'Tahoma'
        ListSettings.OutfilteredValueFont.Style = []
        OnChange = oComboEmpresasChange
      end
      object oXFant: TDBEdit
        Left = 24
        Top = 120
        Width = 565
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
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object oCnpj: TDBEdit
        Left = 595
        Top = 120
        Width = 222
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
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnKeyPress = oCnpjKeyPress
      end
      object oTel2: TDBEdit
        Left = 595
        Top = 200
        Width = 222
        Height = 27
        Hint = 'Documento CPF/CNPJ do fornecedor, campo obrigat'#243'rio!'
        CharCase = ecUpperCase
        DataField = 'F006TELCONTACT'
        DataSource = ods
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnKeyPress = oCnpjKeyPress
      end
      object oTel1: TDBEdit
        Left = 400
        Top = 200
        Width = 189
        Height = 27
        Hint = 'Documento CPF/CNPJ do fornecedor, campo obrigat'#243'rio!'
        CharCase = ecUpperCase
        DataField = 'F005TELCOM'
        DataSource = ods
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnKeyPress = oCnpjKeyPress
      end
      object GroupBox5: TGroupBox
        Left = 24
        Top = 153
        Width = 361
        Height = 96
        Caption = 'Grupo de dados pessoa f'#237'sica'
        TabOrder = 4
        object Label3: TLabel
          Left = 161
          Top = 25
          Width = 173
          Height = 16
          Caption = 'Data de nascimento/Funda'#231#227'o'
        end
        object Label7: TLabel
          Left = 8
          Top = 25
          Width = 100
          Height = 16
          Caption = 'RG do fornecedor'
        end
        object oRg: TDBEdit
          Left = 8
          Top = 47
          Width = 147
          Height = 27
          Hint = 'Documento CPF/CNPJ do fornecedor, campo obrigat'#243'rio!'
          CharCase = ecUpperCase
          DataField = 'F004RG'
          DataSource = ods
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnKeyPress = oCnpjKeyPress
        end
        object oDataNasc: TJvDBDatePickerEdit
          Left = 161
          Top = 47
          Width = 178
          Height = 27
          AllowNoDate = False
          DataField = 'F003FUNDDATANASC'
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
      end
      object oBtEdit: TButton
        Left = 24
        Top = 274
        Width = 125
        Height = 33
        Caption = 'Editar os dados'
        TabOrder = 7
        OnClick = oBtEditClick
      end
    end
  end
  object oEnterAsTab: TJvEnterAsTab
    Left = 312
    Top = 272
  end
  object ods: TDataSource
    AutoEdit = False
    Left = 243
    Top = 269
  end
end
