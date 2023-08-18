unit dm_ora_zakelijk;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, Uni, UniProvider,
  OracleUniProvider, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf,
  FireDAC.Comp.UI;

type
  TdmOraZakelijk = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmOraZakelijk: TdmOraZakelijk;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
