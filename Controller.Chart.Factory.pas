unit Controller.Chart.Factory;

interface

uses Controller.Interfaces, Controller.Chart.Default;

type
     TControllerChartFactory = class(TInterfacedObject, iControllerChartFactory)
          constructor Create;
          destructor Destroy; Override;
          class function New: iControllerChartFactory;
          function Default: iControllerChartDefault;
     end;

implementation

{ TControllerChartFactory }

constructor TControllerChartFactory.Create;
begin
     //
end;

destructor TControllerChartFactory.Destroy;
begin
     inherited;
end;

class function TControllerChartFactory.New: iControllerChartFactory;
begin
     Result := Self.Create;
end;

function TControllerChartFactory.Default: iControllerChartDefault;
begin
     Result := TControllerChartDefault.New;
end;

end.

