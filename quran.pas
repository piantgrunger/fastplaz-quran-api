unit quran;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, database_lib;

type
  TQuranModel = class(TSimpleModel)
  private
  public
    constructor Create(const DefaultTableName: string = '');
  end;

implementation

constructor TQuranModel.Create(const DefaultTableName: string = '');
begin
  inherited Create( DefaultTableName);
  TableName:='quran';
  // table name = qurans
  //inherited Create('yourtablename'); // if use custom tablename
end;

end.

