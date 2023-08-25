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
unit batch_decorator;

interface

uses Uni;

type

  TBatchDecorator = class
  strict private
    Fdset: TCustomUniDataSet;
  public
    constructor Create(dset: TCustomUniDataSet);
    destructor Destroy; override;

    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
  end;

implementation

uses System.SysUtils, CRAccess;

{ TBatchDecorator }

constructor TBatchDecorator.Create(dset: TCustomUniDataSet);
begin
  if not Assigned(dset) then
    raise Exception.Create('qry is null');

  if not Assigned(dset.Connection) then
    raise Exception.Create('qry.Connection is null');

  if dset.Active then
    raise Exception.Create('qry active');

  if 'InterBase' <> dset.Connection.ProviderName then
    raise Exception.Create('For Interbase provider only');

  if dset.Transaction.Active then
    raise Exception.Create('Transaction config error');

  Fdset := dset;

  // Do NOT use the default transaction object.
  // Committing the default, will close are Queries that use this default transaction.
  Fdset.Transaction := TUniTransaction.Create(Fdset.Owner);
  Fdset.Transaction.DefaultConnection := Fdset.Connection;
  Fdset.Transaction.IsolationLevel := ilReadCommitted;
  Fdset.Transaction.DefaultCloseAction := taCommit;
  Fdset.Transaction.ReadOnly := true;

  if not Assigned(Fdset.UpdateTransaction) then
  begin
    Fdset.UpdateTransaction := TUniTransaction.Create(Fdset.Owner);
    Fdset.UpdateTransaction.DefaultConnection := Fdset.Connection;
    Fdset.UpdateTransaction.IsolationLevel := ilReadCommitted;
    Fdset.UpdateTransaction.DefaultCloseAction := taRollback;
    Fdset.UpdateTransaction.ReadOnly := false;
  end;

  dset.Active := true;
end;

destructor TBatchDecorator.Destroy;
begin
  Rollback;
  Fdset := nil;
  inherited;
end;

procedure TBatchDecorator.StartTransaction;
begin
  if not Assigned(Fdset.UpdateTransaction) then
    Exit;

  Fdset.ReadOnly := false;

  if not Fdset.UpdateTransaction.Active then
    Fdset.UpdateTransaction.StartTransaction;
end;

procedure TBatchDecorator.Commit;
begin
  if not Assigned(Fdset.UpdateTransaction) then
    Exit;

  if Fdset.UpdateTransaction.Active then
    Fdset.UpdateTransaction.Commit;

  Fdset.ReadOnly := true;
end;

procedure TBatchDecorator.Rollback;
begin
  if not Assigned(Fdset.UpdateTransaction) then
    Exit;

  if Fdset.UpdateTransaction.Active then
    Fdset.UpdateTransaction.Rollback;

  Fdset.ReadOnly := true;
end;

end.
