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

type
  TDataFacade = class abstract
  private
    function GetConnected: boolean; virtual; abstract;
    procedure SetConnected(c: boolean); virtual; abstract;
  public
    property Connected: boolean read GetConnected write SetConnected;
    procedure procRaboZakelijk; virtual; abstract;
    procedure procKnabZakelijk; virtual; abstract;

  end;

function CreateDataFacade: TDataFacade;

{ ============================================================================ }
implementation

uses System.Classes, System.SysUtils, dm_fb_zakelijk, dm_ora_zakelijk;

type

  { ZBData }
  ZBData = class(TDataFacade)
  private
    function GetConnected: boolean; override;
    procedure SetConnected(c: boolean); override;
    procedure Connect;
    procedure Disconnect;

  public
    destructor Destroy; override;
    procedure procRaboZakelijk; override;
    procedure procKnabZakelijk; override;
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

destructor ZBData.Destroy;
begin
  Disconnect;
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
