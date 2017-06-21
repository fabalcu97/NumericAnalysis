{$mode objfpc}{$H+}

uses
    Functions, Matrix, Bisection;
var
    f: TFunctions;
    bisectionSolver: TBisection;
    equation: String;

begin

    F := TFunctions.Create;
    equation := 'x';

    bisectionSolver := TBisection.Create(equation, -1, 1, 0.0001);

    F.Print(bisectionSolver.execute());


end.