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
