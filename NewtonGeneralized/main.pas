{$mode objfpc}{$H+}

uses
    Functions, GeneralizedNewton, Matrix;
var
    f: TFunctions;
    genNewton: TGeneralizedNewton;
    EquationList: TEquationsList;
    NumericList: TNumericMatrix;

begin

    genNewton.Create;
    f.Create;

    setLength(EquationList, 2);
    setLength(NumericList, 2, 1);

    EquationList[0] := 'a + b - 4';
    EquationList[1] := 'power(a, 2) + power(b, 2) - 8';

    NumericList[0, 0] := 1.7;
    NumericList[1, 0] := 2.3;

    genNewton.execute(EquationList, NumericList, 0.000001);
end.