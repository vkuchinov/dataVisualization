class Complex{
  
 private final double re;   // the real part
 private final double im;   // the imaginary part

 Complex(double re_, double im_){
  
    re = re_; im = im_;
  
 } 
 
 Complex(Complex z_, float r_, float phi_){
  
    re = Math.cos(phi_) * r_;
    im = Math.sin(phi_) * r_;
  
 }
 
 public double re() { return re; }
 public double im() { return im; }
    
 public String toString() {
   
    if (im == 0) return re + "";
    if (re == 0) return im + "i";
    if (im <  0) return re + " - " + (-im) + "i";
    return re + " + " + im + "i";
    
 }
 
 public double modulus()   { return Math.sqrt(re*re + im*im); }                 // |z|: a moodulus 
 public double argument() { return Math.atan2(im, re); }                        // arg(z):A an argument, ϕ(-PI, PI)
 public float  argumentDegrees() { return degrees((float)Math.atan2(im, re)); }  // in degrees
 
 public double modulus2()   { 
 if (this.im() > 0) {
            return Math.atan2(this.im(), this.re());
        }
        else {
            return Math.atan2(this.im(), this.re()) + 2. * PI;
        }
 }  
 
 public Complex conjugate() {  return new Complex(re, -im); }
 
 public Complex plus(Complex b) {
        Complex a = this;             
        double real = a.re + b.re;
        double imag = a.im + b.im;
        return new Complex(real, imag);
    }
    
 public Complex minus(Complex b) {
        Complex a = this;
        double real = a.re - b.re;
        double imag = a.im - b.im;
        return new Complex(real, imag);
    }
    
    
 public Complex times(Complex b) {
        Complex a = this;
        double re_ = a.re * b.re - a.im * b.im;
        double im_ = a.re * b.im + a.im * b.re;
        return new Complex(re_, im_);
    }
    
 //scalar multiplication
 public Complex times(double alpha) {
        return new Complex(alpha * re, alpha * im);
    }
  
 public Complex divides(Complex b) {
        Complex a = this;
        return a.times(b.reciprocal());
    }
    
 //       _   _
 // 1/Z = Z/Z*Z = x / (x² + y²) - y / (x² + y²) * i
 public Complex reciprocal() {
        double scale = re*re + im*im;
        return new Complex(re / scale, -im / scale);
    }
    
 public Complex exp() {
        return new Complex(Math.exp(re) * Math.cos(im), Math.exp(re) * Math.sin(im));
    }
    
 public Complex sin() {
        return new Complex(Math.sin(re) * Math.cosh(im), Math.cos(re) * Math.sinh(im));
    }


 public Complex cos() {
        return new Complex(Math.cos(re) * Math.cosh(im), -Math.sin(re) * Math.sinh(im));
    }

    
 public Complex tan() {
        return sin().divides(cos());
    }
 
}
