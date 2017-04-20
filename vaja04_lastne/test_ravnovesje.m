% testiramo funkcijo ravnovesje na primeru grafa s 6 vozlišči
%              x
%            / | \
%           /  x  \
%          /  / \  \
%         /  x---x  \
%         | /      \|
%         x---------x
% pri katerem so zunanje točke fiksne s koordinatami (0,0), (2,0) in (1,1)
T0 = [0 2 1 0 0 0; 0 0 1 0 0 0];
P = [1 2; 1 3; 1 4; 2 3; 2 5; 3 6; 4 5; 4 6; 5 6]';
fix = [1 2 3];
k = ones(length(P),1);
% poiščimo ravnovesno lego
[T,A] = ravnovesje(T0, P, fix, k);
full(A)
% narisimo graf
figure(1)
plot(T(1,:),T(2,:),'*')
hold on
for k = 1:length(P)
	plot(T(1,P(:,k)),T(2,P(:,k)));
end
hold off
% naslednji primer je naključna triangulacija kvadrata [0,1]x[0,1]
T0=[0 1 1 0; 0 0 1 1]; %oglišča kvadrata in nekaj točk na stranicah
fix = 1:16; % fiksiramo
x = 0.2:0.2:0.8;
nicle = zeros(1,4); enke = ones(1,4);
T0 = [T0 [x x nicle enke; nicle enke x x]]; % dodamo točke na stranicah
T0 = [T0 rand(2,500)]; % množica naključno zbranih točk
tri = delaunay(T0(1,:),T0(2,:)); % tabela trikotnikov
P = unique([tri(:,1:2);tri(:,2:3);tri(:,[1 3])],"rows"); % povezave
k = ones(length(P),1);
% poiščemo ravnovesje
[T,A,flag,iter] = ravnovesje(T0,P',fix,k);
disp(" Število iteracij CG metode"), iter
% narisemo zacetno in ravnovesno pozicijo
figure(2)
axis equal
triplot(tri,T0(1,:),T0(2,:),'b');

figure(3)
axis equal
triplot(tri,T(1,:),T(2,:),'g');

figure(4)
spy(A);

figure(5)
trimesh(tri,T(1,:),T(2,:),T(3,:));