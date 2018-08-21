unit routes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpjson, fastplaz_handler;

implementation

uses  main,daftarsuratmodule,suratmodule;

initialization
  Route.Add( 'main', TMainModule);
   Route.Add('daftarsurat', TDaftarsuratModule);
   Route['^/([0-9_]+)/surat'] := TSuratModule;

end.

