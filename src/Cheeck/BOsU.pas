{ ============================================
  Software Name : 	GAlertService
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight � 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit BOsU;

interface

uses
  AttributesU;

type

  TCustomer = class(TObject)
  private
    FEmail: String;
    FGmail: String;
    FLastname: String;
    FServiceName: String;
    FGmailPassword: string;
    FEventID: String;
    procedure SetEmail(const Value: String);
    procedure SetGmail(const Value: String);
    procedure SetEventID(const Value: String);
    procedure SetServiceName(const Value: String);
    procedure SetGmailPassword(const Value: String);
  public

    { [RequiredValidation('Lastname cannot be blank...', 'RegisterContext')]    [MinLengthValidationAttribute      ('Lastname must have a length between 4 and 15 characters', 4,      'RegisterContext')]    [MaxLengthValidationAttribute      ('Lastname must have a length between 4 and 15 characters', 15,      'RegisterContext')]    property Lastname: String read FLastname write SetLastname; }
    [RequiredValidation('- "Gmail Account" cannot be blank...', 'RegisterContext')]
    [RegexValidation('-> The value does not seem to be a correct Gmail Account...',
      '^[a-z0-9](\.?[a-z0-9]){5,}@g(oogle)?mail\.com$',
      'RegisterContext;LoginContext')]
    property Gmail: String read FGmail write SetGmail;

    [RequiredValidation('- "Gmail Password" cannot be blank...', 'RegisterContext')]
    property GmailPassword: String read FGmailPassword write SetGmailPassword;

    { [RequiredValidation('Lastname cannot be blank...', 'RegisterContext')]    [MinLengthValidationAttribute      ('Lastname must have a length between 4 and 15 characters', 4,      'RegisterContext')]    [MaxLengthValidationAttribute      ('Lastname must have a length between 4 and 15 characters', 15,      'RegisterContext')]    property Lastname: String read FLastname write SetLastname; }
    [RequiredValidation('- "Email(Recieve Alert-Service)" cannot be blank...', 'RegisterContext')]
    [RegexValidation('-> The value does not seem to be a correct Email Account...',
      '^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      'RegisterContext;LoginContext')]
    property Email: String read FEmail write SetEmail;

    [RequiredValidation('- "Service Name" cannot be blank...', 'RegisterContext')]
    property ServiceName: String read FServiceName write SetServiceName;

    [RequiredValidation('- "Event ID" cannot be blank...', 'RegisterContext')]
    [MinLengthValidationAttribute
      ('-> Event ID must have a length 4 characters between 7000..7044', 4,
      'RegisterContext')]
    [MaxLengthValidationAttribute
      ('-> Event ID must have a length 4 characters between 7000..7044', 4,
      'RegisterContext')]
    property EventID: String read FEventID write SetEventID;

  end;

implementation

{ TCustomer }

procedure TCustomer.SetGmail(const Value: String);
begin
  FGmail := Value;
end;

procedure TCustomer.SetEmail(const Value: String);
begin
  FEmail := Value;
end;

procedure TCustomer.SetEventID(const Value: String);
begin
  FEventID := Value;
end;

procedure TCustomer.SetServiceName(const Value: String);
begin
  FServiceName := Value;
end;

procedure TCustomer.SetGmailPassword(const Value: String);
begin
  FGmailPassword := Value;
end;

end.
