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

uses data.DB, FireDac.Comp.BatchMove, file_loader, batch_decorator;

type
  TDataFacade = class
  private
    function GetConnected: boolean; virtual; abstract;
    procedure SetConnected(c: boolean); virtual; abstract;
    function GetZBDataSet(const name: string): TDataSet; virtual; abstract;
    function GetZBDataSource(const name: string): TDataSource; virtual;
      abstract;
    function GetZBQryDecorator(const name: string): IDDReadOnly;
      virtual; abstract;
  public
    property Connected: boolean read GetConnected write SetConnected;
    property ZBDataSet[const name: string]: TDataSet read GetZBDataSet;
    property ZBDataSource[const name: string]: TDataSource read GetZBDataSource;
    property ZBQryDecorator[const name: string]: IDDReadOnly
      read GetZBQryDecorator;
    procedure procRaboZakelijk; virtual; abstract;
    procedure procKnabZakelijk; virtual; abstract;

    function LoadDataSetFromFile(const dsname: string; const filename: String;
      bm: TFDBatchMove; ds: TDataSet): TLoadResult; virtual; abstract;

    function CopyDataSet(bm: TFDBatchMove; src: TDataSet; dst: TDataSet)
      : TLoadResult; virtual; abstract;
  end;

function CreateDataFacade: TDataFacade;

{ ============================================================================ }
implementation

uses System.Classes, System.SysUtils, System.Generics.Collections,
  dm_ora_zakelijk, dm_xaf, dm_fb_zakelijk,
  FireDac.Comp.BatchMove.DataSet, Uni;

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
    function GetZBDataSource(const name: string): TDataSource; override;
    function GetZBQryDecorator(const name: string): IDDReadOnly; override;
    function LoadRaboZakFromFile(const filename: String; bm: TFDBatchMove;
      ds: TDataSet): TLoadResult;
    function LoadKnabZakFromFile(const filename: String; bm: TFDBatchMove;
      ds: TDataSet): TLoadResult;

  public
    constructor Create;
    destructor Destroy; override;
    procedure procRaboZakelijk; override;
    procedure procKnabZakelijk; override;
    function LoadDataSetFromFile(const dsname: string; const filename: String;
      bm: TFDBatchMove; ds: TDataSet): TLoadResult; override;
    function CopyDataSet(bm: TFDBatchMove; src: TDataSet; dst: TDataSet)
      : TLoadResult; override;
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

function ZBData.CopyDataSet(bm: TFDBatchMove; src: TDataSet; dst: TDataSet)
  : TLoadResult;
var
  rdr: TFDBatchMoveDataSetReader;
  wtr: TFDBatchMoveDataSetWriter;
  mi: TFDBatchMoveMappingItem;
  fields: TStringList;
  res: Integer;
  bd: IDDBatch;
  uds: TCustomUniDataSet;
begin
  if not(dst is TCustomUniDataSet) then
    raise Exception.Create('dst must be a TCustomUniDataSet');

  bd := nil;
  fields := TStringList.Create;
  try
    rdr := TFDBatchMoveDataSetReader.Create(bm);
    rdr.DataSet := src;
    src.Active := true;

    wtr := TFDBatchMoveDataSetWriter.Create(bm);
    wtr.Optimise := false;
    wtr.DataSet := dst;

    uds := dst as TCustomUniDataSet;
    bd := CreateBatchDecorator(uds);
    dst.Active := true;

    bm.Mode := dmAlwaysInsert;
    bm.Options := [poClearDest];
    bm.CommitCount := 0;

    bm.Mappings.ClearAndResetID;
    dst.GetFieldNames(fields);
    for var i: Integer := 0 to fields.Count - 1 do
    begin
      mi := bm.Mappings.Add;
      mi.SourceFieldName := fields[i];
      mi.DestinationFieldName := fields[i];
    end;

    bd.StartTransaction;
    res := bm.Execute;
    bd.Commit;
  finally
    bd := nil;
    src.Active := false;
    dst.Active := false;
    fields.Free;
    Result := TLoadResult.Create(bm);
  end;
end;

constructor ZBData.Create;
begin
  FQDecs := TDictionary<string, IDDReadOnly>.Create;
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
  else
    raise Exception.Create('Unknown DataSet name: ' + name);
end;

function ZBData.GetZBDataSource(const name: string): TDataSource;
begin
  if name = 'RaboImp' then
    Result := dmFBZakelijk.dsImpRaboZak
  else if name = 'KnabImp' then
    Result := dmFBZakelijk.dsImpKnab
  else if name = 'Log' then
    Result := dmFBZakelijk.dsLog
  else if name = 'XafCustomer' then
    Result := dmXAF.dsXafCustomer
  else if name = 'OraCustomer' then
    Result := dmXAF.dsOraCustomer
  else
    raise Exception.Create('Unknown DataSource name: ' + name);
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

function ZBData.LoadDataSetFromFile(const dsname, filename: String;
  bm: TFDBatchMove; ds: TDataSet): TLoadResult;
begin
  if dsname = 'RaboImp' then
    Result := LoadRaboZakFromFile(filename, bm, ds)
  else if dsname = 'KnabImp' then
    Result := LoadKnabZakFromFile(filename, bm, ds)
  else
    Result := nil;
end;

function ZBData.LoadKnabZakFromFile(const filename: String; bm: TFDBatchMove;
  ds: TDataSet): TLoadResult;
var
  info: TLoadInfo;
  ldr: TFileLoader;
begin
  info := nil;
  ldr := nil;
  try
    info := TLoadInfo.Create;
    ldr := TFileLoader.Create(bm, ds, true);
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

    Result := ldr.LoadFile;
  finally
    if Assigned(info) then
      info.Free;
    if Assigned(ldr) then
      ldr.Free;
  end;

end;

function ZBData.LoadRaboZakFromFile(const filename: String; bm: TFDBatchMove;
  ds: TDataSet): TLoadResult;
var
  info: TLoadInfo;
  ldr: TFileLoader;
begin
  info := nil;
  ldr := nil;
  try
    info := TLoadInfo.Create;
    ldr := TFileLoader.Create(bm, ds, true);
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
    Result := ldr.LoadFile;
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

end.
