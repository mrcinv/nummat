# Funkcija dp = chebder(p) izračuna koeficiente odvoda dp polinoma p podanega
# v Čebiševi bazi
function dp = chebder(p)
  n = length(p); 
  if (n <= 1)
   dp = 0;
   return
  elseif (n == 2)
   dp = p(2);
   return
  end
  dT1 = [];
  dT2 = 1;
  dp = p(2);
  for i=3:n
    # T(n+1)' = 2xT(n)' + 2T(n) - T(n-1)'
    # 2xT(n) = T(n+1) + T(n-1);
    dTn = [0 dT2] + [dT2(2:end) 0 0] - [dT1 0 0];
    dTn(2) += dT2(1); % T(-1) = T(1) 
    dTn(end) += 2;
    dT1 = dT2; dT2 = dTn;
    dp  = [dp 0] + p(i)*dTn;
  end 
  
%!assert(chebder([1 1]),1)
%!assert(chebder([0 0 1]), [0 4]) % T2' = (2x^2-1)' = 4x = 4T1
%!assert(chebder([0 0 0 1]),[3 0 6])
%!assert(chebder([0 0 0 0 1]),[0 8 0 8])