# Runge-Kutta metoda za reševanje NDE
def rk4(df, t0, tk, y0, n):
    """Funkcija izračuna rešitev začetnega problema za NDE
    y'(t) = df(y,t) z začetnimi pogoji y(t0)=y0 na intervalu [t0,tk]"""
    t = linspace(t0,tk,n+1)
    h = t[1]-t[0]
    y = zeros((len(y0),n+1))
    y[:,0] = y0
    for i in range(n):
        k1 = h*df(y[:,i],t[i])
        k2 = h*df(y[:,i]+k1/2,t[i]+h/2)
        k3 = h*df(y[:,i]+k2/2,t[i+1]+h/2)
        k4 = h*df(y[:,i]+k3,t[i+1])
        y[:,i+1] = y[:,i] + (k1 + 2*k2 + 2*k3 + k4)/6
    return (y,t)
