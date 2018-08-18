unit routes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpjson, fastplaz_handler;

implementation

uses  main;

initialization
  Route.Add( 'main', TMainModule);


end.

