object DatabaseDriverAbstract: TDatabaseDriverAbstract
  OldCreateOrder = False
  Height = 150
  Width = 215
  object oFbDriver: TFDPhysFBDriverLink
    OnDriverCreated = oFbDriverDriverCreated
    OnDriverDestroying = oFbDriverDriverDestroying
    ThreadSafe = True
    Left = 88
    Top = 48
  end
end
