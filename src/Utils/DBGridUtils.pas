{ ============================================
  Software Name : 	GAlertService
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight � 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }

unit DBGridUtils;
// Refer to example for usage

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.themes,
  Vcl.extctrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Buttons,
  Datasnap.DBClient, Vcl.WinXpickers, System.dateutils, FireDAC.Comp.Client;

var
  OriginalGridoptions: TDBGridoptions;

type
  TPent = array [0 .. 4] of TPoint;

  TModDbGrid = class(TCustomGrid)
  end;

  // checkbox     //enter '1' for int or 'true'  boolean
procedure CheckBoxdrawcolumncell(FieldName: String; ValueCheck: Variant;
  Grid: TDBGrid; const Rect: TRect; Column: TColumn; State: TGridDrawState);
procedure CheckboxCell(Grid: TDBGrid; Column: TColumn; FieldName: string);
procedure CheckboxHighlightrows(sender: Tobject; FieldName: string;
  booleantype: string; highlightcol: tcolor; Fromcol, ToCol: integer;
  datacol: integer; Grid: TDBGrid; Rect: TRect; Column: TColumn;
  State: TGridDrawState);

// add button
procedure ButtondrawColumnCell(sender: Tobject; Button: Tbutton;
  Btncaption: string; datacol, YourCol: integer; Column: TColumn; Grid: TDBGrid;
  const Rect: TRect; State: TGridDrawState);

// datepicker windows 10
procedure DatePickerdrawColumnCell(picker: TDatePicker;
  datacol, colpos: integer; Column: TColumn; Grid: TDBGrid; const Rect: TRect;
  State: TGridDrawState);
procedure DatepickerKeyPress(sender: Tobject; picker: TDatePicker;
  var Key: Char; FieldName: string; Grid: TDBGrid);
procedure DatepickerCell(picker: TDatePicker; Grid: TDBGrid; Column: TColumn;
  FieldName: string);
procedure DatePickerColenter(picker: TDatePicker; FieldName: string;
  colpos: integer; Grid: TDBGrid);
procedure DatepickerColExit(picker: TDatePicker; FieldName: string;
  colpos: integer; Grid: TDBGrid);

// std Combobox drop down self fill
procedure PopulatePicklistmanual(s: array of string; Grid: TDBGrid;
  colpos: integer);
procedure PopulatePicklistDB(Grid: TDBGrid; colpos: integer; query: TFDQuery;
  FieldName: string);
// procedure ComboCell(grid:TDbgrid;Column:TColumn;Fieldname:string);

// dbcombobox
procedure DBCombodrawcolumncell(combo: TdbCombobox; datacol, colpos: integer;
  Column: TColumn; Grid: TDBGrid; const Rect: TRect; State: TGridDrawState);
//procedure DBComboKeyPress(sender: Tobject; combo: TdbCombobox; var Key: Char;
//  FieldName: string; Grid: TDBGrid);
procedure DBComboColenter(combo: TdbCombobox; FieldName: string;
  colpos: integer; Grid: TDBGrid);
procedure DBComboColExit(combo: TdbCombobox; FieldName: string; colpos: integer;
  Grid: TDBGrid);
procedure DBComboCell(combo: TdbCombobox; Grid: TDBGrid; Column: TColumn;
  FieldName: string);

// dblookupcombobox
procedure DBlookupCombodrawcolumncell(combo: TdblookupCombobox;
  datacol, colpos: integer; Column: TColumn; Grid: TDBGrid; const Rect: TRect;
  State: TGridDrawState);
procedure DBlookupComboKeyPress(sender: Tobject; combo: TdblookupCombobox;
  var Key: Char; FieldName: string; Grid: TDBGrid);
procedure DBlookupComboColenter(combo: TdblookupCombobox; FieldName: string;
  colpos: integer; Grid: TDBGrid);
procedure DBlookupComboColExit(combo: TdblookupCombobox; FieldName: string;
  colpos: integer; Grid: TDBGrid);
procedure DBlookupComboCell(combo: TdblookupCombobox; Grid: TDBGrid;
  Column: TColumn; FieldName: string);

// add progress
procedure Progressdrawcolumncell(sender: Tobject; Grid: TDBGrid;
  colpos, datacol, progressvalue: integer; Rect: TRect; Column: TColumn;
  State: TGridDrawState; progressnumber: integer = 5;
  overduebreakpoint: integer = 1; breakpoint1: integer = 65;
  breakpoint2: integer = 40; breakpoint3: integer = 20;
  backgroundcolor: tcolor = clgray; overduecolor: tcolor = clwebFirebrick;
  Color1: tcolor = clWebLightSkyBlue; Color2: tcolor = clweborange;
  Color3: tcolor = clWebGold; color4: tcolor = clWebTomato;
  maxvalue: integer = 100; progresspadding: integer = 0;
  isbackground: boolean = false; showtext: boolean = true;
  Percentge: string = '%');

/// add horizontalbar
procedure HorizontalBardrawcolumncell(sender: Tobject; Grid: TDBGrid;
  colpos, datacol, progressvalue1, progressvalue2, progressvalue3,
  progressvalue4, progressvalue5: integer; Rect: TRect; Column: TColumn;
  State: TGridDrawState; progressnumber: integer = 5; // min 1
  Color1: tcolor = clWebLightSkyBlue; Color2: tcolor = clWebLightSeaGreen;
  Color3: tcolor = clweborange; color4: tcolor = clWebGold;
  color5: tcolor = clWebTomato; maxvalue: integer = 100;
  progresspadding: integer = 0; isbackground: boolean = false;
  showtext: boolean = true; Percentge: string = '%');
procedure ColorhorizontalBarshape(shape: Tshape; color: tcolor);

// add stars
procedure StarCombodrawcolumncell(sender: Tobject; Grid: TDBGrid;
  colpos, datacol, offset, starnum, activestar: integer;
  ActiveColor, InactiveColor: tcolor; Rect: TRect; Column: TColumn;
  State: TGridDrawState; isbackground: boolean = false);
procedure StarCell(Grid: TDBGrid; starnum: integer; Column: TColumn;
  FieldName: string);

// add rating circles
procedure CircleCombdrawcolumncell(sender: Tobject; Grid: TDBGrid;
  colpos, datacol, offset, ratingnum, activerating: integer;
  ActiveColor, InactiveColor: tcolor; Rect: TRect; Column: TColumn;
  State: TGridDrawState; isbackground: boolean = false);
procedure CirclesCell(Grid: TDBGrid; circlenum: integer; Column: TColumn;
  FieldName: string);
