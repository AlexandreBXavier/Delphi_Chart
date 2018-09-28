program PrjChart;

uses
  Vcl.Forms,
  View.Chart in 'View.Chart.pas' {FormChart},
  Controller.Chart.Default in 'Controller.Chart.Default.pas',
  Controller.Interfaces in 'Controller.Interfaces.pas',
  Controller.Chart.Factory in 'Controller.Chart.Factory.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormChart, FormChart);
  Application.Run;
end.
