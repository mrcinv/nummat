function [p,it] = gauss_newton(model,x0,y0,p0,maxit=1000,nat=1e-8)
% Funkcija [p,it] = gauss_newton(model,x0,y0,p0,maxit=1000,nat=1e-8)
%
% Izračuna optimalne parametre nelinearnega modela po metodi najmanjših kvadratov
% za podatke x0, y0 z Gauss-Newtonovo iteracijo.
%
% Argumenti:
% model ... kazalec na funkcijo, ki vrne vrednost modela in njegovega
%           gradienta s klicem [m,grad] = model(p,x)
% x0 ... vektor vrednosti neodvisne spremenljivke
% y0 .... vektor vrednosti odvisne spremenljivke
% p0 ... začetni približek za vrednosti parametrov
% maxit ... največje število iteracij
% nat ... zahtevana natančnost rešitve
%
% Rezultat:
% p ... parametri modela
% it ... število iteracij
  for it = 1:maxit
    [m,grad] = model(p0,x0);
    p = p0 + grad\(y0-m); % yi = model(p0,xi) + grad(model)'*(p-p0)
    if norm(p-p0)<nat
      break
    end
    p0 = p;
  end
  if it == maxit
    warning('Metoda ni  konvergirala! Rešitev mogoče nima smisla')
  end
endfunction
%!function [m,grad] = model(p,x0)
%!   m = p(1)*x0./(p(2)+x0);
%!   grad = [x0./(p(2)+x0) -p(1)*x0./(p(2)+x0).^2];
%!endfunction
%!test
%! x0 = [0 1 2]'; y0 = [0 1/2 2/3]';
%! [p,it] = gauss_newton(@model,x0,y0,[1;1]);
%! assert(p,[1;1],10*eps)
%! assert(it,1)
%! [p,it] = gauss_newton(@model,x0,y0,[1.1;0.9]);
%! assert(p,[1;1],1e-7)
%! assert(it<100,true)

%!demo
%! function [m,grad] = model(p,x0)
%!   m = p(1)*x0./(p(2)+x0);
%!   grad = [x0./(p(2)+x0) -p(1)*x0./(p(2)+x0).^2];
%! endfunction
%! x0 = [0.038; 0.194; 0.425; 0.626; 1.253; 2.5; 3.74];
%! y0 = [0.05; 0.127; 0.094; 0.2122; 0.2729; 0.2665; 0.3317];
%! [p,it] = gauss_newton(@model,x0,y0,[1;1])
%! t = linspace(0,4);
%! plot(x0,y0,'o')
%! hold on
%! plot(t,model(p,t))
%! hold off