// grid generic actions
procedure SetGenericBackground(sender: Tobject);
procedure SetAutoAlternateColorLines(const Fromcol: integer;
  const ToCol: integer; datacol: integer; Column: TColumn; Grid: TDBGrid;
  const Rect: TRect; State: TGridDrawState);
procedure RowNumbers(Rect: TRect; Grid: TDBGrid; datacol: integer);
procedure setcolumncolor(sender: Tobject; colnumber, datacol: integer;
  colcolor: tcolor; Grid: TDBGrid; Rect: TRect; Column: TColumn;
  State: TGridDrawState);
procedure SetActiveRowHighlight(Grid: TDBGrid; datacol, Fromcol, ToCol: integer;
  Column: TColumn; const Rect: TRect; State: TGridDrawState;
  const rowcolor: tcolor = clhighlight);

implementation

procedure SetActiveRowHighlight(Grid: TDBGrid; datacol, Fromcol, ToCol: integer;
  Column: TColumn; const Rect: TRect; State: TGridDrawState;
  const rowcolor: tcolor = clhighlight);
var
  modgrid: TModDbGrid;
begin
  if ((datacol >= Fromcol) and (datacol <= ToCol)) then
  begin
    if Grid.DataSource.DataSet.RecNo = modgrid.Row then
    begin
      if styleservices.Enabled then
      begin
        if rowcolor = clhighlight then
        begin
          Grid.Canvas.Brush.color := styleservices.GetSystemColor(clhighlight);
          Grid.Canvas.Font.color := styleservices.GetStylefontColor
            (sfButtonTextnormal);
        end
        else
        begin
          Grid.Canvas.Brush.color := rowcolor;
          Grid.Canvas.Font.color := styleservices.GetStylefontColor
            (sfButtonTextnormal);
        end;
      end;
    end
    else
    begin
      // leave blank for generic background
    end;
    Grid.DefaultDrawColumnCell(Rect, Column.Index, Column, State);
  end;
end;

procedure SetAutoAlternateColorLines(const Fromcol: integer;
  const ToCol: integer; datacol: integer; Column: TColumn; Grid: TDBGrid;
  const Rect: TRect; State: TGridDrawState);
begin
  if ((datacol >= Fromcol) and (datacol <= ToCol)) then
  begin
    if Grid.DataSource.DataSet.RecNo mod 2 = 0 then
    begin
      if styleservices.Enabled then
      begin
        Grid.Canvas.Brush.color := styleservices.GetStyleColor
          (scCategoryPanelGroup);
        Grid.Canvas.Font.color := styleservices.GetStylefontColor
          (sfButtonTextnormal);
      end;
    end
    else
    begin
      // leave blank for generic background
    end;
    Grid.DefaultDrawColumnCell(Rect, Column.Index, Column, State);
  end;
end;

procedure SetGenericBackground(sender: Tobject);
begin
  // Change color if the white space below the grid to same as background
  TModDbGrid(sender).FInternalColor := styleservices.GetStyleColor
    (scCategoryPanelGroup);
end;

procedure ButtondrawColumnCell(sender: Tobject; Button: Tbutton;
  Btncaption: string; datacol, YourCol: integer; Column: TColumn; Grid: TDBGrid;
  const Rect: TRect; State: TGridDrawState);
var
  R, DataRect: TRect;
  style: DWORD;
  FButtonCol: integer;

  FCellDown: TGridCoord;
begin
  R := Rect;
  inflaterect(R, -1, -1);
  // Set up Button
  if (not(gdFixed in State)) and (datacol = YourCol) then
  begin
    if styleservices.Enabled then
      TDBGrid(sender).Canvas.Brush.color := styleservices.GetStyleColor
        (scButtonDisabled)
    else
      TDBGrid(sender).Canvas.Brush.color := clbtnface;

    style := DFCS_INACTIVE or DFCS_ADJUSTRECT;
    DrawFrameControl(Grid.Canvas.Handle, R, DFC_BUTTON, style);
    TDBGrid(sender).DefaultDrawColumnCell(R, datacol, Column, State);
    TDBGrid(sender).Canvas.Brush.style := bsclear;
    if styleservices.Enabled then
      TDBGrid(sender).Canvas.Font.color := styleservices.GetStylefontColor
        (sfButtonTextdisabled)
    else
      TDBGrid(sender).Canvas.Font.color := clblack;

    DrawText(Grid.Canvas.Handle, PChar(Btncaption), -1, R, DT_CENTER);
    TDBGrid(sender).DefaultDrawColumnCell(R, datacol, Column, State);
  end;

  if Grid.DataSource.DataSet.RecNo <= Grid.DataSource.DataSet.recordcount then
  begin
    if (not(gdFixed in State)) and (datacol = YourCol) then
    begin
      if Grid.options = Grid.options + [dgindicator] then
        DataRect := TModDbGrid(Grid).CellRect((YourCol + 1),
          TModDbGrid(Grid).Row)
      else
        DataRect := TModDbGrid(Grid).CellRect((YourCol), TModDbGrid(Grid).Row);
      inflaterect(DataRect, -1, -1);
      Button.Width := DataRect.Width;
      Button.left := (DataRect.right - Button.Width);
      Button.top := DataRect.top;
      Button.height := (DataRect.bottom - DataRect.top);
      Button.visible := true;
    end;
  end;
end;

procedure DatePickerdrawColumnCell(picker: TDatePicker;
  datacol, colpos: integer; Column: TColumn; Grid: TDBGrid; const Rect: TRect;
  State: TGridDrawState);
var
  DataRect: TRect;
begin
  if not(gdFixed in State) and (gdFocused in State) and (datacol = colpos) then
  begin
    picker.Font.Size := Grid.Font.Size;
    if Grid.options = Grid.options + [dgindicator] then
      DataRect := TModDbGrid(Grid).CellRect((colpos + 1), TModDbGrid(Grid).Row)
    else
      DataRect := TModDbGrid(Grid).CellRect((colpos), TModDbGrid(Grid).Row);
    inflaterect(DataRect, -1, -1);
    picker.Width := DataRect.Width + 2;
    picker.left := DataRect.right - picker.Width + 1;
    picker.top := DataRect.top - 2;
    picker.height := DataRect.bottom - DataRect.top;
    picker.Date := dateof(Grid.DataSource.DataSet.fieldbyname
      (Grid.Columns[colpos].FieldName).asdatetime);
  end;
end;

procedure DatepickerCell(picker: TDatePicker; Grid: TDBGrid; Column: TColumn;
  FieldName: string);
begin
  // remove editing cannot post here but will need to globally post change
  if (Column.FieldName = FieldName) then
  begin
    picker.Date := dateof(Grid.DataSource.DataSet.fieldbyname(FieldName)
      .asdatetime);
  end;
end;

