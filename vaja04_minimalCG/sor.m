function [U,it] = sor(U0,omega,maxit,tol)
% funkcija U = sor(U0,omega,maxit,tol) izračuna rešitev diskretizirane Laplaceove
% enačbe s SOR iteracijo z danim začetnim približkom U0
% vrednosti na robu U0 ustrezajo robnim pogojem
[m,n] = size(U0);

U = U0;

for it=1:maxit
    for i = 2:m-1
      for j= 2:n-1
        U(i,j) = (U(i+1,j) + U(i,j+1) + U(i-1,j) + U(i,j-1))/4;
	U(i,j) = omega*U(i,j) + (1-omega)*U0(i,j);
      end
    end
    if max(max(abs(U-U0))) < tol
       break
    end
    U0 = U;
end
