unit Matrix;

{$mode objfpc}{$H+}
    
interface
    
uses
    SysUtils, Classes;

type
    TEquationsList = Array of String;
    TNumericList = Array of Real;
    TEquationsMatrix = Array of Array of String;
    TNumericMatrix = Array of Array of Real;
    TMatrix = class
        public
            constructor Create;
            destructor Destroy; override;
            Function det(matrix: TNumericMatrix): Real;
            function subMatrix(matrix: TNumericMatrix; i: Integer; j: Integer): TNumericMatrix;
            function adj(matrix: TNumericMatrix): TNumericMatrix;
            function inv(matrix: TNumericMatrix): TNumericMatrix;
            function trans(matrix: TNumericMatrix): TNumericMatrix;
            function escMult(matrix: TNumericMatrix; n: Real): TNumericMatrix;
            Function substraction(matrixA: TNumericMatrix; matrixB: TNumericMatrix): TNumericMatrix;
            Function addition(matrixA: TNumericMatrix; matrixB: TNumericMatrix): TNumericMatrix;
            function multiplication(matrixA: TNumericMatrix; matrixB: TNumericMatrix): TNumericMatrix;
    end;

implementation
    
    constructor TMatrix.Create;
        begin
            
        end;
    destructor TMatrix.Destroy;
        begin
            
        end;
    function TMatrix.addition(matrixA: TNumericMatrix; matrixB: TNumericMatrix): TNumericMatrix;
      var
        i: Integer;
        j: Integer;
        ma: Integer;
        na: Integer;
        mb: Integer;
        nb:integer ;
      begin
          ma := Length(matrixA);
          na := Length(matrixA[0]);
          mb := Length(matrixB);
          nb := Length(matrixB[0]);
          SetLength(result,ma,na);
          if not ((ma=mb) and (na=nb)) then
            begin
              result := matrixA;
              exit;
            end;
          for i := 0 to ma-1 do
              for j := 0 to na-1 do
                  begin
                    Result[i, j] := (matrixA[i, j] + matrixB[i, j]);
                  end;
      end;

    function TMatrix.substraction(matrixA: TNumericMatrix; matrixB: TNumericMatrix): TNumericMatrix;
      var
        i: Integer;
        j: Integer;
        ma: Integer;
        na: Integer;
        mb: Integer;
        nb: Integer;
      begin
          ma := Length(matrixA);
          na := Length(matrixA[0]);
          mb := Length(matrixB);
          nb := Length(matrixB[0]);
          SetLength(result,ma,na);
          if not ((ma=mb) and (na=nb)) then
            begin
              result := matrixA;
              exit;
            end;
          for i := 0 to ma-1 do
              for j := 0 to na-1 do
                  begin
                    result[i, j] := (matrixA[i, j] - matrixB[i, j]);
                  end;
      end;

    function TMatrix.multiplication(matrixA: TNumericMatrix; matrixB: TNumericMatrix): TNumericMatrix;
      var
        i: Integer;
        j: Integer;
        h: Integer;
        ma: Integer;
        na: Integer;
        mb: Integer;
        nb: Integer;
      begin
            ma := Length(matrixA);
            na := Length(matrixA[0]);
            mb := Length(matrixB);
            nb := Length(matrixB[0]);
            if not (na = mb) then
            begin
              exit;
            end;
            SetLength(result, ma, nb);
            for i := 0 to ma-1 do
                for j := 0 to nb-1 do
                begin
                  Result[i, j] := 0;
                    for h := 0 to na-1 do
                    begin
                      Result[i,j] := Result[i, j] + (matrixA[i, h] * matrixB[h, j]);
                    end;
                end;
      end;

    function TMatrix.escMult(matrix: TNumericMatrix; n: Real): TNumericMatrix;
      var
        i: Integer;
        j: Integer;
        ma: Integer;
        na: integer;
      begin
          ma := Length(matrix);
          na := Length(matrix[0]);
          SetLength(result, ma, na);
          for i := 0 to ma-1 do
              for j := 0 to na-1 do
              begin
                    Result[i, j] := matrix[i, j] * n;
              end;
      end;
    function TMatrix.trans(matrix: TNumericMatrix): TNumericMatrix;
      var
        i: Integer;
        j: Integer;
        ma: Integer;
        na: Integer;
      begin
          ma := Length(matrix);
          na := Length(matrix[0]);
          SetLength(result, na, ma);
          for i := 0 to ma-1 do
              for j := 0 to na-1 do
              begin
                    result[j, i] := matrix[i, j];
              end;
      end;
    function TMatrix.inv(matrix: TNumericMatrix): TNumericMatrix;
      var
      ma: Integer;
      na: Integer;
      detMat: Real;
      adjMat: TNumericMatrix;
      begin
          ma := Length(matrix);
          na := Length(matrix[0]);
          if not (ma = na) then
          begin
            exit;
          end;
          SetLength(adjMat, ma, na);
          SetLength(result, ma, na);
          adjMat := adj(matrix);
          detMat := det(matrix);
          if (detMat = 0) then
          begin
              exit;
          end;
          adjMat := trans(adjMat);
          detMat := 1 / detMat;
          Result := escMult(adjMat, detMat);
      end;
    function TMatrix.adj(matrix: TNumericMatrix): TNumericMatrix;
      var
        i: Integer;
        j: Integer;
        s: Integer;
        s1: Integer;
        ma: Integer;
        na: Integer;
        temp: TNumericMatrix;
      begin
        ma := Length(matrix);
        na := Length(matrix[0]);
        if not (ma = na) then
        begin
          exit;
        end;
        SetLength(result, ma, na);
        SetLength(temp, ma-1, na-1);
        s1 := 1;
        for i := 0 to ma-1 do
          begin
            s := s1;
            for j := 0 to na-1 do
            begin
              temp := subMatrix(matrix, i, j);
              result[i, j] := s * det(temp);
              s := s * (-1);
            end;
            s1 := s1 * (-1);
          end;
      end;
    function TMatrix.det(matrix: TNumericMatrix): Real;
        var
            s: Integer;
            k: Integer;
            ma: Integer;
            na: Integer;
        begin
            result := 0.0;
            ma := Length(matrix);
            if ma>1 then
                begin
                    na := Length(matrix[0])
                end
            else
                begin
                    result := matrix[0, 0];
                    exit;
                end;
            if not (ma = na) then
                begin
                    exit;
                end;
            if (ma = 2) then
                begin
                    result := matrix[0, 0] * matrix[1, 1] - matrix[0, 1] * matrix[1, 0];
                    exit;
                end
            else if (ma = 3) then
                begin
                    result := matrix[0, 0] * matrix[1, 1] * matrix[2, 2] + matrix[2, 0] * matrix[0, 1] * matrix[1, 2] + matrix[1, 0] * matrix[2, 1] * matrix[0, 2] - 
                            matrix[2, 0] * matrix[1, 1] * matrix[0, 2] - matrix[1, 0] * matrix[0, 1] * matrix[2, 2] - matrix[0, 0] * matrix[2, 1] * matrix[1, 2];
                    exit;
                end
            else
                begin
                    s := 1;
                    for k := 0 to na-1 do
                    begin
                            Result := Result + s * matrix[0, k] * det(subMatrix(matrix, 0, k));
                            s := s * (-1);
                    end;
                end;
        end;

    function TMatrix.subMatrix(matrix: TNumericMatrix; i: Integer; j: Integer): TNumericMatrix;
        var
            x: Integer;
            y: Integer;
            w: Integer;
            z: Integer;
            ma: Integer;
            na: Integer;
        begin
            ma := Length(matrix);
            na := Length(matrix[0]);
            SetLength(result, ma - 1, na - 1);
            w := 0;
            z := 0;
            for x := 0 to ma - 1 do
            begin
            if(x <> i)then
            begin
                for y := 0 to na - 1 do
                    if ( (x <> i) and (y <> j) ) then
                    begin
                        result[w, z] := matrix[x, y];
                        z := z + 1
                    end;
                w := w + 1;
                z := 0;
            end;
            end;
        end;
end.
