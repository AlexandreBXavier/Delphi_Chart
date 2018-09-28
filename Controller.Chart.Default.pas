unit Controller.Chart.Default;

interface

uses Controller.Interfaces, System.Classes, System.SysUtils, Vcl.OleCtrls, Vcl.Forms, ActiveX, SHDocVw;

type
     TControllerChartDefault = class(TInterfacedObject, iControllerChartDefault)
     private
          FValues: TStrings;
          FChartTitle: String;
          FChartSubTitle: String;
          //
          function GetChart(aTypeChart: String; aWidth, aHeight: Integer): String;
          procedure LoadStream(WebBrowser: TWebBrowser; Stream: TStream);
     public
          constructor Create;
          destructor Destroy; Override;
          class function New: iControllerChartDefault;
          function SetCharTitle(aValue: String): iControllerChartDefault;
          function SetCharSubTitle(aValue: String): iControllerChartDefault;
          function AddTitle(aDescription, aValue: String): iControllerChartDefault;
          function AddValue(aDescription, aValue: String): iControllerChartDefault;
          procedure ShowChartDonut(aWebBrowser: TWebBrowser);
          procedure ShowChartPie(aWebBrowser: TWebBrowser);
     end;

implementation

{ TControllerChartDefault }

constructor TControllerChartDefault.Create;
begin
     FValues := TStringList.Create;
end;

destructor TControllerChartDefault.Destroy;
begin
     FValues.Free;
     //
     inherited;
end;

class function TControllerChartDefault.New: iControllerChartDefault;
begin
     Result := Self.Create;
end;

function TControllerChartDefault.SetCharSubTitle(aValue: String): iControllerChartDefault;
begin
     Result := Self;
     //
     FChartSubTitle := aValue;
end;

function TControllerChartDefault.SetCharTitle(aValue: String): iControllerChartDefault;
begin
     Result := Self;
     //
     FChartTitle := aValue;
end;

procedure TControllerChartDefault.ShowChartDonut(aWebBrowser: TWebBrowser);
var
     LocalStream: TStringStream;
begin
     try
          LocalStream := TStringStream.Create(GetChart('donutchart', aWebBrowser.Width, aWebBrowser.Height));
          //
          LoadStream(aWebBrowser, LocalStream);
     finally
          LocalStream.Free;
     end;
end;

procedure TControllerChartDefault.ShowChartPie(aWebBrowser: TWebBrowser);
var
     LocalStream: TStringStream;
begin
     try
          LocalStream := TStringStream.Create(GetChart('piechart', aWebBrowser.Width, aWebBrowser.Height));
          //
          LoadStream(aWebBrowser, LocalStream);
     finally
          LocalStream.Free;
     end;
end;

function TControllerChartDefault.AddTitle(aDescription, aValue: String): iControllerChartDefault;
begin
     Result := Self;
     //
     FValues.Insert(0, '[' + QuotedStr(aDescription) + ', ' + QuotedStr(aValue) + ']');
end;

function TControllerChartDefault.AddValue(aDescription, aValue: String): iControllerChartDefault;
begin
     Result := Self;
     //
     FValues.Add('[' + QuotedStr(aDescription) + ', ' + aValue + ']');
end;

function TControllerChartDefault.GetChart(aTypeChart:String; aWidth, aHeight: Integer): String;
var
     aChart: TStrings;
     aLine: Integer;
begin
     // Use: https://developers.google.com/chart/interactive/docs/gallery
     try
          aChart := TStringList.Create;
          aChart.Add('<html>');
          aChart.Add('<meta http-equiv="X-UA-Compatible" content="IE=edge" />');
          aChart.Add('  <head>');
          aChart.Add('    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>');
          aChart.Add('    <script type="text/javascript">');
          aChart.Add('      google.charts.load(' + QuotedStr('current') + ', {' + QuotedStr('packages') + ':[' + QuotedStr('corechart') + ']});');
          aChart.Add('      google.charts.setOnLoadCallback(drawChart);');
          aChart.Add('      function drawChart() {');
          aChart.Add('        var data = google.visualization.arrayToDataTable([');
          //
          for aLine := 0 to FValues.Count-1 do
          begin
               if (aLine = FValues.Count-1) then
                    aChart.Add(FValues.Strings[aLine])
               else aChart.Add(FValues.Strings[aLine] + ', ');
          end;
          //
          aChart.Add('        ]);');
          aChart.Add('        var options = {');
          aChart.Add('          title: ' + QuotedStr(FChartTitle) + ' - [' + aTypeChart + '],');
          aChart.Add('          subtitle: ' + QuotedStr(FChartSubTitle) + ',');
          //
          if (aTypeChart = 'donutchart') then aChart.Add('          pieHole: 0.4,');
          //
          aChart.Add('        };');
          aChart.Add('        var chart = new google.visualization.PieChart(document.getElementById(' + QuotedStr(aTypeChart) + '));');
          aChart.Add('        chart.draw(data, options);');
          aChart.Add('      }');
          aChart.Add('    </script>');
          aChart.Add('  </head>');
          aChart.Add('  <body>');
          aChart.Add('    <div id="' + aTypeChart + '" style="width: ' + IntToStr(aWidth-60) + 'px; height: ' + IntToStr(aHeight-60) + 'px;"></div>');
          aChart.Add('  </body>');
          aChart.Add('</html>');
     finally
          Result := aChart.Text;
          //
          aChart.Free;
     end;
end;

procedure TControllerChartDefault.LoadStream(WebBrowser: TWebBrowser; Stream: TStream);
var
     PersistStreamInit: IPersistStreamInit;
     StreamAdapter: IStream;
     MemoryStream: TMemoryStream;
begin
     { Load empty HTML document into Webbrowser to make "Document" a valid HTML document }
     WebBrowser.Navigate('about:blank');
     { wait until finished loading }
     repeat
          Application.ProcessMessages;
          Sleep(0);
     until WebBrowser.ReadyState = READYSTATE_COMPLETE;
     { Get IPersistStreamInit - Interface }
     if WebBrowser.Document.QueryInterface(IPersistStreamInit, PersistStreamInit) = S_OK then
     begin
          { Clear document }
          if PersistStreamInit.InitNew = S_OK then
          begin
               { Make local copy of the contents of Stream if you want to use Stream directly,
                 you have to consider, that StreamAdapter will destroy it automatically }
               MemoryStream := TMemoryStream.Create;
               try
                    MemoryStream.CopyFrom(Stream, 0);
                    MemoryStream.Position := 0;
               except
                    MemoryStream.Free;
                    raise;
               end;
               { Use Stream-Adapter to get IStream Interface to our stream }
               StreamAdapter := TStreamAdapter.Create(MemoryStream, soOwned);
               { Load data from Stream into WebBrowser }
               PersistStreamInit.Load(StreamAdapter);
          end;
     end;
end;

end.
