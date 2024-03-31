object DaoAbstract: TDaoAbstract
  OldCreateOrder = False
  Height = 80
  Width = 129
  object oCon: TFDConnection
    LoginPrompt = False
    OnLogin = oConLogin
    OnError = oConError
    OnLost = oConLost
    OnRestored = oConRestored
    OnRecover = oConRecover
    AfterConnect = oConAfterConnect
    BeforeConnect = oConBeforeConnect
    AfterDisconnect = oConAfterDisconnect
    BeforeDisconnect = oConBeforeDisconnect
    BeforeStartTransaction = oConBeforeStartTransaction
    AfterStartTransaction = oConAfterStartTransaction
    BeforeCommit = oConBeforeCommit
    AfterCommit = oConAfterCommit
    BeforeRollback = oConBeforeRollback
    AfterRollback = oConAfterRollback
    Left = 16
    Top = 16
  end
  object oMonitor: TFDMoniCustomClientLink
    OnOutput = oMonitorOutput
    Tracing = True
    Synchronize = True
    Left = 72
    Top = 16
  end
end
