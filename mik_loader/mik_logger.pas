unit mik_logger;

interface

procedure MikLogWriteLn(const msg: string);

implementation

uses
  winapi.Windows;

procedure MikLogWriteLn(const msg: string);
begin
  OutputDebugString(PChar(msg));
end;

end.
