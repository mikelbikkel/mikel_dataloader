object dmOraZakelijk: TdmOraZakelijk
  Height = 300
  Width = 629
  PixelsPerInch = 120
  object provOra: TOracleUniProvider
    Left = 32
    Top = 16
  end
  object connOraZakelijk: TUniConnection
    ProviderName = 'Oracle'
    SpecificOptions.Strings = (
      'Oracle.Direct=True')
    LoginPrompt = False
    Left = 128
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 496
    Top = 144
  end
end
