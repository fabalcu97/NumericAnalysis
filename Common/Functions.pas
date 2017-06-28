unit Functions;

{$mode objfpc}{$H+}

interface

uses
    SysUtils, Classes, ParseMath, Matrix;

type
    TFunctions = class
    public
        constructor Create();
        destructor Destroy; override;
        function jacobian(equations: TEquationsList; values: TNumericMatrix): TNumericMatrix;
        function partialDerivative(equation: String; variable: Integer; values: TNumericMatrix): Real;
        function evaluatePartialDerivatives(equation: String; values: TNumericMatrix): Real;
        function evaluate(equation: String; value: Real): Real;
        function evaluate(equation: String; variable: Array of Real): Real;
        function evaluate(equation: String; variable: TNumericMatrix): Real;
        function sign(a: Real; b: Real): Integer;
        procedure print(matrix: TNumericMatrix);
        procedure print(list: TNumericList);
        function bolzano(a: Real; b: Real): Boolean;
    end;
implementation

    constructor TFunctions.Create;
        begin

        end;

    destructor TFunctions.Destroy;
        begin

        end;

    procedure TFunctions.print(matrix: TNumericMatrix);
      var
        i: Integer;
        j: Integer;
      begin
        for i := 0 to Length(matrix)-1 do
          begin
            for j := 0 to Length(matrix[i])-1 do
            begin
              Write(matrix[i][j],  '-' );
            end;
            WriteLn();
          end;
      end;

    procedure TFunctions.print(list: TNumericList);
      var
        i: Integer;
      begin
        for i := 0 to Length(list)-1 do
          begin
            Write(list[i],  '-' );
          end;
      end;

    function TFunctions.bolzano(a: Real; b: Real): Boolean;
      begin
        if( (a*b) < 0 ) then
          begin
            Result := True;
            exit;
          end;
        Result := False;
      end;

    function TFunctions.Jacobian(equations: TEquationsList; values: TNumericMatrix): TNumericMatrix;
        var
            i: Integer;
            j: Integer;
            n: Integer;
        begin
            n := Length(values);
            SetLength(Result, n, n);

            for i := 0 to n-1 do
            begin
                for j := 0 to n-1 do
                begin
                    Result[i, j] := PartialDerivative(equations[i], j, values);
                end;
            end;
        end;

    function TFunctions.PartialDerivative(equation: String; variable: Integer; values: TNumericMatrix): Real;
        var
            fxh: Real;
            fx: Real;
            h:Real;
        begin
            h := 0.00001;
            fx := evaluatePartialDerivatives(equation, values);

            values[variable, 0] := values[variable, 0] + h;
            fxh := evaluatePartialDerivatives(equation, values);

            values[variable, 0] := values[variable, 0] - h;
            Result := (fxh - fx) / h;

        end;
    function TFunctions.evaluatePartialDerivatives(equation: String; values: TNumericMatrix): Real;
        var
            variable: Char;
            i: Integer;
            n: Integer;
            Parser: TParseMath;
        begin
            Parser := TParseMath.Create();
            n := Length(values);
            variable  := 'a';
            Parser.Expression := equation;

            for i := 0 to n-1 do
            begin
                Parser.AddVariable(variable, values[i, 0]);
                variable := succ(variable);

            end;
            result := Parser.Evaluate();
            Parser.Destroy();
        end;

    function TFunctions.evaluate(equation: String; value: Real): Real;
        var
            Parser: TParseMath;
        begin
            Parser := TParseMath.Create();
            Parser.AddVariable('x', value);
            Parser.Expression := equation;
            Result := Parser.Evaluate();
            Parser.Destroy();
        end;

    function TFunctions.evaluate(equation: String; variable: Array of Real): Real;
        var
            Parser: TParseMath;
            varChar: char;
            i: Integer;
            n: integer;
        begin
            Parser := TParseMath.create();
            Parser.AddVariable('a', 0);
            n := Length(variable);
            varChar := 'x';
            Parser.Expression := equation + '+a';
            for i := 0 to n-1 do
            begin
                Parser.AddVariable(varChar, variable[i]);
                varChar := succ(varChar);
                if varChar>'z' then
                varChar := 'a';
            end;
            result := Parser.Evaluate();
            Parser.destroy;
        end;
    
    function TFunctions.evaluate(equation: String; variable: TNumericMatrix): Real;
        var
            Parser: TParseMath;
            varChar: char;
            i: Integer;
            n: integer;
        begin
            Parser := TParseMath.create();
            Parser.AddVariable('a', 0);
            n := Length(variable);
            varChar := 'x';
            Parser.Expression := equation + '+a';
            for i := 0 to n-1 do
            begin
                Parser.AddVariable(varChar, variable[i, 0]);
                varChar := succ(varChar);
                if varChar>'z' then
                varChar := 'a';
            end;
            result := Parser.Evaluate();
            Parser.destroy;
        end;

    function TFunctions.sign(a: Real; b: Real): Integer;
      begin
        if ((a * b) < 0) then
          begin
            Result := -1;
            exit;
          end;
        Result := 1;
      end;
end.