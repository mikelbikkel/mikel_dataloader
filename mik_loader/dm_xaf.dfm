object dmXAF: TdmXAF
  Height = 423
  Width = 616
  PixelsPerInch = 120
  object qryXafInfo: TUniQuery
    Connection = dmFBZakelijk.connFBZakelijk
    SQL.Strings = (
      
        'select audit_id, cust_id, cust_name, kvk_number, tax_reg_id, cus' +
        't_type'
      'from mk_xaf_customer')
    Left = 24
    Top = 32
    object qryXafInfoAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryXafInfoCUST_ID: TStringField
      FieldName = 'CUST_ID'
      Required = True
      Size = 35
    end
    object qryXafInfoCUST_NAME: TStringField
      FieldName = 'CUST_NAME'
      Size = 50
    end
    object qryXafInfoKVK_NUMBER: TStringField
      FieldName = 'KVK_NUMBER'
      Size = 30
    end
    object qryXafInfoTAX_REG_ID: TStringField
      FieldName = 'TAX_REG_ID'
      Size = 30
    end
    object qryXafInfoCUST_TYPE: TStringField
      FieldName = 'CUST_TYPE'
      Size = 40
    end
  end
  object dsXafInfo: TUniDataSource
    DataSet = qryXafInfo
    Left = 104
    Top = 32
  end
end
