object FormChart: TFormChart
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Form Chart'
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser: TWebBrowser
    Left = 0
    Top = 49
    Width = 800
    Height = 551
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 264
    ExplicitTop = 152
    ExplicitWidth = 300
    ExplicitHeight = 150
    ControlData = {
      4C000000AF520000F33800000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620A000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object PanelChart: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 49
    Align = alTop
    TabOrder = 1
    object ButtonDonut: TButton
      Left = 8
      Top = 13
      Width = 75
      Height = 25
      Caption = 'Donut'
      TabOrder = 0
      OnClick = ButtonDonutClick
    end
    object ButtonPie: TButton
      Left = 89
      Top = 13
      Width = 75
      Height = 25
      Caption = 'Pie'
      TabOrder = 1
      OnClick = ButtonPieClick
    end
  end
end
