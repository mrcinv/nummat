function [x,y,z] = matrika_las(k,l,mg,x0, n)
% funkcija vrne matriko sistema za las
L = -2*(k+l)*eye(n);
L = L + k*(diag(ones(n-1,1),1)+diag(ones(n-1,1),-1));
L = L + l*(diag(ones(n-5,1),5)+diag(ones(n-5,1),-5));
bz = -mg*ones(n,1);
bx = zeros(n,1);
by = zeros(n,1);
bx(1) = -k*x0(1);
bx(5) = -l*x0(1);
by(1) = -k*x0(2);
by(5) = -l*x0(2);
bz(1) = bz(1) - k*x0(3);
bz(5) = bz(2) - l*x0(3);
x = L\bx;
y = L\by;
z = L\bz;
plot3(x,y,z,'o-')