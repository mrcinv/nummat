function [y, t] = euler(f, t0, y0, tk, n)
% Funkcija [y, t] = euler(f, t0, y0, tk, n)
% Poišče približek za rešitev DE y'=f(t,y) z začetnim pogojem y(t0)=y0
% na intervalu [t0,tk] z Eulerjevo metodo z korakom (tk-t0)/n
t = t0;
y = y0;
h = (tk-t0)/n;
for i=1:n
  y(:,i+1) = y(:,i) + h*f(t(i),y(:,i));
  t(i+1) = t(i) + h;
end

% y'=1 => resitev je y=x+c, y(0)=0 => y=x
%!assert(euler(@(t,y) 1, 0, 0, 1, 1),[0,1])
%!assert(euler(@(t,y) y, 0, [0;1], 1, 1),[0 0;1 2])