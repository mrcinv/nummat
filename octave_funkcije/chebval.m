% funkcija y = chebval(p,x) izračuna vrednost polinoma, ki je podan v Čebiševi bazi
% p(x) = p(1)T0(x) + p(2)T1(x) + ... + p(n+1)Tn(x)
function y = chebval(p,x)

 n = length(p);
 if n == 1
  y = ones(size(x));
 elseif n == 2
  y = x;
 else
  y = p(1)+p(2)*x;
  Tp = 1; T = x;
  for i=3:n
    Tn = 2*x.*T-Tp;
    Tp = T; T = Tn;
    y += p(i)*T;
  end
 end    
endfunction
%!test
%! p = [2 0 -1]; t = linspace(-1,1);
%! assert(chebval([0,0,1],t),polyval([2 0 -1],t),eps)

%!demo
%! 1+1
