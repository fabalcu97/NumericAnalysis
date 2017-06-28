unit Euler;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Functions, Matrix;
type
  TEuler = class
    public
    function execute(): TNumericMatrix;
    Constructor Create(deriv: string; initialGoal: Real; initialX: Real; initialY: Real; intervalLength: Real);
    Destructor Destroy; Override;
  end;
var
    derivative: String;
    h: Real;
    n: Integer;
    goal: Real;
    Xn: Array of Real;
    Yn: Array of Real;
    i: Integer;
    F: TFunctions ;

implementation

    Constructor TEuler.Create(deriv: string; initialGoal: Real; initialX: Real; initialY: Real; intervalLength: Real);
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

    Destructor TEuler.Destroy();
    begin

    end;

    function TEuler.execute(): TNumericMatrix;
    begin
     setLength(Result, n + 1, 3);
     i := 1;
     if (goal < 0) then
       begin
         while (Xn[i-1] > goal) do
           begin
             Xn[i] := Xn[i-1] + h;
             Yn[i] := Yn[i-1] + h*F.evaluate(derivative, [Xn[i-1], Yn[i-1]]);
             Result[i-1, 0] := i-1;
             Result[i-1, 1] := Xn[i-1];
             Result[i-1, 2] := Yn[i-1];
             i := i + 1;
           end;
       end
      else
        begin
          while (Xn[i-1] < goal) do
           begin
             Xn[i] := Xn[i-1] + h;
             Yn[i] := Yn[i-1] + h*F.evaluate(derivative, [Xn[i-1], Yn[i-1]]);
             Result[i-1, 0] := i-1;
             Result[i-1, 1] := Xn[i-1];
             Result[i-1, 2] := Yn[i-1];
             i := i + 1;
           end;
        end;
     
end;

end.

