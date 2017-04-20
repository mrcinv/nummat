function [X, lambda, iter] = inv_iter_cg(A,k,tol=1e-5, rtol=1e-5, maxit=1000)
# Funkcija [x,iter] = inv_iter_cg(A,k,tol)
#
# Poišče k po absolutni vrendosti najmanjših lastnih 
# vrednosti z inverzno potenčno metodo.
[n,m] = size(A);

k = min(k,n);

B = rand(n,k);
X = B;

ls = diag(1./max(X));
for iter = 1:maxit
 for j=1:k
    [X(:,j), FLAG, RELRES, ITER, RESVEC] = cgs (A, B(:,j), rtol, maxit);
 endfor 
 % lastne vrednosti: Rayleighov kvocient
 ln = diag(1./diag(X'*B));
 % ortogonalizacija
 [X,R] = qr(X,'0');
 
 if abs(ln-ls) < tol
   break
 endif
 B = X; ls = ln;  
endfor

lambda = ln;

%!test
%! A = -2*eye(5) + diag(ones(4,1),1) + diag(ones(4,1),-1);
%! [Q,D] = eig(A);
%! [X,lambda,iter] = inv_iter_cg(A,3);
%! assert(lambda,D(5:-1:3,5:-1:3),1e-4)
%! assert(abs(X'*Q(:,5:-1:3)),eye(3),1e-4)
%! assert(iter<25)