% Funkcija y = koren(x)
%
% izračuna kvadratni koren števila x z različnimi metodami
%
function y = koren(x,nat=1e-10)
  y = x;
  for i = 1:100
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

% graf napake
%!demo
%! x = linspace(0,5);
%! y = koren(x);
%! plot(x,log10(abs(y.^2-x)),'r',label="$\log_{10}(y^2-x)$")
%! hold on
%! plot(x,log10(sqrt(x)-y,'b')
%! hold off
%! title("Graf ostanka y^2-x in napake y-sqrt(x)")
%! %-------------------------
%! % Graf napake na intervalu [0,5]

