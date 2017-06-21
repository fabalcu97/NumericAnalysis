unit Newton;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Functions, Matrix;
type
  TNewton = class
    public
      function execute(): TNumericMatrix;
      Constructor Create(equationInput: String; derivativeEquationInput: String; initialX: Real; initialError: Real);
      Destructor Destroy; Override;
    private
      x: Real;
      error: Real;
      equation: String;
      derivativeEquation: String;
      F: TFunctions;
  end;

implementation

    Constructor TNewton.Create(equationInput: String; derivativeEquationInput: String; initialX: Real; initialError: Real);
      begin
        equation := equationInput;
        derivativeEquation := derivativeEquationInput;
        x := initialX;
        error := initialError;
        F := TFunctions.Create;
      end;

    Destructor TNewton.Destroy();
      begin

      end;

    function TNewton.execute(): TNumericMatrix;
      var
        i: Integer;
        eaa: Real;
        era: Real;
        erpa: Real;
        xn: Real;
        fd: Real;
      begin
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

            fd := F.evaluate(derivativeEquation, x);
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

