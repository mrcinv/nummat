function [y, t] = trapez(f, t0, y0, tk, n)
% Funkcija [y, t] = trapez(f, t0, y0, tk, n)
% Poišče približek za rešitev DE y'=f(t,y) z začetnim pogojem y(t0)=y0
% na intervalu [t0,tk] z implicitno trapezno metodo z korakom (tk-t0)/n
t = t0;
y = y0;
h = (tk-t0)/n;
for i=1:n
  t(i+1) = t(i) + h;
  y(i+1) = y(i) + h*f(t(i),y(i)); % euler
  for j=1:3
    y(i+1) = y(i) + h/2*(f(t(i),y(i)) + f(t(i+1),y(i+1))); % navadna iteracija
  end
end

% y'=1 => resitev je y=x+c, y(0)=0 => y=x
%!assert(trapez(@(t,y) 1, 0, 0, 1, 1),[0,1])