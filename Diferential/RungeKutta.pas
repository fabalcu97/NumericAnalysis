unit RungeKutta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Functions, Matrix;
type
  TRungeKutta = class
    public
    function execute4(): TNumericMatrix;
    Constructor Create(deriv: string; initialGoal: Real; initialX: Real; initialY: Real; intervalLength: Real);
    Destructor Destroy; Override;
  end;
var
    derivative: String;
    goal: Real;
    h: Real;
    n: Integer;
    i: Integer;
    Xn: Array of Real;
    Yn: Array of Real;
    F: TFunctions ;

implementation

     Constructor TRungeKutta.Create(deriv: string; initialGoal: Real; initialX: Real; initialY: Real; intervalLength: Real);
    var
      sign: Real;
    begin
        derivative := deriv;
        goal := initialGoal;
        h := intervalLength;
        sign := goal - initialX;
        if(sign < 0) then
          begin
            h := h*(-1);
          end;

        n := abs(round((goal - initialX) / h));
        SetLength(Xn, n+1);
        SetLength(Yn, n+1);
        Xn[0] := initialX;
        Yn[0] := initialY;
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
     setLength(Result, n+1, 8);
     i := 1;
     if (goal < 0) then
       begin
         while (Xn[i-1] > goal) do
           begin
             k1 := F.evaluate(derivative, [Xn[i-1], Yn[i-1]]);
             k2 := F.evaluate(derivative, [Xn[i-1] + (h/2), Yn[i-1] + (k1*h/2)]);
             k3 := F.evaluate(derivative, [Xn[i-1] + (h/2), Yn[i-1] + (k2*h/2)]);
             k4 := F.evaluate(derivative, [Xn[i-1] + h, Yn[i-1] + (k3*h)]);
             m := (k1 + 2*k2 + 2*k3 + k4)/6;
             Xn[i] := Xn[i-1] + h;
             Yn[i] := Yn[i-1] + h*m;
             Result[i-1, 0] := i-1;
             Result[i-1, 1] := Xn[i-1];
             Result[i-1, 2] := Yn[i-1];
             Result[i-1, 3] := k1;
             Result[i-1, 4] := k2;
             Result[i-1, 5] := k3;
             Result[i-1, 6] := k4;
             Result[i-1, 7] := m;
             i := i + 1;
           end;
       end
      else
        begin
          while (Xn[i-1] < goal) do
           begin
             k1 := F.evaluate(derivative, [Xn[i-1], Yn[i-1]]);
             k2 := F.evaluate(derivative, [Xn[i-1] + (h/2), Yn[i-1] + (k1*h/2)]);
             k3 := F.evaluate(derivative, [Xn[i-1] + (h/2), Yn[i-1] + (k2*h/2)]);
             k4 := F.evaluate(derivative, [Xn[i-1] + h, Yn[i-1] + (k3*h)]);
             m := (k1 + 2*k2 + 2*k3 + k4)/6;
             Xn[i] := Xn[i-1] + h;
             Yn[i] := Yn[i-1] + h*m;
             Result[i-1, 0] := i-1;
             Result[i-1, 1] := Xn[i-1];
             Result[i-1, 2] := Yn[i-1];
             Result[i-1, 3] := k1;
             Result[i-1, 4] := k2;
             Result[i-1, 5] := k3;
             Result[i-1, 6] := k4;
             Result[i-1, 7] := m;
             i := i + 1;
           end;
        end;
end;

end.

