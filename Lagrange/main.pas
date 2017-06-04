{$mode objfpc}{$H+}

uses
    Lagrange, ParseMath;
     
var

    lagrangePolynom: TLagrange;
    Matrix: TMatriz;
    parser: TParseMath;
    expr: String;
    
begin

    parser := TParseMath.Create;
    lagrangePolynom.Create;
    parser.AddVariable('x', 0.0);

    SetLength(Matrix, 2, 4);
    Matrix[0, 0] := 10;
    Matrix[0, 1] := 30;
    Matrix[0, 2] := 40;
    Matrix[0, 3] := 50;

    Matrix[1, 0] := 0;
    Matrix[1, 1] := 20;
    Matrix[1, 2] := 30;
    Matrix[1, 3] := 40;
    
    lagrangePolynom.IngresarVAlores(Matrix);
    expr := lagrangePolynom.Ejecutar();
    Parser.Expression := expr;
    WriteLn(expr);
    Parser.NewValue('x' , 15 );
    WriteLn(Parser.Evaluate());


end.