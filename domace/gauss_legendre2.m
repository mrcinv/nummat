## Funkcija gauss_legendre2(fun,a,b,n)
##
## Izračuna vrednost integrala funkcije f na intervalu [a,b] s
## sestavljenim Gauss-Legendrovim pravilom na dveh točkah

function I = gauss_legendre2(fun,a,b,n)
  x2 = 1/sqrt(3);
  x0 = zeros(1,2*n);
  x = linspace(a,b,n+1);
  ax = x(1:end-1); bx = x(2:end);
  h = x(2)-x(1);
  x0(1:2:end-1) = (-x2*(bx-ax) + ax + bx)/2;
  x0(2:2:end) = (x2*(bx-ax) + ax + bx)/2;
  I = h/2*sum(fun(x0));
endfunction
%!assert(gauss_legendre2(@(x) x.^2, 0,1,1),1/3,eps)
%!test
%! err = []; n = 1:10;
%! for i = n
%!   err = [err gauss_legendre2(@sin,0,pi,2^i)-2];
%! end
%! assert(polyfit(n,log2(abs(err)),1)(1) < 3.5)
