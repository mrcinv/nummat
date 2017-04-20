function Z = hermite_int(x0,f,df)
# funkcija Z = hermite_int(x0,f,df)
# izračuna hermitov zlepek za dane vrednosti funkcije f
# in vrednosti odvodov df
# Z ... matrika (n-1)x4, v kateri so koeficienti 
#      Newtonovega polinoma, ki interpolira podatke 
#      na intervalu [0,1]

n = length(f);
Z = zeros(n-1,4);

for i=1:n-1
  # izračunamo koeficiente Newtonovega polinoma
  dt  = x0(i+1)-x0(i); % zaradi linearne transformacije moramo popraviti odvode
  Z(i,1) = f(i);
  Z(i,2) = df(i)*dt;
  Z(i,3) = (f(i+1)-f(i))-df(i)*dt;
  Z(i,4) = (df(i+1)*dt - (f(i+1)-f(i)))-Z(i,3);
end

%!assert(hermite_int([1 2], [1 2],[0,0]),[1 0 1 -2])

%!demo
%! x0 = [1 3 4]; y = [1 2 1]; dy = [0 0.1 -1];
%! Z  = hermite_int(x0,y,dy);
%! hermite_plot(Z,x0,y,dy)
%! title("Hermitov kubični zlepek na 3 točkah") 