unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
S: String;
H: Integer;
C: Byte;
F: File Of Byte;
begin
  if OpenDialog1.Execute then
  begin
  S:='';
  AssignFile(f,OpenDialog1.FileName);
  Reset(F);
  while not eof(F) do
    begin
    Read(F,C);
    //S:= S + IntToHex(C, 2)+ ' ';
    S:= S + IntToHex(C, 2);
    end;
  memo1.Text:= S;
  end;
end;

function HexStrToStr(const HexStr: string): string;
var
  tmp: AnsiString;
begin
  Assert(not Odd(Length(HexStr)), 'HexToStr input length must be an even number');
  SetLength(tmp, Length(HexStr) div 2);
  HexToBin(PWideChar(HexStr), @tmp[1], Length(tmp));
  result := tmp;
end;

function HexToString(H: String): String;
var I: Integer;
begin
  Result:= '';
  for I := 1 to length (H) div 2 do
    Result:= Result+Char(StrToInt('$'+Copy(H,(I-1)*2+1,2)));
end;

function HexToAsc(strData: string): string;
var
  sresult: string;
  sfinal: string;
  hexc: cardinal;
  i: integer;
begin
  i := 1;
  while i <= length(strData) do
  begin
    hexc := strtoint('$' + copy(strData, i, 2));
    sresult := inttostr(hexc);
    sresult := chr(strtoint(sresult));
    sfinal := sfinal + sresult;

    i := i + 2;
  end;
  result := sfinal

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  S: string;
  ch: Char;
begin
//  S := '4D'; //HEX string
//  ch := Chr(StrToInt( '$'+ S )); //ASCII character
//  Memo2.Lines.Add(ch);

  Memo2.Lines.Text := (HexToString(Memo1.Lines.Text));
  ShowMessage('Finish');
end;



end.
