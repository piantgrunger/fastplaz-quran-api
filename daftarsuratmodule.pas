unit daftarsuratmodule;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, html_lib, fpcgi, fpjson, HTTPDefs, fastplaz_handler, 
    database_lib,daftarsurat,json_lib;

type
  TDaftarsuratModule = class(TMyCustomWebModule)

  private
    fdaftarsurat: TDaftarsuratModel;
    function Tag_MainContent_Handler(const TagName: string; Params: TStringList
      ): string;
    procedure BeforeRequestHandler(Sender: TObject; ARequest: TRequest);
  public
    constructor CreateNew(AOwner: TComponent; CreateMode: integer); override;
    destructor Destroy; override;

    procedure Get; override;
    procedure Post; override;
  end;

implementation

uses theme_controller, common;

constructor TDaftarsuratModule.CreateNew(AOwner: TComponent; CreateMode: integer
  );
begin
  inherited CreateNew(AOwner, CreateMode);
  BeforeRequest := @BeforeRequestHandler;
end;

destructor TDaftarsuratModule.Destroy;
begin
  inherited Destroy;
end;

// Init First
procedure TDaftarsuratModule.BeforeRequestHandler(Sender: TObject; 
  ARequest: TRequest);

begin
    Response.ContentType := 'application/json';
end;

// GET Method Handler
procedure TDaftarsuratModule.Get;
var Json:TJSONUtil;
  Surat:  TJSONArray;


begin
  fDaftarsurat:=TDaftarsuratModel.Create();
  DataBaseInit();
  json := TJSONUtil.Create;
  fDaftarsurat.All;
  Surat := TJSONArray.Create;
  json['code'] := Int16(200);
  DataToJSON(fDaftarsurat.Data,Surat,false);
  Json.ValueArray['Surat']:=Surat;
  Response.Content:=json.AsJSONFormated;
  Json.free;
  fDaftarsurat.Free;
end;

// POST Method Handler
procedure TDaftarsuratModule.Post;
begin

end;

function TDaftarsuratModule.Tag_MainContent_Handler(const TagName: string; 
  Params: TStringList): string;
begin

  // your code here
  Result:=h3('Hello "Daftarsurat" Module ... FastPlaz !');

end;



initialization
  // -> http://yourdomainname/daftarsurat
  // The following line should be moved to a file "routes.pas"


end.

