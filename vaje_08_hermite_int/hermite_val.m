function y = hermite_val(Z,x0,x)
# funkcija y = hermite_val(Z,x0,x)
# izračuna vrednost kubičnega zlepka v točki x
# Z ... matrika koeficeintov int. polinomov v Newtonovi 
#        obliki za interval [0,1]
# x0 ... tabela interpolacijskih točk
# x ... vrednost, v kateri zlepek računamo

n = length(x0);
y = zeros(size(x));
# gremo po vseh podintervalih
for i = 1:n-1
 # ugotovimo, na kateri elementi x so na tem podintervalu
 idx = find((x0(i)<=x)&(x<=x0(i+1)));
 # preslikamo x na interval [0,1]
 t = (x(idx)-x0(i))/(x0(i+1)-x0(i));
 # izračunamo vrednost za x-e, ki so na podintervalu
 y(idx) = Z(i,1)+t.*(Z(i,2)+t.*(Z(i,3)+(t-1).*Z(i,4))); 
end

endfunction

%!test
%! t = linspace(0.01,0.99);
%! y = hermite_val([1 1 1 1; 1 -1 1 -1],0:2,[t t+1]);
%! y1 = polyval([1 0 1 1],t);
%! y2 = polyval([-1  2   -1  1] , t);
%! assert(y,[y1 y2],eps)

%!demo
%! x0 = 1:3; f = sin(x0); df = cos(x0);
%! Z = hermite_int(x0,f,df);
%! t = linspace(1,3);
%! plot(t,hermite_val(Z,x0,t)-sin(t))
%! hold on; plot(x0,zeros(size(x0)),'o'); hold off
%! title("Napaka Hermitovega zlepka za funkcijo sin v treh točkah.")
%! # v interpolacijskih točkah sta napaka in njen odvod enaka 0.  
