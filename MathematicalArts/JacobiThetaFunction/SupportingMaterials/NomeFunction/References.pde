/*

def nome(ctx, m):
    m = ctx.convert(m)
    if not m:
        return m
    if m == ctx.one:
        return m
    if ctx.isnan(m):
        return m
    if ctx.isinf(m):
        if m == ctx.ninf:
            return type(m)(-1)
        else:
            return ctx.mpc(-1)
    a = ctx.ellipk(ctx.one-m)
    b = ctx.ellipk(m)
    v = ctx.exp(-ctx.pi*a/b)
    if not ctx._im(m) and ctx._re(m) < 1:
        if ctx._is_real_type(m):
            return v.real
        else:
            return v.real + 0j
    elif m == 2:
        v = ctx.mpc(0, v.imag)
    return v
    
 */
 
 /*
 
 def calculate_nome(k):
    """
    Calculate the nome, q, from the value for k.

    Useful factoids:

    k**2 = m;   m is used in Abramowitz
    """
    k = convert_lossless(k)

    if k > mpf('1'):             # range error
        raise ValueError

    zero = mpf('0')
    one = mpf('1')

    if k == zero:
        return zero
    elif k == one:
        return one
    else:
        kprimesquared = one - k**2
        kprime = sqrt(kprimesquared)
        top = ellipk(kprimesquared)
        bottom = ellipk(k**2)

        argument = mpf('-1')*pi*top/bottom

        nome = exp(argument)
        return nome
        
 
 */
 
 /*
 
 ellipk(x);
 
 def ellipk(m):
    """Complete elliptic integral of the first kind, K(m). Note that
    the argument is the parameter m = k^2, not the modulus k."""
    # Poor implementation:
    # return pi/2 * sum_hyp2f1_rat((1,2),(1,2),(1,1), m)
    if m == 1:
        return inf
    if isnan(m):
        return m
    if isinf(m):
        return 1/m
    s = sqrt(m)
    a = (1-s)/(1+s)
    v = pi/4*(1+a)/agm(1,a)
    if isinstance(m, mpf) and m < 1:
        return v.real
    return v

 */
 
 
/*

Arithmetic-geometric mean of a and b. Can be called with
a single argument, computing agm(a,1) = agm(1,a)."""
    
def agm(a, b=1):
    
    if not a or not b:
        return a*b
    weps = eps * 16
    half = mpf(0.5)
    while abs(a-b) > weps:
        a, b = (a+b)*half, (a*b)**half
    return a


*/

/*

 public static void agm (double a, double g){
                double a1 = a;
                double g1 = g;
                while (Math.abs(a1-g1) >= Math.pow(10, -14)){
                        double aTemp = (a1+g1)/2.0;
                        g1 = Math.sqrt(a1*g1);
                        a1 = aTemp;
                }
                System.out.println(a1);
        }

*/

/*






*/

