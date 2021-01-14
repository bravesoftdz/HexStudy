unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
  procedure FileViewHex(FileName: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
FileViewHex('D:\Desktop\1.rpf');
end;

procedure TForm1.FileViewHex(FileName: string);
const
  MaxLineLength = 16 * 6; // each byte displayed with 2 characters plus a space
  BufferSize = 4096;
var
  DataFile: File;
  Buffer: array[1..BufferSize] of byte;
  BytesRead, I: integer;
  HexByte, Line: string;
begin
  AssignFile(DataFile, Filename);
  Reset(DataFile, 1);
  Memo1.Clear;
  while not Eof(DataFile) do begin
    BlockRead(DataFile, Buffer, BufferSize, BytesRead);
    Line := '';
    for I := 1 to BytesRead do begin
      HexByte := IntToHex(Buffer[I], 1); // convert a byte to hexadecimal
      // Add leading 0 if result is shorter than 2, easier to read...
      if Length(HexByte) < 2 then HexByte := '0' + HexByte;
      Line := Line + HexByte + ' ';
      if Length(Line) >= MaxLineLength then begin
        Memo1.Lines.Add(Line);
        Line := '';
      end;
    end;
  end;
  // If not already added, add last line to TMemo
  if Length(Line) > 0 then Memo1.Lines.Add(Line);
  CloseFile(DataFile);
end;

end.
