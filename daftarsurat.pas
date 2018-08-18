unit Daftarsurat;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, database_lib;

type

  { TDaftarsuratModel }

  TDaftarsuratModel = class(TSimpleModel)
  private
  public
    function GetTextCodePage(var T: Text): TSystemCodePage;
    constructor Create(const DefaultTableName: string = '');
  end;

implementation

function TDaftarsuratModel.GetTextCodePage(var T: Text): TSystemCodePage;
begin

end;

constructor TDaftarsuratModel.Create(const DefaultTableName: string = '');
begin
  inherited Create( DefaultTableName); // table name = daftarsurats
  TableName:='daftarsurat';
  //inherited Create('yourtablename'); // if use custom tablename
end;

end.

