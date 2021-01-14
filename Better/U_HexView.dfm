object Form2: TForm2
  Left = 207
  Top = 36
  Caption = 'Hex View:  No file selected'
  ClientHeight = 712
  ClientWidth = 895
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  DesignSize = (
    895
    712)
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 224
    Top = 648
    Width = 66
    Height = 16
    Anchors = [akLeft, akBottom]
    Caption = 'Page 0 of 0'
  end
  object Memo1: TMemo
    Left = 24
    Top = 16
    Width = 848
    Height = 601
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    Lines.Strings = (
      ''
      '    Select a file to view contents.'
      ''
      '    Browse using PgUp, PgDn keys'
      ''
      '    Ctrl+PgUp = view 1st page'
      '    Ctrl+PgDn = view last page'
      '    Esc = Close file')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    WordWrap = False
  end
  object OpenBtn: TButton
    Left = 40
    Top = 648
    Width = 137
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Select a file'
    TabOrder = 1
    OnClick = OpenBtnClick
  end
  object Memo2: TMemo
    Left = 464
    Top = 632
    Width = 393
    Height = 57
    Lines.Strings = (
      '    Browse using PgUp, PgDn keys.  '
      '    Ctrl+PgUp = view 1st page;     Ctrl+PgDn = view last page'
      '    Esc= Close file'
      '')
    TabOrder = 2
  end
  object OpenDialog1: TOpenDialog
    Left = 784
    Top = 576
  end
end