procedure DatePickerColenter(picker: TDatePicker; FieldName: string;
  colpos: integer; Grid: TDBGrid);
begin
  if Grid.SelectedIndex = colpos then
  begin
    picker.visible := true;
  end;
end;

procedure DatepickerColExit(picker: TDatePicker; FieldName: string;
  colpos: integer; Grid: TDBGrid);
begin
  if Grid.SelectedIndex = colpos then
    picker.visible := false;
end;

procedure DatepickerKeyPress(sender: Tobject; picker: TDatePicker;
  var Key: Char; FieldName: string; Grid: TDBGrid);
begin
  if (Key = Chr(9)) then
    Exit;
  if (Grid.SelectedField.FieldName = FieldName) then
  begin
    picker.SetFocus;
    SendMessage(picker.Handle, WM_Char, word(Key), 0);
  end;
  Grid.DataSource.DataSet.fieldbyname(FieldName).asdatetime := picker.Date;
end;

procedure PopulatePicklistmanual(s: array of string; Grid: TDBGrid;
  colpos: integer);
var
  i: integer;
begin
  for i := low(s) to High(s) do
    Grid.Columns[colpos].PickList.Add(s[i]);
end;

procedure PopulatePicklistDB(Grid: TDBGrid; colpos: integer; query: TFDQuery;
  FieldName: string);
begin
  query.open();
  query.disablecontrols;
  query.first;
  while not query.eof do
  begin
    Grid.Columns[colpos].PickList.Add(query.fieldbyname(FieldName).asstring);
    query.Next;
  end;
  query.enablecontrols;
  query.close;
end;

procedure ComboCell(Grid: TDBGrid; Column: TColumn; FieldName: string);
begin
  Grid.options := OriginalGridoptions;
  if (Column.PickList.Count > 0) and (Column.FieldName = FieldName) then
  begin
    keybd_event(VK_F2, 0, 0, 0);
    keybd_event(VK_F2, 0, KEYEVENTF_KEYUP, 0);
    keybd_event(VK_MENU, 0, 0, 0);
    keybd_event(VK_DOWN, 0, 0, 0);
    keybd_event(VK_DOWN, 0, KEYEVENTF_KEYUP, 0);
    keybd_event(VK_MENU, 0, KEYEVENTF_KEYUP, 0);
  end;
end;

procedure ComboColenter(combo: Tcombobox; FieldName: string; colpos: integer;
  Grid: TDBGrid);
begin
  if Grid.SelectedIndex = colpos then
  begin
    combo.Itemindex := combo.items.indexof
      (Grid.DataSource.DataSet.fieldbyname('CITY').asstring);
    combo.Update;
    combo.visible := true;
  end;
end;

procedure ComboColExit(combo: Tcombobox; FieldName: string; colpos: integer;
  Grid: TDBGrid);
begin
  if Grid.SelectedIndex = colpos then
  begin
    combo.visible := false;
  end;
end;

(* procedure ComboCell(combo:Tcombobox;grid:Tdbgrid;Column: TColumn; fieldname:string);
  begin
  //remove editing cannot post here but will need to globally post change
  if (Column.FieldName = fieldname) then
  begin
  if combo.ItemIndex = -1 then
  begin
  // begin
  Combo.SelText:= '';
  combo.Itemindex:= combo.Items.IndexOf(grid.datasource.dataset.FieldByName(fieldname).AsString);
  combo.Visible := True;
  end;
  end;
  end; *)

// dbcombobox and DBlookupcombobox
procedure DBCombodrawcolumncell(combo: TdbCombobox; datacol, colpos: integer;
  Column: TColumn; Grid: TDBGrid; const Rect: TRect; State: TGridDrawState);
var
  DataRect: TRect;
begin
  if not(gdFixed in State) and (gdFocused in State) and (datacol = colpos) then
  begin
    combo.Font.Size := Grid.Font.Size;
    if Grid.options = Grid.options + [dgindicator] then
      DataRect := TModDbGrid(Grid).CellRect((colpos + 1), TModDbGrid(Grid).Row)
    else
      DataRect := TModDbGrid(Grid).CellRect((colpos), TModDbGrid(Grid).Row);
    inflaterect(DataRect, -1, -1);
    combo.Width := DataRect.Width + 2;
    combo.left := DataRect.right - combo.Width;
    combo.top := DataRect.top - 2;
    combo.height := DataRect.bottom - DataRect.top;
    combo.visible := true;
  end;
end;
   {
procedure DBComboKeyPress(sender: Tobject; combo: TdbCombobox; var Key: Char;
  FieldName: string; Grid: TDBGrid);
begin
  if (Grid.SelectedField.FieldName = FieldName) then
  begin
    combo.Text := Grid.DataSource.DataSet.fieldbyname(FieldName).asstring;
    combo.SetFocus;
    SendMessage(combo.Handle, WM_Char, word(Key), 0);
  end;
end;
      }
procedure DBComboColenter(combo: TdbCombobox; FieldName: string;
  colpos: integer; Grid: TDBGrid);
begin
  if Grid.SelectedIndex = colpos then
  begin
    combo.visible := true;
  end;
end;

procedure DBComboColExit(combo: TdbCombobox; FieldName: string; colpos: integer;
  Grid: TDBGrid);
begin
  if Grid.SelectedIndex = colpos then
    if combo.Itemindex <> -1 then
    begin
      combo.Text := Grid.DataSource.DataSet.fieldbyname(FieldName).asstring;
    end;
  combo.visible := false;
end;

procedure DBComboCell(combo: TdbCombobox; Grid: TDBGrid; Column: TColumn;
  FieldName: string);
begin
  // remove editing cannot post here but will need to globally post change
  if (Column.FieldName = FieldName) then
  begin
    combo.SetFocus;
    combo.Text := Grid.DataSource.DataSet.fieldbyname(FieldName).asstring;
  end;
end;

// dblookupcombobox
procedure DBlookupCombodrawcolumncell(combo: TdblookupCombobox;
  datacol, colpos: integer; Column: TColumn; Grid: TDBGrid; const Rect: TRect;
  State: TGridDrawState);
var
  DataRect: TRect;
begin
  if not(gdFixed in State) and (gdFocused in State) and (datacol = colpos) then
  begin
    combo.Font.Size := Grid.Font.Size;
    if Grid.options = Grid.options + [dgindicator] then
      DataRect := TModDbGrid(Grid).CellRect((colpos + 1), TModDbGrid(Grid).Row)
    else
      DataRect := TModDbGrid(Grid).CellRect((colpos), TModDbGrid(Grid).Row);
    inflaterect(DataRect, -1, -1);
    combo.Width := DataRect.Width + 2;
    combo.left := DataRect.right - combo.Width;
    combo.top := DataRect.top - 2;
    combo.height := DataRect.bottom - DataRect.top;
  end;
