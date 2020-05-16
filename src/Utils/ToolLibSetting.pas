{ ============================================
  Software Name : 	GAlertService
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight � 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }

unit ToolLibSetting;
interface

uses
  Vcl.StdCtrls,vcl.Graphics,Winapi.Windows,System.SysUtils,system.Classes, Tlhelp32;
type

  TExecuteWaitEvent = procedure(const ProcessInfo: TProcessInformation;
                                    var ATerminate: Boolean) of object;
procedure PlayResSound(RESName: string; uFlags: integer);
function OpenUpdFTPbpl: boolean;
function GetResourceAsAniCursor(const RESName: string): HCursor;
function KillTask(ExeFileName: string): integer;
function processExists(ExeFileName: string): boolean;
function OpenVDB383(Ax, Ay, Az: integer; const AboolPatform: boolean): boolean;
procedure DialogBoxAutoClose(const ACaption, APrompt: string; DuracaoEmSegundos: integer);
procedure ExecuteFile(const AFilename: String;
                 AParameter, ACurrentDir: String; AWait: Boolean;
                 AOnWaitProc: TExecuteWaitEvent=nil);

implementation

uses
  Winapi.MMSystem, types, DateUtils, forms, dialogs, Winapi.ShellAPI;

var
  hPackage: Thandle;
  hPackVDB: Thandle;












procedure ExecuteFile(const AFilename: String;
                 AParameter, ACurrentDir: String; AWait: Boolean;
                 AOnWaitProc: TExecuteWaitEvent=nil);
var
  si: TStartupInfo;
  pi: TProcessInformation;
  bTerminate: Boolean;
begin
  bTerminate := False;

  if Length(ACurrentDir) = 0 then
    ACurrentDir := ExtractFilePath(AFilename);

  if AnsiLastChar(ACurrentDir) = '' then
    Delete(ACurrentDir, Length(ACurrentDir), 1);

  FillChar(si, SizeOf(si), 0);
  with si do begin
    cb := SizeOf(si);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := SW_NORMAL;
  end;

  FillChar(pi, SizeOf(pi), 0);
  AParameter := Format('"%s" %s', [AFilename, TrimRight(AParameter)]);

  if CreateProcess(Nil, PChar(AParameter), Nil, Nil, False,
                   CREATE_DEFAULT_ERROR_MODE or CREATE_NEW_CONSOLE or
                   NORMAL_PRIORITY_CLASS, Nil, PChar(ACurrentDir), si, pi) then
  try
    if AWait then
      while WaitForSingleObject(pi.hProcess, 50) <> Wait_Object_0 do
      begin
        if Assigned(AOnWaitProc) then
        begin
          AOnWaitProc(pi, bTerminate);
          if bTerminate then
            TerminateProcess(pi.hProcess, Cardinal(-1));
        end;

        Application.ProcessMessages;
      end;
  finally
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
  end;
end;

function SaveResourceAsTempFile(const RESName: string; ResType: Pchar): string;
var
  TempFileName: array [0 .. MAX_PATH - 1] of char;
  TempDir: array [0 .. MAX_PATH - 1] of char;
begin
  GetTempPath(MAX_PATH, TempDir);
  if GetTempFileName(TempDir, '~', 0, TempFileName) = 0 then
    raise Exception.Create(SysErrorMessage(GetLastError));
  Result := TempFileName;
  with TResourceStream.Create(HInstance, RESName, ResType) do
    try
      SaveToFile(Result);
    finally
      free;
    end;
end;

function GetResourceAsAniCursor(const RESName: string): HCursor;
var
  CursorFile: string;
begin
  CursorFile := SaveResourceAsTempFile(RESName, 'ANICURSOR');
  Result := LoadImage(0, Pchar(CursorFile), IMAGE_CURSOR, 0, 0, LR_DEFAULTSIZE or LR_LOADFROMFILE);
  DeleteFile(CursorFile);
  if Result = 0 then
    raise Exception.Create(SysErrorMessage(GetLastError));
end;


procedure PlayResSound(RESName: string; uFlags: integer);
var
  // Handle Deklaration
  hResInfo, hRes: Thandle;
  // Char Deklaration
  lpGlob: PChar;
begin

  hResInfo := FindResource(HInstance, PChar(RESName), MAKEINTRESOURCE('WAVES'));
  if hResInfo = 0 then
  begin
    messagebox(0, 'Could not find this Resource', PChar(RESName), 16);
    Exit;
  end;

  hRes := LoadResource(HInstance, hResInfo);
  if hRes = 0 then
  begin
    messagebox(0, 'Could not load this Resource', PChar(RESName), 16);
    Exit;
  end;
  lpGlob := LockResource(hRes);
  if lpGlob = nil then
  begin
    messagebox(0, 'Resource bad.', PChar(RESName), 16);
    Exit;
  end;
  uFlags := snd_Memory or uFlags;
  SndPlaySound(lpGlob, uFlags);
  UnlockResource(hRes);
  FreeResource(hRes);
