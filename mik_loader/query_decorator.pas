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
unit query_decorator;

interface

uses Uni;

type

  IQueryDecorator = interface
    { Add child after decorator is created, but before it's opened. }
    procedure AddChild(qryC: TUniQuery);

    { Activate the queries and populate the dataset. }
    procedure Open;

    { Rollback changes, if any, to the database. }
    procedure Close;

    { Commit changes, if any to the database. }
    procedure Save;

    { Cancel all the cached (local) updates. }
    procedure Cancel;

    procedure Refresh;
    function HasChanges: boolean;
  end;

function CreateQueryDecorator(qry: TUniQuery): IQueryDecorator;
function CreateQueryDecoratorMD(qryMaster: TUniQuery; qryDetail: TUniQuery)
  : IQueryDecorator;

{ ============================================================================ }
implementation

{$BOOLEVAL OFF}

uses System.SysUtils, Data.DB, CRAccess;

type
  TQryDecoratorBase = class abstract(TInterfacedObject, IQueryDecorator)
  private

  strict protected
    Fqry: TUniQuery;
    FChild: TUniQuery;

    function childActive: boolean; inline;
    function parentActive: boolean; inline;
    procedure postEdits;

    procedure doCreate; virtual; abstract;
    procedure doAddChild; virtual; abstract;
    procedure doOpen; virtual; abstract;
    procedure doSave; virtual; abstract;
    procedure doClose; virtual; abstract;
  public
    // Define a Create constructor parameters, this replaces the default
    // Create and makes its use compulsory.
    constructor Create(qry: TUniQuery);
    destructor Destroy; override;
    procedure AddChild(qryC: TUniQuery);
    procedure Open;
    procedure Close;
    procedure Save;
    procedure Refresh;
    function HasChanges: boolean;
    procedure Cancel;
  end;

  // A FireBird decorator.
  // Supports multiple, concurrent transactions within 1 connection.
  TQryDecoratorFB = class(TQryDecoratorBase)
  strict protected
    procedure doCreate; override;
    procedure doAddChild; override;
    procedure doOpen; override;
    procedure doSave; override;
    procedure doClose; override;
  end;

  // A decorator that supports only 1 concurrent transaction within 1 connection.
  TQryDecoratorUni = class(TQryDecoratorBase)
  strict protected
    procedure doCreate; override;
    procedure doAddChild; override;
    procedure doOpen; override;
    procedure doSave; override;
    procedure doClose; override;
  end;

  { ============================================================================ }
procedure CheckDecoratorInput(qry: TUniQuery);
begin
  if not Assigned(qry) then
    raise Exception.Create('qry is null');
  if not Assigned(qry.Connection) then
    raise Exception.Create('qry.Connection is null');
  if qry.Active then
    raise Exception.Create('qry active');
end;

function CreateQueryDecorator(qry: TUniQuery): IQueryDecorator;
begin
  CheckDecoratorInput(qry);

  if 'InterBase' = qry.Connection.ProviderName then
    Result := TQryDecoratorFB.Create(qry)
  else
    Result := TQryDecoratorUni.Create(qry);
end;

function CreateQueryDecoratorMD(qryMaster: TUniQuery; qryDetail: TUniQuery)
  : IQueryDecorator;
begin
  CheckDecoratorInput(qryMaster);
  CheckDecoratorInput(qryDetail);

  Result := CreateQueryDecorator(qryMaster);
  Result.AddChild(qryDetail);
end;
{ ============================================================================ }
{$REGION 'TQryDecoratorBase'}
{ TQryDecoratorBase }

constructor TQryDecoratorBase.Create(qry: TUniQuery);
begin
  if not Assigned(qry) or qry.Active then
    raise Exception.Create('qry is null/active');

  Fqry := qry;
  Fqry.CachedUpdates := not Fqry.ReadOnly;

  doCreate;
end;

function TQryDecoratorBase.childActive: boolean;
begin
  Result := Assigned(FChild) and FChild.Active;
end;

function TQryDecoratorBase.parentActive: boolean;
begin
  Result := Fqry.Connection.Connected and Fqry.Active;
end;

procedure TQryDecoratorBase.postEdits;
begin
  if parentActive and (Fqry.State in [dsInsert, dsEdit, dsSetKey]) then
    Fqry.Post;
  if (childActive and (FChild.State in [dsInsert, dsEdit, dsSetKey])) then
    FChild.Post;
end;

procedure TQryDecoratorBase.AddChild(qryC: TUniQuery);
begin
  if (not Assigned(qryC)) or qryC.Active then
    Exit;

  { Add child before opening the decorator. }
  if parentActive then
    Exit;

  FChild := qryC;
  FChild.ReadOnly := Fqry.ReadOnly;
  FChild.Options.LocalMasterDetail := not Fqry.ReadOnly;
  FChild.CachedUpdates := not Fqry.ReadOnly;
  doAddChild;
end;

procedure TQryDecoratorBase.Open;
begin
  if Fqry.Connection.Connected then
  begin
    doOpen;
    if Assigned(FChild) then
      FChild.Active := true;
    Fqry.Active := true;

  end;
  // on E: EDatabaseError do
  // on E: Exception do
end;

procedure TQryDecoratorBase.Close;
begin
  Cancel;
  doClose;
  if parentActive then
    Fqry.Close;
  if childActive then
    FChild.Close;
end;

destructor TQryDecoratorBase.Destroy;
begin
  if Assigned(Fqry) then
    Close;
  Fqry := nil;
  FChild := nil;

  inherited;
end;

procedure TQryDecoratorBase.Cancel;
begin
  if parentActive and Fqry.ReadOnly then
    Exit;

  if childActive then
  begin
    FChild.Cancel;
    FChild.CancelUpdates;
  end;
  if parentActive then
  begin
    Fqry.Cancel;
    Fqry.CancelUpdates;
  end;
end;

procedure TQryDecoratorBase.Save;
begin
  if Fqry.ReadOnly then
    Exit;

  postEdits;
  if Fqry.UpdatesPending or (childActive and FChild.UpdatesPending) then
    doSave;
end;

procedure TQryDecoratorBase.Refresh;
begin
  if parentActive then
    Fqry.Refresh;
  if childActive then
    FChild.Refresh;
end;

function TQryDecoratorBase.HasChanges: boolean;
begin
  if Fqry.ReadOnly then
    Exit(false);
  if parentActive and (Fqry.State in [dsInsert, dsEdit, dsSetKey]) then
    Result := true
  else if (childActive and (FChild.State in [dsInsert, dsEdit, dsSetKey])) then
    Result := true
  else if Fqry.UpdatesPending or (childActive and FChild.UpdatesPending) then
    Result := true
  else
    Result := false;
end;

{$ENDREGION}
{ ============================================================================ }
{$REGION 'TQryDecoratorFB'}

{ TQryDecoratorFB }
procedure TQryDecoratorFB.doCreate;
begin
  // TODO: this fails if the qry is active in the IDE.
  if Fqry.Transaction.Active then // or Assigned(Fqry.UpdateTransaction) then
    Exit; // raise Exception.Create('Transaction config error');

  // Do NOT use the default transaction object.
  // Committing the default, will close are Queries that use this default transaction.
  Fqry.Transaction := TUniTransaction.Create(Fqry.Owner);
  Fqry.Transaction.DefaultConnection := Fqry.Connection;
  Fqry.Transaction.IsolationLevel := ilReadCommitted;
  Fqry.Transaction.DefaultCloseAction := taCommit;
  Fqry.Transaction.ReadOnly := true;

  if not Fqry.ReadOnly then
  begin
    Fqry.UpdateTransaction := TUniTransaction.Create(Fqry.Owner);
    Fqry.UpdateTransaction.DefaultConnection := Fqry.Connection;
    Fqry.UpdateTransaction.IsolationLevel := ilReadCommitted;
    Fqry.UpdateTransaction.DefaultCloseAction := taRollback;
    Fqry.UpdateTransaction.ReadOnly := false;
  end;
end;

procedure TQryDecoratorFB.doAddChild;
begin
  // TODO: this fails if the qry is active in the IDE.
  if FChild.Transaction.Active then
    // or Assigned(FChild.UpdateTransaction) then
    raise Exception.Create('Transaction config error');

  FChild.Transaction := Fqry.Transaction;
  if not Fqry.ReadOnly then
    FChild.UpdateTransaction := Fqry.UpdateTransaction;
end;

procedure TQryDecoratorFB.doOpen;
begin
  if not Fqry.Transaction.Active then
    Fqry.Transaction.StartTransaction;
end;

procedure TQryDecoratorFB.doSave;
begin
  if not parentActive or Fqry.ReadOnly then
    Exit;
  if Fqry.UpdateTransaction.Active then
    raise Exception.Create('Transaction config error');

  Fqry.UpdateTransaction.StartTransaction;
  try
    Fqry.ApplyUpdates;
    if childActive then
      FChild.ApplyUpdates;

    Fqry.UpdateTransaction.Commit;
    Fqry.CommitUpdates;
    if childActive then
      FChild.CommitUpdates;
  except
    Fqry.RestoreUpdates;
    if childActive then
      FChild.RestoreUpdates;
    Fqry.UpdateTransaction.Rollback;
    raise;
  end;
end;

procedure TQryDecoratorFB.doClose;
begin
  if parentActive and Fqry.Transaction.Active then
    Fqry.Transaction.Commit;
  { Committing the transaction closes the parent and child queries.
    No need to call CommitUpdates. }

  { Update transaction cannot be active }
  // if Fqry.UpdateTransaction.Active then
  // Fqry.UpdateTransaction.Rollback;
end;
{$ENDREGION}
{ ============================================================================ }
{$REGION 'TQryDecoratorUni'}
{ For non-FB decorator
  Note: The preferred method for updating datasets is to call a
  connection component's ApplyUpdates method rather than to call each
  individual dataset's ApplyUpdates method. The connection component's
  ApplyUpdates method takes care of committing and
  rolling back transactions and clearing the cache
  when the operation is successful.

  TODO: SHOULD WE ROLLBACK???? What about changes from other queries???
  Same for commit.
}

{ TQryDecoratorUni }
procedure TQryDecoratorUni.doCreate;
begin
end;

procedure TQryDecoratorUni.doAddChild;
begin

end;

procedure TQryDecoratorUni.doOpen;
begin
end;

procedure TQryDecoratorUni.doSave;
begin
end;

procedure TQryDecoratorUni.doClose;
begin
end;

{$ENDREGION }

end.
