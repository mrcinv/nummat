function [X,i] = milnica_CG(X0,tol,maxit)
% Funkcija [X,i] = milnica_CG(X0) poišče približek za milnico
%  s pomočjo Jakobijeve iteracije
idx = find(X0);
[n,m] = size(X0);
N = n*m;
idx0 = setdiff(1:N,idx); % ničelni elti v X0

b = -AkratX(X0,n,m,1:N)(idx0);
Axhandle = @(x) AkratX(x,n,m,idx0);
[x, flag, relres, i] = pcg(Axhandle,b,tol,maxit);
X = X0;
X(idx0) = x;

function b = AkratX(x,n,m,idx)
  X = zeros(n,m);
  X(idx) = x; % make it a matrix
  X(2:n-1,2:m-1) = 4*X(2:n-1,2:m-1) - (X(1:n-2,2:m-1) + X(3:n,2:m-1) + X(2:n-1,1:m-2) + X(2:n-1,3:m));
  b = X(idx);
endfunction
