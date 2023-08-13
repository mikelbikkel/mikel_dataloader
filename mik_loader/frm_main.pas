{ ******************************************************************************

  Copyright (c) 2023 M van Delft.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

  ******************************************************************************* }
unit frm_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Actions,
  Vcl.ActnList, Data.DB, Vcl.Grids, Vcl.DBGrids, DBAccess, Uni, MemDS,
  VirtualTable, FireDAC.Stan.Intf, FireDAC.Comp.BatchMove, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.ExtCtrls;

type
  TfrmMain = class(TForm)
    alMain: TActionList;
    actConnect: TAction;
    actLoadKnab: TAction;
    actLoadRabo: TAction;
    btnConnect: TButton;
    btnLoadKnab: TButton;
    btnLoadRabo: TButton;
    lblConnected: TLabel;
    bmLoader: TFDBatchMove;
    vtFileData: TVirtualTable;
    dsFileData: TUniDataSource;
    grdFileData: TDBGrid;
    dlgOpen: TOpenDialog;
    edtRead: TEdit;
    edtWritten: TEdit;
    edtInsert: TEdit;
    edtErrors: TEdit;
    lblRead: TLabel;
    lblWritten: TLabel;
    lblInsert: TLabel;
    lblErrors: TLabel;
    rgLoadType: TRadioGroup;
    btnShowLog: TButton;
    actShowLog: TAction;
    actExecRaboZak: TAction;
    btnExecRaboZak: TButton;
    actExecKnabZak: TAction;
    btnExecKnabZak: TButton;
    actShowXafCustomer: TAction;
    btnXafCustomer: TButton;
    procedure actConnectExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actLoadRaboExecute(Sender: TObject);
    procedure actLoadKnabExecute(Sender: TObject);
    procedure actShowLogExecute(Sender: TObject);
    procedure actExecRaboZakExecute(Sender: TObject);
    procedure actExecKnabZakExecute(Sender: TObject);
    procedure actShowXafCustomerExecute(Sender: TObject);
  private
    { Private declarations }
    procedure LoadConfig;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

  { ============================================================================ }
implementation

uses dm_fb_zakelijk, file_loader, frm_table;
{$R *.dfm}

type

  TConfig = class
  strict private
    Fcfg: TStringList;
    function getServer: string;
    function getHuis: string;
    function getTuin: string;
    function getPop: string;
    function getSpeelTuin: string;
  public
    constructor Create;
    destructor Destroy; override;
    property Server: string read getServer;
    property Huis: string read getHuis;
    property Tuin: string read getTuin;
    property Pop: string read getPop;
    property Speeltuin: string read getSpeelTuin;
  end;

  { ============================================================================ }
{$REGION 'TfrmMain'}

procedure TfrmMain.actConnectExecute(Sender: TObject);
begin
  LoadConfig;
  dmFBZakelijk.connected := true;
  lblConnected.Color := clGreen;
end;

procedure TfrmMain.actExecKnabZakExecute(Sender: TObject);
begin
  dmFBZakelijk.procKnabZakelijk;
end;

procedure TfrmMain.actExecRaboZakExecute(Sender: TObject);
begin
  dmFBZakelijk.procRaboZakelijk;
end;

procedure TfrmMain.actLoadKnabExecute(Sender: TObject);
var
  info: TLoadInfo;
  res: TLoadResult;
  ldr: TFileLoader;
begin
  edtRead.Text := EmptyStr;
  edtWritten.Text := EmptyStr;
  edtInsert.Text := EmptyStr;
  edtErrors.Text := EmptyStr;
  res := nil;
  info := nil;
  ldr := nil;
  info := TLoadInfo.Create;
  if dlgOpen.Execute then
    info.filename := dlgOpen.filename
  else
    Exit;

  case rgLoadType.ItemIndex of
    0:
      begin { Test load }
        ldr := TFileLoader.Create(bmLoader, vtFileData, true);
        grdFileData.DataSource := dsFileData;
      end;
    1:
      begin { Database load }
        if not dmFBZakelijk.connected then
          Exit;
        ldr := TFileLoader.Create(bmLoader, dmFBZakelijk.dsetKnabImp, true);
        grdFileData.DataSource := dmFBZakelijk.dsImpKnab;
      end;
  else
    begin
      Exit;
    end;
  end;

  try
    info.Separator := ';';
    info.DateFormat := 'dd-mm-yyyy';

    { File format: CSV, Knab zakelijk. }
    ldr.SetFileInfo(info);
    ldr.AddField('iban', sftString, 34);
    ldr.AddField('tx_datum', sftDate);
    ldr.AddField('valuta_code', sftString, 4);
    ldr.AddField('credit_debet', sftString, 3);
    ldr.AddField('bedrag', sftNumber);
    ldr.AddField('tegen_iban', sftString, 34);
    ldr.AddField('tegen_naam', sftString);
    ldr.AddField('valuta_datum', sftDate);
    ldr.AddField('betaalwijze', sftString);
    ldr.AddField('omschrijving', sftString);
    ldr.AddField('type_betaling', sftString);
    ldr.AddField('machtigingskenmerk', sftString);
    ldr.AddField('incassant_id', sftString);
    ldr.AddField('adres', sftString);
    ldr.AddField('tx_referentie', sftString);
    ldr.AddField('boek_datum', sftDate);

    res := ldr.LoadFile;
    edtRead.Text := IntToStr(res.FReadCount);
    edtWritten.Text := IntToStr(res.FWriteCount);
    edtInsert.Text := IntToStr(res.FInsertCount);
    edtErrors.Text := IntToStr(res.FErrorCount);
  finally
    if Assigned(res) then
      res.Free;
    if Assigned(info) then
      info.Free;
    if Assigned(ldr) then
      ldr.Free;
  end;

