function [x,y] = vlozi_graf(G,idx0,x0,y0)
% Funkcija [x,y] = vlozi_graf(G,idx) poišče vložitev grafa G v R^2
% z minimalno elastično energijo.
% G ... adjunkcijska matrika grafa G. g(i,j) je koeficient vzmeti
% idx0 ... indeksi fiksnih točk
% x0,y0 ... koordinate fiksnih točk
n = length(G);
idx = setdiff(1:n,idx0); % indeksi ostalih točk
A = G(idx,idx);
A = -A + diag(sum(G(:,idx)));
bx = reshape(x0,1,length(x0))*G(idx0,idx); % fiksne točke prispevajo desne strani enačb
by = reshape(y0,1,length(y0))*G(idx0,idx);

x = zeros(n,1);
y = x;
[x(idx), flag, relres, iter, resvec, eigtest]  = pcg(A,bx',1e-3);
y(idx) = pcg(A,by',1e-6);
x(idx0) = x0;
y(idx0) = y0;
