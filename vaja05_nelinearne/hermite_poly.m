function h = hermite_poly(n)
% Funkcija h = hermite_poly(n)
% izračuna koeficiente n-tega Hermitovega polinoma
  hpp = 1; hp = [2 0];
  if n==0
    h = hpp;
  elseif n==1
    h = hp;
  end
  for i=2:n+1
    % h(n) = 2x h(n-1) - 2(n-1)
    h = 2*[hp 0] - 2*(i-1)*[0 0 hpp];
  end

%!assert(hermite_poly(3),[8 0 -12 0])
%!assert(hermite_poly(6),[64 0 -480 0 720 0 -120])