end;



function OpenUpdFTPbpl: boolean;
var
  createfunc: function: boolean;
  // creatProc:Procedure;

  pathbpl: string;
begin
  result := true;
  pathbpl := ExtractFilePath(Paramstr(0)) + 'Bpl383\FtpBpl.bpl';
  If hPackage = 0 Then
    hPackage := LoadPackage(pathbpl);
  If hPackage = 0 Then
  begin
    ShowMessage('LoadPackage failed');
    result := false;
  end
  Else
  Begin
    @createfunc := GetProcAddress(hPackage, 'CreateUPdFTP');
    If Assigned(createfunc) Then
    begin
      if (not createfunc) then
      begin
        result := false;
      end;
    end
    Else
    begin
      ShowMessage('GetProcAddress failed');
      result := false;
    end;
  End;
end;

function processExists(ExeFileName: string): boolean;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: Thandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  result := false;
  while integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ExeFileName)))
    then
    begin
      result := true;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

function KillTask(ExeFileName: string): integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: Thandle;
  FProcessEntry32: TProcessEntry32;
begin
  result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

  while integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ExeFileName)))
    then
      result := integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0), FProcessEntry32.th32ProcessID), 0));
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

function OpenVDB383(Ax, Ay, Az: integer; const AboolPatform: boolean): boolean;
var
  createfunc: function(x, y, z: integer; const boolPatform: boolean): boolean;
  // creatProc:Procedure;
  pathbpl: string;
begin
  result := true;
  hPackVDB := 0; // u have to set the handle to zero to avoid luck
  pathbpl := ExtractFilePath(Paramstr(0)) + 'Bpl383\VdbBpl.bpl';
  If hPackVDB = 0 Then
    hPackVDB := LoadPackage(pathbpl);
  If hPackVDB = 0 Then
  begin
    ShowMessage('LoadPackage failed');
    result := false;
  end
  Else
  Begin
    @createfunc := GetProcAddress(hPackVDB, 'CreateVDB383');
    If Assigned(createfunc) Then
    begin
      if (not createfunc(Ax, Ay, Az, AboolPatform)) then
      begin
        result := false;
      end;
    end
    Else
    begin
      ShowMessage('GetProcAddress failed');
      result := false;
    end;
  End;
end;
function RepeatString(const s: string; count: cardinal): string;
var
  i: Integer;
begin
  for i := 1 to count do
    Result := Result + s;
end;

procedure DialogBoxAutoClose(const ACaption, APrompt: string; DuracaoEmSegundos: integer);
var
  Form: TForm;
  Prompt: TLabel;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: integer;
  nX, Lines: integer;
  function GetAveCharSize(Canvas: TCanvas): TPoint;
  var
    i: integer;
    Buffer: array [0 .. 51] of char;
  begin
    for i := 0 to 25 do
      Buffer[i] := Chr(i + ord('A'));
    for i := 0 to 25 do
      Buffer[i + 26] := Chr(i + ord('a'));
    GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(result));
    result.x := result.x div 52;
  end;

begin

  Form := TForm.Create(Application);
  Lines := 0;

  for nX := 1 to Length(APrompt) do
    if APrompt[nX] = #13 then
      inc(Lines);
  with Form do
    try
      Font.Name := 'Arial'; // mcg
      Font.Size := 16; // mcg
      Font.Color := clWhite;
      Font.Style := [fsBold];
      // font.Color :=$001C29DA;
      Canvas.Font := Font;

      DialogUnits := GetAveCharSize(Canvas);
      // BorderStyle    := bsDialog;
      BorderStyle := bsToolWindow;
      FormStyle := fsStayOnTop;
      BorderIcons := [];
      Caption := RepeatString(char(32), 29) + ' ' + ACaption + ' ';
      Color := $003C3C3C;
      ClientWidth := MulDiv(Screen.Width div 4, DialogUnits.x, 4);
      ClientHeight := MulDiv(23 + (Lines * 10), DialogUnits.y, 8);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        AutoSize := true;
        Left := MulDiv(8, DialogUnits.x, 4);
        Top := MulDiv(8, DialogUnits.y, 8);
        Caption := APrompt;

      end;
      Form.Width := Prompt.Width + Prompt.Left + 50; // mcg fix
      Show;
      Application.ProcessMessages;
    finally
      sleep(DuracaoEmSegundos * 500);
      Form.free;
    end;
end;



end.