end;

procedure DBlookupComboKeyPress(sender: Tobject; combo: TdblookupCombobox;
  var Key: Char; FieldName: string; Grid: TDBGrid);
begin
  if (Grid.SelectedField.FieldName = FieldName) then
  begin
    combo.SetFocus;
    SendMessage(combo.Handle, WM_Char, word(Key), 0);
  end;
end;

procedure DBlookupComboColenter(combo: TdblookupCombobox; FieldName: string;
  colpos: integer; Grid: TDBGrid);
begin
  if Grid.SelectedIndex = colpos then
  begin
    combo.visible := true;
  end;
end;

procedure DBlookupComboColExit(combo: TdblookupCombobox; FieldName: string;
  colpos: integer; Grid: TDBGrid);
begin
  if Grid.SelectedIndex = colpos then
    combo.visible := false;
end;

procedure DBlookupComboCell(combo: TdblookupCombobox; Grid: TDBGrid;
  Column: TColumn; FieldName: string);
begin
  // remove editing cannot post here but will need to globally post change
  if (Column.FieldName = FieldName) then
    combo.SetFocus;
end;

// add progress
procedure Progressdrawcolumncell(sender: Tobject; Grid: TDBGrid;
  colpos, datacol, progressvalue: integer; Rect: TRect; Column: TColumn;
  State: TGridDrawState; progressnumber: integer = 5;
  overduebreakpoint: integer = 1; breakpoint1: integer = 65;
  breakpoint2: integer = 40; breakpoint3: integer = 20;
  backgroundcolor: tcolor = clgray; overduecolor: tcolor = clwebFirebrick;
  Color1: tcolor = clWebLightSkyBlue; Color2: tcolor = clweborange;
  Color3: tcolor = clWebGold; color4: tcolor = clWebTomato;
  maxvalue: integer = 100; progresspadding: integer = 0;
  isbackground: boolean = false; showtext: boolean = true;
  Percentge: string = '%');
begin
  if (not(gdFixed in State)) and (datacol = colpos) then
  begin
    inflaterect(Rect, -1, -3);
    Grid.Canvas.Brush.style := bsSolid;
    Grid.Canvas.Brush.color := styleservices.GetSystemColor(clGrayText);
    Grid.Canvas.FillRect(Rect);
    inflaterect(Rect, 0, -1);
    Rect.left := Rect.left + progresspadding;
    Rect.right := Rect.left + Round(Rect.Width * progressvalue / maxvalue);

    case progressnumber of
      1:
        begin
          if (progressvalue <= 100) then // 20
          begin

            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color1;
            Grid.Canvas.FillRect(Rect);
          end;
        end;
      2:
        begin
          if (progressvalue < breakpoint3) then // 20
          begin
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color1; //
            Grid.Canvas.FillRect(Rect);
          end
          else if (progressvalue < breakpoint1) then // 40
          begin
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := color4;
            Grid.Canvas.FillRect(Rect);
          end
        end;
      3:
        begin
          if (progressvalue < breakpoint3) then // 20
          begin
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := color4; // clWebTomato;
            Grid.Canvas.FillRect(Rect);
          end
          else if (progressvalue < breakpoint2) then // 40
          begin
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color2; // clWebGold;
            Grid.Canvas.FillRect(Rect);
          end
          else if progressvalue < breakpoint1 then // 60
          begin
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color1; // clweborange;//clwebgoldenrod;
            Grid.Canvas.FillRect(Rect);
          end
        end;

      4:
        begin
          if (progressvalue < breakpoint3) then // 20
          begin
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := color4; // clWebTomato;
            Grid.Canvas.FillRect(Rect);
          end
          else if (progressvalue < breakpoint2) then // 40
          begin
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color3; // clWebGold;
            Grid.Canvas.FillRect(Rect);
          end
          else if progressvalue < breakpoint1 then // 60
          begin
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color2; // clweborange;//clwebgoldenrod;
            Grid.Canvas.FillRect(Rect);
          end
          else if progressvalue > (breakpoint1 - 1) then
          begin
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color1; // clWebLightSkyBlue;
            Grid.Canvas.FillRect(Rect);
          end
        end;

      5:
        begin
          if (progressvalue < breakpoint3) then // 20
          begin
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := color4; // clWebTomato;
            Grid.Canvas.FillRect(Rect);
          end
          else if (progressvalue < breakpoint2) then // 40
          begin
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color3; // clWebGold;
            Grid.Canvas.FillRect(Rect);
          end
          else if progressvalue < breakpoint1 then // 60
          begin
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color2; // clweborange;//clwebgoldenrod;
            Grid.Canvas.FillRect(Rect);
          end
          else if progressvalue > (breakpoint1 - 1) then
          begin
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color1; // clWebLightSkyBlue;
            Grid.Canvas.FillRect(Rect);
          end
          else
            // overdue
            if progressvalue < overduebreakpoint then
            begin
              inflaterect(Rect, -2, -2);
              Rect.right := Rect.left + Rect.Width;
              Grid.Canvas.Brush.style := bsSolid;
              Grid.Canvas.Font.style := [fsbold];

              Grid.Canvas.Brush.color := overduecolor; // clwebFirebrick;
              Grid.Canvas.FillRect(Rect);
            end;
        end;
    end;
    TDBGrid(sender).DefaultDrawColumnCell(Rect, datacol, Column, State);

    if showtext = true then
    begin
      Grid.Canvas.Brush.style := bsclear;
      Grid.Canvas.Font.color := styleservices.GetStylefontColor
        (sfButtonTextnormal);
      Grid.Canvas.Font.Size := Grid.Font.Size - 2;
      Grid.Canvas.TextOut(Rect.left + ((Rect.right - Rect.left) div 2) - 1,
        Rect.top, IntToStr(progressvalue) + Percentge);
    end;
  end;
end;

// add horizontalbar
procedure HorizontalBardrawcolumncell(sender: Tobject; Grid: TDBGrid;
  colpos, datacol, progressvalue1, progressvalue2, progressvalue3,
  progressvalue4, progressvalue5: integer; Rect: TRect; Column: TColumn;
  State: TGridDrawState; progressnumber: integer = 5; // min 2
  Color1: tcolor = clWebLightSkyBlue; Color2: tcolor = clWebLightSeaGreen;
  Color3: tcolor = clweborange; color4: tcolor = clWebGold;
  color5: tcolor = clWebTomato; maxvalue: integer = 100;
  progresspadding: integer = 0; isbackground: boolean = false;
  showtext: boolean = true; Percentge: string = '%');
