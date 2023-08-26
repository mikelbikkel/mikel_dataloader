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

uses Uni, data_facade;

type
  { IDD = Interface Data Decorator }
  IDDBatch = interface
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
  end;

function CreateReadOnlyDecorator(ds: TCustomUniDataSet): IDDReadOnly;
function CreateBatchDecorator(ds: TCustomUniDataSet): IDDBatch;

implementation

uses System.SysUtils, CRAccess;

type
  TReadOnlyDecorator = class(TInterfacedObject, IDDReadOnly)
  private
    Fdata: TCustomUniDataSet;
    function IsInterbase: boolean;
  public
    constructor Create(ds: TCustomUniDataSet);

    destructor Destroy; override;

    procedure Open;

    procedure Refresh;

    procedure Close;
  end;

  TBatchDecorator = class(TInterfacedObject, IDDBatch)
  strict private
    Fdset: TCustomUniDataSet;
    function IsInterbase: boolean;
  public
    constructor Create(dset: TCustomUniDataSet);
    destructor Destroy; override;

    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
  end;

function CreateReadOnlyDecorator(ds: TCustomUniDataSet): IDDReadOnly;
begin
  Result := TReadOnlyDecorator.Create(ds);
end;

function CreateBatchDecorator(ds: TCustomUniDataSet): IDDBatch;
begin
  Result := TBatchDecorator.Create(ds);
end;

{$REGION 'TReadOnlyDecorator'}
{ TReadOnlyDecorator }

constructor TReadOnlyDecorator.Create(ds: TCustomUniDataSet);
begin
  if not Assigned(ds) then
    raise Exception.Create('ds: nil');

  Fdata := ds;

  if IsInterbase then
  begin
    if not Fdata.Transaction.Active then
    begin
      // Do NOT use the default transaction object.
      // Committing the default, will close all Queries that use this default transaction.
      Fdata.Transaction := TUniTransaction.Create(Fdata.Owner);
      Fdata.Transaction.DefaultConnection := Fdata.Connection;
      Fdata.Transaction.IsolationLevel := ilReadCommitted;
      Fdata.Transaction.DefaultCloseAction := taCommit;
      Fdata.Transaction.ReadOnly := true;
    end;
  end;

  Fdata.ReadOnly := true;
end;

destructor TReadOnlyDecorator.Destroy;
begin
  Close;
  Fdata := nil;
  inherited;
end;

function TReadOnlyDecorator.IsInterbase: boolean;
begin
  Result := ('InterBase' = Fdata.Connection.ProviderName);
end;

procedure TReadOnlyDecorator.Open;
begin
  if Fdata.Connection.Connected then
  begin
    if not Fdata.Active then
      Fdata.Active := true;
    if IsInterbase then
      if not Fdata.Transaction.Active then
        Fdata.Transaction.StartTransaction;
  end;
end;

procedure TReadOnlyDecorator.Refresh;
begin
  if Fdata.Connection.Connected and Fdata.Active then
    Fdata.Refresh;
end;

procedure TReadOnlyDecorator.Close;
begin
  if Fdata.Connection.Connected then
  begin
    if IsInterbase then
      if Fdata.Transaction.Active then
        Fdata.Transaction.Commit;
    if Fdata.Active then
      Fdata.Active := false;
  end;
end;

{$ENDREGION}
{$REGION 'TBatchDecorator'}
{ TBatchDecorator }

constructor TBatchDecorator.Create(dset: TCustomUniDataSet);
begin
  if not Assigned(dset) then
    raise Exception.Create('qry is null');

  if dset.Active then
    raise Exception.Create('qry active');

  Fdset := dset;

  if IsInterbase and (not Assigned(Fdset.UpdateTransaction)) then
  begin
    Fdset.UpdateTransaction := TUniTransaction.Create(Fdset.Owner);
    Fdset.UpdateTransaction.DefaultConnection := Fdset.Connection;
    Fdset.UpdateTransaction.IsolationLevel := ilReadCommitted;
    Fdset.UpdateTransaction.DefaultCloseAction := taRollback;
    Fdset.UpdateTransaction.ReadOnly := false;
  end;
end;

destructor TBatchDecorator.Destroy;
begin
  if Assigned(Fdset) then
  begin
    Rollback;
    Fdset := nil;
  end;

  inherited;
end;

function TBatchDecorator.IsInterbase: boolean;
begin
  Result := ('InterBase' = Fdset.Connection.ProviderName);
end;

procedure TBatchDecorator.StartTransaction;
begin
  if IsInterbase then
  begin
    if not Assigned(Fdset.UpdateTransaction) then
      Exit;

    if not Fdset.UpdateTransaction.Active then
      Fdset.UpdateTransaction.StartTransaction;
  end;
  Fdset.ReadOnly := false;
end;

procedure TBatchDecorator.Commit;
begin
  if IsInterbase then
  begin
    if not Assigned(Fdset.UpdateTransaction) then
      Exit;

    if Fdset.UpdateTransaction.Active then
      Fdset.UpdateTransaction.Commit;
  end;

  Fdset.ReadOnly := true;
end;

procedure TBatchDecorator.Rollback;
begin
  if IsInterbase then
  begin
    if not Assigned(Fdset.UpdateTransaction) then
      Exit;

    if Fdset.UpdateTransaction.Active then
      Fdset.UpdateTransaction.Rollback;
  end;

  Fdset.ReadOnly := true;
end;
{$ENDREGION}

end.
