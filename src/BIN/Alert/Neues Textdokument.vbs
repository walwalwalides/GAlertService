Set objEmail = CreateObject("CDO.Message")
objEmail.From = "service1@mydomain.com"
objEmail.To = "yourEmail"
objEmail.Subject = "Service Is Down"
objEmail.Textbody = "The Service ### has stopped."
objEmail.Configuration.Fields.Item _
("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
objEmail.Configuration.Fields.Item _
("http://schemas.microsoft.com/cdo/configuration/smtpserver") = _
"smtp.mydomain.com"
objEmail.Configuration.Fields.Item _
("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
objEmail.Configuration.Fields.Update
objEmail.Send