/*

def jacobi_theta_1(z, m, verbose=False):
    """
    Implements the jacobi theta function 1, using the series expansion
    found in Abramowitz & Stegun [1].

    z is any complex number, but only reals here?
    m is the parameter, which must be converted to the nome
    """
    if verbose:
        print >> sys.stderr, 'elliptic.jacobi_theta_1'

    m = convert_lossless(m)
    z = convert_lossless(z)

    k = sqrt(m)
    q = calculate_nome(k)

    if verbose:
        print >> sys.stderr, '\tk: %f ' % k
        print >> sys.stderr, '\tq: %f ' % q

    if abs(q) >= mpf('1'):
        raise ValueError

    sum = 0
    term = 0                                    # series starts at 0

    minusone = mpf('-1')
    zero = mpf('0')
    one = mpf('1')

    if z == zero:
        if verbose:
            print >> sys.stderr, 'elliptic.jacobi_theta_1: z == 0, return 0'
        return zero
    elif q == zero:
        if verbose:
            print >> sys.stderr, 'elliptic.jacobi_theta_1: q == 0, return 0'
        return zero
    else:
        if verbose:
            print >> sys.stderr, 'ellipticl.jacobi_theta_1: calculating'
        while True:
            if (term % 2) == 0:
                factor0 = one
            else:
                factor0 = minusone

            factor1 = q**(term*(term +1))
            factor2 = sin((2*term + 1)*z)

            term_n = factor0 * factor1 * factor2
            sum = sum + term_n
            if verbose:
                print >> sys.stderr, '\tTerm: %d' % term,
                print >> sys.stderr, '\tterm_n: %e' % term_n,
                print >> sys.stderr, '\tsum: %e' % sum

            if factor1 == zero:         # all further terms will be zero
                break
            if factor2 != zero:         # check precision iff cos != 0
                #if log(term_n, '10') < -1*mpf.dps:
                if abs(term_n) < eps:
                    break

            term = term + 1

        return (2*q**(0.25))*sum

    # can't get here
    print >> sys.stderr, 'elliptic.jacobi_theta_1 in impossible state'
    sys.exit(2)

def jacobi_theta_2(z, m, verbose=False):
    """
    Implements the jacobi theta function 2, using the series expansion
    found in Abramowitz & Stegun [4].

    z is any complex number, but only reals here?
    m is the parameter, which must be converted to the nome
    """
    if verbose:
        print >> sys.stderr, 'elliptic.jacobi_theta_2'

    m = convert_lossless(m)
    z = convert_lossless(z)

    k = sqrt(m)
    q = calculate_nome(k)

    if verbose:
        print >> sys.stderr, '\tk: %f ' % k
        print >> sys.stderr, '\tq: %f ' % q

    if abs(q) >= mpf('1'):
        raise ValueError

    sum = 0
    term = 0                    # series starts at zero

    zero = mpf('0')

    if q == zero:
        if verbose:
            print >> sys.stderr, 'elliptic.jacobi_theta_2: q == 0, return 0'
        return zero
    else:
        if verbose:
            print >> sys.stderr, 'elliptic.jacobi_theta_2: calculating'
        if z == zero:
            factor2 = mpf('1')
            while True:
                factor1 = q**(term*(term + 1))
                term_n = factor1            # suboptimal, kept for readability
                sum = sum + term_n

                if verbose:
                    print >> sys.stderr, '\tTerm: %d' % term,
                    print >> sys.stderr, '\tterm_n: %e' % term_n,
                    print >> sys.stderr, '\tsum: %e' % sum

                if factor1 == zero:         # all further terms will be zero
                    break
                #if log(term_n, '10') < -1*mpf.dps:
                if abs(term_n) < eps:
                    break

                term = term + 1
        else:
            while True:
                factor1 = q**(term*(term + 1))
                if z == zero:
                    factor2 = 1
                else:
                    factor2 = cos((2*term + 1)*z)

                term_n = factor1 * factor2
                sum = sum + term_n

                if verbose:
                    print >> sys.stderr, '\tTerm: %d' % term,
                    print >> sys.stderr, '\tterm_n: %e' % term_n,
                    print >> sys.stderr, '\tsum: %e' % sum

                if factor1 == zero:         # all further terms will be zero
                    break
                if factor2 != zero:         # check precision iff cos != 0
                    #if log(term_n, '10') < -1*mpf.dps:
                    if abs(term_n) < eps:
                        break

                term = term + 1

        return (2*q**(0.25))*sum

    # can't get here
    print >> sys.stderr, 'elliptic.jacobi_theta_2 in impossible state'
    sys.exit(2)

def jacobi_theta_3(z, m):
    """
    Implements the jacobi theta function 2, using the series expansion
    found in Abramowitz & Stegun [4].

    z is any complex number, but only reals here?
    m is the parameter, which must be converted to the nome
    """
    m = convert_lossless(m)
    z = convert_lossless(z)

    k = sqrt(m)
    q = calculate_nome(k)

    if abs(q) >= mpf('1'):
        raise ValueError

    delta_sum = 1
    term = 1                    # series starts at 1

    zero = mpf('0')
    sum = zero

    if z == zero:
        factor2 = mpf('1')
        while True:

            factor1 = q**(term*term)
            term_n = factor1                # suboptimal, kept for readability
            sum = sum + term_n

            if factor1 == mpf('0'):      # all further terms will be zero
                break
            #if log(term_n, '10') < -1*mpf.dps:
            if abs(term_n) < eps:
                break

            term = term + 1

    else:
        while True:
            factor1 = q**(term*term)
            if z == zero:
                factor2 = 1
            else:
                factor2 = cos(2*term*z)

            term_n = factor1 * factor2
            sum = sum + term_n

            if factor1 == mpf('0'):      # all further terms will be zero
                break
            if factor2 != mpf('0'):      # check precision iff cos != 0
                #if log(term_n, '10') < -1*mpf.dps:
                if abs(term_n) < eps:
                    break

            term = term + 1

    return 1 + 2*sum

def jacobi_theta_4(z, m):
    """
    Implements the series expansion of the jacobi theta function
    1, where z == 0.

    z is any complex number, but only reals here?
    m is the parameter, which must be converted to the nome
    """
    m = convert_lossless(m)
    z = convert_lossless(z)

    k = sqrt(m)
    q = calculate_nome(k)

    if abs(q) >= mpf('1'):
        raise ValueError

    sum = 0
    delta_sum = 1
    term = 1                    # series starts at 1

    zero = mpf('0')

    if z == zero:
        factor2 = mpf('1')
        while True:
            if (term % 2) == 0:
                factor0 = 1
            else:
                factor0 = -1
            factor1 = q**(term*term)
            term_n = factor0 * factor1 * factor2
            sum = sum + term_n

            if factor1 == mpf('0'):      # all further terms will be zero
                break
            #if log(term_n, '10') < -1*mpf.dps:
            if abs(term_n) < eps:
                break

            term = term + 1
    else:
        while True:
            if (term % 2) == 0:
                factor0 = 1
            else:
                factor0 = -1
            factor1 = q**(term*term)
            if z == zero:
                factor2 = 1
            else:
                factor2 = cos(2*term*z)

            term_n = factor0 * factor1 * factor2
            sum = sum + term_n

            if factor1 == mpf('0'):      # all further terms will be zero
                break
            if factor2 != mpf('0'):      # check precision iff cos != 0
                #if log(term_n, '10') < -1*mpf.dps:
                if abs(term_n) < eps:
                    break

            term = term + 1

    return 1 + 2*sum

*/
