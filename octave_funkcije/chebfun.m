% funkcija fp = chebfun(fun,n) 
% izračuna razcep funkcije fun na intervalu [-1,1]
% po Čebiševih polinomih stopnje največ n

function c = chebfun(fcheb,n)
k = [0:n];
x = cos(pi*(2*k+1)/(2*n+2));
c = zeros(n+1,1);
c(1) = sum(fcheb(x))/(n+1);
for j=2:n+1
   c(j) = 2*sum(fcheb(x).*cos((j-1)*pi*(2*k+1)/(2*n+2)))/(n+1);
end
endfunction

%!test
%! assert(chebfun(@(x) polyval([4 2 -3 -1],x), 3), [0 0 1 1]',2*eps) 

%!demo
%! x = linspace(-1,1);
%! T = chebfun(@erf,9);
%! plot(x,erf(x)-chebval(T,x))
%! title("Razlika med erf(x) in aproksimacijo")

function fp = chebfun2(fun,n)
  fi = pi*linspace(0.5/n,1-0.5/n,n);
  x = cos(fi); % ničle n-tega Čebiševega polinoma
  f = fun(x); % vrednosti funkcije
  # diskretna cosinusna transformacija
  pf = zeros(1,4*n);
  pf(2:2:2*n) = f; pf(4*n:-2:2*n+1) = f;
  dctf = fft(pf)(1:n);
  fp = real(dctf)/n;
  fp(1) = fp(1)/sqrt(2);
endfunction
