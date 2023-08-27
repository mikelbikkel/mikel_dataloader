object dmFBZakelijk: TdmFBZakelijk
  Height = 477
  Width = 714
  PixelsPerInch = 120
  object connFBZakelijk: TUniConnection
    AutoCommit = False
    ProviderName = 'InterBase'
    Database = 'zakboek'
    SpecificOptions.Strings = (
      'InterBase.Charset=UTF8')
    Options.AllowImplicitConnect = False
    Options.KeepDesignConnected = False
    Username = 'mikel'
    Server = 'localhost'
    ConnectDialog = uniDlgConnect
    LoginPrompt = False
    OnLogin = connFBZakelijkLogin
    Left = 136
    Top = 32
    EncryptedPassword = 'B2FF96FF9CFF97FF9AFFB3FFC9FFC9FF'
  end
  object provFB: TInterBaseUniProvider
    Left = 48
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 448
    Top = 32
  end
  object qryImpRaboZak: TUniQuery
    KeyFields = 'iban;valuta_code;seqno'
    Connection = connFBZakelijk
    SQL.Strings = (
      
        'select iban, valuta_code, bic, seqno, boek_datum, valuta_datum, ' +
        'bedrag, saldo_na_boeking'
      
        ', tegen_iban, tegen_naam, ultimate_naam, init_naam, tegen_bic, t' +
        'x_type_code, batch_id'
      
        ', tx_ref, mandate_ref, collector_id, payment_ref, desc_1, desc_2' +
        ', desc_3, reason_code'
      ', instr_bedrag, instr_valuta, koers'
      'from imp_rabo_ztx')
    Debug = True
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'valuta_datum'
    Left = 56
    Top = 232
    object qryImpRaboZakIBAN: TStringField
      FieldName = 'IBAN'
      Required = True
      Size = 50
    end
    object qryImpRaboZakVALUTA_CODE: TStringField
      FieldName = 'VALUTA_CODE'
      Required = True
      Size = 4
    end
    object qryImpRaboZakBIC: TStringField
      FieldName = 'BIC'
      Size = 11
    end
    object qryImpRaboZakSEQNO: TStringField
      FieldName = 'SEQNO'
      Required = True
      Size = 18
    end
    object qryImpRaboZakBOEK_DATUM: TDateField
      FieldName = 'BOEK_DATUM'
    end
    object qryImpRaboZakVALUTA_DATUM: TDateField
      FieldName = 'VALUTA_DATUM'
    end
    object qryImpRaboZakBEDRAG: TFloatField
      FieldName = 'BEDRAG'
      Required = True
    end
    object qryImpRaboZakSALDO_NA_BOEKING: TFloatField
      FieldName = 'SALDO_NA_BOEKING'
    end
    object qryImpRaboZakTEGEN_IBAN: TStringField
      FieldName = 'TEGEN_IBAN'
      Size = 50
    end
    object qryImpRaboZakTEGEN_NAAM: TStringField
      FieldName = 'TEGEN_NAAM'
      Size = 70
    end
    object qryImpRaboZakULTIMATE_NAAM: TStringField
      FieldName = 'ULTIMATE_NAAM'
      Size = 70
    end
    object qryImpRaboZakINIT_NAAM: TStringField
      FieldName = 'INIT_NAAM'
      Size = 70
    end
    object qryImpRaboZakTEGEN_BIC: TStringField
      FieldName = 'TEGEN_BIC'
      Size = 15
    end
    object qryImpRaboZakTX_TYPE_CODE: TStringField
      FieldName = 'TX_TYPE_CODE'
      Size = 4
    end
    object qryImpRaboZakBATCH_ID: TStringField
      FieldName = 'BATCH_ID'
      Size = 35
    end
    object qryImpRaboZakTX_REF: TStringField
      FieldName = 'TX_REF'
      Size = 35
    end
    object qryImpRaboZakMANDATE_REF: TStringField
      FieldName = 'MANDATE_REF'
      Size = 35
    end
    object qryImpRaboZakCOLLECTOR_ID: TStringField
      FieldName = 'COLLECTOR_ID'
      Size = 35
    end
    object qryImpRaboZakPAYMENT_REF: TStringField
      FieldName = 'PAYMENT_REF'
      Size = 35
    end
    object qryImpRaboZakDESC_1: TStringField
      FieldName = 'DESC_1'
      Size = 140
    end
    object qryImpRaboZakDESC_2: TStringField
      FieldName = 'DESC_2'
      Size = 140
    end
    object qryImpRaboZakDESC_3: TStringField
      FieldName = 'DESC_3'
      Size = 140
    end
    object qryImpRaboZakREASON_CODE: TStringField
      FieldName = 'REASON_CODE'
      Size = 75
    end
    object qryImpRaboZakINSTR_BEDRAG: TFloatField
      FieldName = 'INSTR_BEDRAG'
    end
    object qryImpRaboZakINSTR_VALUTA: TStringField
      FieldName = 'INSTR_VALUTA'
      Size = 4
    end
    object qryImpRaboZakKOERS: TFloatField
      FieldName = 'KOERS'
    end
  end
  object uniDlgConnect: TUniConnectDialog
    DatabaseLabel = 'Database'
    PortLabel = 'Port'
    ProviderLabel = 'Provider'
    Caption = 'Connect'
    UsernameLabel = 'User Name'
    PasswordLabel = 'Password'
    ServerLabel = 'Server'
    ConnectButton = 'Connect'
    CancelButton = 'Cancel'
    StoreLogInfo = False
    Left = 288
    Top = 32
  end
  object qryImpKnab: TUniQuery
    KeyFields = 'iban;tx_referentie;betaalwijze'
    SQLInsert.Strings = (
      'INSERT INTO IMP_MK_KTX'
      
        '  (IBAN, TX_DATUM, VALUTA_CODE, CREDIT_DEBET, BEDRAG, TEGEN_IBAN' +
        ', TEGEN_NAAM, VALUTA_DATUM, BETAALWIJZE, OMSCHRIJVING, TYPE_BETA' +
        'LING, MACHTIGINGSKENMERK, INCASSANT_ID, ADRES, TX_REFERENTIE, BO' +
        'EK_DATUM)'
      'VALUES'
      
        '  (:IBAN, :TX_DATUM, :VALUTA_CODE, :CREDIT_DEBET, :BEDRAG, :TEGE' +
        'N_IBAN, :TEGEN_NAAM, :VALUTA_DATUM, :BETAALWIJZE, :OMSCHRIJVING,' +
        ' :TYPE_BETALING, :MACHTIGINGSKENMERK, :INCASSANT_ID, :ADRES, :TX' +
        '_REFERENTIE, :BOEK_DATUM)')
    SQLUpdate.Strings = (
      'UPDATE IMP_MK_KTX'
      'SET'
      
        '  IBAN = :IBAN, TX_DATUM = :TX_DATUM, VALUTA_CODE = :VALUTA_CODE' +
        ', CREDIT_DEBET = :CREDIT_DEBET, BEDRAG = :BEDRAG, TEGEN_IBAN = :' +
        'TEGEN_IBAN, TEGEN_NAAM = :TEGEN_NAAM, VALUTA_DATUM = :VALUTA_DAT' +
        'UM, BETAALWIJZE = :BETAALWIJZE, OMSCHRIJVING = :OMSCHRIJVING, TY' +
        'PE_BETALING = :TYPE_BETALING, MACHTIGINGSKENMERK = :MACHTIGINGSK' +
        'ENMERK, INCASSANT_ID = :INCASSANT_ID, ADRES = :ADRES, TX_REFEREN' +
        'TIE = :TX_REFERENTIE, BOEK_DATUM = :BOEK_DATUM'
      'WHERE'
      
        '  IBAN = :Old_IBAN AND TX_REFERENTIE = :Old_TX_REFERENTIE AND BE' +
        'TAALWIJZE = :Old_BETAALWIJZE')
    SQLRefresh.Strings = (
      
        'SELECT IBAN, TX_DATUM, VALUTA_CODE, CREDIT_DEBET, BEDRAG, TEGEN_' +
        'IBAN, TEGEN_NAAM, VALUTA_DATUM, BETAALWIJZE, OMSCHRIJVING, TYPE_' +
        'BETALING, MACHTIGINGSKENMERK, INCASSANT_ID, ADRES, TX_REFERENTIE' +
        ', BOEK_DATUM FROM IMP_MK_KTX'
      'WHERE'
      
        '  IBAN = :IBAN AND TX_REFERENTIE = :TX_REFERENTIE AND BETAALWIJZ' +
        'E = :BETAALWIJZE')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM IMP_MK_KTX'
      ''
      ') q')
    Connection = connFBZakelijk
    SQL.Strings = (
      
        'select iban, tx_datum, valuta_code, credit_debet, bedrag, tegen_' +
        'iban'
      ', tegen_naam, valuta_datum, betaalwijze, omschrijving'
      
        ', type_betaling, machtigingskenmerk, incassant_id, adres, tx_ref' +
        'erentie, boek_datum'
      'from imp_mk_ktx')
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'valuta_datum'
    Left = 56
    Top = 328
    object qryImpKnabIBAN: TStringField
      FieldName = 'IBAN'
      Required = True
      Size = 50
    end
    object qryImpKnabTX_DATUM: TDateField
      FieldName = 'TX_DATUM'
    end
    object qryImpKnabVALUTA_CODE: TStringField
      FieldName = 'VALUTA_CODE'
      Size = 3
    end
    object qryImpKnabCREDIT_DEBET: TStringField
      FieldName = 'CREDIT_DEBET'
      Required = True
      Size = 2
    end
    object qryImpKnabBEDRAG: TFloatField
      FieldName = 'BEDRAG'
      Required = True
    end
    object qryImpKnabTEGEN_IBAN: TStringField
      FieldName = 'TEGEN_IBAN'
      Size = 50
    end
    object qryImpKnabTEGEN_NAAM: TStringField
      FieldName = 'TEGEN_NAAM'
      Size = 255
    end
    object qryImpKnabVALUTA_DATUM: TDateField
      FieldName = 'VALUTA_DATUM'
    end
    object qryImpKnabBETAALWIJZE: TStringField
      FieldName = 'BETAALWIJZE'
      Required = True
      Size = 40
    end
    object qryImpKnabOMSCHRIJVING: TStringField
      FieldName = 'OMSCHRIJVING'
      Size = 255
    end
    object qryImpKnabTYPE_BETALING: TStringField
      FieldName = 'TYPE_BETALING'
      Size = 255
    end
    object qryImpKnabMACHTIGINGSKENMERK: TStringField
      FieldName = 'MACHTIGINGSKENMERK'
      Size = 255
    end
    object qryImpKnabINCASSANT_ID: TStringField
      FieldName = 'INCASSANT_ID'
      Size = 255
    end
    object qryImpKnabADRES: TStringField
      FieldName = 'ADRES'
      Size = 70
    end
    object qryImpKnabTX_REFERENTIE: TStringField
      FieldName = 'TX_REFERENTIE'
      Required = True
    end
    object qryImpKnabBOEK_DATUM: TDateField
      FieldName = 'BOEK_DATUM'
    end
  end
  object qryLog: TUniQuery
    KeyFields = 'LOG_ID'
    Connection = connFBZakelijk
    SQL.Strings = (
      'select log_id, log_ts, log_module, log_message from mikel_log')
    Debug = True
    ReadOnly = True
    Options.SetEmptyStrToNull = True
    IndexFieldNames = 'LOG_TS DESC'
    Left = 48
    Top = 408
    object qryLogLOG_ID: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'LOG_ID'
      Required = True
    end
    object qryLogLOG_TS: TDateTimeField
      DisplayLabel = 'Timestamp'
      FieldName = 'LOG_TS'
      Required = True
    end
    object qryLogLOG_MODULE: TStringField
      DisplayLabel = 'Module'
      DisplayWidth = 25
      FieldName = 'LOG_MODULE'
      Required = True
      Size = 75
    end
    object qryLogLOG_MESSAGE: TStringField
      DisplayLabel = 'Message'
      FieldName = 'LOG_MESSAGE'
      Required = True
      Size = 200
    end
  end
  object execLoadRaboZak: TUniStoredProc
    StoredProcName = 'MK_PKG_RABO.IMPORT_RABO_ZTX'
    SQL.Strings = (
      'EXECUTE PROCEDURE MK_PKG_RABO.IMPORT_RABO_ZTX')
    Connection = connFBZakelijk
    Left = 480
    Top = 368
    CommandStoredProcName = 'MK_PKG_RABO.IMPORT_RABO_ZTX'
  end
  object uniMonitor: TUniSQLMonitor
    Options = [moDBMonitor]
    Left = 336
    Top = 352
  end
  object execLoadKnabZak: TUniStoredProc
    StoredProcName = 'MK_PKG_KNAB.IMPORT_KNAB_ZTX'
    SQL.Strings = (
      'EXECUTE PROCEDURE MK_PKG_KNAB.IMPORT_KNAB_ZTX')
    Connection = connFBZakelijk
    Left = 528
    Top = 296
    CommandStoredProcName = 'MK_PKG_KNAB.IMPORT_KNAB_ZTX'
  end
  object provOra: TOracleUniProvider
    Left = 48
    Top = 120
  end
  object connOraZakelijk: TUniConnection
    AutoCommit = False
    ProviderName = 'Oracle'
    SpecificOptions.Strings = (
      'Oracle.Direct=True')
    Options.AllowImplicitConnect = False
    Options.KeepDesignConnected = False
    Username = 'mikel'
    Server = 'mikel-zen:1521/XEPDB1'
    ConnectDialog = uniDlgConnect
    LoginPrompt = False
    Left = 144
    Top = 120
  end
end
