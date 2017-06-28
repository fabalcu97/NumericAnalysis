unit DormandPrince;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Functions, Matrix, Math;
type
  TDormandPrince = class
    public
    Constructor Create(deriv: string; initialGoal: Real; initialX: Real; initialY: Real; initialError: Real);
    Destructor Destroy; Override;
    function execute(): TNumericMatrix;
  end;
var
    derivative: String;
    goal: Real;
    h: Real;
    error: Real;
    n: Integer;
    i: Integer;
    Xn: Array of Real;
    Yn: Array of Real;
    F: TFunctions ;

implementation

  Constructor TDormandPrince.Create(deriv: string; initialGoal: Real; initialX: Real; initialY: Real; initialError: Real);
    var
      sign: Real;
    begin
        derivative := deriv;
        goal := initialGoal;
        error := initialError;
        h := error/10;
        sign := goal - initialX;
        if(sign < 0) then
          begin
            h := h*(-1);
          end;

        n := abs(round((goal - initialX) / h));
        SetLength(Xn, 1);
        SetLength(Yn, 1);
        Xn[0] := initialX;
        Yn[0] := initialY;
        F := TFunctions.Create();
    end;

  Destructor TDormandPrince.Destroy();
    begin

    end;

  function TDormandPrince.execute(): TNumericMatrix;
    var
        k1: Real;
        k2: Real;
        k3: Real;
        k4: Real;
        k5: Real;
        k6: Real;
        k7: Real;
        z: Real;
        newH: Real;
        hMin: Real;
        hMax: Real;
        diff: Real;
    begin
      hMin := h/100;
      hMax := 1;
      i := 1;
      if (goal < 0) then
        begin
          while (Xn[i-1] > goal) do
            begin
                setLength(Result, Length(Result)+1, 11);
                setLength(Xn, Length(Xn)+1);
                setLength(Yn, Length(Yn)+1);
                k1 := h*F.evaluate(derivative, [Xn[i-1], Yn[i-1]]);
                k2 := h*F.evaluate(derivative, [Xn[i-1] + (h*1/5), Yn[i-1] + (k1*1/5)]);
                k3 := h*F.evaluate(derivative, [Xn[i-1] + (h*3/10), Yn[i-1] + (k1*3/40) + (k2*9/2)]);
                k4 := h*F.evaluate(derivative, [Xn[i-1] + (h*4/5), Yn[i-1] + (k1*44/45) - (k2*56/15) + (k3*32/9)]);
                k5 := h*F.evaluate(derivative, [Xn[i-1] + (h*8/9), Yn[i-1] + (k1*19372/6561) - (k2*25360/2187) + (k3*64448/6561) - (k4*212/729)]);
                k6 := h*F.evaluate(derivative, [Xn[i-1] + h, Yn[i-1] + (k1*9017/3168) - (k2*355/33) - (k3*46732/5247) + (k4*49/176) - (k5*5103/18656)]);
                k7 := h*F.evaluate(derivative, [Xn[i-1] + h, Yn[i-1] + (k1*35/384) + (k3*500/1113) + (k4*125/192) - (k5*2187/6784) + (k6*11/84)]);
                Yn[i] := Yn[i-1] + (k1*35/384) + (k3*500/1113) + (k4*125/192) - (k5*2187/6784) + (k6*11/84);
                z := Yn[i-1] + (k1*5179/57600) + (k3*7571/16695) + (k4*393/640) - (k5*92097/339200) + (k6*187/2100) + (k7*1/40);
                diff := abs(z - Yn[n-i]);
                (*newH := power((error*h)/(2*diff), (1/5))*h;
                if (newH < hMin) then
                  begin
                    newH := hMin;
                  end;
                if(newH > hMax) then
                  begin
                    newH := hMax;
                  end;*)
                Result[i-1, 0] := i-1;
                Result[i-1, 1] := Xn[i-1];
                Result[i-1, 2] := Yn[i-1];
                Result[i-1, 3] := k1;
                Result[i-1, 4] := k2;
                Result[i-1, 5] := k3;
                Result[i-1, 6] := k4;
                Result[i-1, 7] := k5;
                Result[i-1, 8] := k6;
                Result[i-1, 9] := k7;
                Result[i-1, 10] := h;
                (*h := newH;*)
                Xn[i] := Xn[i-1] + h;
                i := i + 1;
              end;
        end
        else
          begin
            while (Xn[i-1] < goal) do
              begin
                setLength(Result, Length(Result)+1, 11);
                setLength(Xn, Length(Xn)+1);
                setLength(Yn, Length(Yn)+1);
                k1 := h*F.evaluate(derivative, [Xn[i-1], Yn[i-1]]);
                k2 := h*F.evaluate(derivative, [Xn[i-1] + (h*1/5), Yn[i-1] + (k1*1/5)]);
                k3 := h*F.evaluate(derivative, [Xn[i-1] + (h*3/10), Yn[i-1] + (k1*3/40) + (k2*9/2)]);
                k4 := h*F.evaluate(derivative, [Xn[i-1] + (h*4/5), Yn[i-1] + (k1*44/45) - (k2*56/15) + (k3*32/9)]);
                k5 := h*F.evaluate(derivative, [Xn[i-1] + (h*8/9), Yn[i-1] + (k1*19372/6561) - (k2*25360/2187) + (k3*64448/6561) - (k4*212/729)]);
                k6 := h*F.evaluate(derivative, [Xn[i-1] + h, Yn[i-1] + (k1*9017/3168) - (k2*355/33) - (k3*46732/5247) + (k4*49/176) - (k5*5103/18656)]);
                k7 := h*F.evaluate(derivative, [Xn[i-1] + h, Yn[i-1] + (k1*35/384) + (k3*500/1113) + (k4*125/192) - (k5*2187/6784) + (k6*11/84)]);
                Yn[i] := Yn[i-1] + (k1*35/384) + (k3*500/1113) + (k4*125/192) - (k5*2187/6784) + (k6*11/84);
                z := Yn[i-1] + (k1*5179/57600) + (k3*7571/16695) + (k4*393/640) - (k5*92097/339200) + (k6*187/2100) + (k7*1/40);
                diff := abs(z - Yn[n-i]);
                (*newH := power((error*h)/(2*diff), (1/5))*h;
                if (newH < hMin) then
                  begin
                    newH := hMin;
                  end;
                if(newH > hMax) then
                  begin
                    newH := hMax;
                  end;*)
                Result[i-1, 0] := i-1;
                Result[i-1, 1] := Xn[i-1];
                Result[i-1, 2] := Yn[i-1];
                Result[i-1, 3] := k1;
                Result[i-1, 4] := k2;
                Result[i-1, 5] := k3;
                Result[i-1, 6] := k4;
                Result[i-1, 7] := k5;
                Result[i-1, 8] := k6;
                Result[i-1, 9] := k7;
                Result[i-1, 10] := h;
                (*h := newH;*)
                Xn[i] := Xn[i-1] + h;
                i := i + 1;
              end;
          end;
      end;

end.

