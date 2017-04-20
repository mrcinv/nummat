function [T,A,flag,iter] = ravnovesje(T0,P,fix,k)
% funkcija  T = ravnovesje(T0,P,fix,k) izračuna ravnovesne položaje točk v grafu
% G, v katerem smo povezave nadomestili z idealnimi vzmetmi.
% Vhod:
%  T0 ... 2xn matrika z začetnimi koordiantami točk
%  P ... 2xm tabela povezav, v kateri so pari indeksov točk - krajišč povezave 
%  fix ... tabela indeksov točk, ki jih fiksiramo
%  k ... tabela koeficientov vzmeti
% Rezultat:
%  T ... koordiante vozlič grafa v ravnovesju
%  A ... matrika sistema
%  flag ... status 0: CG je konvergirala, 1: doseženo je bilo maksimalno št. iteracij
%  iter ... število korakov CG (konjugirani gradienti)

n = length(T0); % število vozlišč
m = length(P); % število povezav
fn = length(fix);
A = sparse(n-fn,n-fn); % matrika sistema
b = zeros(n-fn,2); % desne strani
% tabela s položaji nefiksnih točk v matriki A
spr = setdiff(1:n,fix);
idx = zeros(n,1); % idx(k)==0, če je k fiksna točka
idx(spr) = 1:(n-fn); % idx(k) je zaporedna številka za spremenljive točke
% zanka po vseh povezavah 
for l=1:m
	i = P(1,l); j = P(2,l); 
	if idx(i) && idx(j)
		% obe točki se spreminjata
		A(idx(j),idx(j)) += k(l);
		A(idx(i),idx(i)) += k(l);
		A(idx(i),idx(j)) -= k(l);
		A(idx(j),idx(i)) -= k(l); % desna stran
	elseif ~idx(i) && idx(j)
		% točka i je fiksna
		A(idx(j),idx(j)) += k(l);
		b(idx(j),:) += k(l)*T0(:,i)'; % desna stran
	elseif idx(i) && ~idx(j)
		% točka j je fiksna
		A(idx(i),idx(i)) += k(l);
		b(idx(i),:) += k(l)*T0(:,j)'; % desna stran
	end
end
[x, flag, relres, iter] = pcg(A,b(:,1),[],100); % rešimo sistem za ravnovesne koordinate z metodo konj. gradientov
[y, flagy, relres, itery] = pcg(A,b(:,2),[],100);

T = T0;
T(:,spr) = [x y]'; % ravnovesne kordinate shranimo v T
[X, lambda, iter] = inv_iter_cg(A,5,1e-5);
T(3:7,spr) = X;