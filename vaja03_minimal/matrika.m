% Funkcija L = matrika(n,m)
%
% vrne matriko 2D Laplaceovega operatorja
% za območje razeljeno na (n+1)x(m+1) enakih kvadratkov
% Matrika L je dimenzije (nm)x(nm).
function L = matrika(n,m)
  N = n*m;
  L = sparse(1:(N-n),(n+1):N,ones(N-n,1),N,N);
  v = ones(N-1,1);
  v(n:n-1:end-1) = 0;
  L = L + sparse(1:N-1,2:N,v,N,N);
  L = L + L' - 4*speye(N);
endfunction

%!test
%! L2x2 = sparse([-4 1 1 0; 1 -4 0 1;1 0 -4 1; 0 1 1 -4]);
%! assert(matrika(2,2),L2x2)
%!test
%! L3x2 = sparse([-4 1 0 1 0 0;1 -4 1 0 1 0;0 1 -4 0 0 1;1 0 0 -4 1 0;0 1 0 1 -4 1;0 0 1 0 1 -4]);
%! assert(matrika(3,2),L3x2)
%!test
%! L = matrika(5,10);
%! assert(size(L),[50,50])
%! assert(full(L(23,23)),-4)
%! assert(full(L(5:6,6:7)),[0 0;-4 1])
%! assert(L,L')
%! assert(L(21:25,26:30),speye(5))
%!test (issparse(matrika(randi(10),randi(10))))
