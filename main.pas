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
    eulerSolver: TEuler;
    rungeKuttaSolver: TRungeKutta;
    heunSolver: THeun;

    eqList: TEquationsList;
    valMat: TNumericMatrix;
    equation: String;
    derivativeEquation: String;

begin

    F := TFunctions.Create;
    equation := 'power(x, 2)';
    derivativeEquation := '2*x';
    setLength(eqList, 2);
    eqList[0] := 'power(x, 2)+7*power(y, 2)+3*x*y-10';
    eqList[1] :=  '5*power(x, 2)+3*x*y-2';
    setLength(valMat, 2, 1);
    valMat[0][0] := 1;
    valMat[1][0] := 1;

    (*dormandPrinceSolver := TDormandPrince.Create(derivativeEquation, 1, 0, 1, 0.1);*)
    (*heunSolver := THeun.Create(derivativeEquation, 1, 0, 1, 0.1);*)
    (*rungeKuttaSolver := TRungeKutta.Create(derivativeEquation, 1, 0, 1, 0.1);*)
    (*eulerSolver := TEuler.Create(derivativeEquation, 4, 1, 1, 0.01);*)
    generalizedNewtonSolver := TGeneralizedNewton.Create(eqList, valMat, 0.1);
    (*fixedPointSolver := TFixedPoint.Create(equation, derivativeEquation, 0.5, 0.0001);*)
    (*newtonSolver := TNewton.Create(equation, derivativeEquation, -1, 0.0001);*)
    (*secantSolver := TSecant.Create(equation, -1, 0.0001);*)
    (*bisectionSolver := TBisection.Create(equation, -1, 1, 0.0001);*)
    (*falsePositionSolver := TFalsePosition.Create(equation, -1, 1, 0.0001);*)
    (*simpsonSolver := TSimpson.Create('power(x, 2)', -1, 0, 15);*)

    (*F.Print(dormandPrinceSolver.execute());*)
    (*F.Print(heunSolver.execute());*)
    (*F.Print(rungeKuttaSolver.execute4());*)
    (*F.Print(eulerSolver.execute());*)
    F.Print(generalizedNewtonSolver.execute());
    (*F.Print(fixedPointSolver.execute());*)
    (*F.Print(secantSolver.execute());*)
    (*F.Print(newtonSolver.execute());*)
    (*F.Print(bisectionSolver.execute());*)
    (*F.Print(falsePositionSolver.execute());*)
    (*F.Print(simpsonSolver.simpson38());*)


end.