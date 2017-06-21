unit Secant;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Functions, Matrix;
type
  TSecant = class
    public
      function execute(): TNumericMatrix;
      Constructor Create(equationInput: String; initialX: Real; initialError: Real);
      Destructor Destroy; Override;
    private
      x: Real;
      error: Real;
      equation: String;
      F: TFunctions;
  end;

implementation

    Constructor TSecant.Create(equationInput: String; initialX: Real; initialError: Real);
      begin
        x := initialX;
        error := initialError;
        equation := equationInput;
        F := TFunctions.Create;
      end;

    Destructor TSecant.Destroy();
      begin

      end;

    function TSecant.execute(): TNumericMatrix;
      var
        h: Real;
        i: Integer;
        eaa: Real;
        era: Real;
        erpa: Real;
        xn: Real;
        fd: Real;
      begin
        fd := 0;
        h := error/100;
        xn := 0;
        eaa := error + 1;
        i := 0;
        if( F.evaluate(equation, x) = 0 ) then
          begin
            setLength(Result, 1, 1);
            Result[0][0] := x;
            exit;
          end;
        while eaa > error do
          begin
            setLength(Result, i+1, 6);
            Result[i][0] := i;
            Result[i][1] := x;

            fd := ( F.evaluate(equation, (x+h)) - F.evaluate(equation, (x-h)) ) / (2 * h);
            if (fd = 0) then
              begin
                exit;
              end;
            xn := x - F.evaluate(equation, x)/fd;
            Result[i][2] := xn;

            eaa := abs( x - xn );
            Result[i][3] := eaa;
            era := 0;
            if ( x <> 0 ) then
              begin
                era := abs( eaa / x );
              end;
            Result[i][4] := era;

            erpa := abs( era*100 );
            Result[i][5] := erpa;
            x := xn;
            i := i + 1;
          end;
      end;

end.