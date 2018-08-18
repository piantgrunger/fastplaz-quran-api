unit main;

{$mode objfpc}{$H+}



interface

uses
  Classes, SysUtils, fpcgi, fpjson, HTTPDefs, fastplaz_handler, database_lib,Daftarsurat,lconvencoding;

type
  TMainModule = class(TMyCustomWebModule)
  private
    Daftarsurat : TDaftarsuratModel;
    procedure BeforeRequestHandler(Sender: TObject; ARequest: TRequest);
  public
    constructor CreateNew(AOwner: TComponent; CreateMode: integer); override;
    destructor Destroy; override;

    procedure Get; override;
    procedure Post; override;
  end;

implementation

uses json_lib, common;

constructor TMainModule.CreateNew(AOwner: TComponent; CreateMode: integer);
begin
  inherited CreateNew(AOwner, CreateMode);
  BeforeRequest := @BeforeRequestHandler;
end;

destructor TMainModule.Destroy;
begin
  inherited Destroy;
end;

// Init First
procedure TMainModule.BeforeRequestHandler(Sender: TObject; ARequest: TRequest);
begin
  Response.ContentType := 'application/json';
end;

// GET Method Handler
procedure TMainModule.Get;
var Json:TJSONUtil;
  Surat:  TJSONArray;
  s:UnicodeString;
  i:integer;

begin

  DataBaseInit();
  json := TJSONUtil.Create;
  Daftarsurat:=TDaftarsuratModel.Create();
  Daftarsurat.All;
  Surat := TJSONArray.Create;
  json['code'] := Int16(200);
  Daftarsurat.First;
  i:=1;
  while not Daftarsurat.eof do
  begin

    Json['data/'+i2s(i)+'/index']:=Daftarsurat['index'];
    Json['data/'+i2s(i)+'/surat_indonesia']:=Daftarsurat['surat_indonesia'];
    Json['data/'+i2s(i)+'/surat_arab']:= AnsiToUTF8(Daftarsurat.Data.FieldByName('surat_arab').AsString);
    Json['data/'+i2s(i)+'/arti']:=Daftarsurat['arti'];
    Json['data/'+i2s(i)+'/jumlah_ayat']:=Daftarsurat['jumlah_ayat'];
    Json['data/'+i2s(i)+'/urutan_pewahyuan']:=Daftarsurat['urutan_pewahyuan'];





    Daftarsurat.next;
    inc(i);
  end;

  Response.Content:=json.AsJSON;
  Json.free;
  Daftarsurat.Free;

end;

// POST Method Handler
// CURL example:
//   curl -X POST -H "Authorization: Basic dW5hbWU6cGFzc3dvcmQ=" "yourtargeturl"
procedure TMainModule.Post;
var
  json : TJSONUtil;
  authstring : string;
begin
  authstring := Header['Authorization'];
  if authstring <> 'YourAuthKey' then
  begin
    //
  end;
  json := TJSONUtil.Create;

  json['code'] := Int16(0);
  json['data'] := 'yourdatahere';
  json['path01/path02/var01'] := 'value01';
  json['path01/path02/var02'] := 'value02';
  CustomHeader[ 'ThisIsCustomHeader'] := 'datacustomheader';

  //---
  Response.Content := json.AsJSON;
  json.Free;
end;



end.

