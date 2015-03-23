function [X,i] = milnica_jacobi(X0,tol,maxit)
% Funkcija [X,i] = milnica_jacobi(X0) poišče približek za milnico
%  s pomočjo Jakobijeve iteracije
idx = find(X0);
[n,m] = size(X0);
Xp = X0;
X = Xp;
for i=1:maxit
    X(2:n-1,2:m-1) = (Xp(1:n-2,2:m-1) + Xp(3:n,2:m-1) + \
		      Xp(2:n-1,1:m-2) + Xp(2:n-1,3:m))/4;
    if max(max(abs(X-Xp))) < tol
       break
    end
    Xp = X;
    Xp(idx) = X0(idx);
end
X = Xp;
