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
unit file_loader;

interface

uses FireDAC.Stan.Intf, FireDAC.Comp.BatchMove, FireDAC.Comp.BatchMove.Text,
  FireDAC.Comp.BatchMove.Dataset, Data.DB;

type

  { TODO: Add list of fields to load-info. Then pass as param to the ctor. }
  TLoadInfo = class
  strict private
    FName: String;
    FEnc: TFDEncoding; { ecDefault, ecUTF8, ecUTF16, ecANSI }
    FEol: TFDTextEndOfLine; { elDefault, elPosix, elWindows }
    FDelimiter: Char;
    FSep: Char;
    FHeader: Boolean;
    FDateFormat: String;
    FDecimalSep: Char;
    FGroupSep: Char;
  public
    constructor Create;
    property Filename: String read FName write FName;
    property Encoding: TFDEncoding read FEnc write FEnc;
    property EOL: TFDTextEndOfLine read FEol write FEol;
    property Delimiter: Char read FDelimiter write FDelimiter;
    property Separator: Char read FSep write FSep;
    property Header: Boolean read FHeader write FHeader;

    property DateFormat: String read FDateFormat write FDateFormat;
    property decimalSep: Char read FDecimalSep write FDecimalSep;
    property groupSep: Char read FGroupSep write FGroupSep;
  end;

  { Field info: name + type pair. Type = string, integer, number(p,s), date }
  SFieldType = (sftString, sftDate, sftInteger, sftNumber);

  TFieldInfo = record
  public
    name: String;
    ftype: SFieldType;
    p: integer;
    s: integer;
  end;

  TFileLoader = class
  strict private
    FDataMover: TFDBatchMove;
    FRText: TFDBatchMoveTextReader;
    FWDataset: TFDBatchMoveDataSetWriter;
    FDsAddFields: Boolean;
  public
    constructor Create(bm: TFDBatchMove; ds: TDataSet; DsAddFields: Boolean);
    procedure SetFileInfo(const info: TLoadInfo);
    procedure AddField(const name: string; const ftype: SFieldType;
      const fsize: integer = 0);
    procedure LoadFile;
  end;

implementation

{ TLoadInfo }

constructor TLoadInfo.Create;
begin
  FHeader := true;
  FSep := ',';
  FDelimiter := '"';
  FEol := elDefault;
  FEnc := ecDefault;
  FDateFormat := 'yyyy-mm-dd';
  FGroupSep := '.';
  FDecimalSep := ',';
end;

{ TFileLoader }

constructor TFileLoader.Create(bm: TFDBatchMove; ds: TDataSet;
  DsAddFields: Boolean);
begin
  bm.Mappings.ClearAndResetID;
  if DsAddFields then
    ds.FieldDefs.ClearAndResetID;

  FDsAddFields := DsAddFields;
  FDataMover := bm;
  FDataMover.Mode := dmAlwaysInsert;
  FDataMover.Options := [poClearDest];

  FRText := TFDBatchMoveTextReader.Create(FDataMover);
  FWDataset := TFDBatchMoveDataSetWriter.Create(FDataMover);
  FWDataset.Dataset := ds; // Destination dataset
  FWDataset.Dataset.Active := false;
  FWDataset.Optimise := false; // Do not Optimise if dataset is attached to UI
end;

procedure TFileLoader.LoadFile;
begin
  FDataMover.Execute;
  FWDataset.Dataset.Active := true;
end;

procedure TFileLoader.SetFileInfo(const info: TLoadInfo);
begin
  FRText.Filename := info.Filename;
  FRText.Encoding := info.Encoding;
  FRText.DataDef.EndOfLine := info.EOL;
  FRText.DataDef.Delimiter := info.Delimiter;
  FRText.DataDef.Separator := info.Separator;
  FRText.DataDef.WithFieldNames := info.Header;
  FRText.DataDef.FormatSettings.ShortDateFormat := info.DateFormat;
  FRText.DataDef.FormatSettings.ThousandSeparator := info.groupSep;
  FRText.DataDef.FormatSettings.DecimalSeparator := info.decimalSep;
end;

procedure TFileLoader.AddField(const name: string; const ftype: SFieldType;
  const fsize: integer = 0);
var
  fld: TFDTextField;
  fdef: TFieldDef;
  mi: TFDBatchMoveMappingItem;
begin
  fld := FRText.DataDef.Fields.Add;
  fld.FieldName := name;

  if FDsAddFields then
  begin
    fdef := FWDataset.Dataset.FieldDefs.AddFieldDef;
    fdef.name := name;
    // Data.DB.TFieldType: a set of values that parallels the data types of fields in tables.
    case ftype of
      sftString:
        begin
          fld.DataType := TFDTextDataType.atString;
          fdef.DataType := ftString;
          if fsize > 0 then
            fdef.Size := fsize;
        end;
      sftDate:
        begin
          fld.DataType := TFDTextDataType.atDate;
          fdef.DataType := TFieldType.ftDate;
        end;
      sftInteger:
        begin
          fld.DataType := TFDTextDataType.atLongInt;
          fdef.DataType := TFieldType.ftLargeint;
        end;
      sftNumber:
        begin
          fld.DataType := TFDTextDataType.atFloat;
          fdef.DataType := TFieldType.ftFloat;
        end;
    end;
  end;

  mi := FDataMover.Mappings.Add;
  mi.SourceFieldName := name;
  mi.DestinationFieldName := name;
end;

end.
