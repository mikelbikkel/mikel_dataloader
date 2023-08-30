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
unit dm_xaf;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, dm_fb_zakelijk,
  MemDS, DBAccess, Uni;

type
  TdmXAF = class(TDataModule)
    qryXafCustomer: TUniQuery;
    qryXafCustomerAUDIT_ID: TStringField;
    qryXafCustomerCUST_ID: TStringField;
    qryXafCustomerCUST_NAME: TStringField;
    qryXafCustomerKVK_NUMBER: TStringField;
    qryXafCustomerTAX_REG_ID: TStringField;
    qryXafCustomerCUST_TYPE: TStringField;
    qryOraCustomer: TUniQuery;
    qryOraCustomerAUDIT_ID: TStringField;
    qryOraCustomerCUST_ID: TStringField;
    qryOraCustomerCUST_NAME: TStringField;
    qryOraCustomerKVK_NUMBER: TStringField;
    qryOraCustomerTAX_REG_ID: TStringField;
    qryOraCustomerCUST_TYPE: TStringField;
    qryXafInfo: TUniQuery;
    qryXafInfoAUDIT_ID: TStringField;
    qryXafInfoCOMPANYIDENT: TStringField;
    qryXafInfoCOMPANYNAME: TStringField;
    qryXafInfoTAX_REG_COUNTRY: TStringField;
    qryXafInfoTAX_REG_ID: TStringField;
    qryXafInfoFISCALYEAR: TStringField;
    qryXafInfoSTARTDATE: TDateField;
    qryXafInfoENDDATE: TDateField;
    qryXafInfoCURCODE: TStringField;
    qryXafInfoDATECREATED: TDateField;
    qryXafInfoSOFTWARE_DESC: TStringField;
    qryXafInfoSOFTWARE_VERSION: TStringField;
    qryXafVatCode: TUniQuery;
    qryXafVatCodeAUDIT_ID: TStringField;
    qryXafVatCodeVAT_ID: TStringField;
    qryXafVatCodeVAT_DESC: TStringField;
    qryXafVatCodePAY_ACC_ID: TStringField;
    qryXafVatCodeCLAIM_ACC_ID: TStringField;
    qryXafPeriod: TUniQuery;
    qryXafAccount: TUniQuery;
    qryXafAccountAUDIT_ID: TStringField;
    qryXafAccountACC_ID: TStringField;
    qryXafAccountACC_DESC: TStringField;
    qryXafAccountACC_TYPE: TStringField;
    qryXafAccountLEAD_CODE: TStringField;
    qryXafAccountLEAD_DESC: TStringField;
    qryXafPeriodAUDIT_ID: TStringField;
    qryXafPeriodPERIOD_ID: TIntegerField;
    qryXafPeriodPERIOD_DESC: TStringField;
    qryXafPeriodSTARTDATE: TDateField;
    qryXafPeriodENDDATE: TDateField;
    qryOraInfo: TUniQuery;
    qryOraInfoAUDIT_ID: TStringField;
    qryOraInfoCOMPANYIDENT: TStringField;
    qryOraInfoCOMPANYNAME: TStringField;
    qryOraInfoTAX_REG_COUNTRY: TStringField;
    qryOraInfoTAX_REG_ID: TStringField;
    qryOraInfoFISCALYEAR: TStringField;
    qryOraInfoSTARTDATE: TDateTimeField;
    qryOraInfoENDDATE: TDateTimeField;
    qryOraInfoCURCODE: TStringField;
    qryOraInfoDATECREATED: TDateTimeField;
    qryOraInfoSOFTWARE_DESC: TStringField;
    qryOraInfoSOFTWARE_VERSION: TStringField;
    qryOraVatCode: TUniQuery;
    qryOraVatCodeAUDIT_ID: TStringField;
    qryOraVatCodeVAT_ID: TStringField;
    qryOraVatCodeVAT_DESC: TStringField;
    qryOraVatCodePAY_ACC_ID: TStringField;
    qryOraVatCodeCLAIM_ACC_ID: TStringField;
    qryOraPeriod: TUniQuery;
    qryOraPeriodAUDIT_ID: TStringField;
    qryOraPeriodPERIOD_ID: TSmallintField;
    qryOraPeriodPERIOD_DESC: TStringField;
    qryOraPeriodSTARTDATE: TDateTimeField;
    qryOraPeriodENDDATE: TDateTimeField;
    qryOraAccount: TUniQuery;
    qryOraAccountAUDIT_ID: TStringField;
    qryOraAccountACC_ID: TStringField;
    qryOraAccountACC_DESC: TStringField;
    qryOraAccountACC_TYPE: TStringField;
    qryOraAccountLEAD_CODE: TStringField;
    qryOraAccountLEAD_DESC: TStringField;
    qryXafOpBalance: TUniQuery;
    qryXafOpLine: TUniQuery;
    qryXafOpBalanceAUDIT_ID: TStringField;
    qryXafOpBalanceOB_DATE: TDateField;
    qryXafOpBalanceOB_DESC: TStringField;
    qryXafOpBalanceLINES_COUNT: TIntegerField;
    qryXafOpBalanceTOTAL_DEBIT: TFloatField;
    qryXafOpBalanceTOTAL_CREDIT: TFloatField;
    qryXafOpLineAUDIT_ID: TStringField;
    qryXafOpLineOBLINE_NR: TStringField;
    qryXafOpLineOBLINE_ACC_ID: TStringField;
    qryXafOpLineAMNT_STRING: TStringField;
    qryXafOpLineOBLINE_AMOUNT: TFloatField;
    qryXafOpLineOBLINE_TYPE: TStringField;
    qryXafTransaction: TUniQuery;
    qryXafTransactionLine: TUniQuery;
    qryXafVatLine: TUniQuery;
    qryXafTransactionAUDIT_ID: TStringField;
    qryXafTransactionJRN_ID: TStringField;
    qryXafTransactionJRN_DESC: TStringField;
    qryXafTransactionJRN_TYPE: TStringField;
    qryXafTransactionTX_NR: TStringField;
    qryXafTransactionTX_DESC: TStringField;
    qryXafTransactionTX_PERIOD_ID: TIntegerField;
    qryXafTransactionTX_DATE: TDateField;
    qryXafTransactionTX_AMOUNT: TFloatField;
    qryXafTransactionTX_AMOUNT_TYPE: TStringField;
    qryXafTransactionTX_SOURCE_ID: TStringField;
    qryXafTransactionTX_USER_ID: TStringField;
    qryXafVatLineAUDIT_ID: TStringField;
    qryXafVatLineTX_NR: TStringField;
    qryXafVatLineTXLINE_NR: TIntegerField;
    qryXafVatLineVAT_ID: TStringField;
    qryXafVatLineVAT_PERC: TFloatField;
    qryXafVatLineAMOUNT: TFloatField;
    qryXafVatLineAMOUNT_TYPE: TStringField;
    qryXafTransactionLineAUDIT_ID: TStringField;
    qryXafTransactionLineTX_NR: TStringField;
    qryXafTransactionLineTXLINE_NR: TIntegerField;
    qryXafTransactionLineACC_ID: TStringField;
    qryXafTransactionLineDOC_REF: TStringField;
    qryXafTransactionLineEFF_DATE: TDateField;
    qryXafTransactionLineTXLINE_DESC: TStringField;
    qryXafTransactionLineAMOUNT: TFloatField;
    qryXafTransactionLineAMOUNT_TYPE: TStringField;
    qryXafTransactionLineCUSTOMER_ID: TStringField;
    qryXafTransactionLineCOST_ID: TStringField;
    qryXafTransactionLinePRODUCT_ID: TStringField;
    qryXafTransactionLinePROJECT_ID: TStringField;
    qryXafTransactionLineCUR_CODE: TStringField;
    qryXafTransactionLineCUR_AMOUNT: TFloatField;
  end;

var
  dmXAF: TdmXAF;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdmXAF }

end.
