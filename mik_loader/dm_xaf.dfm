object dmXAF: TdmXAF
  Height = 423
  Width = 616
  PixelsPerInch = 120
  object qryXafCustomer: TUniQuery
    SQLInsert.Strings = (
      'INSERT INTO MK_XAF_CUSTOMER'
      
        '  (AUDIT_ID, CUST_ID, CUST_NAME, KVK_NUMBER, TAX_REG_ID, CUST_TY' +
        'PE)'
      'VALUES'
      
        '  (:AUDIT_ID, :CUST_ID, :CUST_NAME, :KVK_NUMBER, :TAX_REG_ID, :C' +
        'UST_TYPE)')
    SQLDelete.Strings = (
      'DELETE FROM MK_XAF_CUSTOMER'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID AND CUST_ID = :Old_CUST_ID')
    SQLUpdate.Strings = (
      'UPDATE MK_XAF_CUSTOMER'
      'SET'
      
        '  AUDIT_ID = :AUDIT_ID, CUST_ID = :CUST_ID, CUST_NAME = :CUST_NA' +
        'ME, KVK_NUMBER = :KVK_NUMBER, TAX_REG_ID = :TAX_REG_ID, CUST_TYP' +
        'E = :CUST_TYPE'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID AND CUST_ID = :Old_CUST_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_XAF_CUSTOMER'
      'WHERE'
      'AUDIT_ID = :Old_AUDIT_ID AND CUST_ID = :Old_CUST_ID'
      'FOR UPDATE WITH LOCK')
    SQLRefresh.Strings = (
      
        'SELECT AUDIT_ID, CUST_ID, CUST_NAME, KVK_NUMBER, TAX_REG_ID, CUS' +
        'T_TYPE FROM MK_XAF_CUSTOMER'
      'WHERE'
      '  AUDIT_ID = :AUDIT_ID AND CUST_ID = :CUST_ID')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM MK_XAF_CUSTOMER'
      ''
      ') q')
    Connection = dmFBZakelijk.connFBZakelijk
    SQL.Strings = (
      
        'select audit_id, cust_id, cust_name, kvk_number, tax_reg_id, cus' +
        't_type'
      'from mk_xaf_customer')
    DMLRefresh = True
    Options.SetEmptyStrToNull = True
    Left = 40
    Top = 32
    object qryXafCustomerAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryXafCustomerCUST_ID: TStringField
      FieldName = 'CUST_ID'
      Required = True
      Size = 35
    end
    object qryXafCustomerCUST_NAME: TStringField
      FieldName = 'CUST_NAME'
      Size = 50
    end
    object qryXafCustomerKVK_NUMBER: TStringField
      FieldName = 'KVK_NUMBER'
      Size = 30
    end
    object qryXafCustomerTAX_REG_ID: TStringField
      FieldName = 'TAX_REG_ID'
      Size = 30
    end
    object qryXafCustomerCUST_TYPE: TStringField
      FieldName = 'CUST_TYPE'
      Size = 40
    end
  end
  object qryOraCustomer: TUniQuery
    Connection = dmFBZakelijk.connOraZakelijk
    SQL.Strings = (
      
        'select audit_id, cust_id, cust_name, kvk_number, tax_reg_id, cus' +
        't_type'
      'from mk_xml_customer;')
    ReadOnly = True
    Left = 176
    Top = 32
    object qryOraCustomerAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryOraCustomerCUST_ID: TStringField
      FieldName = 'CUST_ID'
      Size = 200
    end
    object qryOraCustomerCUST_NAME: TStringField
      FieldName = 'CUST_NAME'
      Size = 200
    end
    object qryOraCustomerKVK_NUMBER: TStringField
      FieldName = 'KVK_NUMBER'
      Size = 200
    end
    object qryOraCustomerTAX_REG_ID: TStringField
      FieldName = 'TAX_REG_ID'
      Size = 200
    end
    object qryOraCustomerCUST_TYPE: TStringField
      FieldName = 'CUST_TYPE'
      Size = 200
    end
  end
end
