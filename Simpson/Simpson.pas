unit Simpson;

{$mode objfpc}{$H+}
    
interface
    
uses
    SysUtils, Classes, Functions;

type
    TArray = Array of Real;
    TSimpson = class
    private
        F: TFunctions;
        equation: String;
        a: Real;
        b: Real;
        n: Integer;
    public
        constructor Create(eq: String; initialA: Real; initialB: Real; initialN: Integer);
        destructor destroy; override;
        function simpson13(): Real;
        function simpson38(): TArray;
    end;


implementation

    constructor TSimpson.Create(eq: String; initialA: Real; initialB: Real; initialN: Integer);
        var
            m: Integer;
        begin
            equation := eq;
            a := initialA;
            b := initialB;
            n := initialN;
            m := n mod 2;
            n := n + m;
        end;
    
    destructor TSimpson.destroy;
        begin
            
        end;

    function TSimpson.simpson13(): Real;
        var
            even: Real;
            odd: Real;
            h: Real;
            Integral: Real;
            i: Integer;
            Xn: Array of Real;
            Yn: Array of Real;
        begin
            SetLength(Xn, n + 1);
            SetLength(Yn, n + 1);
            h := (b - a) / n;
            for i := 0 to n do
                begin
                    Xn[i] := a + (i * h);
                    Yn[i] := F.evaluate(equation, Xn[i]);
                end;
            Integral := (Yn[0] + Yn[n]);
            odd := 0;
            even := 0;
            for i := 1 to (n div 2) do
                begin
                    odd := odd + Yn[(2 * i) - 1];
                end;
            for i := 1 to (n-1) div 2 do
                begin
                    even := even + Yn[2 * i];
                end;
            Integral := Integral + (4 * odd) + (2 * even);
            Integral := (Integral * (h / 3));
            Result := Integral;
        end;
    
    function TSimpson.simpson38(): TArray;
        var
            iMult3: Real;
            aMult3: Real;
            h: Real;
            integral: Real;
            iRem: Real;
            area: Real;
            aRem: Real;
            i: Integer;
            Xn: Array of Real;
            Yn: Array of Real;
        begin
            SetLength(Xn, n + 1);
            SetLength(Result, 2);
            iMult3 := 0;
            aMult3 := 0;
            iRem := 0;
            aRem := 0;
            SetLength(Yn, n + 1);
            h := (b - a) / n;
            for i := 0 to n do
                begin
                    Xn[i] := a + (i * h);
                    Yn[i] := F.evaluate(equation, Xn[i]);
                end;
            integral := (Yn[0] + Yn[n]);
            area := (abs(Yn[0]) + abs(Yn[n]));
            for i := 1 to (n - 1) do
                begin
                    if i mod 3 = 0 then
                        begin
                            iMult3 := iMult3 + Yn[i];
                            aMult3 := aMult3 + abs(Yn[i]) ;
                        end
                    else
                        begin
                            iRem := iRem + Yn[i];
                            aRem := aRem + abs(Yn[i]);
                        end;
                end;
            integral := integral + (2 * iMult3) + (3 * iRem);
            integral := (integral * ((3 * h) / 8));
            area := area + (2 * aMult3) + (3 * aRem);
            area := area * ((3 * h) / 8);
            Result[0] := integral;
            Result[1] := area;
        end;
    end.