function hermite_plot(Z,x0,f,df)
# funkcija hermite_plot(Z,x0,f)
# nariše kubični zlepek
# Z ... matrika koeficeintov int. polinomov v Newtonovi 
#        obliki za interval [0,1]
# x0 ... tabela interpolacijskih točk
# f ... interpolacijske vrednosti
# df ... vrednosti odvodov
n = length(x0);
t = linspace(0,1); 
plot(x0,f,'o');
                                # narišemo tangente
dx = (max(x0)-min(x0))/10;
x = reshape([x0-dx;x0+dx],1,2*n);
y = [f-df*dx; f+df*dx];
hold on
fmt = "r";
for i = 1:n-1
 # izračunamo vrednost
 y = Z(i,1)+t.*(Z(i,2)+t.*(Z(i,3)+(t-1)*Z(i,4))); 
 x = (x0(i+1)-x0(i))*t+x0(i);
 plot(x,y,fmt);
 if fmt == "r"
   fmt = "b";
 else
   fmt ="r";
 end
                                # narišemo tangento
 plot([x0(i)-dx x0(i)+dx], [f(i)-df(i)*dx f(i)+df(i)*dx])
end
plot([x0(n)-dx x0(n)+dx], [f(n)-df(n)*dx f(n)+df(n)*dx])

hold off
