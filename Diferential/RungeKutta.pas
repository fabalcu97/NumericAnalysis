unit RungeKutta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Functions, Matrix;
type
  TRungeKutta = class
    public
    function execute4(): TNumericMatrix;
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

    Constructor TRungeKutta.Create(deriv: string; initialA: Real; initialB: Real; initialX0: Real; initialY0: Real; intervals: Real);
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

    Destructor TRungeKutta.Destroy();
    begin

    end;

    function TRungeKutta.execute4(): TNumericMatrix;
    var
        k1: Real;
        k2: Real;
        k3: Real;
        k4: Real;
        m: Real;
    begin
     setLength(Result, 8, n+1);
     i := 1;
     if (b < 0) then
       begin
         while (Xn[i-1] > b) do
           begin
             k1 := F.evaluate(derivative, [Xn[i-1], Yn[i-1]]);
             k2 := F.evaluate(derivative, [Xn[i-1] + (h/2), Yn[i-1] + (k1*h/2)]);
             k3 := F.evaluate(derivative, [Xn[i-1] + (h/2), Yn[i-1] + (k2*h/2)]);
             k4 := F.evaluate(derivative, [Xn[i-1] + h, Yn[i-1] + (k3*h)]);
             m := (k1 + 2*k2 + 2*k3 + k4)/6;
             Xn[i] := Xn[i-1] + h;
             Yn[i] := Yn[i-1] + h*m;
             Result[0, i-1] := i-1;
             Result[1, i-1] := Xn[i-1];
             Result[2, i-1] := Yn[i-1];
             Result[3, i-1] := k1;
             Result[4, i-1] := k2;
             Result[5, i-1] := k3;
             Result[6, i-1] := k4;
             Result[7, i-1] := m;
             i := i + 1;
           end;
       end
      else
        begin
          while (Xn[i-1] < b) do
           begin
             k1 := F.evaluate(derivative, [Xn[i-1], Yn[i-1]]);
             k2 := F.evaluate(derivative, [Xn[i-1] + (h/2), Yn[i-1] + (k1*h/2)]);
             k3 := F.evaluate(derivative, [Xn[i-1] + (h/2), Yn[i-1] + (k2*h/2)]);
             k4 := F.evaluate(derivative, [Xn[i-1] + h, Yn[i-1] + (k3*h)]);
             m := (k1 + 2*k2 + 2*k3 + k4)/6;
             Xn[i] := Xn[i-1] + h;
             Yn[i] := Yn[i-1] + h*m;
             Result[0, i-1] := i-1;
             Result[1, i-1] := Xn[i-1];
             Result[2, i-1] := Yn[i-1];
             Result[3, i-1] := k1;
             Result[4, i-1] := k2;
             Result[5, i-1] := k3;
             Result[6, i-1] := k4;
             Result[7, i-1] := m;
             i := i + 1;
           end;
        end;
end;

end.

