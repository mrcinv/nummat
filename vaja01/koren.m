% Funkcija [y,it] = koren(x, nat=1e-10)
%
% izračuna kvadratni koren števila x s tangentno metodo. 
%
function [y,it] = koren(x,nat=1e-10,maxit=100)
  y = x;
  for it = 1:maxit
    delta = (y-x./y)/2;
    y = y - delta;
    %y = (y+x./y)/2;
    if (abs(y.^2-x)<nat) || (abs(delta)<nat)
      break
    end
  end
endfunction

% Enotski testi
%!test abs(koren(4)-2)<1e-10
%!assert (koren(8), 2*koren(2), 1e-10)
%!test
%! x = rand(10,1);
%! assert(koren(x).^2,x,1e-10)
%!test [y,it] = koren(rand()); it < 10;

% graf napake
%!demo
%! x = linspace(0,5);
%! y = koren(x);
%! plot(x,y.^2-x,"r;y^2-x;",x,sqrt(x)-y,"b;y-\sqrt{x};")
%! title("Graf ostanka y^2-x in napake y-sqrt(x)")
%! %-------------------------
%! % Graf napake na intervalu [0,5]

% graf časovne zahtevnosti
%!demo
%! speed("koren(2,1/n)","",[1,2^15])
