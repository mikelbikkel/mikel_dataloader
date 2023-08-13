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
unit frm_log;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  dm_fb_zakelijk,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls;

type
  TfrmLog = class(TForm)
    grdLog: TDBGrid;
    btnRefresh: TButton;
    ActionList1: TActionList;
    actRefresh: TAction;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actRefreshExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLog: TfrmLog;

implementation

{$R *.dfm}

procedure TfrmLog.actRefreshExecute(Sender: TObject);
begin
  dmFBZakelijk.rsAppLog.Refresh;
end;

procedure TfrmLog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmFBZakelijk.rsAppLog.Close;
end;

procedure TfrmLog.FormShow(Sender: TObject);
begin
  dmFBZakelijk.rsAppLog.Open;
end;

end.
