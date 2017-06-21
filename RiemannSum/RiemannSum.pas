unit RiemannSum;

{$mode objfpc}{$H+}

interface

uses
    SysUtils, Classes, Functions;

type
    TRiemannSum = class
    private

    public
        constructor create;
        destructor destroy; override;
        function execute(equation: String; a: Real; b: Real; n: Integer): Real;
    end;
implementation

    constructor TRiemannSum.create;
        begin

        end;

    destructor TRiemannSum.destroy;
        begin

        end;

    function TRiemannSum.execute(equation: String; a: Real; b: Real; n: Integer): Real;
        var
            F: TFunctions;
            i: Integer;
            h: Real;
            xN: Real;
        begin
            F := TFunctions.Create();
            i := 0;
            Result := 0;
            h := (b - a) / n;
            
            for i := 1 to n-1 do
                begin
                    xN := a + (i*h);
                    Result := Result + F.evaluate(equation, xN);
                end;

            Result := Result + ( (F.evaluate(equation, a) + F.evaluate(equation, b)) / 2 );
            Result := Result * h;

        end;

end.
