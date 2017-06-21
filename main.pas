{$mode objfpc}{$H+}

uses
    Functions, Matrix, Bisection, FalsePosition, Newton, Secant;
var
    f: TFunctions;
    bisectionSolver: TBisection;
    falsePositionSolver: TFalsePosition;
    newtonSolver: TNewton;
    secantSolver: TSecant;
    equation: String;
    derivativeEquation: String;

begin

    F := TFunctions.Create;
    equation := 'power(x, 2)';
    derivativeEquation := '2*x';

    newtonSolver := TNewton.Create(equation, derivativeEquation, -1, 0.0001);
    secantSolver := TSecant.Create(equation, -1, 0.0001);
    bisectionSolver := TBisection.Create(equation, -1, 1, 0.0001);
    falsePositionSolver := TFalsePosition.Create(equation, -1, 1, 0.0001);

    F.Print(secantSolver.execute());
    (*F.Print(newtonSolver.execute());
    F.Print(bisectionSolver.execute());
    F.Print(falsePositionSolver.execute());*)


end.