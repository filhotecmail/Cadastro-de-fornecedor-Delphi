object ViewEmpresa: TViewEmpresa
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Cadastro e manuten'#231#227'o dos dados da empresa'
  ClientHeight = 378
  ClientWidth = 1010
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 990
    Height = 339
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alClient
    Caption = 'Empresas cadastradas no sistema'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitLeft = -2
    ExplicitTop = -3
    ExplicitWidth = 1004
    ExplicitHeight = 671
    object oGrid: TJvDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 28
      Width = 980
      Height = 306
      Cursor = crHandPoint
      Margins.Top = 10
      Align = alClient
      DataSource = ods
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      AlternateRowColor = 16316664
      AutoSizeColumns = True
      SelectColumnsDialogStrings.Caption = 'Select columns'
      SelectColumnsDialogStrings.OK = '&OK'
      SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
      EditControls = <>
      RowsHeight = 20
      TitleRowHeight = 20
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Width = 107
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'E001XFANT'
          Title.Caption = 'Nome fantasia da empresa'
          Width = 482
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'E002UF'
          Title.Caption = 'UF'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'E003CNPJ'
          Title.Caption = 'Documento CNPJ'
          Width = 313
          Visible = True
        end>
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 359
    Width = 1010
    Height = 19
    Panels = <>
    SizeGrip = False
    ExplicitLeft = -282
    ExplicitTop = 171
  end
  object MainMenu1: TMainMenu
    Left = 855
    Top = 144
    object I1: TMenuItem
      Caption = 'Insere F1'
      OnClick = I1Click
    end
    object D1: TMenuItem
      Caption = 'Deleta F2'
    end
    object S1: TMenuItem
      Caption = 'Sair F9'
    end
  end
  object oEnterAsTab: TJvEnterAsTab
    Left = 864
    Top = 88
  end
  object ods: TDataSource
    AutoEdit = False
    Left = 851
    Top = 221
  end
end
