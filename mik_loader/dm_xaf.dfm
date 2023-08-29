object dmXAF: TdmXAF
  Height = 504
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
    Left = 112
    Top = 112
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
    Left = 248
    Top = 112
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
  object qryXafInfo: TUniQuery
    KeyFields = 'audit_id'
    Connection = dmFBZakelijk.connFBZakelijk
    SQL.Strings = (
      'select audit_id, companyident, companyname, tax_reg_country'
      
        ', tax_reg_id, fiscalyear, startdate, enddate, curcode, datecreat' +
        'ed'
      ', software_desc, software_version'
      'from mk_xaf_info')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'audit_id'
    Left = 112
    Top = 24
    object qryXafInfoAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryXafInfoCOMPANYIDENT: TStringField
      FieldName = 'COMPANYIDENT'
      Size = 35
    end
    object qryXafInfoCOMPANYNAME: TStringField
      FieldName = 'COMPANYNAME'
      Size = 200
    end
    object qryXafInfoTAX_REG_COUNTRY: TStringField
      FieldName = 'TAX_REG_COUNTRY'
      Size = 31
    end
    object qryXafInfoTAX_REG_ID: TStringField
      FieldName = 'TAX_REG_ID'
      Size = 30
    end
    object qryXafInfoFISCALYEAR: TStringField
      FieldName = 'FISCALYEAR'
      Size = 9
    end
    object qryXafInfoSTARTDATE: TDateField
      FieldName = 'STARTDATE'
    end
    object qryXafInfoENDDATE: TDateField
      FieldName = 'ENDDATE'
    end
    object qryXafInfoCURCODE: TStringField
      FieldName = 'CURCODE'
      Size = 31
    end
    object qryXafInfoDATECREATED: TDateField
      FieldName = 'DATECREATED'
    end
    object qryXafInfoSOFTWARE_DESC: TStringField
      FieldName = 'SOFTWARE_DESC'
      Size = 50
    end
    object qryXafInfoSOFTWARE_VERSION: TStringField
      FieldName = 'SOFTWARE_VERSION'
    end
  end
  object qryXafVatCode: TUniQuery
    KeyFields = 'audit_id;vat_id'
    SQLInsert.Strings = (
      'INSERT INTO MK_XAF_VAT_CODE'
      '  (AUDIT_ID, VAT_ID, VAT_DESC, PAY_ACC_ID, CLAIM_ACC_ID)'
      'VALUES'
      '  (:AUDIT_ID, :VAT_ID, :VAT_DESC, :PAY_ACC_ID, :CLAIM_ACC_ID)')
    SQLDelete.Strings = (
      'DELETE FROM MK_XAF_VAT_CODE'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID AND VAT_ID = :Old_VAT_ID')
    SQLUpdate.Strings = (
      'UPDATE MK_XAF_VAT_CODE'
      'SET'
      
        '  AUDIT_ID = :AUDIT_ID, VAT_ID = :VAT_ID, VAT_DESC = :VAT_DESC, ' +
        'PAY_ACC_ID = :PAY_ACC_ID, CLAIM_ACC_ID = :CLAIM_ACC_ID'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID AND VAT_ID = :Old_VAT_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_XAF_VAT_CODE'
      'WHERE'
      'AUDIT_ID = :Old_AUDIT_ID AND VAT_ID = :Old_VAT_ID'
      'FOR UPDATE WITH LOCK')
    SQLRefresh.Strings = (
      
        'SELECT AUDIT_ID, VAT_ID, VAT_DESC, PAY_ACC_ID, CLAIM_ACC_ID FROM' +
        ' MK_XAF_VAT_CODE'
      'WHERE'
      '  AUDIT_ID = :AUDIT_ID AND VAT_ID = :VAT_ID')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM MK_XAF_VAT_CODE'
      ''
      ') q')
    Connection = dmFBZakelijk.connFBZakelijk
    SQL.Strings = (
      'select audit_id, vat_id, vat_desc, pay_acc_id, claim_acc_id'
      'from mk_xaf_vat_code')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'audit_id;vat_id'
    Left = 112
    Top = 200
    object qryXafVatCodeAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryXafVatCodeVAT_ID: TStringField
      FieldName = 'VAT_ID'
      Required = True
      Size = 35
    end
    object qryXafVatCodeVAT_DESC: TStringField
      FieldName = 'VAT_DESC'
      Size = 100
    end
    object qryXafVatCodePAY_ACC_ID: TStringField
      FieldName = 'PAY_ACC_ID'
      Size = 35
    end
    object qryXafVatCodeCLAIM_ACC_ID: TStringField
      FieldName = 'CLAIM_ACC_ID'
      Size = 35
    end
  end
  object qryXafPeriod: TUniQuery
    KeyFields = 'audit_id;period_id'
    SQLInsert.Strings = (
      'INSERT INTO MK_XAF_PERIOD'
      '  (AUDIT_ID, PERIOD_ID, PERIOD_DESC, STARTDATE, ENDDATE)'
      'VALUES'
      '  (:AUDIT_ID, :PERIOD_ID, :PERIOD_DESC, :STARTDATE, :ENDDATE)')
    SQLDelete.Strings = (
      'DELETE FROM MK_XAF_PERIOD'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID AND PERIOD_ID = :Old_PERIOD_ID')
    SQLUpdate.Strings = (
      'UPDATE MK_XAF_PERIOD'
      'SET'
      
        '  AUDIT_ID = :AUDIT_ID, PERIOD_ID = :PERIOD_ID, PERIOD_DESC = :P' +
        'ERIOD_DESC, STARTDATE = :STARTDATE, ENDDATE = :ENDDATE'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID AND PERIOD_ID = :Old_PERIOD_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_XAF_PERIOD'
      'WHERE'
      'AUDIT_ID = :Old_AUDIT_ID AND PERIOD_ID = :Old_PERIOD_ID'
      'FOR UPDATE WITH LOCK')
    SQLRefresh.Strings = (
      
        'SELECT AUDIT_ID, PERIOD_ID, PERIOD_DESC, STARTDATE, ENDDATE FROM' +
        ' MK_XAF_PERIOD'
      'WHERE'
      '  AUDIT_ID = :AUDIT_ID AND PERIOD_ID = :PERIOD_ID')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM MK_XAF_PERIOD'
      ''
      ') q')
    Connection = dmFBZakelijk.connFBZakelijk
    SQL.Strings = (
      'select audit_id, period_id, period_desc, startdate, enddate'
      'from mk_xaf_period')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'audit_id;period_id'
    Left = 112
    Top = 288
    object qryXafPeriodAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryXafPeriodPERIOD_ID: TIntegerField
      FieldName = 'PERIOD_ID'
      Required = True
    end
    object qryXafPeriodPERIOD_DESC: TStringField
      FieldName = 'PERIOD_DESC'
      Size = 50
    end
    object qryXafPeriodSTARTDATE: TDateField
      FieldName = 'STARTDATE'
    end
    object qryXafPeriodENDDATE: TDateField
      FieldName = 'ENDDATE'
    end
  end
  object qryXafAccount: TUniQuery
    KeyFields = 'audit_id;acc_id'
    SQLInsert.Strings = (
      'INSERT INTO MK_XAF_ACCOUNT'
      '  (AUDIT_ID, ACC_ID, ACC_DESC, ACC_TYPE, LEAD_CODE, LEAD_DESC)'
      'VALUES'
      
        '  (:AUDIT_ID, :ACC_ID, :ACC_DESC, :ACC_TYPE, :LEAD_CODE, :LEAD_D' +
        'ESC)')
    SQLDelete.Strings = (
      'DELETE FROM MK_XAF_ACCOUNT'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID AND ACC_ID = :Old_ACC_ID')
    SQLUpdate.Strings = (
      'UPDATE MK_XAF_ACCOUNT'
      'SET'
      
        '  AUDIT_ID = :AUDIT_ID, ACC_ID = :ACC_ID, ACC_DESC = :ACC_DESC, ' +
        'ACC_TYPE = :ACC_TYPE, LEAD_CODE = :LEAD_CODE, LEAD_DESC = :LEAD_' +
        'DESC'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID AND ACC_ID = :Old_ACC_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_XAF_ACCOUNT'
      'WHERE'
      'AUDIT_ID = :Old_AUDIT_ID AND ACC_ID = :Old_ACC_ID'
      'FOR UPDATE WITH LOCK')
    SQLRefresh.Strings = (
      
        'SELECT AUDIT_ID, ACC_ID, ACC_DESC, ACC_TYPE, LEAD_CODE, LEAD_DES' +
        'C FROM MK_XAF_ACCOUNT'
      'WHERE'
      '  AUDIT_ID = :AUDIT_ID AND ACC_ID = :ACC_ID')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM MK_XAF_ACCOUNT'
      ''
      ') q')
    Connection = dmFBZakelijk.connFBZakelijk
    SQL.Strings = (
      
        'select audit_id, acc_id, acc_desc, acc_type, lead_code, lead_des' +
        'c'
      'from mk_xaf_account')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'audit_id;acc_id'
    Left = 112
    Top = 384
    object qryXafAccountAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryXafAccountACC_ID: TStringField
      FieldName = 'ACC_ID'
      Required = True
      Size = 35
    end
    object qryXafAccountACC_DESC: TStringField
      FieldName = 'ACC_DESC'
      Size = 200
    end
    object qryXafAccountACC_TYPE: TStringField
      FieldName = 'ACC_TYPE'
      Size = 2
    end
    object qryXafAccountLEAD_CODE: TStringField
      FieldName = 'LEAD_CODE'
      Size = 50
    end
    object qryXafAccountLEAD_DESC: TStringField
      FieldName = 'LEAD_DESC'
      Size = 100
    end
  end
end
