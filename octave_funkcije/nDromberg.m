function I = nDromberg(f,k,d)

I = zeros(k,k);
h = 1;
for i=1:k
  h = h/2
  x0 = linspace(-1+h,1-h,2^i)
  omega = ones(size(x0))*(x0(2)-x0(1))
  I(i,1) = nDquad(f,x0,omega,d)
end
for j=2:k
 for i=1:k-j+1
   I(i,j) = (4^(j-1)*I(i+1,j-1)-I(i,j-1))/(4^(j-1)-1);
 end
end

%!demo
%! ## povprečna razdalja med točkama v kocki [-1,1]^3
%! f=@(x) norm(x(1:3)-x(4:6)); % razdalja
%! x0 = linspace(-1,1,7); omega = (x0(2)-x0(1))/3*[1 4 2 4 2 4 1];
%! tic; I = nDromberg(f,4,6);toc
%! E = I(1,4)/64;
%! # simulacija
%! Ep = 0; n = 100000;
%! for i=1:n
%!   Ep += norm(rand(3,1)-rand(3,1));
%! end
%! Ep = 2*Ep/n;
%! E # izračunano povprečje
%! Ep # simulacija
%! I # rombergova tabela  