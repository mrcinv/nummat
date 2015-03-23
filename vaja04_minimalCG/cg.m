function [U,it] = cg(U0,maxit,tol)
% funkcija U = cg(U0,omega,maxit,tol) izračuna rešitev diskretizirane Laplaceove
% enačbe z CG iteracijo z danim začetnim približkom U0
% vrednosti na robu U0 ustrezajo robnim pogojem

[m,n] = size(U0);
idx0 = find(U0); %indeksi fiksnih spremenljivk
idx = setdiff(1:n*m,idx0); % komplement idx0
b = -leva_stran(U0,idx);

[x, flag, relres,it]  = pcg(@(x) Akratx(x,m,n,idx), b);

U = U0;
U(idx) = x;
endfunction

function x = leva_stran(U,idx)
% funkcija izračuna desno stran Laplaceove enačbe, pri čemer
% upošteva le elemnte, ki so v idx
[m,n] = size(U);
x = U;
x(2:m-1,2:n-1) = 4*U(2:m-1,2:n-1)-(U(3:m,2:n-1) + U(1:m-2,2:n-1) + U(2:m-1,3:n) + U(2:m-1,1:n-2));
x = x(idx)'; % vrnemo le elemnte, ki so v idx
endfunction

function b = Akratx(x,m,n,idx)
U = zeros(m,n);
U(idx)=x;
b = leva_stran(U,idx);
endfunction
