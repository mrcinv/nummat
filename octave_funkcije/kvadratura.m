% funkcija I = nDquad(f,x0,omega,d)
%
% izračuna integral funkcije f na d-dimenzionalni kocki [-1,1]^d
% s večkratno uporabo enodimenzionalne kvadrature 
% podane z utežmi omega in vozlišči x0
function I = nDquad(f,a,b,x0,omega,d)

n = length(x0);
indeksi = ones(1,d); % začnemo z 1,1,1,1...
for i = 1:n^d
  I += f(diag(x0(indeksi)))*omega(indeksi); 
  j = 1;
  while (indeksi(j)>=n) & (j<d)
    indeksi(j) = 1;
    j += 1;
  end
  indeksi(j) += 1;
end

%!test
%! f = @(x) x(1)+1; #f(x,y)=x+1;
%! omega = [1,1]; x0 = [-0.5,0.5]; #sestavljeno sredinsko pravilo
%! assert ( nQuad(f,x0,omega,2),2,eps)