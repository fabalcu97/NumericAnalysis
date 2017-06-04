COMPILER = fpc
OPTIONS = -Fu/home/fabalcu97/Programming/AN/Métodos/Common/

riemann:
	$(COMPILER) $(OPTIONS) RiemannSum/main.pas
	RiemannSum/./main

lagrange:
	$(COMPILER) $(OPTIONS) Lagrange/main.pas
	lagrange/./main

ngen:
	$(COMPILER) $(OPTIONS) NewtonGeneralized/main.pas
	NewtonGeneralized/./main

euler:
	$(COMPILER) $(OPTIONS) Euler/main.pas
	Euler/./main

simpson:
	$(COMPILER) $(OPTIONS) Simpson/main.pas
	Simpson/./main

clean:
	rm */*.o */*.ppu */main