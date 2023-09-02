object dmXAF: TdmXAF
  Height = 504
  Width = 770
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
    SQLInsert.Strings = (
      'INSERT INTO MK_XML_CUSTOMER'
      
        '  (AUDIT_ID, CUST_ID, CUST_NAME, KVK_NUMBER, TAX_REG_ID, CUST_TY' +
        'PE)'
      'VALUES'
      
        '  (:AUDIT_ID, :CUST_ID, :CUST_NAME, :KVK_NUMBER, :TAX_REG_ID, :C' +
        'UST_TYPE)')
    SQLUpdate.Strings = (
      'UPDATE MK_XML_CUSTOMER'
      'SET'
      
        '  AUDIT_ID = :AUDIT_ID, CUST_ID = :CUST_ID, CUST_NAME = :CUST_NA' +
        'ME, KVK_NUMBER = :KVK_NUMBER, TAX_REG_ID = :TAX_REG_ID, CUST_TYP' +
        'E = :CUST_TYPE'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID AND CUST_ID = :Old_CUST_ID')
    SQLRefresh.Strings = (
      
        'SELECT AUDIT_ID, CUST_ID, CUST_NAME, KVK_NUMBER, TAX_REG_ID, CUS' +
        'T_TYPE FROM MK_XML_CUSTOMER'
      'WHERE'
      '  AUDIT_ID = :AUDIT_ID AND CUST_ID = :CUST_ID')
    SQLRecCount.Strings = (
      'SELECT Count(*) FROM ('
      'SELECT * FROM MK_XML_CUSTOMER'
      ''
      ')')
    Connection = dmFBZakelijk.connOraZakelijk
    SQL.Strings = (
      
        'select audit_id, cust_id, cust_name, kvk_number, tax_reg_id, cus' +
        't_type'
      'from mk_xml_customer;')
    ReadOnly = True
    Options.SetEmptyStrToNull = True
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
    SQLInsert.Strings = (
      'INSERT INTO MK_XAF_INFO'
      
        '  (AUDIT_ID, COMPANYIDENT, COMPANYNAME, TAX_REG_COUNTRY, TAX_REG' +
        '_ID, FISCALYEAR, STARTDATE, ENDDATE, CURCODE, DATECREATED, SOFTW' +
        'ARE_DESC, SOFTWARE_VERSION)'
      'VALUES'
      
        '  (:AUDIT_ID, :COMPANYIDENT, :COMPANYNAME, :TAX_REG_COUNTRY, :TA' +
        'X_REG_ID, :FISCALYEAR, :STARTDATE, :ENDDATE, :CURCODE, :DATECREA' +
        'TED, :SOFTWARE_DESC, :SOFTWARE_VERSION)')
    SQLDelete.Strings = (
      'DELETE FROM MK_XAF_INFO'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID')
    SQLUpdate.Strings = (
      'UPDATE MK_XAF_INFO'
      'SET'
      
        '  AUDIT_ID = :AUDIT_ID, COMPANYIDENT = :COMPANYIDENT, COMPANYNAM' +
        'E = :COMPANYNAME, TAX_REG_COUNTRY = :TAX_REG_COUNTRY, TAX_REG_ID' +
        ' = :TAX_REG_ID, FISCALYEAR = :FISCALYEAR, STARTDATE = :STARTDATE' +
        ', ENDDATE = :ENDDATE, CURCODE = :CURCODE, DATECREATED = :DATECRE' +
        'ATED, SOFTWARE_DESC = :SOFTWARE_DESC, SOFTWARE_VERSION = :SOFTWA' +
        'RE_VERSION'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_XAF_INFO'
      'WHERE'
      'AUDIT_ID = :Old_AUDIT_ID'
      'FOR UPDATE WITH LOCK')
    SQLRefresh.Strings = (
      
        'SELECT AUDIT_ID, COMPANYIDENT, COMPANYNAME, TAX_REG_COUNTRY, TAX' +
        '_REG_ID, FISCALYEAR, STARTDATE, ENDDATE, CURCODE, DATECREATED, S' +
        'OFTWARE_DESC, SOFTWARE_VERSION FROM MK_XAF_INFO'
      'WHERE'
      '  AUDIT_ID = :AUDIT_ID')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM MK_XAF_INFO'
      ''
      ') q')
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
  object qryOraInfo: TUniQuery
    KeyFields = 'audit_id'
    SQLInsert.Strings = (
      'INSERT INTO MK_XML_AUDIT_INFO'
      
        '  (AUDIT_ID, COMPANYIDENT, COMPANYNAME, TAX_REG_COUNTRY, TAX_REG' +
        '_ID, FISCALYEAR, STARTDATE, ENDDATE, CURCODE, DATECREATED, SOFTW' +
        'ARE_DESC, SOFTWARE_VERSION)'
      'VALUES'
      
        '  (:AUDIT_ID, :COMPANYIDENT, :COMPANYNAME, :TAX_REG_COUNTRY, :TA' +
        'X_REG_ID, :FISCALYEAR, :STARTDATE, :ENDDATE, :CURCODE, :DATECREA' +
        'TED, :SOFTWARE_DESC, :SOFTWARE_VERSION)')
    SQLUpdate.Strings = (
      'UPDATE MK_XML_AUDIT_INFO'
      'SET'
      
        '  AUDIT_ID = :AUDIT_ID, COMPANYIDENT = :COMPANYIDENT, COMPANYNAM' +
        'E = :COMPANYNAME, TAX_REG_COUNTRY = :TAX_REG_COUNTRY, TAX_REG_ID' +
        ' = :TAX_REG_ID, FISCALYEAR = :FISCALYEAR, STARTDATE = :STARTDATE' +
        ', ENDDATE = :ENDDATE, CURCODE = :CURCODE, DATECREATED = :DATECRE' +
        'ATED, SOFTWARE_DESC = :SOFTWARE_DESC, SOFTWARE_VERSION = :SOFTWA' +
        'RE_VERSION'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID')
    SQLRefresh.Strings = (
      
        'SELECT AUDIT_ID, COMPANYIDENT, COMPANYNAME, TAX_REG_COUNTRY, TAX' +
        '_REG_ID, FISCALYEAR, STARTDATE, ENDDATE, CURCODE, DATECREATED, S' +
        'OFTWARE_DESC, SOFTWARE_VERSION FROM MK_XML_AUDIT_INFO'
      'WHERE'
      '  AUDIT_ID = :AUDIT_ID')
    SQLRecCount.Strings = (
      'SELECT Count(*) FROM ('
      'SELECT * FROM MK_XML_AUDIT_INFO'
      ''
      ')')
    Connection = dmFBZakelijk.connOraZakelijk
    SQL.Strings = (
      'select audit_id, companyident, companyname, tax_reg_country'
      
        ', tax_reg_id, fiscalyear, startdate, enddate, curcode, datecreat' +
        'ed'
      ', software_desc, software_version'
      'from mk_xml_audit_info')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'audit_id'
    Left = 248
    Top = 24
    object qryOraInfoAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryOraInfoCOMPANYIDENT: TStringField
      FieldName = 'COMPANYIDENT'
      Size = 200
    end
    object qryOraInfoCOMPANYNAME: TStringField
      FieldName = 'COMPANYNAME'
      Size = 200
    end
    object qryOraInfoTAX_REG_COUNTRY: TStringField
      FieldName = 'TAX_REG_COUNTRY'
      Size = 200
    end
    object qryOraInfoTAX_REG_ID: TStringField
      FieldName = 'TAX_REG_ID'
      Size = 200
    end
    object qryOraInfoFISCALYEAR: TStringField
      FieldName = 'FISCALYEAR'
      Size = 200
    end
    object qryOraInfoSTARTDATE: TDateTimeField
      FieldName = 'STARTDATE'
    end
    object qryOraInfoENDDATE: TDateTimeField
      FieldName = 'ENDDATE'
    end
    object qryOraInfoCURCODE: TStringField
      FieldName = 'CURCODE'
      Size = 200
    end
    object qryOraInfoDATECREATED: TDateTimeField
      FieldName = 'DATECREATED'
    end
    object qryOraInfoSOFTWARE_DESC: TStringField
      FieldName = 'SOFTWARE_DESC'
      Size = 200
    end
    object qryOraInfoSOFTWARE_VERSION: TStringField
      FieldName = 'SOFTWARE_VERSION'
      Size = 200
    end
  end
  object qryOraVatCode: TUniQuery
    KeyFields = 'audit_id;vat_id'
    SQLInsert.Strings = (
      'INSERT INTO MK_XML_VAT_CODE'
      '  (AUDIT_ID, VAT_ID, VAT_DESC, PAY_ACC_ID, CLAIM_ACC_ID)'
      'VALUES'
      '  (:AUDIT_ID, :VAT_ID, :VAT_DESC, :PAY_ACC_ID, :CLAIM_ACC_ID)')
    SQLUpdate.Strings = (
      'UPDATE MK_XML_VAT_CODE'
      'SET'
      
        '  AUDIT_ID = :AUDIT_ID, VAT_ID = :VAT_ID, VAT_DESC = :VAT_DESC, ' +
        'PAY_ACC_ID = :PAY_ACC_ID, CLAIM_ACC_ID = :CLAIM_ACC_ID'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID AND VAT_ID = :Old_VAT_ID')
    SQLRefresh.Strings = (
      
        'SELECT AUDIT_ID, VAT_ID, VAT_DESC, PAY_ACC_ID, CLAIM_ACC_ID FROM' +
        ' MK_XML_VAT_CODE'
      'WHERE'
      '  AUDIT_ID = :AUDIT_ID AND VAT_ID = :VAT_ID')
    SQLRecCount.Strings = (
      'SELECT Count(*) FROM ('
      'SELECT * FROM MK_XML_VAT_CODE'
      ''
      ')')
    Connection = dmFBZakelijk.connOraZakelijk
    SQL.Strings = (
      'select audit_id, vat_id, vat_desc, pay_acc_id, claim_acc_id'
      'from mk_xml_vat_code')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'audit_id;vat_id'
    Left = 248
    Top = 200
    object qryOraVatCodeAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryOraVatCodeVAT_ID: TStringField
      FieldName = 'VAT_ID'
      Size = 200
    end
    object qryOraVatCodeVAT_DESC: TStringField
      FieldName = 'VAT_DESC'
      Size = 200
    end
    object qryOraVatCodePAY_ACC_ID: TStringField
      FieldName = 'PAY_ACC_ID'
      Size = 200
    end
    object qryOraVatCodeCLAIM_ACC_ID: TStringField
      FieldName = 'CLAIM_ACC_ID'
      Size = 200
    end
  end
  object qryOraPeriod: TUniQuery
    KeyFields = 'audit_id;period_id'
    SQLInsert.Strings = (
      'INSERT INTO MK_XML_PERIOD'
      '  (AUDIT_ID, PERIOD_ID, PERIOD_DESC, STARTDATE, ENDDATE)'
      'VALUES'
      '  (:AUDIT_ID, :PERIOD_ID, :PERIOD_DESC, :STARTDATE, :ENDDATE)')
    SQLUpdate.Strings = (
      'UPDATE MK_XML_PERIOD'
      'SET'
      
        '  AUDIT_ID = :AUDIT_ID, PERIOD_ID = :PERIOD_ID, PERIOD_DESC = :P' +
        'ERIOD_DESC, STARTDATE = :STARTDATE, ENDDATE = :ENDDATE'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID AND PERIOD_ID = :Old_PERIOD_ID')
    SQLRefresh.Strings = (
      
        'SELECT AUDIT_ID, PERIOD_ID, PERIOD_DESC, STARTDATE, ENDDATE FROM' +
        ' MK_XML_PERIOD'
      'WHERE'
      '  AUDIT_ID = :AUDIT_ID AND PERIOD_ID = :PERIOD_ID')
    SQLRecCount.Strings = (
      'SELECT Count(*) FROM ('
      'SELECT * FROM MK_XML_PERIOD'
      ''
      ')')
    Connection = dmFBZakelijk.connOraZakelijk
    SQL.Strings = (
      'select audit_id, period_id, period_desc, startdate, enddate'
      'from mk_xml_period')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'audit_id;period_id'
    Left = 248
    Top = 288
    object qryOraPeriodAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryOraPeriodPERIOD_ID: TSmallintField
      FieldName = 'PERIOD_ID'
    end
    object qryOraPeriodPERIOD_DESC: TStringField
      FieldName = 'PERIOD_DESC'
      Size = 200
    end
    object qryOraPeriodSTARTDATE: TDateTimeField
      FieldName = 'STARTDATE'
    end
    object qryOraPeriodENDDATE: TDateTimeField
      FieldName = 'ENDDATE'
    end
  end
  object qryOraAccount: TUniQuery
    KeyFields = 'audit_id;acc_id'
    SQLInsert.Strings = (
      'INSERT INTO MK_XML_ACCOUNT'
      '  (AUDIT_ID, ACC_ID, ACC_DESC, ACC_TYPE, LEAD_CODE, LEAD_DESC)'
      'VALUES'
      
        '  (:AUDIT_ID, :ACC_ID, :ACC_DESC, :ACC_TYPE, :LEAD_CODE, :LEAD_D' +
        'ESC)')
    SQLUpdate.Strings = (
      'UPDATE MK_XML_ACCOUNT'
      'SET'
      
        '  AUDIT_ID = :AUDIT_ID, ACC_ID = :ACC_ID, ACC_DESC = :ACC_DESC, ' +
        'ACC_TYPE = :ACC_TYPE, LEAD_CODE = :LEAD_CODE, LEAD_DESC = :LEAD_' +
        'DESC'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID AND ACC_ID = :Old_ACC_ID')
    SQLRefresh.Strings = (
      
        'SELECT AUDIT_ID, ACC_ID, ACC_DESC, ACC_TYPE, LEAD_CODE, LEAD_DES' +
        'C FROM MK_XML_ACCOUNT'
      'WHERE'
      '  AUDIT_ID = :AUDIT_ID AND ACC_ID = :ACC_ID')
    SQLRecCount.Strings = (
      'SELECT Count(*) FROM ('
      'SELECT * FROM MK_XML_ACCOUNT'
      ''
      ')')
    Connection = dmFBZakelijk.connOraZakelijk
    SQL.Strings = (
      
        'select audit_id, acc_id, acc_desc, acc_type, lead_code, lead_des' +
        'c'
      'from mk_xml_account')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'audit_id;acc_id'
    Left = 240
    Top = 384
    object qryOraAccountAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryOraAccountACC_ID: TStringField
      FieldName = 'ACC_ID'
      Size = 200
    end
    object qryOraAccountACC_DESC: TStringField
      FieldName = 'ACC_DESC'
      Size = 200
    end
    object qryOraAccountACC_TYPE: TStringField
      FieldName = 'ACC_TYPE'
      Size = 200
    end
    object qryOraAccountLEAD_CODE: TStringField
      FieldName = 'LEAD_CODE'
      Size = 200
    end
    object qryOraAccountLEAD_DESC: TStringField
      FieldName = 'LEAD_DESC'
      Size = 200
    end
  end
  object qryXafOpBalance: TUniQuery
    KeyFields = 'audit_id'
    SQLInsert.Strings = (
      'INSERT INTO MK_XAF_OPENING_BALANCE'
      
        '  (AUDIT_ID, OB_DATE, OB_DESC, LINES_COUNT, TOTAL_DEBIT, TOTAL_C' +
        'REDIT)'
      'VALUES'
      
        '  (:AUDIT_ID, :OB_DATE, :OB_DESC, :LINES_COUNT, :TOTAL_DEBIT, :T' +
        'OTAL_CREDIT)')
    SQLDelete.Strings = (
      'DELETE FROM MK_XAF_OPENING_BALANCE'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID')
    SQLUpdate.Strings = (
      'UPDATE MK_XAF_OPENING_BALANCE'
      'SET'
      
        '  AUDIT_ID = :AUDIT_ID, OB_DATE = :OB_DATE, OB_DESC = :OB_DESC, ' +
        'LINES_COUNT = :LINES_COUNT, TOTAL_DEBIT = :TOTAL_DEBIT, TOTAL_CR' +
        'EDIT = :TOTAL_CREDIT'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_XAF_OPENING_BALANCE'
      'WHERE'
      'AUDIT_ID = :Old_AUDIT_ID'
      'FOR UPDATE WITH LOCK')
    SQLRefresh.Strings = (
      
        'SELECT AUDIT_ID, OB_DATE, OB_DESC, LINES_COUNT, TOTAL_DEBIT, TOT' +
        'AL_CREDIT FROM MK_XAF_OPENING_BALANCE'
      'WHERE'
      '  AUDIT_ID = :AUDIT_ID')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM MK_XAF_OPENING_BALANCE'
      ''
      ') q')
    Connection = dmFBZakelijk.connFBZakelijk
    SQL.Strings = (
      
        'select audit_id, ob_date, ob_desc, lines_count, total_debit, tot' +
        'al_credit'
      'from mk_xaf_opening_balance')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'audit_id'
    Left = 432
    Top = 80
    object qryXafOpBalanceAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryXafOpBalanceOB_DATE: TDateField
      FieldName = 'OB_DATE'
    end
    object qryXafOpBalanceOB_DESC: TStringField
      FieldName = 'OB_DESC'
      Size = 200
    end
    object qryXafOpBalanceLINES_COUNT: TIntegerField
      FieldName = 'LINES_COUNT'
    end
    object qryXafOpBalanceTOTAL_DEBIT: TFloatField
      FieldName = 'TOTAL_DEBIT'
    end
    object qryXafOpBalanceTOTAL_CREDIT: TFloatField
      FieldName = 'TOTAL_CREDIT'
    end
  end
  object qryXafOpLine: TUniQuery
    KeyFields = 'audit_id;obline_nr'
    SQLInsert.Strings = (
      'INSERT INTO MK_XAF_OPENING_LINE'
      
        '  (AUDIT_ID, OBLINE_NR, OBLINE_ACC_ID, AMNT_STRING, OBLINE_AMOUN' +
        'T, OBLINE_TYPE)'
      'VALUES'
      
        '  (:AUDIT_ID, :OBLINE_NR, :OBLINE_ACC_ID, :AMNT_STRING, :OBLINE_' +
        'AMOUNT, :OBLINE_TYPE)')
    SQLDelete.Strings = (
      'DELETE FROM MK_XAF_OPENING_LINE'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID AND OBLINE_NR = :Old_OBLINE_NR')
    SQLUpdate.Strings = (
      'UPDATE MK_XAF_OPENING_LINE'
      'SET'
      
        '  AUDIT_ID = :AUDIT_ID, OBLINE_NR = :OBLINE_NR, OBLINE_ACC_ID = ' +
        ':OBLINE_ACC_ID, AMNT_STRING = :AMNT_STRING, OBLINE_AMOUNT = :OBL' +
        'INE_AMOUNT, OBLINE_TYPE = :OBLINE_TYPE'
      'WHERE'
      '  AUDIT_ID = :Old_AUDIT_ID AND OBLINE_NR = :Old_OBLINE_NR')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_XAF_OPENING_LINE'
      'WHERE'
      'AUDIT_ID = :Old_AUDIT_ID AND OBLINE_NR = :Old_OBLINE_NR'
      'FOR UPDATE WITH LOCK')
    SQLRefresh.Strings = (
      
        'SELECT AUDIT_ID, OBLINE_NR, OBLINE_ACC_ID, AMNT_STRING, OBLINE_A' +
        'MOUNT, OBLINE_TYPE FROM MK_XAF_OPENING_LINE'
      'WHERE'
      '  AUDIT_ID = :AUDIT_ID AND OBLINE_NR = :OBLINE_NR')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM MK_XAF_OPENING_LINE'
      ''
      ') q')
    Connection = dmFBZakelijk.connFBZakelijk
    SQL.Strings = (
      
        'select audit_id, obline_nr, obline_acc_id, amnt_string, obline_a' +
        'mount'
      ', obline_type'
      'from mk_xaf_opening_line')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'audit_id;obline_nr'
    Left = 432
    Top = 160
    object qryXafOpLineAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryXafOpLineOBLINE_NR: TStringField
      FieldName = 'OBLINE_NR'
      Required = True
      Size = 50
    end
    object qryXafOpLineOBLINE_ACC_ID: TStringField
      FieldName = 'OBLINE_ACC_ID'
      Size = 35
    end
    object qryXafOpLineAMNT_STRING: TStringField
      FieldName = 'AMNT_STRING'
      Size = 50
    end
    object qryXafOpLineOBLINE_AMOUNT: TFloatField
      FieldName = 'OBLINE_AMOUNT'
    end
    object qryXafOpLineOBLINE_TYPE: TStringField
      FieldName = 'OBLINE_TYPE'
      Size = 5
    end
  end
  object qryXafTransaction: TUniQuery
    KeyFields = 'tx_nr'
    SQLInsert.Strings = (
      'INSERT INTO MK_XAF_TRANSACTION'
      
        '  (AUDIT_ID, JRN_ID, JRN_DESC, JRN_TYPE, TX_NR, TX_DESC, TX_PERI' +
        'OD_ID, TX_DATE, TX_AMOUNT, TX_AMOUNT_TYPE, TX_SOURCE_ID, TX_USER' +
        '_ID)'
      'VALUES'
      
        '  (:AUDIT_ID, :JRN_ID, :JRN_DESC, :JRN_TYPE, :TX_NR, :TX_DESC, :' +
        'TX_PERIOD_ID, :TX_DATE, :TX_AMOUNT, :TX_AMOUNT_TYPE, :TX_SOURCE_' +
        'ID, :TX_USER_ID)')
    SQLDelete.Strings = (
      'DELETE FROM MK_XAF_TRANSACTION'
      'WHERE'
      '  TX_NR = :Old_TX_NR')
    SQLUpdate.Strings = (
      'UPDATE MK_XAF_TRANSACTION'
      'SET'
      
        '  AUDIT_ID = :AUDIT_ID, JRN_ID = :JRN_ID, JRN_DESC = :JRN_DESC, ' +
        'JRN_TYPE = :JRN_TYPE, TX_NR = :TX_NR, TX_DESC = :TX_DESC, TX_PER' +
        'IOD_ID = :TX_PERIOD_ID, TX_DATE = :TX_DATE, TX_AMOUNT = :TX_AMOU' +
        'NT, TX_AMOUNT_TYPE = :TX_AMOUNT_TYPE, TX_SOURCE_ID = :TX_SOURCE_' +
        'ID, TX_USER_ID = :TX_USER_ID'
      'WHERE'
      '  TX_NR = :Old_TX_NR')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_XAF_TRANSACTION'
      'WHERE'
      'TX_NR = :Old_TX_NR'
      'FOR UPDATE WITH LOCK')
    SQLRefresh.Strings = (
      
        'SELECT AUDIT_ID, JRN_ID, JRN_DESC, JRN_TYPE, TX_NR, TX_DESC, TX_' +
        'PERIOD_ID, TX_DATE, TX_AMOUNT, TX_AMOUNT_TYPE, TX_SOURCE_ID, TX_' +
        'USER_ID FROM MK_XAF_TRANSACTION'
      'WHERE'
      '  TX_NR = :TX_NR')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM MK_XAF_TRANSACTION'
      ''
      ') q')
    Connection = dmFBZakelijk.connFBZakelijk
    SQL.Strings = (
      
        'select audit_id, jrn_id, jrn_desc, jrn_type, tx_nr, tx_desc, tx_' +
        'period_id'
      ', tx_date, tx_amount, tx_amount_type, tx_source_id, tx_user_id'
      'from mk_xaf_transaction')
    Options.ReturnParams = True
    IndexFieldNames = 'tx_nr'
    Left = 432
    Top = 256
    object qryXafTransactionAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Size = 50
    end
    object qryXafTransactionJRN_ID: TStringField
      FieldName = 'JRN_ID'
      Size = 35
    end
    object qryXafTransactionJRN_DESC: TStringField
      FieldName = 'JRN_DESC'
      Size = 35
    end
    object qryXafTransactionJRN_TYPE: TStringField
      FieldName = 'JRN_TYPE'
      Size = 2
    end
    object qryXafTransactionTX_NR: TStringField
      FieldName = 'TX_NR'
      Required = True
      Size = 35
    end
    object qryXafTransactionTX_DESC: TStringField
      FieldName = 'TX_DESC'
      Size = 100
    end
    object qryXafTransactionTX_PERIOD_ID: TIntegerField
      FieldName = 'TX_PERIOD_ID'
    end
    object qryXafTransactionTX_DATE: TDateField
      FieldName = 'TX_DATE'
    end
    object qryXafTransactionTX_AMOUNT: TFloatField
      FieldName = 'TX_AMOUNT'
    end
    object qryXafTransactionTX_AMOUNT_TYPE: TStringField
      FieldName = 'TX_AMOUNT_TYPE'
      Size = 35
    end
    object qryXafTransactionTX_SOURCE_ID: TStringField
      FieldName = 'TX_SOURCE_ID'
      Size = 35
    end
    object qryXafTransactionTX_USER_ID: TStringField
      FieldName = 'TX_USER_ID'
      Size = 35
    end
  end
  object qryXafTransactionLine: TUniQuery
    KeyFields = 'txline_nr'
    SQLInsert.Strings = (
      'INSERT INTO MK_XAF_TRANSACTION_LINE'
      
        '  (AUDIT_ID, TX_NR, TXLINE_NR, ACC_ID, DOC_REF, EFF_DATE, TXLINE' +
        '_DESC, AMOUNT, AMOUNT_TYPE, CUSTOMER_ID, COST_ID, PRODUCT_ID, PR' +
        'OJECT_ID, CUR_CODE, CUR_AMOUNT)'
      'VALUES'
      
        '  (:AUDIT_ID, :TX_NR, :TXLINE_NR, :ACC_ID, :DOC_REF, :EFF_DATE, ' +
        ':TXLINE_DESC, :AMOUNT, :AMOUNT_TYPE, :CUSTOMER_ID, :COST_ID, :PR' +
        'ODUCT_ID, :PROJECT_ID, :CUR_CODE, :CUR_AMOUNT)')
    SQLDelete.Strings = (
      'DELETE FROM MK_XAF_TRANSACTION_LINE'
      'WHERE'
      '  TXLINE_NR = :Old_TXLINE_NR')
    SQLUpdate.Strings = (
      'UPDATE MK_XAF_TRANSACTION_LINE'
      'SET'
      
        '  AUDIT_ID = :AUDIT_ID, TX_NR = :TX_NR, TXLINE_NR = :TXLINE_NR, ' +
        'ACC_ID = :ACC_ID, DOC_REF = :DOC_REF, EFF_DATE = :EFF_DATE, TXLI' +
        'NE_DESC = :TXLINE_DESC, AMOUNT = :AMOUNT, AMOUNT_TYPE = :AMOUNT_' +
        'TYPE, CUSTOMER_ID = :CUSTOMER_ID, COST_ID = :COST_ID, PRODUCT_ID' +
        ' = :PRODUCT_ID, PROJECT_ID = :PROJECT_ID, CUR_CODE = :CUR_CODE, ' +
        'CUR_AMOUNT = :CUR_AMOUNT'
      'WHERE'
      '  TXLINE_NR = :Old_TXLINE_NR')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_XAF_TRANSACTION_LINE'
      'WHERE'
      'TXLINE_NR = :Old_TXLINE_NR'
      'FOR UPDATE WITH LOCK')
    SQLRefresh.Strings = (
      
        'SELECT AUDIT_ID, TX_NR, TXLINE_NR, ACC_ID, DOC_REF, EFF_DATE, TX' +
        'LINE_DESC, AMOUNT, AMOUNT_TYPE, CUSTOMER_ID, COST_ID, PRODUCT_ID' +
        ', PROJECT_ID, CUR_CODE, CUR_AMOUNT FROM MK_XAF_TRANSACTION_LINE'
      'WHERE'
      '  TXLINE_NR = :TXLINE_NR')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM MK_XAF_TRANSACTION_LINE'
      ''
      ') q')
    Connection = dmFBZakelijk.connFBZakelijk
    SQL.Strings = (
      'select audit_id, tx_nr, txline_nr, acc_id, doc_ref, eff_date'
      
        ', txline_desc, amount, amount_type, customer_id, cost_id, produc' +
        't_id'
      ', project_id, cur_code, cur_amount'
      'from mk_xaf_transaction_line')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'txline_nr'
    Left = 432
    Top = 344
    object qryXafTransactionLineAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Size = 50
    end
    object qryXafTransactionLineTX_NR: TStringField
      FieldName = 'TX_NR'
      Size = 35
    end
    object qryXafTransactionLineTXLINE_NR: TStringField
      FieldName = 'TXLINE_NR'
      Required = True
      Size = 35
    end
    object qryXafTransactionLineACC_ID: TStringField
      FieldName = 'ACC_ID'
      Size = 35
    end
    object qryXafTransactionLineDOC_REF: TStringField
      FieldName = 'DOC_REF'
      Size = 100
    end
    object qryXafTransactionLineEFF_DATE: TDateField
      FieldName = 'EFF_DATE'
    end
    object qryXafTransactionLineTXLINE_DESC: TStringField
      FieldName = 'TXLINE_DESC'
      Size = 100
    end
    object qryXafTransactionLineAMOUNT: TFloatField
      FieldName = 'AMOUNT'
    end
    object qryXafTransactionLineAMOUNT_TYPE: TStringField
      FieldName = 'AMOUNT_TYPE'
      Size = 2
    end
    object qryXafTransactionLineCUSTOMER_ID: TStringField
      FieldName = 'CUSTOMER_ID'
      Size = 35
    end
    object qryXafTransactionLineCOST_ID: TStringField
      FieldName = 'COST_ID'
      Size = 35
    end
    object qryXafTransactionLinePRODUCT_ID: TStringField
      FieldName = 'PRODUCT_ID'
      Size = 35
    end
    object qryXafTransactionLinePROJECT_ID: TStringField
      FieldName = 'PROJECT_ID'
      Size = 35
    end
    object qryXafTransactionLineCUR_CODE: TStringField
      FieldName = 'CUR_CODE'
      Size = 5
    end
    object qryXafTransactionLineCUR_AMOUNT: TFloatField
      FieldName = 'CUR_AMOUNT'
    end
  end
  object qryXafVatLine: TUniQuery
    KeyFields = 'txline_nr'
    SQLInsert.Strings = (
      'INSERT INTO MK_XAF_VAT_LINE'
      
        '  (AUDIT_ID, TX_NR, TXLINE_NR, VAT_ID, VAT_PERC, AMOUNT, AMOUNT_' +
        'TYPE)'
      'VALUES'
      
        '  (:AUDIT_ID, :TX_NR, :TXLINE_NR, :VAT_ID, :VAT_PERC, :AMOUNT, :' +
        'AMOUNT_TYPE)')
    SQLDelete.Strings = (
      'DELETE FROM MK_XAF_VAT_LINE'
      'WHERE'
      '  TXLINE_NR = :Old_TXLINE_NR')
    SQLUpdate.Strings = (
      'UPDATE MK_XAF_VAT_LINE'
      'SET'
      
        '  AUDIT_ID = :AUDIT_ID, TX_NR = :TX_NR, TXLINE_NR = :TXLINE_NR, ' +
        'VAT_ID = :VAT_ID, VAT_PERC = :VAT_PERC, AMOUNT = :AMOUNT, AMOUNT' +
        '_TYPE = :AMOUNT_TYPE'
      'WHERE'
      '  TXLINE_NR = :Old_TXLINE_NR')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_XAF_VAT_LINE'
      'WHERE'
      'TXLINE_NR = :Old_TXLINE_NR'
      'FOR UPDATE WITH LOCK')
    SQLRefresh.Strings = (
      
        'SELECT AUDIT_ID, TX_NR, TXLINE_NR, VAT_ID, VAT_PERC, AMOUNT, AMO' +
        'UNT_TYPE FROM MK_XAF_VAT_LINE'
      'WHERE'
      '  TXLINE_NR = :TXLINE_NR')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM MK_XAF_VAT_LINE'
      ''
      ') q')
    Connection = dmFBZakelijk.connFBZakelijk
    SQL.Strings = (
      
        'select audit_id, tx_nr, txline_nr, vat_id, vat_perc, amount, amo' +
        'unt_type'
      'from mk_xaf_vat_line')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'txline_nr'
    Left = 424
    Top = 424
    object qryXafVatLineAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Size = 50
    end
    object qryXafVatLineTX_NR: TStringField
      FieldName = 'TX_NR'
      Size = 35
    end
    object qryXafVatLineTXLINE_NR: TStringField
      FieldName = 'TXLINE_NR'
      Required = True
      Size = 35
    end
    object qryXafVatLineVAT_ID: TStringField
      FieldName = 'VAT_ID'
      Size = 35
    end
    object qryXafVatLineVAT_PERC: TFloatField
      FieldName = 'VAT_PERC'
    end
    object qryXafVatLineAMOUNT: TFloatField
      FieldName = 'AMOUNT'
    end
    object qryXafVatLineAMOUNT_TYPE: TStringField
      FieldName = 'AMOUNT_TYPE'
      Size = 2
    end
  end
  object qryOraOpBalance: TUniQuery
    KeyFields = 'audit_id'
    SQLRefresh.Strings = (
      
        'SELECT AUDIT_ID, OB_DATE, OB_DESC, LINES_COUNT, TOTAL_DEBIT, TOT' +
        'AL_CREDIT FROM MK_XML_OPENING_BALANCE'
      'WHERE'
      '  AUDIT_ID = :AUDIT_ID')
    SQLRecCount.Strings = (
      'SELECT Count(*) FROM ('
      'SELECT * FROM MK_XML_OPENING_BALANCE'
      ''
      ')')
    Connection = dmFBZakelijk.connOraZakelijk
    SQL.Strings = (
      
        'select audit_id, ob_date, ob_desc, lines_count, total_debit, tot' +
        'al_credit'
      'from mk_xml_opening_balance')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'audit_id'
    Left = 584
    Top = 80
    object qryOraOpBalanceAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryOraOpBalanceOB_DATE: TDateTimeField
      FieldName = 'OB_DATE'
    end
    object qryOraOpBalanceOB_DESC: TStringField
      FieldName = 'OB_DESC'
      Size = 200
    end
    object qryOraOpBalanceLINES_COUNT: TFloatField
      FieldName = 'LINES_COUNT'
    end
    object qryOraOpBalanceTOTAL_DEBIT: TFloatField
      FieldName = 'TOTAL_DEBIT'
    end
    object qryOraOpBalanceTOTAL_CREDIT: TFloatField
      FieldName = 'TOTAL_CREDIT'
    end
  end
  object qryOraOpLine: TUniQuery
    KeyFields = 'audit_id;obline_nr'
    Connection = dmFBZakelijk.connOraZakelijk
    SQL.Strings = (
      
        'select audit_id, obline_nr, obline_acc_id, amnt_string, obline_a' +
        'mount, obline_type'
      'from mk_xml_opening_line')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'audit_id;obline_nr'
    Left = 568
    Top = 168
    object qryOraOpLineAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryOraOpLineOBLINE_NR: TStringField
      FieldName = 'OBLINE_NR'
      Size = 200
    end
    object qryOraOpLineOBLINE_ACC_ID: TStringField
      FieldName = 'OBLINE_ACC_ID'
      Size = 200
    end
    object qryOraOpLineAMNT_STRING: TStringField
      FieldName = 'AMNT_STRING'
      Size = 200
    end
    object qryOraOpLineOBLINE_AMOUNT: TFloatField
      FieldName = 'OBLINE_AMOUNT'
    end
    object qryOraOpLineOBLINE_TYPE: TStringField
      FieldName = 'OBLINE_TYPE'
      Size = 200
    end
  end
  object qryOraTransaction: TUniQuery
    KeyFields = 'tx_nr'
    SQLRefresh.Strings = (
      
        'SELECT AUDIT_ID, JRN_ID, JRN_DESC, JRN_TYPE, TX_NR, TX_DESC, TX_' +
        'PERIOD_ID, TX_DATE, TX_AMOUNT, TX_AMOUNT_TYPE, TX_SOURCE_ID, TX_' +
        'USER_ID FROM MK_XML_TRANSACTION'
      'WHERE'
      '  TX_NR = :TX_NR')
    SQLRecCount.Strings = (
      'SELECT Count(*) FROM ('
      'SELECT * FROM MK_XML_TRANSACTION'
      ''
      ')')
    Connection = dmFBZakelijk.connOraZakelijk
    SQL.Strings = (
      
        'select audit_id, jrn_id, jrn_desc, jrn_type, tx_nr, tx_desc, tx_' +
        'period_id'
      ', tx_date, tx_amount, tx_amount_type, tx_source_id, tx_user_id'
      'from mk_xml_transaction')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'audit_id;tx_nr'
    Left = 592
    Top = 256
    object qryOraTransactionAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryOraTransactionJRN_ID: TStringField
      FieldName = 'JRN_ID'
      Size = 200
    end
    object qryOraTransactionJRN_DESC: TStringField
      FieldName = 'JRN_DESC'
      Size = 200
    end
    object qryOraTransactionJRN_TYPE: TStringField
      FieldName = 'JRN_TYPE'
      Size = 200
    end
    object qryOraTransactionTX_NR: TIntegerField
      FieldName = 'TX_NR'
    end
    object qryOraTransactionTX_DESC: TStringField
      FieldName = 'TX_DESC'
      Size = 200
    end
    object qryOraTransactionTX_PERIOD_ID: TSmallintField
      FieldName = 'TX_PERIOD_ID'
    end
    object qryOraTransactionTX_DATE: TDateTimeField
      FieldName = 'TX_DATE'
    end
    object qryOraTransactionTX_AMOUNT: TFloatField
      FieldName = 'TX_AMOUNT'
    end
    object qryOraTransactionTX_AMOUNT_TYPE: TStringField
      FieldName = 'TX_AMOUNT_TYPE'
      Size = 200
    end
    object qryOraTransactionTX_SOURCE_ID: TStringField
      FieldName = 'TX_SOURCE_ID'
      Size = 200
    end
    object qryOraTransactionTX_USER_ID: TStringField
      FieldName = 'TX_USER_ID'
      Size = 200
    end
  end
  object qryOraTransactionLine: TUniQuery
    KeyFields = 'txline_nr'
    Connection = dmFBZakelijk.connOraZakelijk
    SQL.Strings = (
      'select audit_id, tx_nr, txline_nr, acc_id, doc_ref, eff_date'
      
        ', txline_desc, amount, amount_type, customer_id, cost_id, produc' +
        't_id'
      ', project_id, cur_code, cur_amount'
      'from mk_xml_transaction_line')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'audit_id;txline_nr'
    Left = 592
    Top = 344
    object qryOraTransactionLineAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryOraTransactionLineTX_NR: TIntegerField
      FieldName = 'TX_NR'
    end
    object qryOraTransactionLineTXLINE_NR: TStringField
      FieldName = 'TXLINE_NR'
      Size = 200
    end
    object qryOraTransactionLineACC_ID: TStringField
      FieldName = 'ACC_ID'
      Size = 200
    end
    object qryOraTransactionLineDOC_REF: TStringField
      FieldName = 'DOC_REF'
      Size = 200
    end
    object qryOraTransactionLineEFF_DATE: TDateTimeField
      FieldName = 'EFF_DATE'
    end
    object qryOraTransactionLineTXLINE_DESC: TStringField
      FieldName = 'TXLINE_DESC'
      Size = 200
    end
    object qryOraTransactionLineAMOUNT: TFloatField
      FieldName = 'AMOUNT'
    end
    object qryOraTransactionLineAMOUNT_TYPE: TStringField
      FieldName = 'AMOUNT_TYPE'
      Size = 200
    end
    object qryOraTransactionLineCUSTOMER_ID: TStringField
      FieldName = 'CUSTOMER_ID'
      Size = 200
    end
    object qryOraTransactionLineCOST_ID: TStringField
      FieldName = 'COST_ID'
      Size = 200
    end
    object qryOraTransactionLinePRODUCT_ID: TStringField
      FieldName = 'PRODUCT_ID'
      Size = 200
    end
    object qryOraTransactionLinePROJECT_ID: TStringField
      FieldName = 'PROJECT_ID'
      Size = 200
    end
    object qryOraTransactionLineCUR_CODE: TStringField
      FieldName = 'CUR_CODE'
      Size = 200
    end
    object qryOraTransactionLineCUR_AMOUNT: TFloatField
      FieldName = 'CUR_AMOUNT'
    end
  end
  object qryOraVatLine: TUniQuery
    KeyFields = 'txline_nr'
    Connection = dmFBZakelijk.connOraZakelijk
    SQL.Strings = (
      
        'select audit_id, tx_nr, txline_nr, vat_id, vat_perc, amount, amo' +
        'unt_type'
      'from mk_xml_vat_line')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'audit_id;txline_nr'
    Left = 592
    Top = 424
    object qryOraVatLineAUDIT_ID: TStringField
      FieldName = 'AUDIT_ID'
      Required = True
      Size = 50
    end
    object qryOraVatLineTX_NR: TIntegerField
      FieldName = 'TX_NR'
    end
    object qryOraVatLineTXLINE_NR: TStringField
      FieldName = 'TXLINE_NR'
      Size = 200
    end
    object qryOraVatLineVAT_ID: TStringField
      FieldName = 'VAT_ID'
      Size = 200
    end
    object qryOraVatLineVAT_PERC: TFloatField
      FieldName = 'VAT_PERC'
    end
    object qryOraVatLineAMOUNT: TFloatField
      FieldName = 'AMOUNT'
    end
    object qryOraVatLineAMOUNT_TYPE: TStringField
      FieldName = 'AMOUNT_TYPE'
      Size = 200
    end
  end
end
