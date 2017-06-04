{$mode objfpc}{$H+}

uses
    Functions, RiemannSum;
var
    riemann: TRiemannSum;
    Equation: String;
    a: Real;
    b: Real;
    n: Integer;
    Result: Real;
begin

    riemann := TRiemannSum.Create;

    a := 0;
    b := 3.14151692 / 8;
    n := 500;

    Equation := 'power(sec(x*2), 2)';

    Result := riemann.execute(Equation, a, b, n);
    WriteLn(Result);
end.