all:
	happy -gca ParLambdaNat.y
	alex -g LexLambdaNat.x
	ghc --make TestLambdaNat.hs -o TestLambdaNat

clean:
	-rm -f *.log *.aux *.hi *.o *.dvi

distclean: clean
	-rm -f DocLambdaNat.* LexLambdaNat.* ParLambdaNat.* LayoutLambdaNat.* SkelLambdaNat.* PrintLambdaNat.* TestLambdaNat.* AbsLambdaNat.* TestLambdaNat ErrM.* SharedString.* ComposOp.* LambdaNat1.dtd XMLLambdaNat.* Makefile*
	

