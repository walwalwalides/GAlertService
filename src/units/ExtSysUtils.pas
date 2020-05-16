{ ============================================
  Software Name : 	GAlertService
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight © 2020                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }

unit ExtSysUtils;

interface

uses System.SysUtils;

function TryFormat(const AFormat: string; const Args: array of const): string;
function UnixPathToDosPath(const Path: string): string;
function DosPathToUnixPath(const Path: string): string;

implementation

uses UnitConsts;

{ --------------------------------------------------------------- }
// Format without raising an exception on errors
function TryFormat(const AFormat: string; const Args: array of const): string;
begin
  try
    Result:=Format(AFormat,Args);
  except
    on E:Exception do Result:=rsFormatError+AFormat;
    end;
  end;

{ --------------------------------------------------------------- }
function UnixPathToDosPath(const Path: string): string;
begin
  Result := Path.Replace('/', '\');
end;

function DosPathToUnixPath(const Path: string): string;
begin
  Result := Path.Replace('\', '/');
end;


end.
