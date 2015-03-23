function [U,it] = gs(U0,maxit,tol)
% funkcija U = gs(U0,maxit,tol) izračuna rešitev diskretizirane Laplaceove
% enačbe z Gauss-Seidelovo iteracijo z danim začetnim približkom U0
% vrednosti na robu U0 ustrezajo robnim pogojem
[m,n] = size(U0);

U = U0;

for it=1:maxit
    for i = 2:m-1
      for j= 2:n-1
        U(i,j) = (U(i+1,j) + U(i,j+1) + U(i-1,j) + U(i,j-1))/4;
      end
    end
    if max(max(abs(U-U0))) < tol
       break
    end
    U0 = U;
end
