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

uses Uni, CRBatchMove;

{
  DD: create = start transaction.
  Add = execute statement.
}
type
  ILUW = interface
    procedure StartTransaction;
    procedure AddStoredProc(sp: TUniStoredProc);
    procedure AddBatchMove(bm: TCRBatchMove);
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
    procedure AddStoredProc(sp: TUniStoredProc);
    procedure AddBatchMove(bm: TCRBatchMove);
    procedure Commit;
    procedure Rollback;
  end;

function CreateLUW(conn: TUniConnection): ILUW;
begin
  if not Assigned(conn) then
    Exit(nil);
  if not('InterBase' = conn.ProviderName) then
    Exit(nil);

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

procedure TMikLUW.AddBatchMove(bm: TCRBatchMove);
var
  dst: TCustomUniDataSet;
begin
  if FStatus <> txsActive then
    Exit;
  if not Assigned(bm) then
    Exit;
  if not(bm.Destination is TCustomUniDataSet) then
    Exit;

  dst := bm.Destination as TCustomUniDataSet;
  dst.Transaction := FtxR;
  dst.UpdateTransaction := FtxU;
  bm.Execute;
end;

procedure TMikLUW.AddStoredProc(sp: TUniStoredProc);
begin
  if FStatus <> txsActive then
    Exit;

  if not Assigned(sp) then
    Exit;
  if not Assigned(sp.Connection) then
    Exit;
  // check if dsame conn as in ctor.
  if not('InterBase' = sp.Connection.ProviderName) then
    Exit;

  sp.Transaction := FtxU;
  sp.UpdateTransaction := FtxU;
  sp.ExecProc;
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
