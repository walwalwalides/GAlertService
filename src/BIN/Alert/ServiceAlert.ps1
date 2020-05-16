$filter="*[System[EventID=7030] and EventData[Data='YourServiceName']]"
$A = Get-WinEvent -LogName System -MaxEvents 1 -FilterXPath $filter
$Message = $A.Message
$EventID = $A.Id
$MachineName = $A.MachineName
$Source = $A.ProviderName
function Get-Time()

{
    return Get-Date -DisplayHint Time
}


$EmailFrom = "yourEmail"
$EmailTo = "yourEmail"
$Subject ="Alert From $env:computername" 
$Body ="Server Problem Detected at : $(Get-Time)" 
$SMTPServer = "smtp.gmail.com"
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPClient.EnableSsl = $true
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("yourEmail", "yourPassword");
$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)