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

uses Data.DB, data_facade;

type
  { IDD = Interface Data Decorator }
  IDDBatch = interface
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
  end;

function CreateReadOnlyDecorator(ds: TDataSet): IDDReadOnly;
function CreateBatchDecorator(ds: TDataSet): IDDBatch;

implementation

uses System.SysUtils, CRAccess, Uni;

type
  TReadOnlyDecorator = class(TInterfacedObject, IDDReadOnly)
  private
    Fdata: TDataSet;
    function IsInterbase: boolean;
  public
    constructor Create(ds: TDataSet);

    destructor Destroy; override;

    procedure Open;

    procedure Refresh;

    procedure Close;

    function GetDataSet: TDataSet;

  end;

  TBatchDecorator = class(TInterfacedObject, IDDBatch)
  strict private
    Fdata: TDataSet;
    function IsInterbase: boolean;
  public
    constructor Create(const ds: TDataSet);
    destructor Destroy; override;

    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
  end;

function CreateReadOnlyDecorator(ds: TDataSet): IDDReadOnly;
begin
  Result := TReadOnlyDecorator.Create(ds);
end;

function CreateBatchDecorator(ds: TDataSet): IDDBatch;
begin
  Result := TBatchDecorator.Create(ds);
end;

{$REGION 'TReadOnlyDecorator'}
{ TReadOnlyDecorator }

constructor TReadOnlyDecorator.Create(ds: TDataSet);
begin
  if not Assigned(ds) then
    raise Exception.Create('ds: nil');

  Fdata := ds;

  { Only use transactions with a TCustomUniDataSet descendant.
    If the dataset is, for example, a virtual table... skip the transaction management. }
  if (Fdata is TCustomUniDataSet) then
  begin
    var
    uds := Fdata as TCustomUniDataSet;

    if IsInterbase and (not uds.Transaction.Active) then
    begin
      // Do NOT use the default transaction object.
      // Committing the default, will close all Queries that use this default transaction.
      uds.Transaction := TUniTransaction.Create(Fdata.Owner);
      uds.Transaction.DefaultConnection := uds.Connection;
      uds.Transaction.IsolationLevel := ilReadCommitted;
      uds.Transaction.DefaultCloseAction := taCommit;
      uds.Transaction.ReadOnly := true;
    end;

    uds.ReadOnly := true;
  end;
end;

destructor TReadOnlyDecorator.Destroy;
begin
  Close;
  Fdata := nil;
  inherited;
end;

function TReadOnlyDecorator.GetDataSet: TDataSet;
begin
  Result := Fdata;
end;

function TReadOnlyDecorator.IsInterbase: boolean;
begin
  if (Fdata is TCustomUniDataSet) then
  begin
    var
    uds := Fdata as TCustomUniDataSet;
    Result := Assigned(uds.Connection) and
      ('InterBase' = uds.Connection.ProviderName);
  end
  else
    Result := false;
end;

procedure TReadOnlyDecorator.Open;
begin
  if not Fdata.Active then
    Fdata.Active := true;

  if (Fdata is TCustomUniDataSet) then
  begin
    var
    uds := Fdata as TCustomUniDataSet;
    if uds.Connection.Connected and IsInterbase then
      if not uds.Transaction.Active then
        uds.Transaction.StartTransaction;
  end;
end;

procedure TReadOnlyDecorator.Refresh;
begin
  if (Fdata is TCustomUniDataSet) then
  begin
    var
    uds := Fdata as TCustomUniDataSet;
    if uds.Connection.Connected and Fdata.Active then
      uds.Refresh;
  end;
end;

procedure TReadOnlyDecorator.Close;
begin
  if (Fdata is TCustomUniDataSet) then
  begin
    var
    uds := Fdata as TCustomUniDataSet;
    if uds.Connection.Connected and IsInterbase then
      if uds.Transaction.Active then
        uds.Transaction.Commit;
  end;
  if Fdata.Active then
    Fdata.Active := false;
end;

{$ENDREGION}
{$REGION 'TBatchDecorator'}
{ TBatchDecorator }

constructor TBatchDecorator.Create(const ds: TDataSet);
begin
  if not Assigned(ds) then
    raise Exception.Create('qry is null');

  if ds.Active then
    raise Exception.Create('qry active');

  Fdata := ds;
  { Only use transactions with a TCustomUniDataSet descendant.
    If the dataset is, for example, a virtual table... skip the transaction management. }
  if (Fdata is TCustomUniDataSet) then
  begin
    var
    uds := Fdata as TCustomUniDataSet;
    if IsInterbase and (not Assigned(uds.UpdateTransaction)) then
    begin
      uds.UpdateTransaction := TUniTransaction.Create(uds.Owner);
      uds.UpdateTransaction.DefaultConnection := uds.Connection;
      uds.UpdateTransaction.IsolationLevel := ilReadCommitted;
      uds.UpdateTransaction.DefaultCloseAction := taRollback;
      uds.UpdateTransaction.ReadOnly := false;
    end;
  end;
end;

destructor TBatchDecorator.Destroy;
begin
  if Assigned(Fdata) then
  begin
    Rollback;
    Fdata := nil;
  end;

  inherited;
end;

function TBatchDecorator.IsInterbase: boolean;
begin
  if (Fdata is TCustomUniDataSet) then
  begin
    var
    uds := Fdata as TCustomUniDataSet;
    Result := Assigned(uds.Connection) and
      ('InterBase' = uds.Connection.ProviderName);
  end
  else
    Result := false;
end;

procedure TBatchDecorator.StartTransaction;
begin
  if (Fdata is TCustomUniDataSet) then
  begin
    var
    uds := Fdata as TCustomUniDataSet;
    if IsInterbase and Assigned(uds.UpdateTransaction) then
      if not uds.UpdateTransaction.Active then
        uds.UpdateTransaction.StartTransaction;
    uds.ReadOnly := false;
  end;
end;

procedure TBatchDecorator.Commit;
begin
  if (Fdata is TCustomUniDataSet) then
  begin
    var
    uds := Fdata as TCustomUniDataSet;
    if IsInterbase and Assigned(uds.UpdateTransaction) then
      if uds.UpdateTransaction.Active then
        uds.UpdateTransaction.Commit;
    uds.ReadOnly := true;
  end;
end;

procedure TBatchDecorator.Rollback;
begin
  if (Fdata is TCustomUniDataSet) then
  begin
    var
    uds := Fdata as TCustomUniDataSet;
    if IsInterbase and Assigned(uds.UpdateTransaction) then
      if uds.UpdateTransaction.Active then
        uds.UpdateTransaction.Rollback;
    uds.ReadOnly := true;
  end;
end;
{$ENDREGION}

end.
