inherited ModelEmpresa: TModelEmpresa
  OldCreateOrder = True
  Height = 108
  Width = 184
  inherited oDataset: TFDQuery
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'GEN_EMPRESA_ID'
    UpdateOptions.KeyFields = 'ID'
    UpdateOptions.AutoIncFields = 'id'
    SQL.Strings = (
      'select ID, E001XFANT, E002UF, E003CNPJ'
      'from EMPRESA')
  end
end
