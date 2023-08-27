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
  end;

var
  dmXAF: TdmXAF;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TdmXAF }

end.
