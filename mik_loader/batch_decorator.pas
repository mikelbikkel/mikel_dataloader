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
  { TODO: add Truncate to IDDBatch?
    Execute delete from ds.UpdatingTable as part of the batch transaction. }

  { IDD = Interface Data Decorator }
  IDDBatch = interface
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
  end;

function CreateReadOnlyDecorator(ds: TDataSet): IDDReadOnly;
function CreateBatchDecorator(ds: TDataSet; bTruncate: boolean = false)
  : IDDBatch;

implementation

uses System.SysUtils, System.Classes, CRAccess, Uni, mik_logger;

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
    FTruncate: TUniSQL;
    Ftx: TUniTransaction;
    FtxU: TUniTransaction;
    function IsInterbase: boolean;
    function GetTableName: string;
    procedure EndTransaction(const doCommit: boolean);
    procedure SetIsolationLevelFB(const tx: TUniTransaction);
  public
    constructor Create(const ds: TDataSet; bTruncate: boolean = false);
    destructor Destroy; override;

    function ToString: string; override;

    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
  end;

function CreateReadOnlyDecorator(ds: TDataSet): IDDReadOnly;
begin
  Result := TReadOnlyDecorator.Create(ds);
end;

function CreateBatchDecorator(ds: TDataSet; bTruncate: boolean): IDDBatch;
begin
  Result := TBatchDecorator.Create(ds, bTruncate);
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

constructor TBatchDecorator.Create(const ds: TDataSet;
  bTruncate: boolean = false);
begin
  if not Assigned(ds) then
    raise Exception.Create('qry is null');

  if ds.Active then
    raise Exception.Create('qry active');

  Fdata := ds;

  { Only use transactions with a TCustomUniDataSet descendant.
    If the dataset is, for example, a virtual table... skip the transaction management. }
  if not(Fdata is TCustomUniDataSet) then
    Exit;

  if not IsInterbase then
    Exit;

  var
  uds := Fdata as TCustomUniDataSet;
  if not uds.Transaction.Active then
  begin
    // Do NOT use the default transaction object.
    // Commit the default, and you close all Queries using this default tx.
    Ftx := TUniTransaction.Create(nil);
    Ftx.AddConnection(uds.Connection);
    SetIsolationLevelFB(Ftx);
    // Ftx.IsolationLevel := ilReadCommitted;
    Ftx.DefaultCloseAction := taCommit;
    Ftx.ReadOnly := true;
    uds.Transaction := Ftx;

    {

      I think I figured out why the transactions weren't committing.
      I needed to add this code:

      IsolationLevel := ilCustom;
      slParams := TStringList.Create;
      slParams.Add('wait');  nowait [lock resolution]
      slParams.Add('read_committed');  consistency [concurrency]
      slParams.Add('rec_version');
      SpecificOptions.Values['Params'] := slParams.Text;
      FreeAndNil(slParams);

      It seems to be working after code was adjusted as above.
    }
  end;

  if not Assigned(uds.UpdateTransaction) then
  begin
    FtxU := TUniTransaction.Create(nil);
    FtxU.AddConnection(uds.Connection);
    FtxU.IsolationLevel := ilReadCommitted;
    FtxU.DefaultCloseAction := taRollback;
    FtxU.ReadOnly := false;
    uds.UpdateTransaction := FtxU;
    if bTruncate then
    begin
      var
        TableName: string := GetTableName;
      if TableName <> EmptyStr then
      begin
        FTruncate := TUniSQL.Create(uds.Owner);
        FTruncate.Connection := uds.Connection;
        FTruncate.Transaction := FtxU;
        FTruncate.SQL.Add('delete from ' + TableName);
        FTruncate.Debug := true;
      end;
    end;
  end;
end;

destructor TBatchDecorator.Destroy;
begin
  if Assigned(Fdata) then
  begin
    Rollback;
    Fdata := nil;
    if Assigned(Ftx) then
    begin
      Ftx.Free;
      Ftx := nil;
    end;
    if Assigned(FtxU) then
    begin
      FtxU.Free;
      FtxU := nil;
    end;
  end;
  if Assigned(FTruncate) then
  begin
    FTruncate.Free;
    FTruncate := nil;
  end;

  inherited;
end;

function TBatchDecorator.GetTableName: string;
begin
  if not Assigned(Fdata) then
  begin
    Result := EmptyStr;
    Exit;
  end;

  if (Fdata is TUniTable) then
  begin
    var
    ut := Fdata as TUniTable;
    Result := ut.TableName;
  end
  else if (Fdata is TUniQuery) then
  begin
    var
    uq := Fdata as TUniQuery;
    Result := uq.UpdatingTable;
  end
  else
    Result := EmptyStr;
end;

function TBatchDecorator.IsInterbase: boolean;
begin
  if not Assigned(Fdata) then
    Exit(false);

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

procedure TBatchDecorator.SetIsolationLevelFB(const tx: TUniTransaction);
var
  slParams: TStringList;