var
  Rect1, Rect2, Rect3, rect4, Rect5: TRect;
  i, j, p, s: integer;
begin
  if (not(gdFixed in State)) and (datacol = colpos) then
  begin
    inflaterect(Rect, -1, -3);
    Grid.Canvas.Brush.style := bsSolid;
    Grid.Canvas.Brush.color := styleservices.GetSystemColor(clGrayText);
    Grid.Canvas.FillRect(Rect);
    inflaterect(Rect, 0, -1);
    Rect.left := Rect.left + progresspadding;
    // Rect.Right := Rect.Left + Round(Rect.Width * progressvalue / maxValue);
    if (progressnumber < 1) or (progressnumber > 6) then
      showmessage
        (' - HorizontalBar - progressvalue must 2 > progressvalue < 6');
    TDBGrid(sender).DefaultDrawColumnCell(Rect, datacol, Column, State);
    case progressnumber of
      2:
        begin
          if (progressvalue2 > 0) or (progressvalue2 <= 100) then
          begin
            Rect2 := Rect;
            Rect2.left := Rect.right -
              Round(Rect.Width * progressvalue2 / maxvalue);
            inflaterect(Rect2, 0, 0);
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color3;
            Grid.Canvas.FillRect(Rect2);
            TDBGrid(sender).DefaultDrawColumnCell(Rect2, datacol,
              Column, State);

            if showtext = true then
            begin
              Grid.Canvas.Brush.style := bsclear;
              Grid.Canvas.Font.color := styleservices.GetStylefontColor
                (sfButtonTextnormal);
              Grid.Canvas.Font.Size := Grid.Font.Size - 2;
              Grid.Canvas.TextOut(Rect2.left + ((Rect2.right - Rect2.left)
                div 2) - 1, Rect2.top, IntToStr(progressvalue2) + Percentge);
            end;
          end;

          if (progressvalue1 > 0) or (progressvalue1 <= 100) then
          begin
            Rect1 := Rect;
            Rect1.right := Rect.left +
              Round(Rect.Width * progressvalue1 / maxvalue);
            inflaterect(Rect1, 0, 0);
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color1;
            Grid.Canvas.FillRect(Rect1);
            TDBGrid(sender).DefaultDrawColumnCell(Rect1, datacol,
              Column, State);
            if showtext = true then
            begin
              Grid.Canvas.Brush.style := bsclear;
              Grid.Canvas.Font.color := styleservices.GetStylefontColor
                (sfButtonTextnormal);
              Grid.Canvas.Font.Size := Grid.Font.Size - 2;
              Grid.Canvas.TextOut(Rect1.left + ((Rect1.right - Rect1.left)
                div 2) - 1, Rect1.top, IntToStr(progressvalue1) + Percentge);
            end;
          end;

        end;
      3:
        begin
          if (progressvalue3 > 0) or (progressvalue3 <= 100) then
          begin
            Rect3 := Rect;
            Rect3.left := Rect.right -
              Round(Rect.Width * progressvalue3 / maxvalue);
            inflaterect(Rect3, 0, 0);
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := color4;
            Grid.Canvas.FillRect(Rect3);
            TDBGrid(sender).DefaultDrawColumnCell(Rect3, datacol,
              Column, State);

            if showtext = true then
            begin
              Grid.Canvas.Brush.style := bsclear;
              Grid.Canvas.Font.color := styleservices.GetStylefontColor
                (sfButtonTextnormal);
              Grid.Canvas.Font.Size := Grid.Font.Size - 2;
              Grid.Canvas.TextOut(Rect3.left + ((Rect3.right - Rect3.left)
                div 2) - 1, Rect3.top, IntToStr(progressvalue3) + Percentge);
            end;
          end;

          if (progressvalue2 > 0) or (progressvalue2 <= 100) then
          begin
            Rect2 := Rect;
            Rect2.right := Rect.right -
              Round(Rect.Width * (progressvalue3) / maxvalue);
            inflaterect(Rect2, 0, 0);
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color2;
            Grid.Canvas.FillRect(Rect2);
            TDBGrid(sender).DefaultDrawColumnCell(Rect2, datacol,
              Column, State);
            if showtext = true then
            begin
              Grid.Canvas.Brush.style := bsclear;
              Grid.Canvas.Font.color := styleservices.GetStylefontColor
                (sfButtonTextnormal);
              Grid.Canvas.Font.Size := Grid.Font.Size - 2;
              Grid.Canvas.TextOut(Rect2.left + ((Rect2.right - Rect2.left)
                div 2) - 1, Rect2.top, IntToStr(progressvalue2) + Percentge);
            end;
          end;

          if (progressvalue1 > 0) or (progressvalue1 <= 100) then
          begin
            Rect1 := Rect;
            Rect1.right := Rect.left +
              Round(Rect.Width * progressvalue1 / maxvalue);
            inflaterect(Rect1, 0, 0);
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color1;
            TDBGrid(sender).DefaultDrawColumnCell(Rect1, datacol,
              Column, State);
            if showtext = true then
            begin
              Grid.Canvas.Brush.style := bsclear;
              Grid.Canvas.Font.color := styleservices.GetStylefontColor
                (sfButtonTextnormal);
              Grid.Canvas.Font.Size := Grid.Font.Size - 2;
              Grid.Canvas.TextOut(Rect1.left + ((Rect1.right - Rect1.left)
                div 2) - 1, Rect1.top, IntToStr(progressvalue1) + Percentge);
            end;
          end;
        end;

      4:
        begin
          if (progressvalue4 > 0) or (progressvalue4 <= 100) then
          begin
            rect4 := Rect;
            rect4.left := Rect.right -
              Round(Rect.Width * progressvalue4 / maxvalue);
            inflaterect(rect4, 0, 0);
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := color4;
            Grid.Canvas.FillRect(rect4);
            TDBGrid(sender).DefaultDrawColumnCell(rect4, datacol,
              Column, State);

            if showtext = true then
            begin
              Grid.Canvas.Brush.style := bsclear;
              Grid.Canvas.Font.color := styleservices.GetStylefontColor
                (sfButtonTextnormal);
              Grid.Canvas.Font.Size := Grid.Font.Size - 2;
              Grid.Canvas.TextOut(rect4.left + ((rect4.right - rect4.left)
                div 2) - 1, rect4.top, IntToStr(progressvalue4) + Percentge);
            end;
          end;

          if (progressvalue3 > 0) or (progressvalue3 <= 100) then
          begin
            Rect3 := Rect;
            Rect3.right := Rect.right -
              Round(Rect.Width * progressvalue4 / maxvalue);
            Rect3.left := Rect3.right -
              Round(Rect.Width * progressvalue3 / maxvalue);
            inflaterect(Rect3, 0, 0);
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color3;
            Grid.Canvas.FillRect(Rect3);
            TDBGrid(sender).DefaultDrawColumnCell(Rect3, datacol,
              Column, State);
            if showtext = true then
            begin
              Grid.Canvas.Brush.style := bsclear;
              Grid.Canvas.Font.color := styleservices.GetStylefontColor
                (sfButtonTextnormal);
              Grid.Canvas.Font.Size := Grid.Font.Size - 2;
              Grid.Canvas.TextOut(Rect3.left + ((Rect3.right - Rect3.left)
                div 2) - 1, Rect3.top, IntToStr(progressvalue3) + Percentge);
            end;
          end;

          if (progressvalue2 > 0) or (progressvalue2 <= 100) then
          begin
            Rect2 := Rect;
            Rect2.right := Rect.right -
              Round(Rect.Width * (progressvalue4 + progressvalue3) / maxvalue);
            Rect2.left := Rect2.right -
              Round(Rect.Width * (progressvalue2 / maxvalue));
            inflaterect(Rect2, 0, 0);
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color2;
            Grid.Canvas.FillRect(Rect2);
            TDBGrid(sender).DefaultDrawColumnCell(Rect2, datacol,
              Column, State);

            if showtext = true then
            begin
              Grid.Canvas.Brush.style := bsclear;
              Grid.Canvas.Font.color := styleservices.GetStylefontColor
                (sfButtonTextnormal);
              Grid.Canvas.Font.Size := Grid.Font.Size - 2;
              Grid.Canvas.TextOut(Rect2.left + ((Rect2.right - Rect2.left)
                div 2) - 1, Rect2.top, IntToStr(progressvalue2) + Percentge);
            end;
          end;

          if (progressvalue1 > 0) or (progressvalue1 <= 100) then
          begin
            Rect1 := Rect;
            Rect1.right := Rect.left +
              Round(Rect.Width * progressvalue1 / maxvalue);
            inflaterect(Rect1, 0, 0);
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color1;
            Grid.Canvas.FillRect(Rect1);
            TDBGrid(sender).DefaultDrawColumnCell(Rect1, datacol,
              Column, State);
            if showtext = true then
            begin
              Grid.Canvas.Brush.style := bsclear;
              Grid.Canvas.Font.color := styleservices.GetStylefontColor
                (sfButtonTextnormal);
              Grid.Canvas.Font.Size := Grid.Font.Size - 2;
              Grid.Canvas.TextOut(Rect1.left + ((Rect1.right - Rect1.left)
                div 2) - 1, Rect1.top, IntToStr(progressvalue1) + Percentge);
            end;
          end;
        end;

      5:
        begin
          if (progressvalue5 > 0) or (progressvalue5 <= 100) then
          begin
            Rect5 := Rect;
            Rect5.left := Rect.right -
              Round(Rect.Width * progressvalue5 / maxvalue);
            inflaterect(Rect5, 0, 0);
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := color5;
            Grid.Canvas.FillRect(Rect5);
            TDBGrid(sender).DefaultDrawColumnCell(Rect5, datacol,
              Column, State);

            if showtext = true then
            begin
              Grid.Canvas.Brush.style := bsclear;
              Grid.Canvas.Font.color := styleservices.GetStylefontColor
                (sfButtonTextnormal);
              Grid.Canvas.Font.Size := Grid.Font.Size - 2;
              Grid.Canvas.TextOut(Rect5.left + ((Rect5.right - Rect5.left)
                div 2) - 1, Rect5.top, IntToStr(progressvalue5) + Percentge);
            end;
          end;

          if (progressvalue4 > 0) or (progressvalue4 <= 100) then
          begin
            rect4 := Rect;
            rect4.right := Rect.right -
              Round(Rect.Width * progressvalue5 / maxvalue);
            rect4.left := rect4.right -
              Round(Rect.Width * progressvalue4 / maxvalue);
            inflaterect(rect4, 0, 0);
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := color4;
            Grid.Canvas.FillRect(rect4);
            TDBGrid(sender).DefaultDrawColumnCell(rect4, datacol,
              Column, State);

            if showtext = true then
            begin
              Grid.Canvas.Brush.style := bsclear;
              Grid.Canvas.Font.color := styleservices.GetStylefontColor
                (sfButtonTextnormal);
              Grid.Canvas.Font.Size := Grid.Font.Size - 2;
              Grid.Canvas.TextOut(rect4.left + ((rect4.right - rect4.left)
                div 2) - 1, rect4.top, IntToStr(progressvalue4) + Percentge);
            end;
          end;
          if (progressvalue3 > 0) or (progressvalue3 <= 100) then
          begin
            Rect3 := Rect;
            Rect3.right := Rect.right -
              Round(Rect.Width * (progressvalue4 + progressvalue5) / maxvalue);
            Rect3.left := Rect3.right -
              Round(Rect.Width * progressvalue3 / maxvalue);
            inflaterect(Rect3, 0, -1);
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color3;
            Grid.Canvas.FillRect(Rect3);
            TDBGrid(sender).DefaultDrawColumnCell(Rect3, datacol,
              Column, State);
            if showtext = true then
            begin
              Grid.Canvas.Brush.style := bsclear;
              Grid.Canvas.Font.color := styleservices.GetStylefontColor
                (sfButtonTextnormal);
              Grid.Canvas.Font.Size := Grid.Font.Size - 2;
              Grid.Canvas.TextOut(Rect3.left + ((Rect3.right - Rect3.left)
                div 2) - 1, Rect3.top, IntToStr(progressvalue3) + Percentge);
            end;
          end;

          if (progressvalue2 > 0) or (progressvalue2 <= 100) then
          begin
            Rect2 := Rect;
            Rect2.right := Rect.right -
              Round(Rect.Width * (progressvalue3 + progressvalue4 +
              progressvalue5) / maxvalue);
            Rect2.left := Rect2.right -
              Round(Rect.Width * progressvalue2 / maxvalue);
            inflaterect(Rect2, 0, -1);
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color2;
            Grid.Canvas.FillRect(Rect2);
            TDBGrid(sender).DefaultDrawColumnCell(Rect2, datacol,
              Column, State);
            if showtext = true then
            begin
              Grid.Canvas.Brush.style := bsclear;
              Grid.Canvas.Font.color := styleservices.GetStylefontColor
                (sfButtonTextnormal);
              Grid.Canvas.Font.Size := Grid.Font.Size - 2;
              Grid.Canvas.TextOut(Rect2.left + ((Rect2.right - Rect2.left)
                div 2) - 1, Rect2.top, IntToStr(progressvalue2) + Percentge);
            end;
          end;

          if (progressvalue1 > 0) or (progressvalue1 <= 100) then
          begin
            Rect1 := Rect;
            Rect1.right := Rect.left +
              Round(Rect.Width * progressvalue1 / maxvalue);
            inflaterect(Rect1, 0, -1);
            Grid.Canvas.Brush.style := bsSolid;
            Grid.Canvas.Brush.color := Color1;
            Grid.Canvas.FillRect(Rect1);
            TDBGrid(sender).DefaultDrawColumnCell(Rect1, datacol,
              Column, State);
            if showtext = true then
            begin
              Grid.Canvas.Brush.style := bsclear;
              Grid.Canvas.Font.color := styleservices.GetStylefontColor
                (sfButtonTextnormal);
              Grid.Canvas.Font.Size := Grid.Font.Size - 2;
              Grid.Canvas.TextOut(Rect1.left + ((Rect1.right - Rect1.left)
                div 2) - 1, Rect1.top, IntToStr(progressvalue1) + Percentge);
            end;
          end;
        end;
    end;
  end;
