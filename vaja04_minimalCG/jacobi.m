function [U,i] = jacobi(U0,maxit,tol)
% funkcija U = jacobi(U0,maxit,tol) izračuna rešitev diskretizirane Laplaceove
% enačbe z Jacobijevo iteracijo z danim začetnim približkom U0
% vrednosti na robu U0 ustrezajo robnim pogojem
[m,n] = size(U0);

U = U0;

for i=1:maxit
    U(2:m-1,2:n-1) = (U(3:m,2:n-1) + U(1:m-2,2:n-1) + U(2:m-1,3:n) + U(2:m-1,1:n-2))/4;
    if max(max(abs(U-U0))) < tol
       break
    end
    U0 = U;
end
