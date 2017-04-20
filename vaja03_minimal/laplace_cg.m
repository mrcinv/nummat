% Funkcija [Z,it] = laplace_cg(X)
%
% reši robni problem za Laplaceovo enačbo na pravokotniku.
% X ... matrika nxm,
% Neničelne vrednosti v matriki X presdstavljajo robne pogoje
% Z ... matrika z rešitvijo

function [Z,it] = laplace_cg(X,maxit=10000)
  [n,m] = size(X);
  n = n-2; m = m-2;
  b = zeros(n*m,1);
  b(1:n:end) = -X(1,2:end-1);
  b(n:n:end) = -X(end,2:end-1);
  b(1:n) = b(1:n) - X(2:end-1,1);
  b(end-n+1:end) = b(end-n+1:end) - X(2:end-1,end);
  [x, FLAG, RELRES, it, RESVEC] = cgs(@(x) laplace_krat(n,m,x) ,b, 1e-10,1000);
  Z = X;
  Z(2:end-1,2:end-1) = reshape(x,n,m);  
endfunction

%!demo
%! n=50; X = zeros(n);
%! X(:,1) = sin((1:n)/n*pi); X(:,end) = X(:,1);
%! [Z,it] = laplace_cg(X); it
%! mesh(Z);