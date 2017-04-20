% Funkcija Z = laplace_jac(X)
%
% reši robni problem za Laplaceovo enačbo na pravokotniku.
% X ... matrika nxm,
% Neničelne vrednosti v matriki X presdstavljajo robne pogoje
% Z ... matrika z rešitvijo

function [Z,it] = laplace_jac(X,maxit=10000)
  idx = find(X); %neničelni elementi X
  nonfix = setdiff(1:numel(X),idx);
  res = 0;
  Z = X;
  for it=1:maxit
     Z(2:end-1,2:end-1) = (X(1:end-2,2:end-1) + X(3:end,2:end-1) + ...
      X(2:end-1,1:end-2) + X(2:end-1,3:end))/4;
     if norm(Z(nonfix)-X(nonfix),'inf')<1e-10
      break
     end
     Z(idx) = X(idx); % pustimo fiksne elemente
     X = Z;
  end
    
endfunction

%!demo
%! n=50; X = zeros(n);
%! X(:,1) = sin((1:n)/n*pi); X(:,end) = X(:,1);
%! [Z,it] = laplace_jac(X); it
%! mesh(Z);