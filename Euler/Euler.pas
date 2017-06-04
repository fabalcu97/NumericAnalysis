unit Euler;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Functions;
type
  TEuler = class
    public
    function execute(): Real;
    Constructor Create(deriv: string; initialA: Real; initialB: Real; initialX0: Real; initialY0: Real; iterations: Integer);
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
    Yn_e: Array of Real;
    F: TFunctions ;

implementation

    Constructor TEuler.Create(deriv: string; initialA: Real; initialB: Real; initialX0: Real; initialY0: Real; iterations: Integer);
    begin
        derivative := deriv;
        a := initialA;
        b := initialb;
        n := iterations;
        SetLength(Xn, n+1);
        SetLength(Yn, n+1);
        SetLength(Yn_e, n+1);
        Xn[0] := initialX0;
        Yn[0] := initialY0;
        F := TFunctions.Create();
    end;

    Destructor TEuler.Destroy();
    begin

    end;

    function TEuler.execute(): Real;
    begin
     h := (b - a) / n;
     Yn_e[0] := Yn[0];
     for i := 1 to n do
     begin
         Xn[i] := Xn[i-1] + h;
         Yn_e[i] := Yn[i-1] + h*F.evaluate(derivative, [Xn[i-1],Yn[i-1]]);
         Yn[i] := Yn[i-1] + h*(F.evaluate(derivative, [Xn[i-1], Yn[i-1]]) + F.evaluate(derivative, [Xn[i],Yn_e[i]]))/2;
     end;
     Result := Yn[i];

end;

end.

