unit Heun;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Functions, Matrix;
type
  THeun = class
    public
    function execute(): TNumericMatrix;
    Constructor Create(deriv: string; initialA: Real; initialB: Real; initialX0: Real; initialY0: Real; intervals: Real);
    Destructor Destroy; Override;
  end;
var
    derivative: String;
    a: Real;
    b: Real;
    h: Real;
    n: Integer;
    i: Integer;
    Xn: Array of Real;
    Yn: Array of Real;
    eulerApproximation: Array of Real;
    F: TFunctions ;

implementation

    Constructor THeun.Create(deriv: string; initialA: Real; initialB: Real; initialX0: Real; initialY0: Real; intervals: Real);
    begin
        derivative := deriv;
        a := initialA;  
        b := initialb;
        h := intervals;

        n := abs(round((b - a) / h));
        SetLength(Xn, n+1);
        SetLength(Yn, n+1);
        SetLength(eulerApproximation, n+1);
        Xn[0] := initialX0;
        Yn[0] := initialY0;
        F := TFunctions.Create();
    end;

    Destructor THeun.Destroy();
    begin

    end;

    function THeun.execute(): TNumericMatrix;
    var
      m: Real;
    begin
     setLength(Result, n + 1, 4);
     eulerApproximation[0] := Yn[0];
     m := 0;
     i := 1;
     if (b < 0) then
       begin
         while (Xn[i-1] > b) do
           begin
             Xn[i] := Xn[i-1] + h;
             eulerApproximation[i] := Yn[i-1] + h*F.evaluate(derivative, [Xn[i-1], Yn[i-1]]);
             m := (F.evaluate(derivative, [Xn[i-1], Yn[i-1]]) + F.evaluate(derivative, [Xn[i], eulerApproximation[i]]))/2;
             Yn[i] := Yn[i-1] + (h * m);
             Result[i-1, 0] := i-1;
             Result[i-1, 1] := Xn[i-1];
             Result[i-1, 2] := Yn[i-1];
             Result[i-1, 3] := eulerApproximation[i-1];
             i := i + 1;
           end;
       end
      else
        begin
          while (Xn[i-1] < b) do
           begin
             Xn[i] := Xn[i-1] + h;
             eulerApproximation[i] := Yn[i-1] + h*F.evaluate(derivative, [Xn[i-1], Yn[i-1]]);
             m := (F.evaluate(derivative, [Xn[i-1], Yn[i-1]]) + F.evaluate(derivative, [Xn[i], eulerApproximation[i]]))/2;
             Yn[i] := Yn[i-1] + (h * m);
             Result[i-1, 0] := i-1;
             Result[i-1, 1] := Xn[i-1];
             Result[i-1, 2] := Yn[i-1];
             Result[i-1, 3] := eulerApproximation[i-1];
             i := i + 1;
           end;
        end;
     
end;

end.

