/*
def jtheta(ctx, n, z, q, derivative=0):
    if derivative:
        return ctx._djtheta(n, z, q, derivative)

    z = ctx.convert(z)
    q = ctx.convert(q)
    if abs(q) > ctx.THETA_Q_LIM:
        raise ValueError('abs(q) > THETA_Q_LIM = %f' % ctx.THETA_Q_LIM)

    extra = 10
    if z:
        M = ctx.mag(z)
        if M > 5 or (n == 1 and M < -5):
            extra += 2*abs(M)
    cz = 0.5
    extra2 = 50
    prec0 = ctx.prec
    try:
        ctx.prec += extra
        if n == 1:
            if ctx._im(z):
                if abs(ctx._im(z)) < cz * abs(ctx._re(ctx.log(q))):
                    ctx.dps += extra2
                    res = ctx._jacobi_theta2(z - ctx.pi/2, q)
                else:
                    ctx.dps += 10
                    res = ctx._jacobi_theta2a(z - ctx.pi/2, q)
            else:
                res = ctx._jacobi_theta2(z - ctx.pi/2, q)
        elif n == 2:
            if ctx._im(z):
                if abs(ctx._im(z)) < cz * abs(ctx._re(ctx.log(q))):
                    ctx.dps += extra2
                    res = ctx._jacobi_theta2(z, q)
                else:
                    ctx.dps += 10
                    res = ctx._jacobi_theta2a(z, q)
            else:
                res = ctx._jacobi_theta2(z, q)
        elif n == 3:
            if ctx._im(z):
                if abs(ctx._im(z)) < cz * abs(ctx._re(ctx.log(q))):
                    ctx.dps += extra2
                    res = ctx._jacobi_theta3(z, q)
                else:
                    ctx.dps += 10
                    res = ctx._jacobi_theta3a(z, q)
            else:
                res = ctx._jacobi_theta3(z, q)
        elif n == 4:
            if ctx._im(z):
                if abs(ctx._im(z)) < cz * abs(ctx._re(ctx.log(q))):
                    ctx.dps += extra2
                    res = ctx._jacobi_theta3(z, -q)
                else:
                    ctx.dps += 10
                    res = ctx._jacobi_theta3a(z, -q)
            else:
                res = ctx._jacobi_theta3(z, -q)
        else:
            raise ValueError
    finally:
        ctx.prec = prec0
    return res

*/

/*

def _jacobi_theta2a(ctx, z, q):
    """
    case ctx._im(z) != 0
    theta(2, z, q) =
    q**1/4 * Sum(q**(n*n + n) * exp(j*(2*n + 1)*z), n=-inf, inf)
    max term for minimum (2*n+1)*log(q).real - 2* ctx._im(z)
    n0 = int(ctx._im(z)/log(q).real - 1/2)
    theta(2, z, q) =
    q**1/4 * Sum(q**(n*n + n) * exp(j*(2*n + 1)*z), n=n0, inf) +
    q**1/4 * Sum(q**(n*n + n) * exp(j*(2*n + 1)*z), n, n0-1, -inf)
    """
    n = n0 = int(ctx._im(z)/ctx._re(ctx.log(q)) - 1/2)
    e2 = ctx.expj(2*z)
    e = e0 = ctx.expj((2*n+1)*z)
    a = q**(n*n + n)
    # leading term
    term = a * e
    s = term
    eps1 = ctx.eps*abs(term)
    while 1:
        n += 1
        e = e * e2
        term = q**(n*n + n) * e
        if abs(term) < eps1:
            break
        s += term
    e = e0
    e2 = ctx.expj(-2*z)
    n = n0
    while 1:
        n -= 1
        e = e * e2
        term = q**(n*n + n) * e
        if abs(term) < eps1:
            break
        s += term
    s = s * ctx.nthroot(q, 4)
    return s

@defun
def _jacobi_theta3a(ctx, z, q):
    """
    case ctx._im(z) != 0
    theta3(z, q) = Sum(q**(n*n) * exp(j*2*n*z), n, -inf, inf)
    max term for n*abs(log(q).real) + ctx._im(z) ~= 0
    n0 = int(- ctx._im(z)/abs(log(q).real))
    """
    n = n0 = int(-ctx._im(z)/abs(ctx._re(ctx.log(q))))
    e2 = ctx.expj(2*z)
    e = e0 = ctx.expj(2*n*z)
    s = term = q**(n*n) * e
    eps1 = ctx.eps*abs(term)
    while 1:
        n += 1
        e = e * e2
        term = q**(n*n) * e
        if abs(term) < eps1:
            break
        s += term
    e = e0
    e2 = ctx.expj(-2*z)
    n = n0
    while 1:
        n -= 1
        e = e * e2
        term = q**(n*n) * e
        if abs(term) < eps1:
            break
        s += term
    return s

*/

