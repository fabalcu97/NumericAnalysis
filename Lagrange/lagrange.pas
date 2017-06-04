unit Lagrange;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;
type
  TMatriz = Array of Array of Real;
  TLagrange = class
    public
    procedure IngresarValores(vPuntos: TMatriz);
    function Ejecutar(): String;
    Constructor Create;
    Destructor Destroy;
    
  end;
var
   i: Integer;
   j: Integer;
   n: Integer;
   Li: Real;
   polinomio: String;
   Puntos: TMatriz;

implementation
    Constructor TLagrange.Create();
    begin
         SetLength(Puntos,1,1);
         Puntos[0,0] := 0;
    end;

    Destructor TLagrange.Destroy();
    begin

    end;

    procedure TLagrange.IngresarValores(vPuntos: TMatriz);
    begin
      n := Length(vPuntos[0]);
      SetLength(Puntos, 2, n);
      Puntos := vPuntos;
      polinomio := '';
    end;

    function TLagrange.Ejecutar(): String;
    begin

    for i := 0 to n-1 do
    begin
        Li := 1;
        polinomio := polinomio + '(';
        for j := 0 to n-1 do
        begin
            if( i <> j ) then
            begin
                polinomio := polinomio  +  '(x-' + FloatToStr(Puntos[0,j]) + ')*';
                Li := Li * ((Puntos[0,i]) - (Puntos[0,j]));
            end;
        end;
        Li := (Puntos[1,i]) / Li;
        polinomio := polinomio + '(' + FloatToStr(Li) + ')) + ';
    end;
    polinomio := polinomio + '0';
    Result := polinomio;

  end;

end.

