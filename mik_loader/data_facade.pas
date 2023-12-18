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

  ****************************************************************************** }
unit data_facade;

interface

uses data.DB;

type
  // tmAppend: insert if PK does not exist. Do nothing if PK exists.
  // tmReplace:  truncate first, then insert all.
  TTargetMode = (tmAppend, tmReplace);

  IDDReadOnly = interface
    procedure Open;
    procedure Refresh;
    procedure Close;

    { Returns the wrapped Datasource component. }
    function GetDataSet: TDataSet;
  end;

  TXafCopyEvent = procedure(msg: string) of object;

  TDataFacade = class
  private
    function GetConnected: boolean; virtual; abstract;
    procedure SetConnected(c: boolean); virtual; abstract;
    function GetZBDataSet(const name: string): TDataSet; virtual; abstract;
    function GetZBQryDecorator(const name: string): IDDReadOnly;
      virtual; abstract;
  protected
    FXafEvent: TXafCopyEvent;
    procedure TriggerXEvent(msg: string); dynamic;
  public
    property OnXafCopy: TXafCopyEvent read FXafEvent write FXafEvent;

    property Connected: boolean read GetConnected write SetConnected;
    property ZBDataSet[const name: string]: TDataSet read GetZBDataSet;
    property ZBQryDecorator[const name: string]: IDDReadOnly
      read GetZBQryDecorator;
    procedure procRaboZakelijk; virtual; abstract;
    procedure procKnabZakelijk; virtual; abstract;

    procedure LoadDataSetFromFile(const dsname: string; const filename: String;
      ds: TDataSet); virtual; abstract;

    function UCopyDataSet(src: TDataSet; dst: TDataSet; tmMode: TTargetMode)
      : integer; virtual; abstract;

    procedure CopyXaf; virtual; abstract;
    procedure CopyKnabTx(tm: TTargetMode); virtual; abstract;
    procedure CopyRaboTx; virtual; abstract;
  end;

function CreateDataFacade: TDataFacade;

{ ============================================================================ }
implementation

uses System.Classes, System.SysUtils, System.Generics.Collections,
  CRBatchMove, Uni, dm_xaf, dm_fb_zakelijk, file_loader, batch_decorator,
  mik_logger, data_luw;

type

  { ZBData }
  ZBData = class(TDataFacade)
  strict private
    FQDecs: TDictionary<string, IDDReadOnly>;

    function GetConnected: boolean; override;
    procedure SetConnected(c: boolean); override;
    procedure Connect;
    procedure Disconnect;
    function GetZBDataSet(const name: string): TDataSet; override;
    function GetZBQryDecorator(const name: string): IDDReadOnly; override;
    procedure LoadRaboZakFromFile(const filename: String; ds: TDataSet);
    procedure LoadKnabZakFromFile(const filename: String; ds: TDataSet);
    function CreateMove(src: TDataSet; dst: TDataSet; tmMode: TTargetMode)
      : TCRBatchMove;
  public
    constructor Create;
    destructor Destroy; override;
    procedure procRaboZakelijk; override;
    procedure procKnabZakelijk; override;
    procedure LoadDataSetFromFile(const dsname: string; const filename: String;
      ds: TDataSet); override;
    function UCopyDataSet(src: TDataSet; dst: TDataSet; tmMode: TTargetMode)
      : integer; override;

    procedure CopyXaf; override;
    procedure CopyKnabTx(tm: TTargetMode); override;
    procedure CopyRaboTx; override;
  end;

  TConfig = class
  strict private
    Fcfg: TStringList;
    function getServer: string;
    function getHuis: string;
    function getTuin: string;
    function getPop: string;
    function getSpeelTuin: string;
    function getOServer: string;
    function getOHuis: string;
    function getOTuin: string;
    function getOPop: string;
    function getOSpeelTuin: string;
  public
    constructor Create;
    destructor Destroy; override;
    property Server: string read getServer;
    property Huis: string read getHuis;
    property Tuin: string read getTuin;
    property Pop: string read getPop;
    property Speeltuin: string read getSpeelTuin;
    property OServer: string read getOServer;
    property OHuis: string read getOHuis;
    property OTuin: string read getOTuin;
    property OPop: string read getOPop;
    property OSpeeltuin: string read getOSpeelTuin;

  end;

