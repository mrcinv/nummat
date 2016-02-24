% Funkcija y = koren(x)
%
% izračuna kvadratni koren števila x z različnimi metodami
%
function y = koren(x,nat=1e-10)
  y = x/2;
  while abs(y.^2-x)>nat
    y = (y+x./y)/2;
  end
endfunction

% Enotski testi
%!test koren(4)==2
%!assert (koren(8), 2*koren(2))
%!test
%! x = rand();
%! assert(koren(x)^2,x,1e-10)

% graf napake
%!demo
%! x = linspace(0,5);
%! for i=1:length(x)
%!  y(i) = koren(x(i));
%! end
%! plot(x,log10(abs(y.^2-x)))
%! title("Graf napake")
%! %-------------------------
%! % Graf napake na intervalu [0,5]

% graf časovne zahtevnosti
%!demo
%! speed("koren(2,1/n)","",[1,2^15])
