unit Euler;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Functions, Matrix;
type
  TEuler = class
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
    F: TFunctions ;

implementation

    Constructor TEuler.Create(deriv: string; initialA: Real; initialB: Real; initialX0: Real; initialY0: Real; intervals: Real);
    begin
        derivative := deriv;
        a := initialA;
        b := initialb;
        h := intervals;

        n := abs(round((b - a) / h));
        SetLength(Xn, n+1);
        SetLength(Yn, n+1);
        Xn[0] := initialX0;
        Yn[0] := initialY0;
        F := TFunctions.Create();
    end;

    Destructor TEuler.Destroy();
    begin

    end;

    function TEuler.execute(): TNumericMatrix;
    begin
     setLength(Result, 3, n + 1);
     i := 1;
     if (b < 0) then
       begin
         while (Xn[i-1] > b) do
           begin
             Xn[i] := Xn[i-1] + h;
             Yn[i] := Yn[i-1] + h*F.evaluate(derivative, [Xn[i-1], Yn[i-1]]);
             Result[0, i-1] := i-1;
             Result[1, i-1] := Xn[i-1];
             Result[2, i-1] := Yn[i-1];
             i := i + 1;
           end;
       end
      else
        begin
          while (Xn[i-1] < b) do
           begin
             Xn[i] := Xn[i-1] + h;
             Yn[i] := Yn[i-1] + h*F.evaluate(derivative, [Xn[i-1], Yn[i-1]]);
             Result[0, i-1] := i-1;
             Result[1, i-1] := Xn[i-1];
             Result[2, i-1] := Yn[i-1];
             i := i + 1;
           end;
        end;
     
end;

end.

