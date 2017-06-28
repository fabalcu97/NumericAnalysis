{$mode objfpc}{$H+}

uses
    Functions, Matrix, Bisection, FalsePosition, Newton, Secant, FixedPoint, Euler, Heun,
    RungeKutta, Lagrange, GeneralizedNewton, RiemannSum, Simpson, DormandPrince;
var
    f: TFunctions;
    bisectionSolver: TBisection;
    falsePositionSolver: TFalsePosition;
    newtonSolver: TNewton;
    secantSolver: TSecant;
    fixedPointSolver: TFixedPoint;
    dormandPrinceSolver: TDormandPrince;
    generalizedNewtonSolver: TGeneralizedNewton;
    simpsonSolver: TSimpson;
    equation: String;
    derivativeEquation: String;

begin

    F := TFunctions.Create;
    equation := 'power(x, 2)';
    derivativeEquation := 'x*power(y, 2)';

    generalizedNewtonSolver := TGeneralizedNewton.Create();
    (*dormandPrinceSolver := TDormandPrince.create(derivativeEquation, 0, 1, 0, 1, 0.1);
    fixedPointSolver := TFixedPoint.Create(equation, derivativeEquation, 0.5, 0.0001);
    newtonSolver := TNewton.Create(equation, derivativeEquation, -1, 0.0001);
    secantSolver := TSecant.Create(equation, -1, 0.0001);
    bisectionSolver := TBisection.Create(equation, -1, 1, 0.0001);
    falsePositionSolver := TFalsePosition.Create(equation, -1, 1, 0.0001);*)
    simpsonSolver := TSimpson.Create('power(x, 2)', -1, 0, 15);

    F.Print(generalizedNewtonSolver.execute());
    (*F.Print(simpsonSolver.simpson38());
    F.Print(dormandPrinceSolver.execute());
    F.Print(fixedPointSolver.execute());
    F.Print(secantSolver.execute());
    F.Print(newtonSolver.execute());
    F.Print(bisectionSolver.execute());
    F.Print(falsePositionSolver.execute());*)


end.