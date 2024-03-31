object ControllerAbstract: TControllerAbstract
  OldCreateOrder = False
  Height = 70
  Width = 159
  object oProvider: TDataSetProvider
    Left = 17
    Top = 10
  end
  object oTimerStatus: TTimer
    Enabled = False
    OnTimer = oTimerStatusTimer
    Left = 81
    Top = 10
  end
end
