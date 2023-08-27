object frmTable: TfrmTable
  Left = 0
  Top = 0
  Caption = 'Mikel log'
  ClientHeight = 267
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object grdLog: TDBGrid
    Left = 24
    Top = 24
    Width = 577
    Height = 168
    DataSource = dsrcTable
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object btnRefresh: TButton
    Left = 472
    Top = 208
    Width = 91
    Height = 41
    Action = actRefresh
    TabOrder = 1
  end
  object ActionList1: TActionList
    Left = 272
    Top = 208
    object actRefresh: TAction
      Caption = 'Refresh'
      OnExecute = actRefreshExecute
    end
  end
  object dsrcTable: TUniDataSource
    Left = 136
    Top = 208
  end
end
