% funkcija I = nDquad(f,x0,omega,d)
%
% izračuna integral funkcije f na d-dimenzionalni kocki [-1,1]^d
% s večkratno uporabo enodimenzionalne kvadrature 
% podane z utežmi omega in vozlišči x0
function I = nDquad(f,x0,omega,d)

% število vozlišč
n = length(x0);
index = ones(d,1); % multiindeks začnem z 1,1,1,1,1,...
I = 0;
for i=1:n^d
  I += f(x0(index))*prod(omega(index));
  % naslednji multiindex
  j = 1;
  while (index(j)>=n) && (j<d)
    index(j)=1;
    j += 1;
  end
  index(j) += 1;
end

%!test
%! f = @(x) x(1)+1; #f(x,y)=x+1;
%! omega = [1,1]; x0 = [-0.5,0.5]; #sestavljeno sredinsko pravilo
%! assert ( nDquad(f,x0,omega,2),4,eps)

%!demo
%! ## povprečna razdalja med točkama v kocki [-1,1]^3
%! f=@(x) norm(x(1:3)-x(4:6)); % razdalja
%! x0 = linspace(-1,1,7); omega = (x0(2)-x0(1))/3*[1 4 2 4 2 4 1];
%! tic; I = nDquad(f,x0,omega,6);toc
%! E = I/64;
%! # simulacija
%! Ep = 0; n = 100000;
%! for i=1:n
%!   Ep += norm(rand(3,1)-rand(3,1));
%! end
%! Ep = 2*Ep/n;
%! E # izračunano povprečje
%! Ep # simulacija  