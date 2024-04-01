object DatabaseDriverAbstract: TDatabaseDriverAbstract
  OldCreateOrder = False
  Height = 140
  Width = 201
  object oFbDriver: TFDPhysFBDriverLink
    OnDriverCreated = oFbDriverDriverCreated
    OnDriverDestroying = oFbDriverDriverDestroying
    ThreadSafe = True
    Left = 88
    Top = 48
  end
end