function CreateDataFacade: TDataFacade;
begin
  Result := ZBData.Create;
end;

{ ============================================================================ }

procedure ZBData.CopyKnabTx(tm: TTargetMode);
var
  luw: ILUW;
  s: string;
  sp: TUniStoredProc;
  src: array of TCustomUniDataSet;
  dst: array of TCustomUniDataSet;
  bm: array of TCRBatchMove;
begin
  src := [dmXAF.qryOraKtx, dmXAF.qryOraKtxInfo, dmXAF.qryOraKtxGL];
  dst := [dmXAF.qryKnabTx, dmXAF.qryKnabInfo, dmXAF.qryKnabGL];
  SetLength(bm, Length(src));

  sp := nil;

  try
    luw := CreateLUW(dmFBZakelijk.connFBZakelijk);
    luw.StartTransaction;

    try
      sp := TUniStoredProc.Create(nil);
      sp.Connection := dmFBZakelijk.connFBZakelijk;
      sp.StoredProcName := 'mk_pkg_knab.delete_knab_ztx';
      luw.AddStoredProc(sp);

      for var i: integer := Low(src) to High(src) do
      begin
        bm[i] := CreateMove(src[i], dst[i], tmReplace);
        luw.AddBatchMove(bm[i]);
        TriggerXEvent(bm[i].Destination.name + ': ' +
          IntToStr(bm[i].MovedCount) + '.');
      end;

      luw.Commit;
    except
      luw.Rollback;
      TriggerXEvent('knab_ztx: exception.');
    end;

    // s := (luw as TObject).ToString;
  finally
    if Assigned(sp) then
      sp.Free;

    for var i: integer := Low(src) to High(src) do
      if Assigned(bm[i]) then
        bm[i].Free;
  end;

end;

procedure ZBData.CopyRaboTx;
var
  luw: ILUW;
  s: string;
  sp: TUniStoredProc;
  src: array of TCustomUniDataSet;
  dst: array of TCustomUniDataSet;
  bm: array of TCRBatchMove;
begin
  src := [dmXAF.qryOraRZtx, dmXAF.qryOraRZinfo, dmXAF.qryOraRZGL];
  dst := [dmXAF.qryFBRZtx, dmXAF.qryFBRZinfo, dmXAF.qryFBRZGL];
  SetLength(bm, Length(src));

  sp := nil;

  try
    luw := CreateLUW(dmFBZakelijk.connFBZakelijk);
    luw.StartTransaction;

    try
      sp := TUniStoredProc.Create(nil);
      sp.Connection := dmFBZakelijk.connFBZakelijk;
      sp.StoredProcName := 'mk_pkg_rabo.delete_rabo_ztx';
      luw.AddStoredProc(sp);

      for var i: integer := Low(src) to High(src) do
      begin
        bm[i] := CreateMove(src[i], dst[i], tmReplace);
        luw.AddBatchMove(bm[i]);
        TriggerXEvent(bm[i].Destination.name + ': ' +
          IntToStr(bm[i].MovedCount) + '.');
      end;

      luw.Commit;
    except
      luw.Rollback;
      TriggerXEvent('rabo_ztx: exception.');
    end;

    // s := (luw as TObject).ToString;
  finally
    if Assigned(sp) then
      sp.Free;

    for var i: integer := Low(src) to High(src) do
      if Assigned(bm[i]) then
        bm[i].Free;
  end;
end;

procedure ZBData.Connect;
var
  cfg: TConfig;
