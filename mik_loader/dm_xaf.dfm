object dmXAF: TdmXAF
  Height = 649
  Width = 931
  PixelsPerInch = 120
  object qryXafCustomer: TUniQuery
    UpdatingTable = 'mk_xaf_customer'
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
    UpdatingTable = 'mk_xaf_info'
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
    UpdatingTable = 'mk_xaf_vat_code'
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
    UpdatingTable = 'mk_xaf_period'
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
    UpdatingTable = 'mk_xaf_account'
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
    UpdatingTable = 'mk_xaf_opening_balance'
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
    UpdatingTable = 'mk_xaf_opening_line'
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
    UpdatingTable = 'mk_xaf_transaction'
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
    UpdatingTable = 'mk_xaf_transaction_line'
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
    UpdatingTable = 'mk_xaf_vat_line'
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
    Left = 560
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
    Left = 536
    Top = 160
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
    Left = 568
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
    Left = 544
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
  object qryKnabTx: TUniQuery
    UpdatingTable = 'mk_ktx'
    KeyFields = 'mikel_tx_id'
    SQLInsert.Strings = (
      'INSERT INTO MK_KTX'
      
        '  (IBAN, TX_DATUM, VALUTA_CODE, CREDIT_DEBET, BEDRAG, TEGEN_IBAN' +
        ', TEGEN_NAAM, VALUTA_DATUM, BETAALWIJZE, OMSCHRIJVING, TYPE_BETA' +
        'LING, MACHTIGINGSKENMERK, INCASSANT_ID, ADRES, TX_REFERENTIE, BO' +
        'EK_DATUM, MIKEL_TX_ID, CREATE_DATE)'
      'VALUES'
      
        '  (:IBAN, :TX_DATUM, :VALUTA_CODE, :CREDIT_DEBET, :BEDRAG, :TEGE' +
        'N_IBAN, :TEGEN_NAAM, :VALUTA_DATUM, :BETAALWIJZE, :OMSCHRIJVING,' +
        ' :TYPE_BETALING, :MACHTIGINGSKENMERK, :INCASSANT_ID, :ADRES, :TX' +
        '_REFERENTIE, :BOEK_DATUM, :MIKEL_TX_ID, :CREATE_DATE)')
    SQLDelete.Strings = (
      'DELETE FROM MK_KTX'
      'WHERE'
      '  MIKEL_TX_ID = :Old_MIKEL_TX_ID')
    SQLUpdate.Strings = (
      'UPDATE MK_KTX'
      'SET'
      
        '  IBAN = :IBAN, TX_DATUM = :TX_DATUM, VALUTA_CODE = :VALUTA_CODE' +
        ', CREDIT_DEBET = :CREDIT_DEBET, BEDRAG = :BEDRAG, TEGEN_IBAN = :' +
        'TEGEN_IBAN, TEGEN_NAAM = :TEGEN_NAAM, VALUTA_DATUM = :VALUTA_DAT' +
        'UM, BETAALWIJZE = :BETAALWIJZE, OMSCHRIJVING = :OMSCHRIJVING, TY' +
        'PE_BETALING = :TYPE_BETALING, MACHTIGINGSKENMERK = :MACHTIGINGSK' +
        'ENMERK, INCASSANT_ID = :INCASSANT_ID, ADRES = :ADRES, TX_REFEREN' +
        'TIE = :TX_REFERENTIE, BOEK_DATUM = :BOEK_DATUM, MIKEL_TX_ID = :M' +
        'IKEL_TX_ID, CREATE_DATE = :CREATE_DATE'
      'WHERE'
      '  MIKEL_TX_ID = :Old_MIKEL_TX_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_KTX'
      'WHERE'
      'MIKEL_TX_ID = :Old_MIKEL_TX_ID'
      'FOR UPDATE WITH LOCK')
    SQLRefresh.Strings = (
      
        'SELECT IBAN, TX_DATUM, VALUTA_CODE, CREDIT_DEBET, BEDRAG, TEGEN_' +
        'IBAN, TEGEN_NAAM, VALUTA_DATUM, BETAALWIJZE, OMSCHRIJVING, TYPE_' +
        'BETALING, MACHTIGINGSKENMERK, INCASSANT_ID, ADRES, TX_REFERENTIE' +
        ', BOEK_DATUM, MIKEL_TX_ID, CREATE_DATE FROM MK_KTX'
      'WHERE'
      '  MIKEL_TX_ID = :MIKEL_TX_ID')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM MK_KTX'
      ''
      ') q')
    Connection = dmFBZakelijk.connFBZakelijk
    SQL.Strings = (
      
        'select iban, tx_datum, valuta_code, credit_debet, bedrag, tegen_' +
        'iban'
      
        ', tegen_naam, valuta_datum, betaalwijze, omschrijving, type_beta' +
        'ling'
      
        ', machtigingskenmerk, incassant_id, adres, tx_referentie, boek_d' +
        'atum'
      ', mikel_tx_id, create_date'
      'from mk_ktx')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'boek_datum'
    Left = 48
    Top = 520
    object qryKnabTxIBAN: TStringField
      FieldName = 'IBAN'
      Required = True
      Size = 50
    end
    object qryKnabTxTX_DATUM: TDateField
      FieldName = 'TX_DATUM'
    end
    object qryKnabTxVALUTA_CODE: TStringField
      FieldName = 'VALUTA_CODE'
      Size = 3
    end
    object qryKnabTxCREDIT_DEBET: TStringField
      FieldName = 'CREDIT_DEBET'
      Required = True
      Size = 2
    end
    object qryKnabTxBEDRAG: TFloatField
      FieldName = 'BEDRAG'
      Required = True
    end
    object qryKnabTxTEGEN_IBAN: TStringField
      FieldName = 'TEGEN_IBAN'
      Size = 50
    end
    object qryKnabTxTEGEN_NAAM: TStringField
      FieldName = 'TEGEN_NAAM'
      Size = 255
    end
    object qryKnabTxVALUTA_DATUM: TDateField
      FieldName = 'VALUTA_DATUM'
    end
    object qryKnabTxBETAALWIJZE: TStringField
      FieldName = 'BETAALWIJZE'
      Size = 40
    end
    object qryKnabTxOMSCHRIJVING: TStringField
      FieldName = 'OMSCHRIJVING'
      Size = 255
    end
    object qryKnabTxTYPE_BETALING: TStringField
      FieldName = 'TYPE_BETALING'
      Size = 255
    end
    object qryKnabTxMACHTIGINGSKENMERK: TStringField
      FieldName = 'MACHTIGINGSKENMERK'
      Size = 255
    end
    object qryKnabTxINCASSANT_ID: TStringField
      FieldName = 'INCASSANT_ID'
      Size = 255
    end
    object qryKnabTxADRES: TStringField
      FieldName = 'ADRES'
      Size = 70
    end
    object qryKnabTxTX_REFERENTIE: TStringField
      FieldName = 'TX_REFERENTIE'
      Required = True
    end
    object qryKnabTxBOEK_DATUM: TDateField
      FieldName = 'BOEK_DATUM'
    end
    object qryKnabTxMIKEL_TX_ID: TStringField
      FieldName = 'MIKEL_TX_ID'
      Required = True
      Size = 120
    end
    object qryKnabTxCREATE_DATE: TDateTimeField
      FieldName = 'CREATE_DATE'
      Required = True
    end
  end
  object qryKnabInfo: TUniQuery
    UpdatingTable = 'MK_KTX_XAF_INFO'
    KeyFields = 'mikel_tx_id'
    SQLInsert.Strings = (
      'INSERT INTO MK_KTX_XAF_INFO'
      '  (MIKEL_TX_ID, TX_TYPE, MK_GL_DATE, TX_NR, CREATE_DATE)'
      'VALUES'
      '  (:MIKEL_TX_ID, :TX_TYPE, :MK_GL_DATE, :TX_NR, :CREATE_DATE)')
    SQLDelete.Strings = (
      'DELETE FROM MK_KTX_XAF_INFO'
      'WHERE'
      '  MIKEL_TX_ID = :Old_MIKEL_TX_ID')
    SQLUpdate.Strings = (
      'UPDATE MK_KTX_XAF_INFO'
      'SET'
      
        '  MIKEL_TX_ID = :MIKEL_TX_ID, TX_TYPE = :TX_TYPE, MK_GL_DATE = :' +
        'MK_GL_DATE, TX_NR = :TX_NR, CREATE_DATE = :CREATE_DATE'
      'WHERE'
      '  MIKEL_TX_ID = :Old_MIKEL_TX_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_KTX_XAF_INFO'
      'WHERE'
      'MIKEL_TX_ID = :Old_MIKEL_TX_ID'
      'FOR UPDATE WITH LOCK')
    SQLRefresh.Strings = (
      
        'SELECT MIKEL_TX_ID, TX_TYPE, MK_GL_DATE, TX_NR, CREATE_DATE FROM' +
        ' MK_KTX_XAF_INFO'
      'WHERE'
      '  MIKEL_TX_ID = :MIKEL_TX_ID')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM MK_KTX_XAF_INFO'
      ''
      ') q')
    Connection = dmFBZakelijk.connFBZakelijk
    SQL.Strings = (
      'select mikel_tx_id, tx_type, mk_gl_date, tx_nr, create_date'
      'from mk_ktx_xaf_info')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'MK_GL_DATE'
    Left = 280
    Top = 536
    object qryKnabInfoMIKEL_TX_ID: TStringField
      FieldName = 'MIKEL_TX_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 120
    end
    object qryKnabInfoTX_TYPE: TStringField
      FieldName = 'TX_TYPE'
      Required = True
      Size = 2
    end
    object qryKnabInfoMK_GL_DATE: TDateField
      FieldName = 'MK_GL_DATE'
      Required = True
    end
    object qryKnabInfoTX_NR: TIntegerField
      FieldName = 'TX_NR'
    end
    object qryKnabInfoCREATE_DATE: TDateTimeField
      FieldName = 'CREATE_DATE'
      Required = True
    end
  end
  object qryKnabGL: TUniQuery
    UpdatingTable = 'MK_KTX_GL_INFO'
    KeyFields = 'mikel_tx_id;gl_code;btw_perc'
    SQLInsert.Strings = (
      'INSERT INTO MK_KTX_GL_INFO'
      
        '  (MIKEL_TX_ID, GL_CODE, BTW_PERC, GL_AMOUNT, TX_REMARK, CREATE_' +
        'DATE)'
      'VALUES'
      
        '  (:MIKEL_TX_ID, :GL_CODE, :BTW_PERC, :GL_AMOUNT, :TX_REMARK, :C' +
        'REATE_DATE)')
    SQLDelete.Strings = (
      'DELETE FROM MK_KTX_GL_INFO'
      'WHERE'
      
        '  MIKEL_TX_ID = :Old_MIKEL_TX_ID AND GL_CODE = :Old_GL_CODE AND ' +
        'BTW_PERC = :Old_BTW_PERC')
    SQLUpdate.Strings = (
      'UPDATE MK_KTX_GL_INFO'
      'SET'
      
        '  MIKEL_TX_ID = :MIKEL_TX_ID, GL_CODE = :GL_CODE, BTW_PERC = :BT' +
        'W_PERC, GL_AMOUNT = :GL_AMOUNT, TX_REMARK = :TX_REMARK, CREATE_D' +
        'ATE = :CREATE_DATE'
      'WHERE'
      
        '  MIKEL_TX_ID = :Old_MIKEL_TX_ID AND GL_CODE = :Old_GL_CODE AND ' +
        'BTW_PERC = :Old_BTW_PERC')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_KTX_GL_INFO'
      'WHERE'
      
        'MIKEL_TX_ID = :Old_MIKEL_TX_ID AND GL_CODE = :Old_GL_CODE AND BT' +
        'W_PERC = :Old_BTW_PERC'
      'FOR UPDATE WITH LOCK')
    SQLRefresh.Strings = (
      
        'SELECT MIKEL_TX_ID, GL_CODE, BTW_PERC, GL_AMOUNT, TX_REMARK, CRE' +
        'ATE_DATE FROM MK_KTX_GL_INFO'
      'WHERE'
      
        '  MIKEL_TX_ID = :MIKEL_TX_ID AND GL_CODE = :GL_CODE AND BTW_PERC' +
        ' = :BTW_PERC')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM MK_KTX_GL_INFO'
      ''
      ') q')
    Connection = dmFBZakelijk.connFBZakelijk
    SQL.Strings = (
      
        'select mikel_tx_id, gl_code, btw_perc, gl_amount, tx_remark, cre' +
        'ate_date'
      'from mk_ktx_gl_info')
    IndexFieldNames = 'mikel_tx_id'
    Left = 544
    Top = 536
    object qryKnabGLMIKEL_TX_ID: TStringField
      FieldName = 'MIKEL_TX_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 120
    end
    object qryKnabGLGL_CODE: TStringField
      FieldName = 'GL_CODE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryKnabGLBTW_PERC: TFloatField
      FieldName = 'BTW_PERC'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryKnabGLGL_AMOUNT: TFloatField
      FieldName = 'GL_AMOUNT'
      Required = True
    end
    object qryKnabGLTX_REMARK: TStringField
      FieldName = 'TX_REMARK'
      Size = 200
    end
    object qryKnabGLCREATE_DATE: TDateTimeField
      FieldName = 'CREATE_DATE'
      Required = True
    end
  end
  object qryOraKtx: TUniQuery
    UpdatingTable = 'MK_KTX'
    KeyFields = 'mikel_tx_id'
    SQLInsert.Strings = (
      'INSERT INTO MK_KTX'
      
        '  (IBAN, TX_DATUM, VALUTA_CODE, CREDIT_DEBET, BEDRAG, TEGEN_IBAN' +
        ', TEGEN_NAAM, VALUTA_DATUM, BETAALWIJZE, OMSCHRIJVING, TYPE_BETA' +
        'LING, MACHTIGINGSKENMERK, INCASSANT_ID, ADRES, TX_REFERENTIE, BO' +
        'EK_DATUM, MIKEL_TX_ID, CREATE_DATE)'
      'VALUES'
      
        '  (:IBAN, :TX_DATUM, :VALUTA_CODE, :CREDIT_DEBET, :BEDRAG, :TEGE' +
        'N_IBAN, :TEGEN_NAAM, :VALUTA_DATUM, :BETAALWIJZE, :OMSCHRIJVING,' +
        ' :TYPE_BETALING, :MACHTIGINGSKENMERK, :INCASSANT_ID, :ADRES, :TX' +
        '_REFERENTIE, :BOEK_DATUM, :MIKEL_TX_ID, :CREATE_DATE)')
    SQLDelete.Strings = (
      'DELETE FROM MK_KTX'
      'WHERE'
      '  MIKEL_TX_ID = :Old_MIKEL_TX_ID')
    SQLUpdate.Strings = (
      'UPDATE MK_KTX'
      'SET'
      
        '  IBAN = :IBAN, TX_DATUM = :TX_DATUM, VALUTA_CODE = :VALUTA_CODE' +
        ', CREDIT_DEBET = :CREDIT_DEBET, BEDRAG = :BEDRAG, TEGEN_IBAN = :' +
        'TEGEN_IBAN, TEGEN_NAAM = :TEGEN_NAAM, VALUTA_DATUM = :VALUTA_DAT' +
        'UM, BETAALWIJZE = :BETAALWIJZE, OMSCHRIJVING = :OMSCHRIJVING, TY' +
        'PE_BETALING = :TYPE_BETALING, MACHTIGINGSKENMERK = :MACHTIGINGSK' +
        'ENMERK, INCASSANT_ID = :INCASSANT_ID, ADRES = :ADRES, TX_REFEREN' +
        'TIE = :TX_REFERENTIE, BOEK_DATUM = :BOEK_DATUM, MIKEL_TX_ID = :M' +
        'IKEL_TX_ID, CREATE_DATE = :CREATE_DATE'
      'WHERE'
      '  MIKEL_TX_ID = :Old_MIKEL_TX_ID')
    SQLLock.Strings = (
      
        'SELECT IBAN, TX_DATUM, VALUTA_CODE, CREDIT_DEBET, BEDRAG, TEGEN_' +
        'IBAN, TEGEN_NAAM, VALUTA_DATUM, BETAALWIJZE, OMSCHRIJVING, TYPE_' +
        'BETALING, MACHTIGINGSKENMERK, INCASSANT_ID, ADRES, TX_REFERENTIE' +
        ', BOEK_DATUM, MIKEL_TX_ID, CREATE_DATE FROM MK_KTX'
      'WHERE'
      '  MIKEL_TX_ID = :Old_MIKEL_TX_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT IBAN, TX_DATUM, VALUTA_CODE, CREDIT_DEBET, BEDRAG, TEGEN_' +
        'IBAN, TEGEN_NAAM, VALUTA_DATUM, BETAALWIJZE, OMSCHRIJVING, TYPE_' +
        'BETALING, MACHTIGINGSKENMERK, INCASSANT_ID, ADRES, TX_REFERENTIE' +
        ', BOEK_DATUM, MIKEL_TX_ID, CREATE_DATE FROM MK_KTX'
      'WHERE'
      '  MIKEL_TX_ID = :MIKEL_TX_ID')
    SQLRecCount.Strings = (
      'SELECT Count(*) FROM ('
      'SELECT * FROM MK_KTX'
      ''
      ')')
    Connection = dmFBZakelijk.connOraZakelijk
    SQL.Strings = (
      
        'select iban, tx_datum, valuta_code, credit_debet, bedrag, tegen_' +
        'iban'
      
        ', tegen_naam, valuta_datum, betaalwijze, omschrijving, type_beta' +
        'ling'
      
        ', machtigingskenmerk, incassant_id, adres, tx_referentie, boek_d' +
        'atum'
      ', mikel_tx_id, create_date'
      'from mk_ktx'
      '')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'boek_datum'
    Left = 136
    Top = 520
    object qryOraKtxIBAN: TStringField
      FieldName = 'IBAN'
      Required = True
      Size = 255
    end
    object qryOraKtxTX_DATUM: TDateTimeField
      FieldName = 'TX_DATUM'
    end
    object qryOraKtxVALUTA_CODE: TStringField
      FieldName = 'VALUTA_CODE'
      Size = 255
    end
    object qryOraKtxCREDIT_DEBET: TStringField
      FieldName = 'CREDIT_DEBET'
      Required = True
      Size = 2
    end
    object qryOraKtxBEDRAG: TFloatField
      FieldName = 'BEDRAG'
      Required = True
    end
    object qryOraKtxTEGEN_IBAN: TStringField
      FieldName = 'TEGEN_IBAN'
      Size = 255
    end
    object qryOraKtxTEGEN_NAAM: TStringField
      FieldName = 'TEGEN_NAAM'
      Size = 255
    end
    object qryOraKtxVALUTA_DATUM: TDateTimeField
      FieldName = 'VALUTA_DATUM'
    end
    object qryOraKtxBETAALWIJZE: TStringField
      FieldName = 'BETAALWIJZE'
      Size = 255
    end
    object qryOraKtxOMSCHRIJVING: TStringField
      FieldName = 'OMSCHRIJVING'
      Size = 255
    end
    object qryOraKtxTYPE_BETALING: TStringField
      FieldName = 'TYPE_BETALING'
      Size = 255
    end
    object qryOraKtxMACHTIGINGSKENMERK: TStringField
      FieldName = 'MACHTIGINGSKENMERK'
      Size = 255
    end
    object qryOraKtxINCASSANT_ID: TStringField
      FieldName = 'INCASSANT_ID'
      Size = 255
    end
    object qryOraKtxADRES: TStringField
      FieldName = 'ADRES'
      Size = 255
    end
    object qryOraKtxTX_REFERENTIE: TStringField
      FieldName = 'TX_REFERENTIE'
      Required = True
      Size = 255
    end
    object qryOraKtxBOEK_DATUM: TDateTimeField
      FieldName = 'BOEK_DATUM'
    end
    object qryOraKtxMIKEL_TX_ID: TStringField
      FieldName = 'MIKEL_TX_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 255
    end
    object qryOraKtxCREATE_DATE: TSQLTimeStampField
      FieldName = 'CREATE_DATE'
      Required = True
    end
  end
  object qryOraKtxInfo: TUniQuery
    UpdatingTable = 'MK_KTX_XAF_INFO'
    KeyFields = 'mikel_tx_id'
    SQLInsert.Strings = (
      'INSERT INTO MK_KTX_XAF_INFO'
      '  (MIKEL_TX_ID, TX_TYPE, MK_GL_DATE, TX_NR, CREATE_DATE)'
      'VALUES'
      '  (:MIKEL_TX_ID, :TX_TYPE, :MK_GL_DATE, :TX_NR, :CREATE_DATE)')
    SQLDelete.Strings = (
      'DELETE FROM MK_KTX_XAF_INFO'
      'WHERE'
      '  MIKEL_TX_ID = :Old_MIKEL_TX_ID')
    SQLUpdate.Strings = (
      'UPDATE MK_KTX_XAF_INFO'
      'SET'
      
        '  MIKEL_TX_ID = :MIKEL_TX_ID, TX_TYPE = :TX_TYPE, MK_GL_DATE = :' +
        'MK_GL_DATE, TX_NR = :TX_NR, CREATE_DATE = :CREATE_DATE'
      'WHERE'
      '  MIKEL_TX_ID = :Old_MIKEL_TX_ID')
    SQLLock.Strings = (
      
        'SELECT MIKEL_TX_ID, TX_TYPE, MK_GL_DATE, TX_NR, CREATE_DATE FROM' +
        ' MK_KTX_XAF_INFO'
      'WHERE'
      '  MIKEL_TX_ID = :Old_MIKEL_TX_ID'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT MIKEL_TX_ID, TX_TYPE, MK_GL_DATE, TX_NR, CREATE_DATE FROM' +
        ' MK_KTX_XAF_INFO'
      'WHERE'
      '  MIKEL_TX_ID = :MIKEL_TX_ID')
    SQLRecCount.Strings = (
      'SELECT Count(*) FROM ('
      'SELECT * FROM MK_KTX_XAF_INFO'
      ''
      ')')
    Connection = dmFBZakelijk.connOraZakelijk
    SQL.Strings = (
      'select mikel_tx_id, tx_type, mk_gl_date, tx_nr, create_date'
      'from mk_ktx_xaf_info')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'MK_GL_DATE'
    Left = 392
    Top = 536
    object qryOraKtxInfoMIKEL_TX_ID: TStringField
      FieldName = 'MIKEL_TX_ID'
      Required = True
      Size = 255
    end
    object qryOraKtxInfoTX_TYPE: TStringField
      FieldName = 'TX_TYPE'
      Required = True
      Size = 2
    end
    object qryOraKtxInfoMK_GL_DATE: TDateTimeField
      FieldName = 'MK_GL_DATE'
      Required = True
    end
    object qryOraKtxInfoTX_NR: TIntegerField
      FieldName = 'TX_NR'
    end
    object qryOraKtxInfoCREATE_DATE: TSQLTimeStampField
      FieldName = 'CREATE_DATE'
      Required = True
    end
  end
  object qryOraKtxGL: TUniQuery
    UpdatingTable = 'MK_KTX_GL_INFO'
    KeyFields = 'mikel_tx_id;gl_code;btw_perc'
    SQLInsert.Strings = (
      'INSERT INTO MK_KTX_GL_INFO'
      
        '  (MIKEL_TX_ID, GL_CODE, BTW_PERC, GL_AMOUNT, TX_REMARK, CREATE_' +
        'DATE)'
      'VALUES'
      
        '  (:MIKEL_TX_ID, :GL_CODE, :BTW_PERC, :GL_AMOUNT, :TX_REMARK, :C' +
        'REATE_DATE)')
    SQLDelete.Strings = (
      'DELETE FROM MK_KTX_GL_INFO'
      'WHERE'
      
        '  MIKEL_TX_ID = :Old_MIKEL_TX_ID AND GL_CODE = :Old_GL_CODE AND ' +
        'BTW_PERC = :Old_BTW_PERC')
    SQLUpdate.Strings = (
      'UPDATE MK_KTX_GL_INFO'
      'SET'
      
        '  MIKEL_TX_ID = :MIKEL_TX_ID, GL_CODE = :GL_CODE, BTW_PERC = :BT' +
        'W_PERC, GL_AMOUNT = :GL_AMOUNT, TX_REMARK = :TX_REMARK, CREATE_D' +
        'ATE = :CREATE_DATE'
      'WHERE'
      
        '  MIKEL_TX_ID = :Old_MIKEL_TX_ID AND GL_CODE = :Old_GL_CODE AND ' +
        'BTW_PERC = :Old_BTW_PERC')
    SQLLock.Strings = (
      
        'SELECT MIKEL_TX_ID, GL_CODE, BTW_PERC, GL_AMOUNT, TX_REMARK, CRE' +
        'ATE_DATE FROM MK_KTX_GL_INFO'
      'WHERE'
      
        '  MIKEL_TX_ID = :Old_MIKEL_TX_ID AND GL_CODE = :Old_GL_CODE AND ' +
        'BTW_PERC = :Old_BTW_PERC'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      
        'SELECT MIKEL_TX_ID, GL_CODE, BTW_PERC, GL_AMOUNT, TX_REMARK, CRE' +
        'ATE_DATE FROM MK_KTX_GL_INFO'
      'WHERE'
      
        '  MIKEL_TX_ID = :MIKEL_TX_ID AND GL_CODE = :GL_CODE AND BTW_PERC' +
        ' = :BTW_PERC')
    SQLRecCount.Strings = (
      'SELECT Count(*) FROM ('
      'SELECT * FROM MK_KTX_GL_INFO'
      ''
      ')')
    Connection = dmFBZakelijk.connOraZakelijk
    SQL.Strings = (
      
        'select mikel_tx_id, gl_code, btw_perc, gl_amount, tx_remark, cre' +
        'ate_date'
      'from mk_ktx_gl_info')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'MIKEL_TX_ID'
    Left = 656
    Top = 536
    object qryOraKtxGLMIKEL_TX_ID: TStringField
      FieldName = 'MIKEL_TX_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 255
    end
    object qryOraKtxGLGL_CODE: TStringField
      FieldName = 'GL_CODE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryOraKtxGLBTW_PERC: TFloatField
      FieldName = 'BTW_PERC'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryOraKtxGLGL_AMOUNT: TFloatField
      FieldName = 'GL_AMOUNT'
      Required = True
    end
    object qryOraKtxGLTX_REMARK: TStringField
      FieldName = 'TX_REMARK'
      Size = 200
    end
    object qryOraKtxGLCREATE_DATE: TSQLTimeStampField
      FieldName = 'CREATE_DATE'
      Required = True
    end
  end
  object qryOraRZtx: TUniQuery
    UpdatingTable = 'MK_RABO_ZTX'
    KeyFields = 'iban;valuta_code;seqno'
    Connection = dmFBZakelijk.connOraZakelijk
    SQL.Strings = (
      
        'select iban, valuta_code, bic, seqno, boek_Datum, valuta_datum, ' +
        'bedrag, saldo_na_boeking, tegen_iban, tegen_naam'
      
        '     , ultimate_naam, init_naam, tegen_bic, tx_type_code, batch_' +
        'id, tx_ref, mandate_ref, collector_id,  payment_ref'
      
        '     , desc_1, desc_2, desc_3, reason_code, instr_bedrag, instr_' +
        'valuta, koers, create_date'
      'from mk_rabo_ztx;')
    ReadOnly = True
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'iban;valuta_code;seqno'
    Left = 816
    Top = 184
    object qryOraRZtxIBAN: TStringField
      FieldName = 'IBAN'
      Required = True
      Size = 50
    end
    object qryOraRZtxVALUTA_CODE: TStringField
      FieldName = 'VALUTA_CODE'
      Required = True
      Size = 4
    end
    object qryOraRZtxBIC: TStringField
      FieldName = 'BIC'
      Size = 11
    end
    object qryOraRZtxSEQNO: TStringField
      FieldName = 'SEQNO'
      Required = True
      Size = 18
    end
    object qryOraRZtxBOEK_DATUM: TDateTimeField
      FieldName = 'BOEK_DATUM'
    end
    object qryOraRZtxVALUTA_DATUM: TDateTimeField
      FieldName = 'VALUTA_DATUM'
    end
    object qryOraRZtxBEDRAG: TFloatField
      FieldName = 'BEDRAG'
      Required = True
    end
    object qryOraRZtxSALDO_NA_BOEKING: TFloatField
      FieldName = 'SALDO_NA_BOEKING'
    end
    object qryOraRZtxTEGEN_IBAN: TStringField
      FieldName = 'TEGEN_IBAN'
      Size = 50
    end
    object qryOraRZtxTEGEN_NAAM: TStringField
      FieldName = 'TEGEN_NAAM'
      Size = 70
    end
    object qryOraRZtxULTIMATE_NAAM: TStringField
      FieldName = 'ULTIMATE_NAAM'
      Size = 70
    end
    object qryOraRZtxINIT_NAAM: TStringField
      FieldName = 'INIT_NAAM'
      Size = 70
    end
    object qryOraRZtxTEGEN_BIC: TStringField
      FieldName = 'TEGEN_BIC'
      Size = 15
    end
    object qryOraRZtxTX_TYPE_CODE: TStringField
      FieldName = 'TX_TYPE_CODE'
      Size = 4
    end
    object qryOraRZtxBATCH_ID: TStringField
      FieldName = 'BATCH_ID'
      Size = 35
    end
    object qryOraRZtxTX_REF: TStringField
      FieldName = 'TX_REF'
      Size = 35
    end
    object qryOraRZtxMANDATE_REF: TStringField
      FieldName = 'MANDATE_REF'
      Size = 35
    end
    object qryOraRZtxCOLLECTOR_ID: TStringField
      FieldName = 'COLLECTOR_ID'
      Size = 35
    end
    object qryOraRZtxPAYMENT_REF: TStringField
      FieldName = 'PAYMENT_REF'
      Size = 35
    end
    object qryOraRZtxDESC_1: TStringField
      FieldName = 'DESC_1'
      Size = 140
    end
    object qryOraRZtxDESC_2: TStringField
      FieldName = 'DESC_2'
      Size = 140
    end
    object qryOraRZtxDESC_3: TStringField
      FieldName = 'DESC_3'
      Size = 140
    end
    object qryOraRZtxREASON_CODE: TStringField
      FieldName = 'REASON_CODE'
      Size = 75
    end
    object qryOraRZtxINSTR_BEDRAG: TFloatField
      FieldName = 'INSTR_BEDRAG'
    end
    object qryOraRZtxINSTR_VALUTA: TStringField
      FieldName = 'INSTR_VALUTA'
      Size = 4
    end
    object qryOraRZtxKOERS: TFloatField
      FieldName = 'KOERS'
    end
    object qryOraRZtxCREATE_DATE: TSQLTimeStampField
      FieldName = 'CREATE_DATE'
      Required = True
    end
  end
  object qryOraRZinfo: TUniQuery
    UpdatingTable = 'MK_RABO_ZTX_XAF_INFO'
    KeyFields = 'iban;valuta_code;seqno'
    Connection = dmFBZakelijk.connOraZakelijk
    SQL.Strings = (
      
        'select iban, valuta_code, seqno, tx_type, mk_gl_date, tx_nr, cre' +
        'ate_date'
      'from    mk_rabo_ztx_xaf_info')
    ReadOnly = True
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'iban;valuta_code;seqno'
    Left = 816
    Top = 296
    object qryOraRZinfoIBAN: TStringField
      FieldName = 'IBAN'
      Required = True
      Size = 50
    end
    object qryOraRZinfoVALUTA_CODE: TStringField
      FieldName = 'VALUTA_CODE'
      Required = True
      Size = 4
    end
    object qryOraRZinfoSEQNO: TStringField
      FieldName = 'SEQNO'
      Required = True
      Size = 18
    end
    object qryOraRZinfoTX_TYPE: TStringField
      FieldName = 'TX_TYPE'
      Required = True
      Size = 2
    end
    object qryOraRZinfoMK_GL_DATE: TDateTimeField
      FieldName = 'MK_GL_DATE'
      Required = True
    end
    object qryOraRZinfoTX_NR: TIntegerField
      FieldName = 'TX_NR'
    end
    object qryOraRZinfoCREATE_DATE: TSQLTimeStampField
      FieldName = 'CREATE_DATE'
      Required = True
    end
  end
  object qryOraRZGL: TUniQuery
    UpdatingTable = 'MK_RABO_ZTX_GL_INFO'
    Connection = dmFBZakelijk.connOraZakelijk
    SQL.Strings = (
      
        'select iban, valuta_code, seqno, gl_code, btw_perc, gl_amount, t' +
        'x_remark, create_date'
      'from    mk_rabo_ztx_gl_info')
    ReadOnly = True
    Options.SetEmptyStrToNull = True
    Left = 816
    Top = 392
    object qryOraRZGLIBAN: TStringField
      FieldName = 'IBAN'
      Required = True
      Size = 50
    end
    object qryOraRZGLVALUTA_CODE: TStringField
      FieldName = 'VALUTA_CODE'
      Required = True
      Size = 4
    end
    object qryOraRZGLSEQNO: TStringField
      FieldName = 'SEQNO'
      Required = True
      Size = 18
    end
    object qryOraRZGLGL_CODE: TStringField
      FieldName = 'GL_CODE'
      Required = True
    end
    object qryOraRZGLBTW_PERC: TFloatField
      FieldName = 'BTW_PERC'
      Required = True
    end
    object qryOraRZGLGL_AMOUNT: TFloatField
      FieldName = 'GL_AMOUNT'
      Required = True
    end
    object qryOraRZGLTX_REMARK: TStringField
      FieldName = 'TX_REMARK'
      Size = 200
    end
    object qryOraRZGLCREATE_DATE: TSQLTimeStampField
      FieldName = 'CREATE_DATE'
      Required = True
    end
  end
end
