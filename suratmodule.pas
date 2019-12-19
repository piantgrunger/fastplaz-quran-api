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
    Fquran : TquranModel;
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
    Fquran:=TquranModel.Create();
    Fquran.Data.SQL.Text:='Select quran.AyahText as AyatText,quranindonesia.AyahText as Terjemahan ,quran.VerseID as Ayat  ' +
                          ' ,concat(''http://www.everyayah.com/data/Abdurrahmaan_As-Sudais_192kbps/'',lpad(quran.suraID,3,''0''),lpad(quran.verseID,3,''0'') ,''.mp3 '')  as Recitation'+
                          ' from quran '+
                          ' inner Join quranindonesia on quran.ID=quranindonesia.ID  '+
     format('where quran.SuraID = %s',[s]);
     if Fquran.Open() then
    begin
      Jarray:=TJSONArray.Create;
      json['code'] := Int16(200);
      Response.Code:=200;
      DataToJSON(Fquran.Data,Jarray,false);
      json.ValueArray['content']:=Jarray;
    end
 end   
  else if ((not s.isEmpty) ) then
  begin
    Fquran:=TquranModel.Create();
    Fquran.Data.SQL.Text:='Select quran.AyahText as AyatText,quranindonesia.AyahText as Terjemahan ,quran.VerseID as Ayat  ' +
                          ' ,concat(''http://www.everyayah.com/data/Abdurrahmaan_As-Sudais_192kbps/'',lpad(quran.suraID,3,''0''),lpad(quran.verseID,3,''0'') ,''.mp3 '')  as Recitation'+
                          ' from quran '+
                          ' inner Join quranindonesia on quran.ID=quranindonesia.ID  '+
    'where quranindonesia.AyahText like '+quotedstr('%'+s+'%');
     if Fquran.Open() then
    begin
      Jarray:=TJSONArray.Create;
      json['code'] := Int16(200);
      Response.Code:=200;
      DataToJSON(Fquran.Data,Jarray,false);
      json.ValueArray['content']:=Jarray;
   end
   end
    else
    begin
       json['code'] := Int16(404);
      Response.Code:=404;

      json['content']:=MSG_CONTENT_NOTFOUND;

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