end;

procedure ColorhorizontalBarshape(shape: Tshape; color: tcolor);
begin
  shape.Brush.color := color;
  shape.Pen.style := psClear;
end;

// star
// helper worker function for stars
function MakePent(X, Y, L: integer): TPent;
var
  DX1, DY1, DX2, DY2: integer;
  newpent: TPent;
const
  Sin54 = 0.809;
  Cos54 = 0.588;
  Tan72 = 3.078;
begin
  DX1 := trunc(L * Sin54);
  DY1 := trunc(L * Cos54);
  DX2 := L div 2;
  DY2 := trunc(L * Tan72 / 2);
  newpent[0] := point(X, Y);
  newpent[1] := point(X - DX1, Y + DY1);
  newpent[2] := point(X - DX2, Y + DY2);
  newpent[3] := point(X + DX2, Y + DY2);
  newpent[4] := point(X + DX1, Y + DY1);
  result := newpent;
end;

// function for star
procedure DrawPentacle(Canvas: TCanvas; Pent: TPent);
begin
  with Canvas do
  begin
    MoveTo(Pent[0].X, Pent[0].Y);
    LineTo(Pent[2].X, Pent[2].Y);
    LineTo(Pent[4].X, Pent[4].Y);
    LineTo(Pent[1].X, Pent[1].Y);
    LineTo(Pent[3].X, Pent[3].Y);
    LineTo(Pent[0].X, Pent[0].Y);
  end;
