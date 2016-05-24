## Funkcija [x0,omega] = gauss_quad_rule(a,b,n)
##
## Izračuna uteži in vozlišča za Gaussove kvadraturne formule z Golub-Welshovim algoritmom
## a, b in c so funkciji n, ki predstavljajo koeficiente v tročlenski  rekurzivni
## formuli
##
## p_n(x) = (a(n)x+b(n))p_{n-1}(x) - c_n p_{n-2}(x)
## mu je vrednost integrala uteži na izbranem intervalu
function [x0,omega] = gauss_quad_rule(a,b,c,mu,n)
  J = zeros(n);
  J(1,1) = -b(1)/a(1);
  for i=2:n
    J(i,i) = -b(i)/a(i);
    J(i-1,i) = sqrt(c(i)/(a(i-1)*a(i)));
    J(i,i-1) = J(i-1,i);
  end
  [Q, lambda] = eig(J);
  x0 = diag(lambda)';
  omega = Q(1,:).^2*mu;
endfunction

%!test
%! a = @(n)  (2*n-1)/n; b = @(n) 0; c = @(n) (n-1)/n;
%! [x0,omega] = gauss_quad_rule(a,b,c,2,2);
%! assert(sort(x0),[-1,1]/sqrt(3),eps)
%! assert(omega,[1,1],eps)
%! [x0,omega] = gauss_quad_rule(a,b,c,2,3);
%! assert(sort(x0),[-1,0,1]*sqrt(3/5),eps)
%! assert(sort(omega),[5 5 8]/9,eps)
%!test
%! a = @(n) -1/(n); b = @(n) (2*n-1)/n; c = @(n) (n-1)/n;
%! [x0,omega] = gauss_quad_rule(a,b,c,1,2);
%! assert(sort(x0), 2+sqrt(2)*[-1,1],eps)
%! assert(sort(omega), (2+sqrt(2)*[-1,1])/4,eps)
