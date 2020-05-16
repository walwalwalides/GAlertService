{ ============================================
  Software Name : 	GAlertService
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides                     }
{ CopyRight � 2020                             }
{ Email : WalWalWalides@gmail.com              }
{ GitHub :https://github.com/walwalwalides     }
{ ******************************************** }

unit AttributesU;

interface

uses
  ValidatorU;

type

  ValidationAttribute = class abstract(TCustomAttribute)
  private
    FContext: String;
  protected
    FErrorMessage: string;
    function DoValidate(AValue: string): Boolean; virtual; abstract;
  public
    constructor Create(AErrorMessage: string; AContext: String = '');
    function Validate(AValue: string): TValidationResult;
    function AcceptContext(AContext: String): Boolean;
  end;

  RequiredValidationAttribute = class(ValidationAttribute)
  public
    function DoValidate(AValue: string): Boolean; override;
  end;

  MaxLengthValidationAttribute = class(ValidationAttribute)
  protected
    FLength: Integer;
  public
    constructor Create(AErrorMessage: string; ALength: Integer;
      AContext: String = '');
    function DoValidate(AValue: string): Boolean; override;
  end;

  MinLengthValidationAttribute = class(MaxLengthValidationAttribute)
  public
    function DoValidate(AValue: string): Boolean; override;
  end;

  RegexValidationAttribute = class(ValidationAttribute)
  private
    FRegex: string;
  public
    constructor Create(AErrorMessage: string; ARegex: string;
      AContext: String = '');
    function DoValidate(AValue: string): Boolean; override;
  end;

implementation

uses
  System.SysUtils, System.RegularExpressions, TaskMain;

{ ValidationAttribute }

function ValidationAttribute.AcceptContext(AContext: String): Boolean;
var
  LContexts: TArray<String>;
  LContext: String;
begin
  Result := False;
  LContexts := FContext.Split([';']); // used if yiu have more context
  for LContext in LContexts do
    if LContext.ToLower = AContext.ToLower then
      Exit(true)
end;

constructor ValidationAttribute.Create(AErrorMessage: string;
  AContext: String = '');
begin

  FErrorMessage := AErrorMessage;
  FContext := AContext;
end;

function ValidationAttribute.Validate(AValue: string): TValidationResult;
// add error to record in validator
begin
  if not DoValidate(AValue) then
    Result.ErrorMessage := FErrorMessage;
end;

{ RequiredValidationAttribute }

function RequiredValidationAttribute.DoValidate(AValue: string): Boolean;
begin
  // value cannot be empty
  Result := not AValue.IsEmpty;
  if (Result = true) then
  begin
     if (FErrorMessage <> '- "Service Name" cannot be blank...') then
    frmTaskMain.GlyStatGPass.ImageIndex := 1;
     if (FErrorMessage <> '- "Gmail Password" cannot be blank...') then
    frmTaskMain.GlyStatServiceName.ImageIndex := 1;

  end
  else
  begin
    if (FErrorMessage = '- "Gmail Password" cannot be blank...') then
      frmTaskMain.GlyStatGPass.ImageIndex := 0;
    if (FErrorMessage = '- "Service Name" cannot be blank...') then
      frmTaskMain.GlyStatServiceName.ImageIndex := 0;

  end;

end;

{ MaxLengthValidationAttribute }

constructor MaxLengthValidationAttribute.Create(AErrorMessage: string;
  ALength: Integer; AContext: String = '');
begin
  inherited Create(AErrorMessage, AContext);
  FLength := ALength;
end;

function MaxLengthValidationAttribute.DoValidate(AValue: string): Boolean;
begin
  // length of value must be less than or equal to length provided in attributes
  Result := Length(AValue) <= FLength;
  if (Result = False) then
    frmTaskMain.GlystatEventID.ImageIndex := 0;
end;

{ MinLengthValidationAttribute }

function MinLengthValidationAttribute.DoValidate(AValue: string): Boolean;
begin
  // length of value must be greather than or equal to length provided in attributes
  Result := Length(AValue) >= FLength;
  if (Result = False) then
    frmTaskMain.GlystatEventID.ImageIndex := 0
  else if ((Strtoint(AValue) >= 7000) and (Strtoint(AValue) <= 7044)) then

    frmTaskMain.GlystatEventID.ImageIndex := 1
  else
  Begin
    Result := False;
    frmTaskMain.GlystatEventID.ImageIndex := 0;
  End;
end;

{ RegexValidationAttribute }

constructor RegexValidationAttribute.Create(AErrorMessage: string;
  ARegex: string; AContext: String = '');
begin
  inherited Create(AErrorMessage, AContext);

  FRegex := ARegex;
end;

function RegexValidationAttribute.DoValidate(AValue: string): Boolean;
begin
  // Match the value of regular expression
  Result := TRegEx.IsMatch(AValue, FRegex);

  if ((Pos('@', AValue) <> 0) and (Result = true)) then
    frmTaskMain.GlystatEmail.ImageIndex := 1
  else
    frmTaskMain.GlystatEmail.ImageIndex := 0;

  if ((Pos('@gmail', lowercase(AValue)) <> 0) and (Result = true)) then
    frmTaskMain.GlystatGmail.ImageIndex :=
      1 { else  frmTaskMain.GlystatGmail.ImageIndex := 0 };
  if (Result = False) and (FErrorMessage<>'-> The value does not seem to be a correct Email Account...') then
    frmTaskMain.GlystatGmail.ImageIndex := 0;
end;

end.
