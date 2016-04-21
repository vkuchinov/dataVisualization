/*

TESTING VALUES:

    0.1:    0.00658465       should be sqrt(0.1)
    0.3:    0.0222774        ...
    0.5:    0.0432139
    0.7:    0.0746899
    0.9:    0.140173
    0.99:   0.262196

*/

//mag(x): Quick logarithmic magnitude estimate of a number. 
//        Returns an integer or infinity mm such that |x|<=2m|x|<=2m.

//def jtheta(n, z, q, derivative: false):
double jtheta(int n_, double z_, double q_, boolean derivative_){
  
    final double THETA_Q_LIM = 10e-7;
    
    double res = 0.0;
    
    double extra = 10.0;
    double cz = 0.5;
    double extra2 = 50.0;
    
    
    return res;
    
}


//correct
double jtheta_1(double z_, double q_, boolean verbose_){
  
     final double EPSILON = 2.22045e-16;
     
     double factor0, factor1, factor2;
     
     double k = Math.sqrt(q_);
     double q = EllipticNomeQ(k);

     if(verbose_) println("tk:", k, "tq:", q);
     if(Math.abs(q) >= 1.0) println("error");

     double sum = 0.0;
     double term = 0.0;

     if(z_ == 0.0) { if(verbose_) { println("elliptic.jacobi_theta_1: z == 0, return 0"); } return 0.0; }
     else if(q == 0.0) { if(verbose_) { println("elliptic.jacobi_theta_1: q == 0, return 0"); } return 0.0; }
     else{
       
          if(verbose_) println("ellipticl.jacobi_theta_1: calculating");
          
          while(true){
            if(term % 2 == 0) factor0 = 1.0; else factor0 = -1.0;
      
            factor1 = Math.pow(q, (term*(term + 1.0)));
            factor2 = Math.sin((2*term + 1.0)*z_);

            double term_n = factor0 * factor1 * factor2;
            sum = sum + term_n;
            
            if(verbose_) println("tTerm:", term, "tterm_n:", term_n, "tsum:", sum);
            if(factor1 == 0.0) break;         
            if(factor2 != 0){ if(Math.abs(term_n) < EPSILON) break; }

            term = term + 1;
          }
          
          return 2*Math.pow(q, 0.25)*sum;
        
        }
  
}


//correct
double EllipticNomeQ(double k_){

  if( k_ == 0 ) return 0.0;
  else if(k_ == 1 ) return 1.0;
  else {
    
      double kPrimeSquared = 1.0 - Math.pow(k_, 2.0);
      double top = ellipk(kPrimeSquared);
      double bottom = ellipk(Math.pow(k_, 2.0));
      
      double argument = -1.0 * Math.PI * top / bottom;
      
      return Math.exp(argument);
      
  }

}

//correct
double ellipk(double x_){
 
 
 if(x_ == 1.0) return Double.POSITIVE_INFINITY;
 else if(x_ == Double.NaN) return x_;
 else if(x_ == Double.POSITIVE_INFINITY || x_ == Double.NEGATIVE_INFINITY) return 1.0 / x_;
 else{
   
    double s = Math.sqrt(x_);
    double a = (1.0 - s) / (1.0 + s);
     

     //if isinstance(m, mpf) and m < 1: return v.re()
     //for k_ = 0.1, x_ < 1!
     double v = Math.PI / 4.0 * ( 1.0 + a ) / agm(1.0, a);

    return v;
 } 
  
}

//correct
double agm(double a_,double b_){
  
   final double EPSILON = 2.22045e-16;
    
    while (Math.abs(a_- b_) >= EPSILON){
           double aTemp = (a_ + b_)/2.0;
            b_ = Math.sqrt(a_ * b_);
            a_ = aTemp;
    }
    return a_;
}

int mag(double x_){
  
 
     return 1;
     
}

