from numpy import zeros
from numpy.linalg import cholesky,solve,norm

def rbf_int(tocke, rbf, z):
	"""
	Funkcija rbf_int resi interpolacijski problem
	   F(tocke[i]) = z[i]
	z radialnimi baznimi funkcijami oblike
		rbf(norm(x-tocke[i]))
	Vhodni podatki:
	tocke ... nxk tabela n-tock v R^k
	rbf ... funkcija, ki doloca obliko
	z ... predpisane vrednosti v tockah
	Rezultat:
	alpha ... koeficienti v razvoju po RBF
	"""
	# zgradimo matriko sistema
	n,k = tocke.shape
	A = zeros((n,n))
	for i in range(n):
		for j in range(n):
			A[i,j] = rbf(norm(tocke[i,:]-tocke[j,:])**2)
	# razcep choleskega
	try:
		R = cholesky(A)
		U = R.T
                # obratno vstavljanje R*y = z
                y = solve(R,z)
                # direktno vstavljanje R^T*alpha = y
                alpha = solve(R.T,y)
        except:
            #matrika ni pozitivno definitna
            alpha = solve(A,z)
        alpha = solve(A,z)
	
	return alpha
