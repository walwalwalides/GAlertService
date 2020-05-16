program GAlertService;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  ShellAPI,
  Sysutils,
  System.IOUtils,
  Types,
  Winapi.Windows,
  TaskMain in 'TaskMain.pas' {frmTaskMain} ,
  ExtSysUtils in 'units\ExtSysUtils.pas',
  TaskSchedApi in 'units\TaskSchedApi.pas',
  UnitConsts in 'units\UnitConsts.pas',
  WinApiUtils in 'units\WinApiUtils.pas',
  WinTask in 'units\WinTask.pas',
  WinTaskConsts in 'units\WinTaskConsts.pas',
  CreateScript in 'units\CreateScript.pas',
  AttributesU in 'Cheeck\AttributesU.pas',
  BOsU in 'Cheeck\BOsU.pas',
  ErrorsMessageFormU in 'Cheeck\ErrorsMessageFormU.pas' {ErrorsMessageForm} ,
  ValidatorU in 'Cheeck\ValidatorU.pas',
  About in 'About\About.pas' {AboutBox} ,
  DBGridUtils in 'Utils\DBGridUtils.pas',
  DX.Windows.UAC in 'Utils\DX.Windows.UAC.pas',
  ToolLibSetting in 'Utils\ToolLibSetting.pas';

{$R *.res}
function PathCanonicalize(lpszDst: PChar; lpszSrc: PChar): LongBool; stdcall;
  external 'shlwapi.dll' name 'PathCanonicalizeW';

function ResolvePath(const RelPath, BasePath: string): string;
var
  lpszDst: array [0 .. MAX_PATH - 1] of char;
begin
  PathCanonicalize(@lpszDst[0], PChar(IncludeTrailingPathDelimiter(BasePath) +
    RelPath));
  Exit(lpszDst);
end;

procedure LoadVCLStyles;
var
  f, s: string;
  LFiles: TStringDynArray;
  StyleInfo: TStyleInfo;
begin
  s := ExtractFilePath(ParamStr(0));
  LFiles := TDirectory.GetFiles(s, '*.vsf');
  if Length(LFiles) > 0 then
  begin
    for f in TDirectory.GetFiles(s, '*.vsf') do
      if TStyleManager.IsValidStyle(f, StyleInfo) and
        SameText(StyleInfo.Name, 'Tablet Light') then
        TStyleManager.LoadFromFile(f)
  end
  else
  begin
    s := ResolvePath('Libary\vsf', ExtractFilePath(ParamStr(0)));
    for f in TDirectory.GetFiles(s, '*.vsf') do
      if TStyleManager.IsValidStyle(f, StyleInfo) and
        SameText(StyleInfo.Name, 'Silver') then
        TStyleManager.LoadFromFile(f);
  end;
end;

begin
  LoadVCLStyles;
  TStyleManager.TrySetStyle('Silver');
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTaskMain, frmTaskMain);
  Application.CreateForm(TErrorsMessageForm, ErrorsMessageForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;

end.
