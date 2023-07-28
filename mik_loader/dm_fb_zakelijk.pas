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
unit dm_fb_zakelijk;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, Uni, UniProvider,
  InterBaseUniProvider, MemDS, VirtualTable, FireDAC.Stan.Intf,
  FireDAC.Comp.BatchMove, UniDacVcl, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI;

type
  TdmFBZakelijk = class(TDataModule)
    connFBZakelijk: TUniConnection;
    provFB: TInterBaseUniProvider;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    qryImpRaboZak: TUniQuery;
    qryImpRaboZakIBAN: TStringField;
    qryImpRaboZakVALUTA_CODE: TStringField;
    qryImpRaboZakBIC: TStringField;
    qryImpRaboZakSEQNO: TStringField;
    qryImpRaboZakBOEK_DATUM: TDateField;
    qryImpRaboZakVALUTA_DATUM: TDateField;
    qryImpRaboZakBEDRAG: TFloatField;
    qryImpRaboZakSALDO_NA_BOEKING: TFloatField;
    qryImpRaboZakTEGEN_IBAN: TStringField;
    qryImpRaboZakTEGEN_NAAM: TStringField;
    qryImpRaboZakULTIMATE_NAAM: TStringField;
    qryImpRaboZakINIT_NAAM: TStringField;
    qryImpRaboZakTEGEN_BIC: TStringField;
    qryImpRaboZakTX_TYPE_CODE: TStringField;
    qryImpRaboZakBATCH_ID: TStringField;
    qryImpRaboZakTX_REF: TStringField;
    qryImpRaboZakMANDATE_REF: TStringField;
    qryImpRaboZakCOLLECTOR_ID: TStringField;
    qryImpRaboZakPAYMENT_REF: TStringField;
    qryImpRaboZakDESC_1: TStringField;
    qryImpRaboZakDESC_2: TStringField;
    qryImpRaboZakDESC_3: TStringField;
    qryImpRaboZakREASON_CODE: TStringField;
    qryImpRaboZakINSTR_BEDRAG: TFloatField;
    qryImpRaboZakINSTR_VALUTA: TStringField;
    qryImpRaboZakKOERS: TFloatField;
    dsImpRaboZak: TUniDataSource;
    uniDlgConnect: TUniConnectDialog;
    procedure connFBZakelijkLogin(Connection: TCustomDAConnection;
      LoginParams: TStrings);
  strict private
    { Private declarations }
    function GetConnected: boolean;
    procedure SetConnected(setConn: boolean);
    function GetRaboImpZak: TDataSet;
  public
    { Public declarations }
    property connected: boolean read GetConnected write SetConnected;
    property dsetImpRaboZak: TDataSet read GetRaboImpZak;
  end;

var
  dmFBZakelijk: TdmFBZakelijk;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdmFBZakelijk }

procedure TdmFBZakelijk.connFBZakelijkLogin(Connection: TCustomDAConnection;
  LoginParams: TStrings);
var
  S: String;
begin
  if Assigned(Connection) then
    S := LoginParams.CommaText;
end;

function TdmFBZakelijk.GetConnected: boolean;
begin
  Result := connFBZakelijk.connected;
end;

function TdmFBZakelijk.GetRaboImpZak: TDataSet;
begin
  Result := qryImpRaboZak;
end;

procedure TdmFBZakelijk.SetConnected(setConn: boolean);
begin
  if setConn and (not connFBZakelijk.connected) then
    connFBZakelijk.connected := true
  else if (not setConn) and connFBZakelijk.connected then
    connFBZakelijk.connected := false;
end;

end.
