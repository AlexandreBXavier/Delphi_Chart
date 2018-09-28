unit View.Chart;

interface

uses
     Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
     Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ActiveX, Vcl.ExtCtrls,
     Vcl.OleCtrls, SHDocVw;

type
     TFormChart = class(TForm)
          WebBrowser: TWebBrowser;
          PanelChart: TPanel;
          ButtonDonut: TButton;
          ButtonPie: TButton;
          procedure ButtonDonutClick(Sender: TObject);
          procedure ButtonPieClick(Sender: TObject);
     private
          { Private declarations }
     public
          { Public declarations }
     end;

var
     FormChart: TFormChart;

implementation

{$R *.dfm}
{ TForm1 }

uses Controller.Chart.Factory;

procedure TFormChart.ButtonDonutClick(Sender: TObject);
begin
     TControllerChartFactory.New.Default
          .SetCharTitle('Sales TODAY')
          .SetCharSubTitle('Sales of Product')
          .AddTitle('Product', 'Amount')
          .AddValue('Pens', '190')
          .AddValue('Glasses', '110')
          .AddValue('Cups', '90')
          .AddValue('Papers', '88')
          .AddValue('Scissors', '63')
          .ShowChartDonut(WebBrowser);
end;

procedure TFormChart.ButtonPieClick(Sender: TObject);
begin
     TControllerChartFactory.New.Default
          .SetCharTitle('Sales TODAY')
          .SetCharSubTitle('Sales of Product')
          .AddTitle('Product', 'Amount')
          .AddValue('Pens', '190')
          .AddValue('Glasses', '110')
          .AddValue('Cups', '90')
          .AddValue('Papers', '88')
          .AddValue('Scissors', '63')
          .ShowChartPie(WebBrowser);
end;

end.