begin
  try
    cfg := TConfig.Create;
    dmFBZakelijk.connFBZakelijk.Server := cfg.Server;
    dmFBZakelijk.connFBZakelijk.Username := cfg.Huis;
    dmFBZakelijk.connFBZakelijk.Password := cfg.Tuin;
    dmFBZakelijk.connFBZakelijk.Database := cfg.Pop;
    dmFBZakelijk.connFBZakelijk.ProviderName := cfg.Speeltuin;

    dmFBZakelijk.connOraZakelijk.Server := cfg.OServer;
    dmFBZakelijk.connOraZakelijk.Username := cfg.OHuis;
    dmFBZakelijk.connOraZakelijk.Password := cfg.OTuin;
    dmFBZakelijk.connOraZakelijk.ProviderName := cfg.OSpeeltuin;

    dmFBZakelijk.connFBZakelijk.Connected := true;
    dmFBZakelijk.connOraZakelijk.Connected := true;
  except
    on Exception do
    begin
      Disconnect;
      raise;
    end;
  end;
end;

procedure ZBData.CopyXaf;
var
  luw: ILUW;
  s: string;
  sp: TUniStoredProc;
  src: array of TCustomUniDataSet;
  dst: array of TCustomUniDataSet;
  bm: array of TCRBatchMove;
begin
  src := [dmXAF.qryOraInfo, dmXAF.qryOraCustomer, dmXAF.qryOraVatCode,
    dmXAF.qryOraPeriod, dmXAF.qryOraAccount, dmXAF.qryOraTxTotal,
    dmXAF.qryOraOpBalance, dmXAF.qryOraOpLine, dmXAF.qryOraTransaction,
    dmXAF.qryOraTransactionLine, dmXAF.qryOraVatLine];
  dst := [dmXAF.qryXafInfo, dmXAF.qryXafCustomer, dmXAF.qryXafVatCode,
    dmXAF.qryXafPeriod, dmXAF.qryXafAccount, dmXAF.qryXafTxTotal,
    dmXAF.qryXafOpBalance, dmXAF.qryXafOpLine, dmXAF.qryXafTransaction,
    dmXAF.qryXafTransactionLine, dmXAF.qryXafVatLine];
  SetLength(bm, Length(src));

  sp := nil;

  try
    luw := CreateLUW(dmFBZakelijk.connFBZakelijk);
    luw.StartTransaction;

    try
      sp := TUniStoredProc.Create(nil);
      sp.Connection := dmFBZakelijk.connFBZakelijk;
      sp.StoredProcName := 'mk_pkg_xaf.delete_xaf';
      luw.AddStoredProc(sp);

      for var i: integer := Low(src) to High(src) do
      begin
        bm[i] := CreateMove(src[i], dst[i], tmReplace);
        luw.AddBatchMove(bm[i]);
        TriggerXEvent(bm[i].Destination.name + ': ' +
          IntToStr(bm[i].MovedCount) + '.');
      end;

      luw.Commit;
    except
      luw.Rollback;
      TriggerXEvent('xaf: exception.');
    end;
  finally
    if Assigned(sp) then
      sp.Free;

    for var i: integer := Low(src) to High(src) do
      if Assigned(bm[i]) then
        bm[i].Free;
  end;
end;

constructor ZBData.Create;
begin
  FQDecs := TDictionary<string, IDDReadOnly>.Create;
end;

function ZBData.CreateMove(src: TDataSet; dst: TDataSet; tmMode: TTargetMode)
  : TCRBatchMove;
var
  bm: TCRBatchMove;
  fields: TStringList;
  s: string;
begin
  if not(dst is TCustomUniDataSet) then
    raise Exception.Create('dst must be a TCustomUniDataSet');

  bm := nil;
  fields := nil;
  s := EmptyStr;
  try
    bm := TCRBatchMove.Create(nil);
    case tmMode of
      tmReplace:
        begin
          bm.AbortOnKeyViol := true;
          bm.Mode := bmAppend;
        end;
      tmAppend:
        begin
          bm.AbortOnKeyViol := false;
          bm.Mode := bmAppend;
        end;
    else
      raise Exception.Create('unknown tmMode');
    end;
    bm.FieldMappingMode := mmFieldName;
    bm.Source := src;
    bm.Destination := dst;

    fields := TStringList.Create;
    dst.GetFieldNames(fields);
    for var i: integer := 0 to fields.Count - 1 do
    begin
      s := fields[i] + '=' + fields[i];
      bm.Mappings.Add(s);
    end;

    Result := bm;
  finally
    if Assigned(fields) then
      fields.Free;
  end;

