# Funkcija D = chebder_matrix(n) izračuna matriko odvodov 
# prvih n Čebiševih polinomov podanih v Čebiševi bazi
function D = chebder_matrix(n) 
  D = zeros(n);
  if (n <= 1)
   D = 0;
   return
  elseif (n == 2)
   D = [0 1; 0 0];
   return
  end
  D(1,2) = 1;
  for i=3:n
    # T(n+1)' = 2xT(n)' + 2T(n) - T(n-1)'
    # 2xT(n) = T(n+1) + T(n-1);
    D(2:i,i) += D(1:i-1,i-1); 
    D(1:i-1,i) += D(2:i,i-1); 
    D(:,i)   -= D(:,i-2);
    D(2,i)   += D(1,i-1); % T(-1) = T(1) 
    D(i-1,i) += 2;
  end 
  
%!assert(chebder_matrix(2),[0 1;0 0])
%!assert(chebder_matrix(3)(:,3), [0 4 0]') % T2' = (2x^2-1)' = 4x = 4T1
%!assert(chebder_matrix(4)(:,4),[3 0 6 0]')
%!assert(chebder_matrix(5)(:,5),[0 8 0 8 0]')

%!demo
%! # Rešujemo robni problem za enačbo y''+y=e^t z robnima pogojema y(-1)=1 in y(1)=0
%! ya = 1; yb = 0;
%! # desno stran enačbe aproksimiramo z odrezano Čebiševo vrsto
%! b = chebfun(@exp,10);
%! figure(1)
%! t = linspace(-1,1);
%! plot(t, exp(t)-chebval(b,t))
%! title("Napaka aproksimacije desne strani e^t")
%! # enačba y''+y = e^t se prevede v sistem (D^2+I)T = b
%! D = chebder_matrix(11); A = D^2 + eye(11); 
%! # plus robni pogoji
%! A = [A;(-1).^(2:12);ones(1,11)]
%! T = A\[b;ya;yb]; # koeficienti rešitve
%! figure(2)
%! plot(t, chebval(T,t))
%! title("Numerična rešitev robnega problema")
%! figure(3)
%! CD = [cos(-1) sin(-1);cos(1) sin(1)]\([ya;yb]-exp([-1;1])/2);
%! plot(t,chebval(T,t)-(exp(t)/2+CD(1)*cos(t)+CD(2)*sin(t)))
%! title("Razlika med numerično in pravo rešitvijo")