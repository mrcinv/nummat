% Algoritem za izračun razvoja funkcije v (okrnjeno) vrsto Čebiševa
%
% Podatki: fcheb	Funkcija, ki jo razvijamo
%          n		stopnja polinoma
%
% Rezultat: c		koeficienti razvoja funkcije fcheb v vrsto Čebiševa
%
function c = chebfun2(fcheb,n)
k = [0:n];
x = cos(pi*(2*k+1)/(2*n+2));
c = zeros(n+1,1);
c(1) = sum(fcheb(x))/(n+1);
for j=2:n+1
   c(j) = 2*sum(fcheb(x).*cos((j-1)*pi*(2*k+1)/(2*n+2)))/(n+1);
end