end;

destructor ZBData.Destroy;
begin
  Disconnect;
  FQDecs.Free;
  inherited;
end;

procedure ZBData.Disconnect;
begin
  if Assigned(dmFBZakelijk.connFBZakelijk) then
    dmFBZakelijk.connFBZakelijk.Connected := false;

  if Assigned(dmFBZakelijk.connOraZakelijk) then
    dmFBZakelijk.connOraZakelijk.Connected := false;
end;

function ZBData.GetConnected: boolean;
begin
  if Assigned(dmFBZakelijk.connFBZakelijk) and
    dmFBZakelijk.connFBZakelijk.Connected and
    Assigned(dmFBZakelijk.connOraZakelijk) and dmFBZakelijk.connOraZakelijk.Connected
  then
    Result := true
  else
    Result := false;
end;

function ZBData.GetZBDataSet(const name: string): TDataSet;
begin
  if name = 'RaboImp' then
    Result := dmFBZakelijk.qryImpRaboZak
  else if name = 'KnabImp' then
    Result := dmFBZakelijk.qryImpKnab
  else if name = 'XafCustomer' then
    Result := dmXAF.qryXafCustomer
  else if name = 'OraCustomer' then
    Result := dmXAF.qryOraCustomer
  else if name = 'XafInfo' then
    Result := dmXAF.qryXafInfo
  else if name = 'OraInfo' then
    Result := dmXAF.qryOraInfo
  else
    raise Exception.Create('Unknown DataSet name: ' + name);
end;

function ZBData.GetZBQryDecorator(const name: string): IDDReadOnly;
var
  res: IDDReadOnly;
begin
  if name = EmptyStr then
    raise Exception.Create('Invalid decorator name.');

  res := nil;
  if FQDecs.TryGetValue(name, res) then
  begin
    Result := res;
    Exit;
  end;

  if name = 'AppLog' then
  begin
    res := CreateReadOnlyDecorator(dmFBZakelijk.qryLog);
    FQDecs.Add(name, res);
  end
  else if name = 'XafCustomer' then
  begin
    res := CreateReadOnlyDecorator(dmXAF.qryXafCustomer);
    FQDecs.Add(name, res);
  end
  else if name = 'OraCustomer' then
  begin
    res := CreateReadOnlyDecorator(dmXAF.qryOraCustomer);
    FQDecs.Add(name, res);
  end
  else
    raise Exception.Create('Unknown decorator name: ' + name);

  Result := res;
end;

procedure ZBData.LoadDataSetFromFile(const dsname, filename: String;
  ds: TDataSet);
begin
  if dsname = 'RaboImp' then
    LoadRaboZakFromFile(filename, ds)
  else if dsname = 'KnabImp' then
    LoadKnabZakFromFile(filename, ds)
end;

procedure ZBData.LoadKnabZakFromFile(const filename: String; ds: TDataSet);
var
  info: TLoadInfo;
  ldr: TFileLoader;
begin
  info := nil;
  ldr := nil;
  try
    info := TLoadInfo.Create;
    ldr := TFileLoader.Create(ds, true, tfReplace);
    info.filename := filename;
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

    ldr.LoadFile;
  finally
    if Assigned(info) then
      info.Free;
    if Assigned(ldr) then
      ldr.Free;
  end;

end;

procedure ZBData.LoadRaboZakFromFile(const filename: String; ds: TDataSet);
var
  info: TLoadInfo;
  ldr: TFileLoader;
