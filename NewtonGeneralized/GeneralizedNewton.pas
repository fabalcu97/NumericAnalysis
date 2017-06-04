unit GeneralizedNewton;

{$mode objfpc}{$H+}
    
interface
    
uses
    SysUtils, Classes, Functions, Matrix;

type
    TGeneralizedNewton = class
    private
        
    public
        constructor Create;
        destructor Destroy; override;
        function execute(equations: TEquationsList; values: TNumericMatrix; error: Real): TNumericList;
    end;
implementation

    constructor TGeneralizedNewton.Create;
        begin
        
        end;
    
    destructor TGeneralizedNewton.Destroy;
        begin
            
        end;

    function TGeneralizedNewton.execute(equations: TEquationsList; values: TNumericMatrix; error: Real): TNumericList;
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
            setLength(Result, n);

            while e > error do
                begin
                    WriteLn('Error: ', e);

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

                    i := i + 1;
                    values := Xn1;
                end;
            for i := 0 to n-1 do
                begin
                    WriteLn(values[i, 0]);
                end;
        end;
    
end.