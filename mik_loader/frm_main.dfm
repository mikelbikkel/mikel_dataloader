object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Mikel Loader'
  ClientHeight = 596
  ClientWidth = 837
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object lblConnected: TLabel
    Left = 416
    Top = 25
    Width = 97
    Height = 17
    Margins.Top = 8
    Alignment = taCenter
    AutoSize = False
    Color = clMaroon
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoBk
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    ShowAccelChar = False
    Transparent = False
  end
  object lblRead: TLabel
    Left = 29
    Top = 356
    Width = 29
    Height = 15
    Caption = 'Read:'
  end
  object lblWritten: TLabel
    Left = 149
    Top = 356
    Width = 42
    Height = 15
    Caption = 'Written:'
  end
  object lblInsert: TLabel
    Left = 306
    Top = 356
    Width = 35
    Height = 15
    Caption = 'Insert: '
  end
  object lblErrors: TLabel
    Left = 462
    Top = 356
    Width = 33
    Height = 15
    Caption = 'Errors:'
  end
  object btnConnect: TButton
    Left = 416
    Top = 48
    Width = 97
    Height = 41
    Action = actConnect
    TabOrder = 0
  end
  object btnLoadKnab: TButton
    Left = 159
    Top = 48
    Width = 97
    Height = 41
    Action = actLoadKnab
    TabOrder = 1
  end
  object btnLoadRabo: TButton
    Left = 278
    Top = 48
    Width = 97
    Height = 41
    Action = actLoadRabo
    TabOrder = 2
  end
  object grdFileData: TDBGrid
    Left = 8
    Top = 116
    Width = 737
    Height = 231
    DataSource = dsFileData
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object edtRead: TEdit
    Left = 64
    Top = 353
    Width = 41
    Height = 23
    ReadOnly = True
    TabOrder = 4
  end
  object edtWritten: TEdit
    Left = 197
    Top = 353
    Width = 41
    Height = 23
    ReadOnly = True
    TabOrder = 5
  end
  object edtInsert: TEdit
    Left = 347
    Top = 353
    Width = 41
    Height = 23
    ReadOnly = True
    TabOrder = 6
  end
  object edtErrors: TEdit
    Left = 501
    Top = 353
    Width = 41
    Height = 23
    ReadOnly = True
    TabOrder = 7
  end
  object rgLoadType: TRadioGroup
    Left = 8
    Top = 25
    Width = 129
    Height = 73
    Caption = 'Type of load'
    ItemIndex = 0
    Items.Strings = (
      'Test load'
      'Database load')
    TabOrder = 8
  end
  object btnShowLog: TButton
    Left = 536
    Top = 48
    Width = 75
    Height = 41
    Action = actShowLog
    TabOrder = 9
  end
  object btnExecRaboZak: TButton
    Left = 617
    Top = 48
    Width = 128
    Height = 41
    Action = actExecRaboZak
    TabOrder = 10
  end
  object btnExecKnabZak: TButton
    Left = 616
    Top = 8
    Width = 129
    Height = 33
    Action = actExecKnabZak
    TabOrder = 11
  end
  object btnXafCustomer: TButton
    Left = 640
    Top = 392
    Width = 105
    Height = 41
    Action = actShowXafCustomer
    TabOrder = 12
  end
  object btnShowOraCust: TButton
    Left = 506
    Top = 392
    Width = 105
    Height = 41
    Action = actShowOraCustomer
    TabOrder = 13
  end
  object btnCopyXAF: TButton
    Left = 336
    Top = 392
    Width = 113
    Height = 41
    Action = actCopyXAF
    TabOrder = 14
  end
  object lstLog: TListBox
    Left = 40
    Top = 392
    Width = 257
    Height = 129
    ItemHeight = 15
    TabOrder = 15
  end
  object Button1: TButton
    Left = 336
    Top = 464
    Width = 132
    Height = 41
    Action = actCopyKtx
    TabOrder = 16
  end
  object rgKnabCopyMode: TRadioGroup
    Left = 488
    Top = 464
    Width = 137
    Height = 73
    Caption = 'Knab Copy modus'
    ItemIndex = 0
    Items.Strings = (
      'Replace all'
      'Append new')
    TabOrder = 17
  end
  object Button2: TButton
    Left = 672
    Top = 496
    Width = 73
    Height = 41
    Action = actCopyRZ
    TabOrder = 18
  end
  object alMain: TActionList
    Left = 256
    Top = 16
    object actConnect: TAction
      Caption = 'Connect'
      OnExecute = actConnectExecute
    end
    object actLoadKnab: TAction
      Caption = 'Load KNAB'
      OnExecute = actLoadKnabExecute
    end
    object actLoadRabo: TAction
      Caption = 'Load Rabo'
      OnExecute = actLoadRaboExecute
    end
    object actShowLog: TAction
      Caption = 'Show Log'
      OnExecute = actShowLogExecute
    end
    object actExecRaboZak: TAction
      Caption = 'Import Rabo Zakelijk'
      OnExecute = actExecRaboZakExecute
    end
    object actExecKnabZak: TAction
      Caption = 'Import Knab Zakelijk'
      OnExecute = actExecKnabZakExecute
    end
    object actShowXafCustomer: TAction
      Caption = 'XAF Customer'
      OnExecute = actShowXafCustomerExecute
    end
    object actShowOraCustomer: TAction
      Caption = 'Ora Customer'
      OnExecute = actShowOraCustomerExecute
    end
    object actCopyXAF: TAction
      Caption = 'Copy XAF data'
      OnExecute = actCopyXAFExecute
    end
    object actCopyKtx: TAction
      Caption = 'Copy Knab transactions'
      OnExecute = actCopyKtxExecute
    end
    object actCopyRZ: TAction
      Caption = 'Copy RZ'
      OnExecute = actCopyRZExecute
    end
  end
  object vtFileData: TVirtualTable
    Left = 96
    Top = 16
    Data = {04000000000000000000}
  end
  object dsFileData: TUniDataSource
    DataSet = vtFileData
    Left = 152
    Top = 16
  end
  object dlgOpen: TOpenDialog
    Filter = 'Text files|*.txt|Data files|*.dat'
    InitialDir = 'C:\mikel\aaa_data'
    Left = 320
    Top = 32
  end
end
