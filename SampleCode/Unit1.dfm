object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 224
    Top = 266
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 635
    Height = 105
    Align = alTop
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button2: TButton
    Left = 305
    Top = 266
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Memo2: TMemo
    Left = 0
    Top = 105
    Width = 635
    Height = 89
    Align = alTop
    Lines.Strings = (
      'Memo2')
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object OpenDialog1: TOpenDialog
    Left = 312
    Top = 152
  end
  object SaveDialog1: TSaveDialog
    Left = 344
    Top = 152
  end
end