begin
  info := nil;
  ldr := nil;
  try
    info := TLoadInfo.Create;
    ldr := TFileLoader.Create(ds, true, tfReplace);
    info.filename := filename;

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

    ldr.LoadFile;
  finally
    if Assigned(info) then
      info.Free;
    if Assigned(ldr) then
      ldr.Free;
  end;
end;

procedure ZBData.SetConnected(c: boolean);
begin
  if not GetConnected and c then
    Connect
  else
    Disconnect;
end;

function ZBData.UCopyDataSet(src, dst: TDataSet; tmMode: TTargetMode): integer;
var
  bm: TCRBatchMove;
  fields: TStringList;
  s: string;
  uds: TCustomUniDataSet;
  bd: IDDBatch;
  bTruncate: boolean;
begin
  if not(dst is TCustomUniDataSet) then
    raise Exception.Create('dst must be a TCustomUniDataSet');

  bm := nil;
  fields := nil;
  s := EmptyStr;
  uds := nil;
  bd := nil;
  bTruncate := false;
  try
    bm := TCRBatchMove.Create(nil);
    case tmMode of
      tmReplace:
        begin
          bTruncate := true;
          bm.AbortOnKeyViol := true;
          bm.Mode := bmAppend;
        end;
      tmAppend:
        begin
          bTruncate := false;
          bm.AbortOnKeyViol := false;
          bm.Mode := bmAppend;
        end;
    else
      raise Exception.Create('unknown tmMode');
    end;
    bm.FieldMappingMode := mmFieldName;
    bm.Source := src;
    bm.Destination := dst;

    fields := TStringList.Create;
    dst.GetFieldNames(fields);
    for var i: integer := 0 to fields.Count - 1 do
    begin
      s := fields[i] + '=' + fields[i];
      bm.Mappings.Add(s);
    end;

    uds := dst as TCustomUniDataSet;
    bd := CreateBatchDecorator(uds, bTruncate);
    var
    s2 := (bd as TObject).ToString;
    MikLogWriteLn(s2);

    dst.Active := true;
    bd.StartTransaction;
    bm.Execute;
    bd.Commit;
    Result := bm.MovedCount;
  finally
    if Assigned(bm) then
      bm.Free;
    bd := nil;
    if Assigned(fields) then
      fields.Free;
  end;
end;

procedure ZBData.procRaboZakelijk;
begin
  dmFBZakelijk.execLoadRaboZak.ExecProc;
end;

procedure ZBData.procKnabZakelijk;
begin
  dmFBZakelijk.execLoadKnabZak.ExecProc;
end;

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
  if Assigned(Fcfg) then
    Fcfg.Free;
  inherited;
end;

function TConfig.getHuis: string;
begin
  Result := Fcfg.Values['zkb_fb_huis'];
end;

function TConfig.getOHuis: string;
begin
  Result := Fcfg.Values['zkb_ora_huis'];
end;

function TConfig.getServer: string;
begin
  Result := Fcfg.Values['zkb_fb_stad'];
end;

function TConfig.getOServer: string;
begin
  Result := Fcfg.Values['zkb_ora_stad'];
end;

function TConfig.getTuin: string;
begin
  Result := Fcfg.Values['zkb_fb_tuin'];
end;

function TConfig.getOTuin: string;
begin
  Result := Fcfg.Values['zkb_ora_tuin'];
end;

function TConfig.getPop: string;
begin
  Result := Fcfg.Values['zkb_fb_pop'];
end;

function TConfig.getOPop: string;
begin
  Result := Fcfg.Values['zkb_ora_pop'];
end;

function TConfig.getSpeelTuin: string;
begin
  Result := Fcfg.Values['zkb_fb_speeltuin'];
end;

function TConfig.getOSpeelTuin: string;
begin
  Result := Fcfg.Values['zkb_ora_speeltuin'];
end;

{$ENDREGION}
{ TDataFacade }

procedure TDataFacade.TriggerXEvent(msg: string);
begin
  if Assigned(FXafEvent) then
    FXafEvent(msg);
end;

end.
