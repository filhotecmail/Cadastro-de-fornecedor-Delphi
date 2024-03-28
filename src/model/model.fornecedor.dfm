inherited ModelFornecedor: TModelFornecedor
  OldCreateOrder = True
  Width = 202
  inherited oDataset: TFDQuery
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'GEN_FORNECEDOR_ID'
    UpdateOptions.KeyFields = 'id'
    UpdateOptions.AutoIncFields = 'id'
    SQL.Strings = (
      'SELECT * FROM FORNECEDOR')
  end
  object oEmpresas: TFDQuery
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'GEN_EMPRESA_ID'
    UpdateOptions.KeyFields = 'ID'
    UpdateOptions.AutoIncFields = 'id'
    SQL.Strings = (
      'select ID, E001XFANT, E002UF, E003CNPJ'
      'from EMPRESA')
    Left = 104
    Top = 24
  end
end
