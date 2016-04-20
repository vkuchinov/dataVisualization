/*

TESTING VALUES:

    0.1:    0.00658465       should be sqrt(0.1)
    0.3:    0.0222774        ...
    0.5:    0.0432139
    0.7:    0.0746899
    0.9:    0.140173
    0.99:   0.262196

*/

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

