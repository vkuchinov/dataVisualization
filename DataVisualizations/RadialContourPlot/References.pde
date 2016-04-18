/*

public Jacobi(final double[][] aa)  {
  
    n = aa.length;
    a = buildMatrix(aa);
    v = new double[n][n];
    d = new double[n];
    nrot = 0;
    EPS = DBL_EPSILON;
    
    int i,j,ip,iq;
    double tresh,theta,tau,t,sm,s,h,g,c;
    double[] b = new double[n];
    double[] z = new double[n];

    for (ip=0;ip<n;ip++) {
      for (iq=0;iq<n;iq++) v[ip][iq]=0.0;
      v[ip][ip]=1.0;
    }
    for (ip=0;ip<n;ip++) {
      b[ip]=d[ip]=a[ip][ip];
      z[ip]=0.0;
    }
    for (i=1;i<=50;i++) {
      sm=0.0;
      for (ip=0;ip<n-1;ip++) {
        for (iq=ip+1;iq<n;iq++)
          sm += abs(a[ip][iq]);
      }
      if (sm == 0.0) {
        eigsrt(d,v);
        return;
      }
      if (i < 4)
        tresh=0.2*sm/(n*n);
      else
        tresh=0.0;
      for (ip=0;ip<n-1;ip++) {
        for (iq=ip+1;iq<n;iq++) {
          g=100.0*abs(a[ip][iq]);
          if (i > 4 && g <= EPS*abs(d[ip]) && g <= EPS*abs(d[iq]))
              a[ip][iq]=0.0;
          else if (abs(a[ip][iq]) > tresh) {
            h=d[iq]-d[ip];
            if (g <= EPS*abs(h))
              t=(a[ip][iq])/h;
            else {
              theta=0.5*h/(a[ip][iq]);
              t=1.0/(abs(theta)+sqrt(1.0+theta*theta));
              if (theta < 0.0) t = -t;
            }
            c=1.0/sqrt(1+t*t);
            s=t*c;
            tau=s/(1.0+c);
            h=t*a[ip][iq];
            z[ip] -= h;
            z[iq] += h;
            d[ip] -= h;
            d[iq] += h;
            a[ip][iq]=0.0;
            for (j=0;j<ip;j++)
              rot(a,s,tau,j,ip,j,iq);
            for (j=ip+1;j<iq;j++)
              rot(a,s,tau,ip,j,j,iq);
            for (j=iq+1;j<n;j++)
              rot(a,s,tau,ip,j,iq,j);
            for (j=0;j<n;j++)
              rot(v,s,tau,j,ip,j,iq);
            ++nrot;
          }
        }
      }
      for (ip=0;ip<n;ip++) {
        b[ip] += z[ip];
        d[ip]=b[ip];
        z[ip]=0.0;
      }
    }
    throw new IllegalArgumentException("Too many iterations in routine jacobi");
  }
  
  

*/
