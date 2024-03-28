inherited ModelEmpresa: TModelEmpresa
  Height = 128
  Width = 287
  inherited oProvider: TDataSetProvider
    Left = 64
    Top = 24
  end
  inherited oDataset: TFDQuery
    SQL.Strings = (
      'select ID, E001XFANT, E002UF, E003CNPJ'
      'from EMPRESA')
    Left = 128
    Top = 24
  end
end
