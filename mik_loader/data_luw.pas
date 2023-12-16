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
unit data_luw;

interface

uses Uni;

type
  ILUW = interface
    procedure StartTransaction;
    procedure Add(ds: TCustomUniDataSet);
    procedure Commit;
    procedure Rollback;
  end;

function CreateLUW(conn: TUniConnection): ILUW;

implementation

uses System.SysUtils, System.Classes, CRAccess;

type

  TTxStatus = (txsNew, txsActive, txsClosed);

  TMikLUW = class(TInterfacedObject, ILUW)
  private
    FStatus: TTxStatus;
    FtxR: TUniTransaction;
    FtxU: TUniTransaction;
  public
    constructor Create(conn: TUniConnection);
    destructor Destroy; override;
    procedure StartTransaction;
    procedure Add(ds: TCustomUniDataSet);
    procedure Commit;
    procedure Rollback;
  end;

function CreateLUW(conn: TUniConnection): ILUW;
begin
  Result := TMikLUW.Create(conn);
end;

constructor TMikLUW.Create(conn: TUniConnection);
begin
  FStatus := txsNew;
  FtxR := TUniTransaction.Create(nil);
  FtxR.DefaultConnection := conn;
  FtxR.IsolationLevel := ilReadCommitted;
  FtxR.DefaultCloseAction := taCommit;
  FtxR.ReadOnly := true;

  FtxU := TUniTransaction.Create(nil);
  FtxU.DefaultConnection := conn;
  FtxU.IsolationLevel := ilReadCommitted;
  FtxU.DefaultCloseAction := taRollback;
end;

destructor TMikLUW.Destroy;
begin
  if Assigned(FtxR) then
    FreeAndNil(FtxR);
  if Assigned(FtxU) then
    FreeAndNil(FtxU);

  inherited;
end;

procedure TMikLUW.StartTransaction;
begin
  if FStatus <> txsNew then
    Exit;
  FStatus := txsActive;
  FtxR.StartTransaction;
  FtxU.StartTransaction;
end;

procedure TMikLUW.Add(ds: TCustomUniDataSet);
begin
  if FStatus <> txsActive then
    Exit;
  ds.Connection := FtxR.DefaultConnection;
  if (ds is TUniStoredProc) then
    ds.Transaction := FtxU
  else
    ds.Transaction := FtxR;

  ds.UpdateTransaction := FtxU;
end;

procedure TMikLUW.Commit;
begin
  if FStatus <> txsActive then
    Exit;
  FStatus := txsClosed;
  FtxU.Commit;
  FtxR.Commit;
end;

procedure TMikLUW.Rollback;
begin
  if FStatus <> txsActive then
    Exit;
  FStatus := txsClosed;
  FtxU.Rollback;
  FtxR.Commit;
end;

end.
