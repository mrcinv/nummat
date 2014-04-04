def qr(A):
    """Funkcija qr(A) vrne QR razcep matrike A
    Vhod:
        A ... nxm matrika
    Rezultat:
        Q ... nxm matrika Q.T*Q = Id
        R ... mxm zgornje trikotna matrika
    """
    n,m = A.shape
    R = A.copy()
    Q = vstack((eye(m),zeros((n-m,m))))
    for i in range(m-1):
        x = R[i:,[i]]
        e1 = zeros(x.shape); e1[0] = 1
        # vektor preko katerega zrcalimo
        u = x - sign(x[0])*norm(x)*e1
        uTu = u.T.dot(u)
        if uTu < 1e-15:
            # če sta vektorja e1 in x kolinearna
            # smo že opravili
            continue
        # prezrcalimo preostanek matrike 
        R[i:,i:] = R[i:,i:] - 2*u.dot(u.T.dot(R[i:,i:]))/uTu
        # prezrcalimo še I
        Q[i:,i:] = Q[i:,i:] - 2*u.dot(u.T.dot(Q[i:,i:]))/uTu
    return (Q,R)
