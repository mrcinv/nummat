function I = kvadratura_multiD(f,a,b,x0,omega,d)
n = length(x0);
I=0;
if d>1
  for i=1:n
    I += omega(i)*kvadratura_multiD(@(x) f([x0(i),x]),a(2:end),b(2:end),x0,omega,d-1)
  end
else
  for i=1:n
    I += omega(i)*f(x0(i));
  end
end 
