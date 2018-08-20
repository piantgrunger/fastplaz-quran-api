unit suratmodule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcgi, fpjson, HTTPDefs, fastplaz_handler, database_lib,quran;

type
  TSuratModule = class(TMyCustomWebModule)
  private
    Fquran : TQuranModel;
  public
    constructor CreateNew(AOwner: TComponent; CreateMode: integer); override;
    destructor Destroy; override;

    procedure Get; override;
    procedure Post; override;
  end;

implementation

uses common, json_lib;

constructor TSuratModule.CreateNew(AOwner: TComponent; CreateMode: integer);
begin
  inherited CreateNew(AOwner, CreateMode);
end;

destructor TSuratModule.Destroy;
begin
  inherited Destroy;
end;

// GET Method Handler
procedure TSuratModule.Get;
var
  json : TJSONUtil;

begin
  json := TJSONUtil.Create;

  json['code'] := Int16(0);
  json['variable'] := 'value';
  json['path01/path02/var01'] := 'value01';
  json['path01/path02/var02'] := 'value02';
  json['msg'] := 'Ok';

  //---
  Response.ContentType := 'application/json';
  Response.Content := json.AsJSON;
  json.Free;
end;

// POST Method Handler
procedure TSuratModule.Post;
begin
  Response.Content := '';
end;




initialization
  // -> http://yourdomainname/surat
  // The following line should be moved to a file "routes.pas"
  Route.Add('surat', TSuratModule);

end.

