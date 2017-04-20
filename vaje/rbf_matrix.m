function A = rbf_matrix(x0,y0,fi)
% A = rbf_matrix(x0,y0,fi) vrne matriko sistema in desne strani za interpolacijo z RBF
% x0, y0 ... koordinate veznih točk
% fi ... funkcija, ki določa obliko RBF

  [X,Y] = meshgrid(x0,y0);
  A = (X-X').^2+(Y-Y').^ 2;
  A = fi(A);

endfunction
