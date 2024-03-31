inherited ModelMaster: TModelMaster
  OldCreateOrder = True
  Width = 185
  inherited oDataset: TFDQuery
    SQL.Strings = (
      'SELECT '
      '    E.E001XFANT,'
      '    E.E002UF,'
      '    E.E003CNPJ,'
      '    F.EMPRESA,'
      '    F.F001DATETIEMEC,'
      '    F.F002CPFCNPJ,'
      '    F.F003FUNDDATANASC,'
      '    F.F004NOMERAZAO,'
      '    F.F004RG,'
      '    F.F005TELCOM,'
      '    F.F006TELCONTACT'
      'FROM FORNECEDOR F'
      '   INNER JOIN EMPRESA E ON (F.EMPRESA = E.E003CNPJ)'
      '   WHERE CAST(F.F002CPFCNPJ AS VARCHAR(60) ) CONTAINING( :P )'
      
        '    OR (  CAST(F.F004NOMERAZAO AS VARCHAR(60)) CONTAINING( :P ) ' +
        ')'
      '    OR (  CAST(E.E002UF AS VARCHAR(60)) CONTAINING( :P ) )'
      '    OR (  CAST(E.E003CNPJ AS VARCHAR(60)) CONTAINING( :P ) )'
      '    OR (  CAST(E.E001XFANT AS VARCHAR(60)) CONTAINING( :P ) )')
    ParamData = <
      item
        Name = 'P'
        ParamType = ptInput
      end>
  end
  object oFiltered: TFDQuery
    SQL.Strings = (
      'SELECT '
      '    E.E001XFANT,'
      '    E.E002UF,'
      '    E.E003CNPJ,'
      '    F.EMPRESA,'
      '    F.F001DATETIEMEC,'
      '    F.F002CPFCNPJ,'
      '    F.F003FUNDDATANASC,'
      '    F.F004NOMERAZAO,'
      '    F.F004RG,'
      '    F.F005TELCOM,'
      '    F.F006TELCONTACT'
      'FROM FORNECEDOR F'
      '   INNER JOIN EMPRESA E ON (F.EMPRESA = E.E003CNPJ)')
    Left = 96
    Top = 24
  end
end
