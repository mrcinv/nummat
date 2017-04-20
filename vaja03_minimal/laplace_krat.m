% Funkcija y = laplace_krat(m,n,x)
%
% izračuna produkt A*x vektorja x in 2D Laplaceove matrike A za 
% pravokotno mrežo dimenzije m x n.

function y = laplace_krat(m,n,x)
  X = zeros(m+2,n+2);
  X(2:end-1,2:end-1) = reshape(x,m,n);
  X(2:end-1,2:end-1) = -4*X(2:end-1,2:end-1) + X(1:end-2,2:end-1) + X(3:end,2:end-1) + X(2:end-1,1:end-2) + X(2:end-1,3:end);
  y = reshape(X(2:end-1,2:end-1),m*n,1);
endfunction

%!test
%! A = [-4 1 1 0; 1 -4 0 1; 1 0 -4 1; 0 1 1 -4]; x = (1:4)';
%! assert(A*x,laplace_krat(2,2,x),10*eps)
%!test
%! x = rand(21*33,1);
%! assert (matrika(21,33)*x, laplace_krat(21,33,x),1e-15)
