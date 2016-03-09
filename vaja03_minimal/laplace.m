%Funkcija Z = laplace(X)
%
% reši robni problem za Laplaceovo enačbo na pravokotniku.
% X ... matrika nxm,
% Vrednosti na „robu“ matrike, presdstavljajo robne pogoje
% Z ... matrika z rešitvijo
function Z = laplace(X)
  [n,m]=size(X);
  n = n-2; m = m-2;
  L = matrika(n,m);
  b = zeros(n*m,1);
  b(1:n:end) = -X(1,2:end-1);
  b(n:n:end) = -X(end,2:end-1);
  b(1:n) = b(1:n) - X(2:end-1,1);
  b(end-n+1:end) = b(end-n+1:end) - X(2:end-1,end);
  Z = [X(:,1) [X(1,2:end-1); reshape(L\b,n,m); X(end,2:end-1)] X(:,end)];
endfunction

%!test
%! x = [0:5];
%! [X,Y] = meshgrid(x,x);
%! assert(laplace(X+2*Y),X+2*Y,1e-14)
%! # linearna funkcija je rešitev
%!test
%! X = rand(15,27);
%! Z = laplace(X);
%! for k=1:10
%!   j = randi([2,26]); i = randi([2,14]);
%!   assert(4*Z(i,j), Z(i-1,j)+Z(i+1,j)+Z(i,j-1)+Z(i,j+1),1e-14)
%! end
%! # testiramo ali je Z rešitev Laplaceove enačbe
%!test
%! X=rand(12,7); Z=laplace(X);
%! assert(X(1,:),Z(1,:),1e-14)
%! assert(X(end,:),Z(end,:),1e-14)
%! assert(X(:,end),Z(:,end),1e-14)
%! # testiramo, da se rob ne spremeni
