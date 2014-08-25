# -*- coding: utf-8 -*-
def jacobi(F):
    """Izračuna približek za rešitev laplaceovo enačbo na pravokotniku. Za reševanje linearnega sistema uporabimo Jacobijevo iteracijo.
    F ... matrika, ki na robu vsebuje predpisane vrednosti, v notranjosti pa začetni približek
    """
    n,m = F.shape
    Fp = F.copy()
    napaka = 1
    k = 0
    maxk = 100
    tol = 0.0001
    while 1:
    #while (napaka > tol) and (k<maxk):
        # en korak Jacobijeve iteracije
        print n
        i=0;j=0
        print range(1,n-2)
        for i in range(1,n-2):
            for j in range(1,m-2):
                F[i,j]=(Fp[i-1,j]+Fp[i+1,j]+Fp[i,j-1]+Fp[i,j+1])/4
        napaka = norm(F-Fp)
        Fp = F.copy()
        k = k+1
