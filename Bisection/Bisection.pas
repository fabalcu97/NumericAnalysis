unit Bisection;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Functions, Matrix;
type
  TBisection = class
    public
      function execute(): TNumericMatrix;
      Constructor Create(equationInput: String; initialA: Real; initialB: Real; initialError: Real);
      Destructor Destroy; Override;
    private
      a: Real;
      b: Real;
      error: Real;
      equation: String;
      F: TFunctions;
  end;

implementation

    Constructor TBisection.Create(equationInput: String; initialA: Real; initialB: Real; initialError: Real);
      begin
        equation := equationInput;
        a := initialA;
        b := initialB;
        error := initialError;
        F := TFunctions.Create;
      end;

    Destructor TBisection.Destroy();
      begin

      end;

    function TBisection.execute(): TNumericMatrix;
      var
        i: Integer;
        temp_ant: Real;
        eaa: Real;
        era: Real;
        erpa: Real;
        c: Real;
        signo: Integer;
      begin
        c := 0;
        eaa := error + 1;
        i := 0;
        temp_ant := 0;
        if not F.Bolzano( F.evaluate(equation, a), F.evaluate(equation, b) ) then
          begin
            setLength(Result, 1, 1);
            Result[0][0] := 0;
            exit;
          end;
        while eaa > error do
          begin
            setLength(Result, i+1, 8);
            Result[i][0] := i;
            Result[i][1] := a;
            Result[i][2] := b;

            temp_ant := c;
            c := (a + b)/2;
            Result[i][3] := c;

            signo := F.Sign( F.evaluate(equation, a),  F.evaluate(equation, c) );
            Result[i][4] := signo;
            if ( i > 0 ) then
              begin
                eaa := abs( c - temp_ant );
                Result[i][5] := eaa;

                era := abs( eaa / c );
                Result[i][6] := era;

                erpa := abs( era*100 );
                Result[i][7] := erpa;
              end;
            if ( signo < 0 ) then
              b := c
            else
              a := c;
            i := i + 1;
          end;
    end;

end.

