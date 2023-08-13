{ ******************************************************************************

  Copyright (c) 2022 M van Delft.

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
program mik_loader;

uses
  Vcl.Forms,
  frm_main in 'frm_main.pas' {frmMain},
  dm_fb_zakelijk in 'dm_fb_zakelijk.pas' {dmFBZakelijk: TDataModule},
  file_loader in 'file_loader.pas',
  frm_table in 'frm_table.pas' {frmLog},
  query_decorator in 'query_decorator.pas',
  dm_xaf in 'dm_xaf.pas' {dmXAF: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Mikel Loader';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmFBZakelijk, dmFBZakelijk);
  Application.CreateForm(TfrmLog, frmLog);
  Application.CreateForm(TdmXAF, dmXAF);
  Application.Run;
end.