end;

// add stars
procedure StarCombodrawcolumncell(sender: Tobject; Grid: TDBGrid;
  colpos, datacol, offset, starnum, activestar: integer;
  ActiveColor, InactiveColor: tcolor; Rect: TRect; Column: TColumn;
  State: TGridDrawState; isbackground: boolean = false);
var
  Pent: TPent;
  i: integer;
  fullwidth, Width: integer;
  finalColor: tcolor;
  R: TRect;
  X, Y, L: integer;
begin
  if (not(gdFixed in State)) and (datacol = colpos) then
  begin
    R := Rect;
    if isbackground = true then
    begin
      inflaterect(R, -1, -1);
      Grid.Canvas.Brush.color := styleservices.GetStyleColor(scButtonDisabled);
      TDBGrid(sender).DefaultDrawColumnCell(R, datacol, Column, State);
    end;
    inflaterect(Rect, 0, 0);
    L := (Rect.bottom - Rect.top) div 2;
    Y := Rect.top + 2;
    X := Rect.left + 3 + (offset div 2);

    Width := trunc(L + (L div 2));
    X := X + (Width div 2) + offset;

    for i := 1 to starnum do
    begin
      finalColor := ActiveColor;
      if i = 1 then
        X := X;
      if i > 1 then
        X := X + Width;
      if i > activestar then
        finalColor := InactiveColor;
      Pent := MakePent(X, Y, L);
      BeginPath(Grid.Canvas.Handle);
      DrawPentacle(Grid.Canvas, Pent);
      EndPath(Grid.Canvas.Handle);
      SetPolyFillMode(Grid.Canvas.Handle, WINDING);
      Grid.Canvas.Brush.color := finalColor;
      FillPath(Grid.Canvas.Handle);
      // this fills the path using the brush colour
    end;
  end;
end;

procedure StarCell(Grid: TDBGrid; starnum: integer; Column: TColumn;
  FieldName: string);
begin

  if Grid.DataSource.DataSet.fieldbyname(FieldName).asinteger < starnum then
  begin
    if not(Grid.DataSource.DataSet.State in [dsedit, dsinsert]) then
      Grid.DataSource.DataSet.edit;
    begin
      Grid.DataSource.DataSet.fieldbyname(FieldName).asinteger :=
        Grid.DataSource.DataSet.fieldbyname(FieldName).asinteger + 1;
      Grid.DataSource.DataSet.post;
    end;
  end
  else if Grid.DataSource.DataSet.fieldbyname(FieldName).asinteger >= starnum
  then
  begin
    if not(Grid.DataSource.DataSet.State in [dsedit, dsinsert]) then
      Grid.DataSource.DataSet.edit;
    begin
      Grid.DataSource.DataSet.fieldbyname(FieldName).asinteger := 1;
      Grid.DataSource.DataSet.post;
    end
  end;
end;

// circles -rating
procedure DrawEllipseFromCenter(Canvas: TCanvas; Rect: TRect;
  Radius, n: integer);
var
  R: TRect;
begin
  with Canvas do
  begin
    R.top := Rect.top;
    if n = 1 then
      R.left := Rect.left
    else
      R.left := Rect.left + (((Radius * 2)) * (n - 1));
    R.bottom := Rect.bottom;
    if n = 1 then
      R.right := Rect.left + (Radius * 2) - 1
    else
      R.right := Rect.left + (((Radius * 2)) * (n)) - 1;
    Ellipse(R);
  end;
end;

// add circle rating
procedure CircleCombdrawcolumncell(sender: Tobject; Grid: TDBGrid;
  colpos, datacol, offset, ratingnum, activerating: integer;
  ActiveColor, InactiveColor: tcolor; Rect: TRect; Column: TColumn;
  State: TGridDrawState; isbackground: boolean = false);
var
  Radius: integer;
  i: integer;
  R, CircleRect: TRect;
