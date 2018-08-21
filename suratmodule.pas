unit suratmodule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcgi, fpjson, HTTPDefs, fastplaz_handler,
  database_lib,quran,string_helpers;
const
  MSG_CONTENT_NOTFOUND = 'Content Not Found';
  MSG_DATA_NOTFOUND = 'Data Not Found';

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
  s:string;
  Jarray: TJSONArray;

begin
  json := TJSONUtil.Create;

  DataBaseInit();

  s := _GET['$1']; // <<-- first parameter in routing: Route['^/([0-9_]+)'] := TMainModule;
  if ((not s.isEmpty) and (s.IsNumeric)) then
  begin
    Fquran:=TQuranModel.Create();
    Fquran.Data.SQL.Text:='Select Quran.AyahText as AyatText,Quranindonesia.AyahText as Terjemahan ,Quran.VerseID as Ayat  ' +
                          ' ,concat(''http://www.everyayah.com/data/Abdurrahmaan_As-Sudais_192kbps/'',lpad(Quran.suraID,3,''0''),lpad(Quran.verseID,3,''0'') ,''.mp3 '')  as Recitation'+
                          ' from Quran '+
                          ' inner Join QuranIndonesia on Quran.ID=QuranIndonesia.ID  '+
     format('where Quran.SuraID = %s',[s]);
     if Fquran.Open() then
    begin
      Jarray:=TJSONArray.Create;
      json['code'] := Int16(200);
      Response.Code:=200;
      DataToJSON(Fquran.Data,Jarray,false);
      json.ValueArray['content']:=Jarray;
    end
    else
    begin
       json['code'] := Int16(404);
      Response.Code:=404;

      json['content']:=MSG_CONTENT_NOTFOUND;

    end;

  end;

  Response.ContentType := 'application/json';
  Response.Content := json.AsJSONFormated;
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


end.

