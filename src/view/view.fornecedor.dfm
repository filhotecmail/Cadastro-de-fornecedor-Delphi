object ViewFornecedor: TViewFornecedor
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Cadastro e manuten'#231#227'o de fornecedores no sistema'
  ClientHeight = 439
  ClientWidth = 959
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 420
    Width = 959
    Height = 19
    Panels = <>
    ExplicitLeft = 264
    ExplicitTop = 392
    ExplicitWidth = 0
  end
  object MainMenu1: TMainMenu
    Left = 800
    Top = 24
    object M1: TMenuItem
      Caption = 'Menu principal'
      object C1: TMenuItem
        Caption = 'Cadastrar uma nova empresa no sistema'
      end
      object I1: TMenuItem
        Caption = 'Incluir um fornecedor no sistema'
      end
      object S1: TMenuItem
        Caption = 'Sobre o sistema'
      end
    end
  end
  object oEnterAsTab: TJvEnterAsTab
    Left = 864
    Top = 88
  end
end
