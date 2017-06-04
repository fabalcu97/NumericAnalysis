{$mode objfpc}{$H+}

uses
    Euler;
     
var

    EulerMethod: TEuler;
    ans: Real;
    
begin

    EulerMethod := TEuler.Create('2-exp(-4*x)-2*y', 0, 0.5, 0, 1, 5);

    ans := EulerMethod.execute();

    WriteLn(ans);

end.