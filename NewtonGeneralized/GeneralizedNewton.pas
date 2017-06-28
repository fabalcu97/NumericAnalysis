unit GeneralizedNewton;

{$mode objfpc}{$H+}
    
interface
    
uses
    SysUtils, Classes, Functions, Matrix;

type
    TGeneralizedNewton = class
    private
        equations: TEquationsList;
        values: TNumericMatrix;
        error: Real;
    public
        constructor Create(eq: TEquationsList; val: TNumericMatrix; err: Real);
        destructor Destroy; override;
        function execute: TNumericMatrix;
    end;
implementation

    constructor TGeneralizedNewton.Create(eq: TEquationsList; val: TNumericMatrix; err: Real);
        begin
            equations := eq;
            values := val;
            error := err;
        end;
    
    destructor TGeneralizedNewton.Destroy;
        begin
            
        end;

    function TGeneralizedNewton.execute(): TNumericMatrix;
        var 
            mat: TMatrix;
            F: TFunctions;
            n: Integer;
            i: Integer;
            j: Integer;
            e: Real;
            Fx: TNumericMatrix;
            Xn1: TNumericMatrix;
            Jb: TNumericMatrix;
            JF: TNumericMatrix;
        begin
            mat := TMatrix.Create();
            F := TFunctions.Create();
            i := 0;
            e := error + 1;
            n := Length(values);

            setLength(Fx, n, 1);
            setLength(Xn1, n, 1);
            setLength(JF, n, 1);

            while e > error do
                begin
                    setLength(Result, Length(Result)+1, 6);

                    for j := 0 to n-1 do
                        begin
                            Fx[j, 0] := F.evaluate(equations[j], values);
                        end;
                    Jb := F.jacobian(equations, values);
                    Jb := mat.inv(Jb);
                    JF := mat.multiplication(Jb, Fx);
                    Xn1 := mat.substraction(values, JF);

                    e := 0;
                    for j :=  0 to n-1 do
                        e := e + sqr((Xn1[j, 0]-values[j, 0]));
                    e := sqrt(e);

                    Result[i][0] := i;
                    Result[i][1] := values[0][0];
                    Result[i][2] := values[1][0];
                    Result[i][3] := Xn1[0][0];
                    Result[i][4] := Xn1[1][0];
                    Result[i][5] := e;

                    i := i + 1;
                    values := Xn1;
                end;
        end;
    
end.