/*

def mag(ctx, x):
        """
        Quick logarithmic magnitude estimate of a number. Returns an
        integer or infinity `m` such that `|x| <= 2^m`. It is not
        guaranteed that `m` is an optimal bound, but it will never
        be too large by more than 2 (and probably not more than 1).

        **Examples**

            >>> from mpmath import *
            >>> mp.pretty = True
            >>> mag(10), mag(10.0), mag(mpf(10)), int(ceil(log(10,2)))
            (4, 4, 4, 4)
            >>> mag(10j), mag(10+10j)
            (4, 5)
            >>> mag(0.01), int(ceil(log(0.01,2)))
            (-6, -6)
            >>> mag(0), mag(inf), mag(-inf), mag(nan)
            (-inf, +inf, +inf, nan)

        """
        if hasattr(x, "_mpf_"):
            return ctx._mpf_mag(x._mpf_)
        elif hasattr(x, "_mpc_"):
            r, i = x._mpc_
            if r == fzero:
                return ctx._mpf_mag(i)
            if i == fzero:
                return ctx._mpf_mag(r)
            return 1+max(ctx._mpf_mag(r), ctx._mpf_mag(i))
        elif isinstance(x, int_types):
            if x:
                return bitcount(abs(x))
            return ctx.ninf
        elif isinstance(x, rational.mpq):
            p, q = x._mpq_
            if p:
                return 1 + bitcount(abs(p)) - bitcount(q)
            return ctx.ninf
        else:
            x = ctx.convert(x)
            if hasattr(x, "_mpf_") or hasattr(x, "_mpc_"):
                return ctx.mag(x)
            else:
                raise TypeError("requires an mpf/mpc")




*/

/*

 def mag(ctx, z):
        if z:
            return ctx.frexp(abs(z))[1]
        return ctx.ninf

    def isint(ctx, z):
        if hasattr(z, "imag"):   # float/int don't have .real/.imag in py2.5
            if z.imag:
                return False
            z = z.real
        try:
            return z == int(z)
        except:
            return False
            
            
     def frexp(ctx, x):
        r"""
        Given a real number `x`, returns `(y, n)` with `y \in [0.5, 1)`,
        `n` a Python integer, and such that `x = y 2^n`. No rounding is
        performed.

            >>> from mpmath import *
            >>> mp.dps = 15; mp.pretty = False
            >>> frexp(7.5)
            (mpf('0.9375'), 3)

        """
        x = ctx.convert(x)
        y, n = libmp.mpf_frexp(x._mpf_)
        return ctx.make_mpf(y), n
        
        
    def mpf_frexp(x):
    """Convert x = y*2**n to (y, n) with abs(y) in [0.5, 1) if nonzero"""
    sign, man, exp, bc = x
    if not man:
        if x == fzero:
            return (fzero, 0)
        else:
            raise ValueError
    return mpf_shift(x, -bc-exp), bc+exp
    
    def mpf_shift(s, n):
    """Quickly multiply the raw mpf s by 2**n without rounding."""
    sign, man, exp, bc = s
    if not man:
        return s
    return sign, man, exp+n, bc


*/
