{ ============================================
  Software Name : 	GAlertService
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight � 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit CreateScript;

interface

uses
  Winapi.Windows, system.Types, system.sysutils, system.classes, registry,
  ShellApi;

procedure CreatePsScript(const AFilePs: string;
  const AEventID, AEventData: string; AEmailTo: String;
  const AGmailAccount, AGmailPassword: string);
procedure CreateChartDep(AFilevbs, AFunc: string);
Procedure ExecuteScript(AScriptDirectory, ACommandLine, scriptfilename,
  ScriptDirectoryAlias: String); // execute VBScript

implementation

procedure CreatePsScript(const AFilePs: string;
  const AEventID, AEventData: string; AEmailTo: String;
  const AGmailAccount, AGmailPassword: string);
var
  vbsScript: Tstringlist;
begin
  vbsScript := Tstringlist.Create;
  try

    vbsScript.ADD('$filter="*[System[EventID='+AEventID+'] and EventData[Data=' +
      QuotedStr(AEventData)+ ']]"');
    vbsScript.ADD
      ('$A = Get-WinEvent -LogName System -MaxEvents 1 -FilterXPath $filter');
    vbsScript.ADD('$Message = $A.Message');
    vbsScript.ADD('$EventID = $A.Id');
    vbsScript.ADD('$MachineName = $A.MachineName');
    vbsScript.ADD('$Source = $A.ProviderName');
    vbsScript.ADD('function Get-Time()');
    vbsScript.ADD('{');
    vbsScript.ADD('return Get-Date -DisplayHint Time');
    vbsScript.ADD('}');
    vbsScript.ADD('$EmailFrom = "'+AGmailAccount+'"');
    vbsScript.ADD('$EmailTo = "'+AEmailTo+'"');
    vbsScript.ADD('$Subject ="Alert From $env:computername"');
    vbsScript.ADD('$Body ="Windows Service Error ( EventID : '+AEventID+' )'#13#10'- Problem Detected at : $(Get-Time)"');
    vbsScript.ADD('$SMTPServer = "smtp.gmail.com"');
    vbsScript.ADD
      ('$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)');
    vbsScript.ADD('$SMTPClient.EnableSsl = $true');
    vbsScript.ADD
      ('$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("'+AGmailAccount+'", "'+AGmailPassword+'");');
    vbsScript.ADD('$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)');

    vbsScript.SaveToFile(AFilePs);
  finally
    vbsScript.Free;
  end;

end;

Procedure ExecuteScript(AScriptDirectory, ACommandLine, scriptfilename,
  ScriptDirectoryAlias: String); // execute VBScript
Const
  ReadBuffer = 4800;
Var
  Security: TSecurityAttributes;
  ProcessInfo: TProcessInformation;
  Start: TStartupInfo;
  ReadPipe, WritePipe: THandle;
  Buffer: PAnsiChar;
  BytesRead: DWORD;
  wResult: DWORD;
  sError: String;
Begin
  Security.nlength := sizeof(TSecurityAttributes);
  Security.binherithandle := True;
  Security.lpsecuritydescriptor := nil;
  If CreatePipe(ReadPipe, WritePipe, @Security, 0) Then
  Begin
    Buffer := AllocMem(ReadBuffer + 1);
    FillChar(Start, sizeof(Start), #0);
    Start.cb := sizeof(Start);
    Start.hStdOutput := WritePipe;
    Start.hStdInput := ReadPipe;
    Start.dwFlags := STARTF_USESTDHANDLES + STARTF_USESHOWWINDOW;
    Start.wShowWindow := SW_HIDE;

    UniqueString(ACommandLine);
    If CreateProcess(Nil, PChar(ACommandLine), @Security, @Security, True,
      NORMAL_PRIORITY_CLASS, Nil, PChar(AScriptDirectory), Start,
      ProcessInfo) Then
    Begin
      WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
      GetExitCodeProcess(ProcessInfo.hProcess, wResult);
      If (wResult = 0) Then
      Begin
        Repeat
          BytesRead := 0;
          ReadFile(ReadPipe, Buffer[0], ReadBuffer, BytesRead, nil);
          Buffer[BytesRead] := #0;
          OemToAnsi(Buffer, Buffer);
          sError := sError + String(Buffer);
        Until (BytesRead < ReadBuffer);
        // log to the database
        // Log.Add(msgGENERIC_ERROR,Format('Script Error: %s', [sError]));
      End;
      // Success := (wResult > 0);
    End
    Else
    Begin
      // create an error message to raise out using global variables
      Raise Exception.CreateFmt
        ('Error launching script: "%s" in directory "%s"'#13#10'System error: %s',
        [scriptfilename, ScriptDirectoryAlias, SysErrorMessage(GetLastError)]);
    End;

    FreeMem(Buffer);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ReadPipe);
    CloseHandle(WritePipe);

  End;
End;

procedure CreateChartDep(AFilevbs, AFunc: string);
var
  HtmlScript: Tstringlist;
begin
  HtmlScript := Tstringlist.Create;
  try
    HtmlScript.ADD('<!DOCTYPE html>');
    HtmlScript.ADD('<html lang="en">');
    HtmlScript.ADD('<head>');
    HtmlScript.ADD('<meta charset="utf-8">');
    HtmlScript.ADD('<meta http-equiv="X-UA-Compatible" content="IE=edge">');
    HtmlScript.ADD
      ('<meta name="viewport" content="width=device-width, initial-scale=1">');
    HtmlScript.ADD('<meta name="description" content="Chromelink Solutions">');
    HtmlScript.ADD('<meta name="Chromelink Solutions" content="">');
    HtmlScript.ADD('<title>Chart Department');
    HtmlScript.ADD('</title>');
    HtmlScript.ADD('<script src="' + AFunc + '"></script>');
    HtmlScript.ADD('</head>');

    HtmlScript.ADD('<body>');
    HtmlScript.ADD('<canvas id="myChart" width="400" height="400"></canvas>');
    HtmlScript.ADD('<script>');
    HtmlScript.ADD
      ('window.addEventListener("error", handleWindowError); function handleWindowError(e) {alert(e.error)}');
    HtmlScript.ADD('window.onload = function(e) { Drawchart();};');
    HtmlScript.ADD('function Drawchart(){');
    HtmlScript.ADD('var ctx = document.getElementById("myChart").getContext(' +
      char(39) + '2d' + char(39) + ');');
    HtmlScript.ADD('var myChart = new Chart(ctx, {');

    HtmlScript.ADD('type: ' + char(39) + 'bar' + char(39) + ',');
    HtmlScript.ADD('data: {');
    HtmlScript.ADD
      ('labels: ["Sales", "Support", "Shipping", "Engineering", "Human Resources", "Management", "IT"],');
    HtmlScript.ADD('datasets: [{');
    HtmlScript.ADD('label: ' + char(39) + '#' + ' of Department' +
      char(39) + ',');
    HtmlScript.ADD('data: [0, 1, 2, 3, 4, 5, 6],');

    HtmlScript.ADD('backgroundColor: [');
    HtmlScript.ADD(char(39) + 'rgba(255, 99, 132, 0.2)' + char(39) + ',');
    HtmlScript.ADD(char(39) + 'rgba(54, 162, 235, 0.2)' + char(39) + ',');
    HtmlScript.ADD(char(39) + 'rgba(255, 206, 86, 0.2)' + char(39) + ',');
    HtmlScript.ADD(char(39) + 'rgba(75, 192, 192, 0.2)' + char(39) + ',');
    HtmlScript.ADD(char(39) + 'rgba(153, 102, 255, 0.2)' + char(39) + ',');
    HtmlScript.ADD(char(39) + 'rgba(120, 50, 80, 0.2)' + char(39) + ',');
    HtmlScript.ADD(char(39) + 'rgba(255, 159, 64, 0.2)' + char(39));
    HtmlScript.ADD('],');

    HtmlScript.ADD('borderColor: [');
    HtmlScript.ADD(char(39) + 'rgba(255, 99, 132, 1)' + char(39) + ',');
    HtmlScript.ADD(char(39) + 'rgba(54, 162, 235, 1)' + char(39) + ',');
    HtmlScript.ADD(char(39) + 'rgba(255, 206, 86, 1)' + char(39) + ',');
    HtmlScript.ADD(char(39) + 'rgba(75, 192, 192, 1)' + char(39) + ',');
    HtmlScript.ADD(char(39) + 'rgba(153, 102, 255, 1)' + char(39) + ',');
    HtmlScript.ADD(char(39) + 'rgba(120, 50, 80, 1)' + char(39) + ',');
    HtmlScript.ADD(char(39) + 'rgba(255, 159, 64, 1)' + char(39));
    HtmlScript.ADD('],');

    HtmlScript.ADD('borderWidth: 1');
    HtmlScript.ADD('}]');
    HtmlScript.ADD('},');
    HtmlScript.ADD('options: {');
    HtmlScript.ADD('scales: {');
    HtmlScript.ADD('yAxes: [{');
    HtmlScript.ADD('ticks: {');
    HtmlScript.ADD('beginAtZero:true');
    HtmlScript.ADD('}');
    HtmlScript.ADD('}]');
    HtmlScript.ADD('}');
    HtmlScript.ADD('}');
    HtmlScript.ADD('});');
    HtmlScript.ADD('}');
    HtmlScript.ADD('</script>');
    HtmlScript.ADD('</body>');
    HtmlScript.ADD('</html>');

    HtmlScript.SaveToFile(AFilevbs);
  finally
    HtmlScript.Free;
  end;

end;

end.
