object dmFBZakelijk: TdmFBZakelijk
  Height = 354
  Width = 664
  PixelsPerInch = 120
  object connFBZakelijk: TUniConnection
    ProviderName = 'InterBase'
    SpecificOptions.Strings = (
      'InterBase.Charset=UTF8')
    ConnectDialog = uniDlgConnect
    OnLogin = connFBZakelijkLogin
    Left = 240
    Top = 32
  end
  object provFB: TInterBaseUniProvider
    Left = 96
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 448
    Top = 32
  end
  object qryImpRaboZak: TUniQuery
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
    Left = 248
    Top = 200
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
  object dsImpRaboZak: TUniDataSource
    DataSet = qryImpRaboZak
    Left = 376
    Top = 200
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
    Left = 552
    Top = 168
  end
end