begin
  if (not(gdFixed in State)) and (datacol = colpos) then
  begin
    R := Rect;
    if isbackground = true then
    begin
      inflaterect(R, -1, -1);
      Grid.Canvas.Brush.color := styleservices.GetStyleColor(scButtonDisabled);
      TDBGrid(sender).DefaultDrawColumnCell(R, datacol, Column, State);
    end;
    inflaterect(Rect, -2, -3);
    CircleRect.top := Rect.top;
    Radius := (Rect.bottom - Rect.top) div 2;
    CircleRect.right := Radius * ratingnum;
    CircleRect.left := Rect.left + offset;
    CircleRect.bottom := Rect.bottom;
    inflaterect(CircleRect, -2, -2);

    for i := 1 to ratingnum do
    begin
      if i <= activerating then
      begin
        Grid.Canvas.Pen.color := ActiveColor;
        Grid.Canvas.Brush.color := ActiveColor;
      end
      else
      begin
        Grid.Canvas.Pen.color := InactiveColor;
        Grid.Canvas.Brush.color := InactiveColor;
      end;
      DrawEllipseFromCenter(Grid.Canvas, CircleRect, Radius, i);
    end;
  end;
end;

procedure CirclesCell(Grid: TDBGrid; circlenum: integer; Column: TColumn;
  FieldName: string);
begin

  if Grid.DataSource.DataSet.fieldbyname(FieldName).asinteger < circlenum then
  begin
    if not(Grid.DataSource.DataSet.State in [dsedit, dsinsert]) then
      Grid.DataSource.DataSet.edit;
    begin
      Grid.DataSource.DataSet.fieldbyname(FieldName).asinteger :=
        Grid.DataSource.DataSet.fieldbyname(FieldName).asinteger + 1;
      Grid.DataSource.DataSet.post;
    end;
  end
  else if Grid.DataSource.DataSet.fieldbyname(FieldName).asinteger >= circlenum
  then
  begin
    if not(Grid.DataSource.DataSet.State in [dsedit, dsinsert]) then
      Grid.DataSource.DataSet.edit;
    begin
      Grid.DataSource.DataSet.fieldbyname(FieldName).asinteger := 1;
      Grid.DataSource.DataSet.post;
    end
  end;
end;

procedure CheckBoxdrawcolumncell(FieldName: String; ValueCheck: Variant;
  Grid: TDBGrid; const Rect: TRect; Column: TColumn; State: TGridDrawState);
const
  CtrlState: Array [boolean] of integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or
    DFCS_CHECKED);
  CtrlStateXP: Array [boolean] of TThemedButton = (tbCheckBoxUncheckedNormal,
    tbCheckBoxCheckedNormal);
var
  R: TRect;
  Details: TThemedElementDetails;
begin
  if Column.FieldName = FieldName then
  begin
    Column.Title.Alignment := taCenter;
    Column.Alignment := taCenter;
    Grid.Canvas.FillRect(Rect);

    if styleservices.Enabled then
    begin
      Details := styleservices.GetElementDetails
        (CtrlStateXP[Column.Field.Value = ValueCheck]);
      styleservices.DrawElement(Grid.Canvas.Handle, Details, Rect);
      if ((not(gdFixed in State)) and (not(gdselected in State)) and
        (not(gdFocused in State))) then
      begin
        Grid.Canvas.Brush.color := styleservices.GetSystemColor(clhighlight);
        DrawFrameControl(Grid.Canvas.Handle, R, DFC_BUTTON,
          CtrlState[Column.Field.Value = ValueCheck]);
      end;
    end
    else
    begin
      R := Rect;
      inflaterect(R, -1, -1);
      DrawFrameControl(Grid.Canvas.Handle, R, DFC_BUTTON,
        CtrlState[Column.Field.Value = ValueCheck]);
    end;
  end;
end;

// if '1' integer if 'true' then boolean
procedure CheckboxCell(Grid: TDBGrid; Column: TColumn; FieldName: string);
begin
  if (Column.FieldName = FieldName) then
  begin
    OriginalGridoptions := Grid.options;
    Grid.options := Grid.options - [dgediting];
    Column.Grid.DataSource.DataSet.edit;
    if Column.Field.Value = 1 then
      Column.Field.Value := 0
    else if Column.Field.Value <> 1 then
      Column.Field.Value := 1;

    if Column.Field.datatype = ftboolean then
      Column.Field.Value := not Column.Field.AsBoolean;
    Column.Grid.DataSource.DataSet.post;
  end;
end;

// enter '1' or 'true'
procedure CheckboxHighlightrows(sender: Tobject; FieldName: string;
  booleantype: string; highlightcol: tcolor; Fromcol, ToCol: integer;
  datacol: integer; Grid: TDBGrid; Rect: TRect; Column: TColumn;
  State: TGridDrawState);
begin
  if ((datacol >= Fromcol) and (datacol <= ToCol)) then
  begin
    if booleantype = '1' then
    begin
      if Grid.DataSource.DataSet.fieldbyname(FieldName).asinteger = 1 then
        Grid.Canvas.Brush.color := styleservices.GetSystemColor(highlightcol);
    end
    else if lowercase(booleantype) = 'true' then
    begin
      if Grid.DataSource.DataSet.fieldbyname(FieldName).AsBoolean then
        Grid.Canvas.Brush.color := styleservices.GetSystemColor(highlightcol);
    end
  end;
  TDBGrid(sender).DefaultDrawColumnCell(Rect, datacol, Column, State);
end;

procedure CheckboxCellBool(Column: TColumn; FieldName: string);
begin
  if (Column.FieldName = FieldName) then
  begin
    Column.Grid.DataSource.DataSet.edit;
    if Column.Field.Value = 1 then
      Column.Field.Value := 0
    else if Column.Field.Value <> 1 then
      Column.Field.Value := 1;
    Column.Grid.DataSource.DataSet.post;
  end;
end;

procedure RowNumbers(Rect: TRect; Grid: TDBGrid; datacol: integer);
begin
  // set row numbers
  if Grid.DataSource.DataSet.RecNo > 0 then
  begin
    if datacol = 0 then
      Grid.Canvas.TextOut(Rect.left + 6, Rect.top,
        IntToStr(Grid.DataSource.DataSet.RecNo));
  end;
end;

procedure setcolumncolor(sender: Tobject; colnumber, datacol: integer;
  colcolor: tcolor; Grid: TDBGrid; Rect: TRect; Column: TColumn;
  State: TGridDrawState);
var
  vdbgrid: TDBGrid absolute sender;
begin
  if (datacol = colnumber) then
  begin
    vdbgrid.Canvas.Brush.color := colcolor;
    vdbgrid.Canvas.Font.color := styleservices.GetStylefontColor
      (sfButtonTextnormal);
  end;
  if (gdselected in State) then
    with Grid.Canvas do
    begin
      Brush.color := styleservices.GetSystemColor(clhighlight);
    end;
  TDBGrid(sender).DefaultDrawColumnCell(Rect, datacol, Column, State);
end;

end.
