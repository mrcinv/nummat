M = 110; %masa v kg
S=42; % starost v letih
I=3300; % vnos energije v kcal

a = 293; p = 0.43; b=5.1; % Moški
#a = 248; p = 0.43; b=5.9; % ženske
beta = 0.08;
DIT = beta*I;
RMR = a*M^p - b*S;
E0 = RMR/0.6
NEAT = 0.1*E0;
PA = E0-RMR-DIT;
m = PA/M
C = NEAT-2*(PA+DIT+RMR)

