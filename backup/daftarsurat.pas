unit Daftarsurat;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, database_lib;

type
  TDaftarsuratModel = class(TSimpleModel)
  private
  public
    constructor Create(const DefaultTableName: string = '');
  end;

implementation

constructor TDaftarsuratModel.Create(const DefaultTableName: string = '');
begin
  inherited Create( DefaultTableName); // table name = daftarsurats
  TableName:='daftarsurat';
  //inherited Create('yourtablename'); // if use custom tablename
end;

end.

