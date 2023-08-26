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
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.ExtCtrls, data_facade;

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
    btnShowOraCust: TButton;
    actShowOraCustomer: TAction;
    btnCopyCustomer: TButton;
    actCopyCustomer: TAction;
    procedure actConnectExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actLoadRaboExecute(Sender: TObject);
    procedure actLoadKnabExecute(Sender: TObject);
    procedure actShowLogExecute(Sender: TObject);
    procedure actExecRaboZakExecute(Sender: TObject);
    procedure actExecKnabZakExecute(Sender: TObject);
    procedure actShowXafCustomerExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actShowOraCustomerExecute(Sender: TObject);
    procedure actCopyCustomerExecute(Sender: TObject);
  private
    FDataFacade: TDataFacade;
    procedure LoadDataFromFile(const dsname: string);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

  { ============================================================================ }
implementation

uses file_loader, frm_table;

{$R *.dfm}
{ ============================================================================ }
{$REGION 'TfrmMain'}

procedure TfrmMain.actConnectExecute(Sender: TObject);
begin
  FDataFacade.Connected := true;
  lblConnected.Color := clGreen;
end;

procedure TfrmMain.actCopyCustomerExecute(Sender: TObject);
var
  src: TDataSet;
  dest: TDataSet;
begin
  src := FDataFacade.ZBDataSet['OraCustomer'];
  dest := FDataFacade.ZBDataSet['XafCustomer'];
  FDataFacade.CopyDataSet(bmLoader, src, dest);
end;

procedure TfrmMain.actExecKnabZakExecute(Sender: TObject);
begin
  FDataFacade.procKnabZakelijk;
end;

procedure TfrmMain.actExecRaboZakExecute(Sender: TObject);
begin
  FDataFacade.procRaboZakelijk;
end;

procedure TfrmMain.actLoadKnabExecute(Sender: TObject);
begin
  LoadDataFromFile('KnabImp');
end;

procedure TfrmMain.actLoadRaboExecute(Sender: TObject);
begin
  LoadDataFromFile('RaboImp');
end;

procedure TfrmMain.actShowLogExecute(Sender: TObject);
begin
  frmTable.TableData := FDataFacade.ZBQryDecorator['AppLog'];
  frmTable.TableSource := FDataFacade.ZBDataSource['Log'];
  frmTable.Caption := 'Mikel log blog';
  frmTable.Show;
end;

procedure TfrmMain.actShowOraCustomerExecute(Sender: TObject);
begin
  frmTable.TableData := FDataFacade.ZBQryDecorator['OraCustomer'];
  frmTable.TableSource := FDataFacade.ZBDataSource['OraCustomer'];
  frmTable.Caption := 'Mikel Ora customer';
  frmTable.Show;
end;

procedure TfrmMain.actShowXafCustomerExecute(Sender: TObject);
begin
  frmTable.TableData := FDataFacade.ZBQryDecorator['XafCustomer'];
  frmTable.TableSource := FDataFacade.ZBDataSource['XafCustomer'];
  frmTable.Caption := 'Mikel XAF customer';
  frmTable.Show;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FDataFacade) then
  begin
    FDataFacade.Connected := false;
    FDataFacade.Free;
    FDataFacade := nil;
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  if not Assigned(FDataFacade) then
    FDataFacade := CreateDataFacade;
end;

procedure TfrmMain.LoadDataFromFile(const dsname: string);
var
  res: TLoadResult;
  ds: TDataSet;
begin
  edtRead.Text := EmptyStr;
  edtWritten.Text := EmptyStr;
  edtInsert.Text := EmptyStr;
  edtErrors.Text := EmptyStr;
  res := nil;
  if not dlgOpen.Execute then
    Exit;

  case rgLoadType.ItemIndex of
    0:
      begin { Test load }
        ds := vtFileData;
        grdFileData.DataSource := dsFileData;
      end;
    1:
      begin { Database load }
        if not FDataFacade.Connected then
          Exit;
        ds := FDataFacade.ZBDataSet[dsname];
        grdFileData.DataSource := FDataFacade.ZBDataSource[dsname];
      end;
  else
    Exit;
  end;

  try
    res := FDataFacade.LoadDataSetFromFile(dsname, dlgOpen.filename,
      bmLoader, ds);
    edtRead.Text := IntToStr(res.ReadCount);
    edtWritten.Text := IntToStr(res.WriteCount);
    edtInsert.Text := IntToStr(res.InsertCount);
    edtErrors.Text := IntToStr(res.ErrorCount);
  finally
    if Assigned(res) then
      res.Free;
  end;
end;

{$ENDREGION}

end.