end;

procedure TfrmMain.actLoadRaboExecute(Sender: TObject);
var
  info: TLoadInfo;
  res: TLoadResult;
  ldr: TFileLoader;
begin
  edtRead.Text := EmptyStr;
  edtWritten.Text := EmptyStr;
  edtInsert.Text := EmptyStr;
  edtErrors.Text := EmptyStr;
  res := nil;
  info := nil;
  ldr := nil;
  info := TLoadInfo.Create;
  if dlgOpen.Execute then
    info.filename := dlgOpen.filename
  else
    Exit;

  case rgLoadType.ItemIndex of
    0:
      begin { Test load }
        ldr := TFileLoader.Create(bmLoader, vtFileData, true);
        grdFileData.DataSource := dsFileData;
      end;
    1:
      begin { Database load }
        if not dmFBZakelijk.connected then
          Exit;
        ldr := TFileLoader.Create(bmLoader, dmFBZakelijk.dsetImpRaboZak, false);
        grdFileData.DataSource := dmFBZakelijk.dsImpRaboZak;
      end;
  else
    begin
      Exit;
    end;
  end;

  try
    { File format: CSV, Rabo zakelijk. }
    ldr.SetFileInfo(info);
    ldr.AddField('IBAN', sftString, 34);
    ldr.AddField('VALUTA_CODE', sftString, 4);
    ldr.AddField('BIC', sftString, 11);
    ldr.AddField('SEQNO', sftString, 18);
    ldr.AddField('BOEK_DATUM', sftDate);
    ldr.AddField('VALUTA_DATUM', sftDate);
    ldr.AddField('BEDRAG', sftNumber);
    ldr.AddField('SALDO_NA_BOEKING', sftNumber); // empty?
    ldr.AddField('TEGEN_IBAN', sftString, 34);
    ldr.AddField('TEGEN_NAAM', sftString, 70);
    ldr.AddField('ULTIMATE_NAAM', sftString, 70);
    ldr.AddField('INIT_NAAM', sftString, 70); // empty
    ldr.AddField('TEGEN_BIC', sftString, 15); // empty
    ldr.AddField('TX_TYPE_CODE', sftString, 4);
    ldr.AddField('BATCH_ID', sftString, 35);
    ldr.AddField('TX_REF', sftString, 35);
    ldr.AddField('MANDATE_REF', sftString, 35);
    ldr.AddField('COLLECTOR_ID', sftString, 35);
    ldr.AddField('PAYMENT_REF', sftString, 35);
    ldr.AddField('DESC_1', sftString, 140);
    ldr.AddField('DESC_2', sftString, 140);
    ldr.AddField('DESC_3', sftString, 140);
    ldr.AddField('REASON_CODE', sftString, 75);
    ldr.AddField('INSTR_BEDRAG', sftNumber);
    ldr.AddField('INSTR_VALUTA', sftString, 11);
    ldr.AddField('KOERS', sftNumber);
    res := ldr.LoadFile;
    edtRead.Text := IntToStr(res.FReadCount);
    edtWritten.Text := IntToStr(res.FWriteCount);
    edtInsert.Text := IntToStr(res.FInsertCount);
    edtErrors.Text := IntToStr(res.FErrorCount);
  finally
    if Assigned(res) then
      res.Free;
    if Assigned(info) then
      info.Free;
    if Assigned(ldr) then
      ldr.Free;
  end;
end;

procedure TfrmMain.actShowLogExecute(Sender: TObject);
begin
  frmTable.TableData := dmFBZakelijk.rsAppLog;
  frmTable.TableSource := dmFBZakelijk.dsLog;
  frmTable.Caption := 'Mikel log blog';
  frmTable.Show;
end;

procedure TfrmMain.actShowXafCustomerExecute(Sender: TObject);
begin
  // TODO: set correct properties.
  frmTable.TableData := dmFBZakelijk.rsAppLog;
  frmTable.TableSource := dmFBZakelijk.dsLog;
  frmTable.Caption := 'Mikel XAF customer';
  frmTable.Show;

end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmFBZakelijk.connected := false;
end;

procedure TfrmMain.LoadConfig;
var
  cfg: TConfig;
begin
  cfg := TConfig.Create;
  dmFBZakelijk.connFBZakelijk.Server := cfg.Server;
  dmFBZakelijk.connFBZakelijk.Username := cfg.Huis;
  dmFBZakelijk.connFBZakelijk.Password := cfg.Tuin;
  dmFBZakelijk.connFBZakelijk.Database := cfg.Pop;
  dmFBZakelijk.connFBZakelijk.ProviderName := cfg.Speeltuin;
end;
{$ENDREGION}
{ ============================================================================ }
{$REGION 'TConfig'}
{ TConfig }

constructor TConfig.Create;
var
  fname: string;
begin
  Fcfg := TStringList.Create;
  try
    if ParamCount >= 1 then
    begin
      fname := ParamStr(1);
      Fcfg.LoadFromFile(fname);
    end;
  except
    on Exception do
      Fcfg.Clear;
  end;
end;

destructor TConfig.Destroy;
begin
  Fcfg.Free;
  inherited;
end;

function TConfig.getHuis: string;
begin
  Result := Fcfg.Values['zkb_fb_huis'];
end;

function TConfig.getServer: string;
begin
  Result := Fcfg.Values['zkb_fb_stad'];
end;

function TConfig.getTuin: string;
begin
  Result := Fcfg.Values['zkb_fb_tuin'];
end;

function TConfig.getPop: string;
begin
  Result := Fcfg.Values['zkb_fb_pop'];
end;

function TConfig.getSpeelTuin: string;
begin
  Result := Fcfg.Values['zkb_fb_speeltuin'];
end;

{$ENDREGION}

end.
