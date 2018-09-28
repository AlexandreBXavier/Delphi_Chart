unit Controller.Interfaces;

interface

uses SHDocVw;

type

     iControllerChartDefault = interface
          ['{E68D2823-79B8-42F7-8455-B87FD5598C03}']
          function SetCharTitle(aValue: String): iControllerChartDefault;
          function SetCharSubTitle(aValue: String): iControllerChartDefault;
          function AddTitle(aDescription, aValue: String): iControllerChartDefault;
          function AddValue(aDescription, aValue: String): iControllerChartDefault;
          procedure ShowChartDonut(aWebBrowser: TWebBrowser);
          procedure ShowChartPie(aWebBrowser: TWebBrowser);
     end;

     iControllerChartFactory = interface
          ['{599B5323-71FF-46A5-9473-FF934913AD48}']
          function Default: iControllerChartDefault;
     end;

implementation

end.
