function Z = int_rbf(alfa,x0,y0,fi,x,y)
% function [A,b] = rbf(alfa,x0,y0,fi,x,y) izračuna vrednosti interpolanda RBF
% oblike sum_i alfa(i)*fi((x-x0(i))^2 + (y-y0(i))^2)
% alfa ... uteži
% x0, y0 ... koordinate veznih točk
% fi ... funkcija, ki določa obliko RBF
% x,y ... spremenljivke, v katerih želimo izračunati funkcij

n = length(x0);
Z = zeros(size(x));
for i=1:n
    Z = Z + alfa(i)*fi((x-x0(i)).^2 + (y-y0(i)).^2);
end

endfunction
