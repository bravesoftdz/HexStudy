unit U_HexView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, Menus, ShellApi;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    OpenBtn: TButton;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    Memo2: TMemo;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
  public
    { Public declarations }
    browsefilename:string;
    f_in : TFileStream;
    buffer:array of byte;
    buflen:integer; {buffer size and number of bytes to read}
    bytesread:integer;  {number of bytes actually read during last read}
    curpage,maxpage:integer;
    charsperline:integer;
    list:TStringlist;  {area in which to build  the lines for a displayed page}
    procedure setupPage;
    procedure showpage; {display the current page (curpage)}
    procedure resetbrowsefile;
  end;

var
  Form2: TForm2;

implementation


{$R *.DFM}

var hexchars:array[0..15] of char=('0','1','2','3','4','5','6','7','8',
                                   '9','A','B','C','D','E','F');

{*************** FormActivate *****************}
procedure TForm2.FormActivate(Sender: TObject);

begin
  memo1.doublebuffered:=true;
  list:=TStringlist.create;
  formresize(sender);  {set up the page paramters for the current form size}
end;

{****************** SetupPage ****************}
procedure Tform2.SetupPage;
{{Called initally and if form size changes}
var
  savefont:TFont;
  w,h:integer;
  pagecharwidth, pagelines:integer;
begin
  if not fileexists(browsefilename) then exit;
  {Memo does not have a canvas so we'll use the forms canvas to calculate
   character height and width}
  savefont:=font;
  font:=memo1.font;
  w:=canvas.textwidth('X');
  h:=canvas.textheight('X');
  font:=savefont;
  pagecharwidth:=memo1.width{clientwidth} div w;
  pagelines:=memo1.height {clientheight} div h-1;
  {due to hex display formatting, characters can only use less than  1/3 of width}
  charsperline:=4*((4*pagecharwidth div 13 -2) div 4);
  buflen:=charsperline*pagelines;
  setlength(buffer,buflen);
  maxpage:=f_in.size div buflen ;
  curpage:=0;
  showpage;
end;


{**************** ShowPage *************}
 procedure TForm2.showpage;
 {Display the page indicated by CurPage variable}
 var
   lines:integer;
   i,j,n:integer;
   text:string;
   hex:string;
   bytesread, byteswritten:integer;
   hexsize:integer;
 begin
   if browsefilename='' then exit;
   f_in.seek(curpage*buflen, soFromBeginning);
   bytesread:=f_in.read(buffer[0],buflen);
   label1.caption:=inttostr(curpage+1) +#13+'of  '+ #13+ inttostr(maxpage+1);
   list.clear;
   lines:=bytesread div charsperline;
   hexsize:=charsperline*2+charsperline div 4; {length of a full hex string}
   if lines>=0 then
   begin
     byteswritten:=0;
     for i:= 0 to lines do {for all lines}
     begin
       hex:='';
       n:=i*charsperline;
       text:='';
       for j:=0 to charsperline -1 do  {for characters im the line}
       begin
         {The clear text part -  if it's displayable the do it}
         if (buffer[n+j]>=32) and (buffer[n+j]<=127) then text:=text+ char(buffer[n+j])
         else text:=text+char($90); {otherwise display a block char}
         {The hex part - turn left and right halves of each character into a
          two character hex number}
         if (j mod 4=0) and (j>0) then hex:=hex+' ';
         hex:=hex+hexchars[(buffer[n+j] and $F0) shr 4]
            + hexchars[(buffer[n+j] and $0F)];
         inc(byteswritten);
         if byteswritten>=bytesread then break;
       end;
       {pad out the last hex string if it is short}
       if length(hex)< hexsize then hex:=hex+stringofchar(' ',hexsize-length(hex));
       list.add(hex+' '+text);
       if byteswritten>=bytesread then break;
     end;
     memo1.lines.assign(list); {move the text to the display area}
   end;
end;


{***************** FormKeyDown ***************}
procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word;
{Form KeyPreview property is set to True, so we come here for any
keypress.  We'll handle PgUp, PgDn, CtrlPgUp,CtrlPgDn and Up and Dow arrow keys to
display a new page from the file}
  Shift: TShiftState);
begin
    If (key=vk_Next) or (key=vk_down) then
    begin
      if ssCtrl in shift then  curpage:=maxpage
      else if curpage<maxpage then inc(curpage) else beep;
      showpage;
    end
    else if (key=vk_Prior) or (key=vk_up) then
    begin
     if ssctrl in shift then  curpage:=0
     else if curpage>0 then dec(curpage) else beep;
     showpage;
    end
    else if key=vk_escape then
    begin
      resetbrowsefile;
    end;
    key:=0;
end;

{************ FormResize *************}
procedure TForm2.FormResize(Sender: TObject);
{Resize the memo1 display area and other controls when the form is resized}
begin

  {if browsefilename<>'' then} setuppage;
end;


{*********** OpenBtnClick ***********}
procedure TForm2.OpenBtnClick(Sender: TObject);
begin
  if assigned(f_in) then freeandnil(f_in);
  If opendialog1.execute then
  begin
    if fileexists(opendialog1.filename)
    then
    begin
      browsefilename:=opendialog1.filename;
      caption:='Hex View: File:  ' +browsefilename;
      f_in:=TFileStream.create(browsefilename,fmOpenread);
    end
    else resetbrowsefile;
    setupPage; {calculate page size stuff}
    showpage;
  end;
end;

{********* ResetBrowsefile ********}
procedure TForm2.resetbrowsefile;
begin
  browsefilename:='';
  Caption:='Hex View:  No file selected';
  Memo1.Clear;
  freeandnil(f_in);
end;


end.
