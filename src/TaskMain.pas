﻿{ ============================================
  Software Name : 	GAlertService
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }

unit TaskMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, WinTask, System.ImageList, Vcl.ImgList, RzStatus, BOsU,
  Vcl.Menus, System.Actions, Vcl.ActnList;

type
  TfrmTaskMain = class(TForm)
    gbDetails: TGroupBox;
    Label1: TLabel;
    edUserAccount: TLabeledEdit;
    edComment: TLabeledEdit;
    edCreator: TLabeledEdit;
    edStatus: TLabeledEdit;
    edApplication: TLabeledEdit;
    edParameters: TLabeledEdit;
    edWorkDir: TLabeledEdit;
    lbTriggers: TListBox;
    bitbtnDelete: TBitBtn;
    bitbtnCreate: TBitBtn;
    lvTasks: TListView;
    edCompat: TLabeledEdit;
    GroupBox1: TGroupBox;
    lblEdtServiceName: TLabeledEdit;
    lblEdtEventID: TLabeledEdit;
    lblEdtGmailAccount: TLabeledEdit;
    lbledtGmailPassword: TLabeledEdit;
    lblEdtEmailTo: TLabeledEdit;
    BitBtnEdit: TBitBtn;
    BitBtnSave: TBitBtn;
    GlystatEmail: TRzGlyphStatus;
    GlyStatEventID: TRzGlyphStatus;
    GlyStatGmail: TRzGlyphStatus;
    ilStatusDaten: TImageList;
    GlyStatGPass: TRzGlyphStatus;
    GlystatServiceName: TRzGlyphStatus;
    TabControlMain: TTabControl;
    Menu: TMainMenu;
    FileHeader: TMenuItem;
    NewMenu: TMenuItem;
    OpenMenu: TMenuItem;
    CloseMenu: TMenuItem;
    N4: TMenuItem;
    QuitMenu: TMenuItem;
    PasswordsHeader: TMenuItem;
    miCreate: TMenuItem;
    miDelete: TMenuItem;
    N2: TMenuItem;
    SetupHeader: TMenuItem;
    miConnection: TMenuItem;
    AboutHeader: TMenuItem;
    AboutMenu: TMenuItem;
    actLMain: TActionList;
    actDelete: TAction;
    actAndroid: TAction;
    actOpenFile: TAction;
    actShowInExplorer: TAction;
    actOpenFolder: TAction;
    actExit: TAction;
    actCopyToClipboard: TAction;
    actUpdate: TAction;
    actSettings: TAction;
    actAbout: TAction;
    actCreate: TAction;
    actWav: TAction;
    actMathE: TAction;
    actFMXE: TAction;
    StatusBar1: TStatusBar;
    BitBtnAsAdmin: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btbCancelClick(Sender: TObject);
    procedure lvTasksSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormResize(Sender: TObject);
    procedure bitbtnCreateClick(Sender: TObject);
    procedure bitbtnDeleteClick(Sender: TObject);
    procedure lvTasksCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure BitBtnEditClick(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actCreateExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure BitBtnAsAdminClick(Sender: TObject);
  private
    { Private-Deklarationen }
    AppPath: String;
    WinTasks: TWinTaskScheduler;
    SelectedTaskIndex: integer;
    un: string;
    procedure UpdateListeView(AIndex: integer);
    procedure ShowData(Item: TListItem; Selected: Boolean);
    procedure ShowErrors(const AErrors: TArray<String>);
    function GetCustomer: TCustomer;
    procedure EnablelblEditControls(const AValue: Boolean);
    function CheeckEmpty: Boolean;
    procedure SaveTaskParametere;
    procedure ReadTaskParametere;
    procedure ClearAllparamTasks;
  public
    { Public-Deklarationen }
  end;

var
  frmTaskMain: TfrmTaskMain;

implementation

{$R *.dfm}

uses System.Win.ComObj, System.DateUtils, Vcl.FileCtrl, Winapi.ActiveX,
  WinApiUtils, CreateScript, Winapi.ShlObj, ErrorsMessageFormU, ValidatorU,
  IniFiles, About, DX.Windows.UAC, Shellapi;

procedure TfrmTaskMain.FormCreate(Sender: TObject);
var
  hr: HResult;
begin
  bitbtnDelete.Cursor:=crHandPoint;
  bitbtnCreate.Cursor:=crHandPoint;
  BitBtnEdit.Cursor:=crHandPoint;
  BitBtnSave.Cursor:=crHandPoint;
  BitBtnAsAdmin.Cursor:=crHandPoint;



 BitBtnAsAdmin.Enabled := False;
  AppPath := extractFilePath(Application.ExeName);
  ReadTaskParametere;

  bitbtnCreate.Enabled := IsAdministrator and IsAdministratorAccount and
    IsUACEnabled and IsElevated;

  bitbtnDelete.Enabled := IsAdministrator and IsAdministratorAccount and
    IsUACEnabled and IsElevated;

  miCreate.Enabled := IsAdministrator and IsAdministratorAccount and
    IsUACEnabled and IsElevated;

  miDelete.Enabled := IsAdministrator and IsAdministratorAccount and
    IsUACEnabled and IsElevated;
  if not(bitbtnCreate.Enabled) then

  Begin
    StatusBar1.Panels[0].Text :=
      'run the application as administrator to create and delete a task.';
    BitBtnAsAdmin.Enabled := True;
  End;

  // CoInitializeEx(nil,COINIT_MULTITHREADED);
  hr := CreateWinTaskScheduler(WinTasks);
  if failed(hr) then
  begin
    if hr = NotAvailOnXp then
    begin
      MessageDlg('Windows Task Scheduler 2.0 requires at least Windows Vista',
        mtError, [mbOK], 0);
      Halt(1)
    end
    else
    begin
      // MessageDlg('Error initializing TWinTaskScheduler - '+SystemErrorMessage(hr),mtError,[mbOK],0);
      Halt(2)
    end;
  end;
  un := UserFullname;
  un := Username;
end;

procedure TfrmTaskMain.SaveTaskParametere;
var
  INI: TIniFile;
  LIPAdresse: string;
  LPort: string;
begin
  if (CheeckEmpty = True) then
  begin
    INI := TIniFile.Create
      (ChangeFileExt(AppPath + ExtractFileName(Application.ExeName), '.ini'));
    try
      INI.WriteString('Alert-Service', 'Gmail Account',
        lblEdtGmailAccount.Text);
      INI.WriteString('Alert-Service', 'Gmail Password',
        lbledtGmailPassword.Text);
      INI.WriteString('Alert-Service', 'Email(Recieve Alert-Service)',
        lblEdtEmailTo.Text);
      INI.WriteString('Alert-Service', 'Service Name', lblEdtServiceName.Text);
      INI.WriteString('Alert-Service', 'Event ID', lblEdtEventID.Text);

    finally
      INI.Free;
    end;
  end;
end;

procedure TfrmTaskMain.ReadTaskParametere;
var
  INI: TIniFile;
  LIPAdresse: string;
  LPort: string;
begin
  if (CheeckEmpty = false) then
  begin
    INI := TIniFile.Create
      (ChangeFileExt(AppPath + ExtractFileName(Application.ExeName), '.ini'));
    try
      lblEdtGmailAccount.Text := INI.ReadString('Alert-Service',
        'Gmail Account', '');
      lbledtGmailPassword.Text := INI.ReadString('Alert-Service',
        'Gmail Password', '');
      lblEdtEmailTo.Text := INI.ReadString('Alert-Service',
        'Email(Recieve Alert-Service)', '');
      lblEdtServiceName.Text := INI.ReadString('Alert-Service',
        'Service Name', '');
      lblEdtEventID.Text := INI.ReadString('Alert-Service', 'Event ID', '');

    finally
      INI.Free;
    end;
    if (CheeckEmpty = True) then
      BitBtnSave.Enabled := false;
  end;
end;

procedure TfrmTaskMain.FormDestroy(Sender: TObject);
begin
  WinTasks.Free;
  // CoUninitialize;
end;

procedure TfrmTaskMain.FormResize(Sender: TObject);
begin
  with lvTasks do
  begin
    Columns[1].Width := 80;
    Columns[2].Width := 150;
    Columns[3].Width := 150;
    Columns[0].Width := Width - 401;
  end;
end;

procedure TfrmTaskMain.FormShow(Sender: TObject);
begin
  UpdateListeView(0);
  if not CheeckEmpty then
    BitBtnEdit.Enabled := false;

end;

procedure TfrmTaskMain.UpdateListeView(AIndex: integer);
var
  i: integer;
begin
  lvTasks.Clear;
  with WinTasks.TaskFolder do
  begin
    for i := 0 to TaskCount - 1 do
      with Tasks[i] do
      begin
        if TaskName = 'Alert-Service' then
          with lvTasks.Items.Add do
          begin
            Caption := TaskName;
            Data := pointer(i);
            SubItems.Add(StatusAsString);
            SubItems.Add(LastRunTimeAsString);
            SubItems.Add(NextRunTimeAsString);
          end;
      end;
    with lvTasks do
    begin
      if AIndex >= Items.Count then
        AIndex := Items.Count - 1;
      ItemIndex := AIndex;
      Invalidate;
      if (lvTasks.Items.Count > 0) then
        Selected.MakeVisible(false);
    end;
  end;
end;

procedure TfrmTaskMain.lvTasksCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  // if (Item.Index > 1) then
  // exit;
  with lvTasks.Canvas.Brush do
  begin
    case Item.Index of
      0:
        Color := clYellow;
      1:
        Color := clGreen;
      2:
        Color := clRed;
    end;
  end;
end;

procedure TfrmTaskMain.lvTasksSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  ShowData(Item, Selected);
end;

procedure TfrmTaskMain.ShowData(Item: TListItem; Selected: Boolean);
var
  i: integer;

  procedure ShowText(AEdit: TCustomEdit; const AText: string);
  begin
    with AEdit do
    begin
      Text := MinimizeName(AText, self.Canvas, Width);
      ShowHint := length(AText) > length(Text);
      if ShowHint then
        Hint := AText;
    end;
  end;

begin
  if Assigned(Item) and Selected then
  begin
    with WinTasks.TaskFolder.Tasks[integer(Item.Data)], Definition do
    begin
      gbDetails.Caption := 'Properties of task: ' + TaskName;
      ShowText(edStatus, StatusAsString);
      ShowText(edUserAccount, UserId);
      ShowText(edComment, Description);
      ShowText(edCreator, Author);
      ShowText(edStatus, DateAsString);
      ShowText(edCompat, CompatibilityAsString);
      // cbReRun.Checked:=RunIfMissed;
      if ActionCount > 0 then
        with Actions[0] do
          if ActionType = taExec then
            with TWinTaskExecAction(Actions[0]) do
            begin
              ShowText(edApplication, ApplicationPath);
              ShowText(edParameters, Arguments);
              ShowText(edWorkDir, WorkingDirectory);
            end
          else
          begin
            edApplication.Text := '';
            edParameters.Text := '';
            edWorkDir.Text := '';
          end;
      lbTriggers.Clear;
      for i := 0 to TriggerCount - 1 do
        with Triggers[i] do
        begin
          lbTriggers.Items.Add(TriggerString);
        end;
      SelectedTaskIndex := TaskIndex;
    end;
  end
end;

procedure TfrmTaskMain.ShowErrors(const AErrors: TArray<String>);
begin
  ErrorsMessageForm.Errors := AErrors;
  ErrorsMessageForm.ShowModal;
end;

function TfrmTaskMain.GetCustomer: TCustomer;
begin
  Result := TCustomer.Create;
  Result.Email := lblEdtEmailTo.Text;
  // Result.Lastname := LabeledEdit2.Text;
  Result.Gmail := lblEdtGmailAccount.Text;
  Result.EventID := lblEdtEventID.Text;
  Result.GmailPassword := lbledtGmailPassword.Text;
  Result.ServiceName := lblEdtServiceName.Text;

end;

procedure TfrmTaskMain.EnablelblEditControls(const AValue: Boolean);
begin
  lblEdtServiceName.ReadOnly := AValue;
  lbledtGmailPassword.ReadOnly := AValue;
  lblEdtEmailTo.ReadOnly := AValue;
  lblEdtEventID.ReadOnly := AValue;
  lblEdtGmailAccount.ReadOnly := AValue;
end;

procedure TfrmTaskMain.actAboutExecute(Sender: TObject);
var
  f: TAboutBox;
begin
  if Assigned(f) then
    Application.CreateForm(TAboutBox, f);
  f.Position := poMainFormCenter;
  try
    f.ShowModal;
  finally
    FreeAndNil(f);
  end;

end;

procedure TfrmTaskMain.actCreateExecute(Sender: TObject);
begin
  bitbtnCreateClick(nil);
end;

procedure TfrmTaskMain.actDeleteExecute(Sender: TObject);
begin
  bitbtnDeleteClick(nil);
end;

procedure TfrmTaskMain.actExitExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmTaskMain.BitBtnAsAdminClick(Sender: TObject);
begin
  Close;
  RunAsAdmin(self.Handle, Application.ExeName, '');

end;

procedure TfrmTaskMain.BitBtnEditClick(Sender: TObject);
begin
  EnablelblEditControls(false);
  BitBtnSave.Enabled := True;
end;

procedure TfrmTaskMain.BitBtnSaveClick(Sender: TObject);
var
  LCustomer: TCustomer;
  LErrors: TArray<string>;
begin
  LCustomer := GetCustomer;
  try
    LErrors := [];
    if TValidator.Validate(LCustomer, LErrors, 'RegisterContext') then
    begin
      GlyStatGmail.imageindex := 1;
      GlystatEmail.imageindex := 1;
      GlyStatGPass.imageindex := 1;
      GlystatServiceName.imageindex := 1;
      GlyStatEventID.imageindex := 1;
      BitBtnSave.Enabled := false;
      SaveTaskParametere;
      EnablelblEditControls(True);

    end
    else
    begin
      if (GlystatEmail.imageindex = -1) then
        GlystatEmail.imageindex := 0;

      if (GlyStatGmail.imageindex = -1) then
        GlyStatGmail.imageindex := 0;

      if (GlyStatEventID.imageindex = -1) then
        GlyStatEventID.imageindex := 0;

      if (GlyStatGPass.imageindex = -1) then
        GlyStatGPass.imageindex := 0;

      if (GlystatServiceName.imageindex = -1) then
        GlystatServiceName.imageindex := 0;

      ShowErrors(LErrors);
      exit;
    end;
  finally
    LCustomer.Free;

  end;
end;

procedure RunAsAdmin(hWnd: hWnd; aFile: String; aParameters: String);
Var
  Sei: TShellExecuteInfo;
begin
  Fillchar(Sei, SizeOf(Sei), 0);
  Sei.cbSize := SizeOf(Sei);
  Sei.Wnd := hWnd;
  Sei.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
  Sei.lpfile := PChar(aFile);
  Sei.lpVerb := 'runas';
  Sei.lpParameters := PChar(aParameters);
  Sei.nShow := SW_SHOWNORMAL;
  if not ShellExecuteEx(@Sei) then
    RaiseLastOSError;
end;

procedure TfrmTaskMain.btbCancelClick(Sender: TObject);
begin
  Close;
end;

function GetSpecialFolderPath(CSIDLFolder: integer): string;
var
  FilePath: array [0 .. MAX_PATH] of char;
begin
  SHGetFolderPath(0, CSIDLFolder, 0, 0, FilePath);
  Result := FilePath;
end;

function GetWinDir: string;
var
  dir: array [0 .. MAX_PATH] of char;
begin
  GetWindowsDirectory(dir, MAX_PATH);
  Result := StrPas(dir);
end;

function SystemDir: string;
var
  dir: array [0 .. MAX_PATH] of char;
begin
  GetSystemDirectory(dir, MAX_PATH);
  Result := StrPas(dir);
end;

function TfrmTaskMain.CheeckEmpty: Boolean;
begin
  Result := (lblEdtEventID.Text <> '') and (lblEdtServiceName.Text <> '') and
    (lblEdtEmailTo.Text <> '') and (lblEdtGmailAccount.Text <> '') and
    (lbledtGmailPassword.Text <> '');
end;

procedure TfrmTaskMain.bitbtnCreateClick(Sender: TObject);
var
  td: TWinTask;
  n: integer;
  user, pwd: string;
  mydatatime: Tdatetime;
  psScriptname: string;
  pathWindows, pathSystem: string;
  AEventID, AEventData, AEmailTo, AGmailAccount, AGmailPassword: string;
begin

  // pathWindows:=GetSpecialFolderPath(CSIDL_WINDOWS);

  if (CheeckEmpty) then
  begin
    AEventID := lblEdtEventID.Text;
    AEventData := lblEdtServiceName.Text;
    AEmailTo := lblEdtEmailTo.Text;
    AGmailAccount := lblEdtGmailAccount.Text;
    AGmailPassword := lbledtGmailPassword.Text;
  end
  else
  begin
    MessageDlg
      ('before create "Alert-Service" task you have to add all parameters !',
      mtWarning, [mbOK], 0);
    exit;
  end;

  pathWindows := IncludeTrailingBackslash(GetWinDir);
  psScriptname := pathWindows + 'ServiceAlert.ps1';

  CreatePsScript(psScriptname, AEventID, AEventData, AEmailTo, AGmailAccount,
    AGmailPassword);

  user := '';
  pwd := '';;
  if SelectedTaskIndex >= 0 then
    with WinTasks do
    begin
      td := NewTask; // Tasks[SelectedTaskIndex];
      with td do
      begin
        UserId := Username;
        Description := 'Email Me By Service Problem';
        LogOnType := ltToken; // as current user
        Author := UserId;
        Date := Now;
        with TWinTaskExecAction(NewAction(taExec)) do
        begin
          ApplicationPath := 'powershell.exe';
          Arguments := '-windowstyle hidden -ExecutionPolicy Bypass ' +
            psScriptname + ' -RunType $true';
        end;
        with NewTrigger(ttEvent) do
        begin
          Subscription :=
            '<QueryList>'#13#10'<Query Id="0" Path="System">'#13#10'<Select Path="System">*[System[(Level=2 or Level=0) and (EventID='
            + AEventID + ')]] and *[EventData[Data[1]=' + QuotedStr(AEventData)
            + ']]</Select>'#13#10'</Query>'#13#10'</QueryList>';


          // mydatatime := EncodeDate(YearOf(Now), MonthOf(Now), DayOf(Now)) + EncodeTime(10, 00, 00, 00);
          // StartTime := mydatatime;
          // mydatatime := EncodeDate(YearOf(Now), MonthOf(Now), DayOf(Now)) + EncodeTime(10, 30, 00, 00);
          // EndTime := mydatatime;
          /// /          DaysOfWeek := 5;
          // Duration := 300; // 5 min lang
          // Interval := 60; // after 1 min gone reapeat
          // Delay := 1;

        end;
      end;
      n := TaskFolder.RegisterTask('Alert-Service', td, user, pwd);
      if n < 0 then
        MessageDlg(TaskFolder.ErrorMessage, mtError, [mbOK], 0)
      else
      begin
        UpdateListeView(n);
        ShowData(lvTasks.Items[n], True);
      end;
    end;
end;

procedure TfrmTaskMain.ClearAllparamTasks;
begin
 edApplication.Clear;
 edUserAccount.Clear;
 edComment.Clear;
 edCreator.Clear;
 edStatus.Clear;
 edParameters.Clear;
 edWorkDir.Clear;
 edCompat.Clear;
 lbTriggers.Clear;
end;

procedure TfrmTaskMain.bitbtnDeleteClick(Sender: TObject);
begin
  if SelectedTaskIndex >= 0 then
    with WinTasks.TaskFolder do
    begin
      if failed(DeleteTask(Tasks[SelectedTaskIndex].TaskName)) then
        MessageDlg(ErrorMessage, mtError, [mbOK], 0)
      else
      begin
        UpdateListeView(SelectedTaskIndex);
      end;
    end;

  ClearAllparamTasks;

end;

end.
