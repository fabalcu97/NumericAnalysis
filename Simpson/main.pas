{$mode objfpc}{$H+}

uses
    Simpson;
var
    simpsonSolver: TSimpson;
    ans: Real;
    arrAns: TArray;
begin

    simpsonSolver := TSimpson.Create('exp(power(x, 2))', 0, 1, 2);
    
    ans := simpsonSolver.simpson13();
    arrAns := simpsonSolver.simpson38();

    WriteLn('Simpson(1/3): ', ans);
    WriteLn('Integral: ', arrAns[0]);
    WriteLn('Area: ', arrAns[1]);

    simpsonSolver.destroy();
end.