begin
  // unit: IBC      TIBCTransaction = class(TDATransaction);
  // https://docwiki.embarcadero.com/InterBase/2020/en/Understanding_InterBase_Transactions
  // each row version contains the number of the tx that created it.
  // InterBase tracks the state of transactions on the transaction inventory pages (TIP).
  { [1] snapshot isolation.      aka concurrency
    When a transaction using snapshot isolation starts:
    InterBase makes a copy of the TIP and gives the new transaction a pointer to this copy.
    This enables the transaction to determine what the state of
    all other transactions was when it started.

    snapshot transaction finds the most recent version of the row that was already
    committed when the snapshot transaction started
    allows the transaction to see only those changes that  were committed before
    it was started.

    [2] read committed.
    When a read committed transaction starts it gets a pointer to the
    live TIP (actually the TIP cache or TPC) so it can determine the current
    state of any transaction.

    read committed transaction will get the most recent version of the row that
    was created by a transaction whose current state is committed

    One of three modifying parameters can be specified for READ COMMITTED transactions,
    depending on the kind of conflict resolution desired: READ CONSISTENCY,
    RECORD_VERSION or NO RECORD_VERSION.
    When the ReadConsistency setting is set to 1 in firebird.conf (the default)
    or in databases.conf, these variants are effectively ignored and behave as READ CONSISTENCY
    The other two variants can result in statement-level inconsistent reads
    as they may read some but not all changes of a concurrent transaction if
    that transaction commits during statement execution.
    For example, a SELECT COUNT(*) could read some, but not all inserted records
    of another transaction if the commit of that transaction occurs while the
    statement is reading records


    [3] Consistency.           aka Table Stability.
    Provides a stable view of the data
    and is serializable. However, serializability is achieved by locking tables
    which blocks updates by other transactions.
    no other transactions can make any changes to any table in the database that
    has changes pending for this transaction

    When your transaction updates an existing row your transaction places a
    row level write lock on that row until the transaction ends.
    This prevents another transaction from updating the same row before
    your transaction either commits or rolls back.
    The lock resolution setting determines what happens to the other
    transaction when it tries to update a row that your transaction has locked.
    wait, the other transaction will wait until your transaction ends.
    nowait the other transaction will return an error immediately when it
    tries to update the locked row.
    Default = wait.

    If, for some reason, you cannot use the wait option there is another alternative.
    The table reservation mechanism lets you lock tables when your transaction
    starts so you are guaranteed the access you need to every row in the tables
    for the life of your transaction. The disadvantage of table reservation
    is that no other transaction can update the reserved tables for the
    life of your transaction.
  }
  tx.IsolationLevel := ilCustom;
  slParams := TStringList.Create;
  slParams.Add('read'); // read; "read write" [access mode]
  slParams.Add('wait'); // wait nowait [lock resolution]
  slParams.Add('read_committed');
  // [isolation level]: consistency(=table stability) concurrency(=snapshot) read_committed
  // slParams.Add('no_rec_version'); // no_rec_version
  tx.SpecificOptions.Values['Params'] := slParams.Text;
  FreeAndNil(slParams);
end;

procedure TBatchDecorator.StartTransaction;
var
  cnt: Integer;
begin
  if not Assigned(Fdata) then
    Exit;

  if (Fdata is TCustomUniDataSet) then
  begin
    var
    uds := Fdata as TCustomUniDataSet;
    if IsInterbase and Assigned(uds.UpdateTransaction) then
      if not uds.UpdateTransaction.Active then
      begin
        uds.UpdateTransaction.StartTransaction;
        if Assigned(FTruncate) then
        begin
          FTruncate.Execute;
          cnt := FTruncate.RowsAffected;
        end;
      end;
  end;
end;

function TBatchDecorator.ToString: string;
begin
  Result := self.ClassName;
  if Assigned(Fdata) then
    Result := Result + ': ' + Fdata.Name + ' [' + GetTableName + '].';
  if Assigned(FtxU) then
  begin
    Result := Result + ' FtxU: ' + IntToHex(Integer(FtxU), 8);
  end
  else
    Result := Result + ' FtxU: nil';
  if Assigned(Ftx) then
  begin
    Result := Result + ' Ftx: ' + IntToHex(Integer(Ftx), 8);
  end
  else
    Result := Result + ' Ftx: nil';
  if Assigned(FTruncate) then
    Result := Result + '. Truncate: True.'
  else
    Result := Result + '. Truncate: False.';
end;

procedure TBatchDecorator.Commit;
begin
  EndTransaction(true);
end;

procedure TBatchDecorator.Rollback;
begin
  EndTransaction(false);
end;

procedure TBatchDecorator.EndTransaction(const doCommit: boolean);
begin
  if not Assigned(Fdata) then
    Exit;

  if (Fdata is TCustomUniDataSet) then
  begin
    var
    uds := Fdata as TCustomUniDataSet;
    if IsInterbase and Assigned(uds.UpdateTransaction) then
      if uds.UpdateTransaction.Active then
      begin
        if doCommit then
          uds.UpdateTransaction.Commit
        else
          uds.UpdateTransaction.Rollback;
        if Assigned(FTruncate) then
        begin
          FTruncate.Free;
          FTruncate := nil;
        end;
      end;
    if Assigned(uds.Transaction) then
      if uds.Transaction.Active then
        uds.Transaction.Commit;
  end;
end;

{$ENDREGION}

end.
