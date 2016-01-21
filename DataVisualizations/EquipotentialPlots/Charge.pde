class Charge{
  
     // electrostatic constant (N m^2 / C^2)
     private static final double ELECTROSTATIC_CONSTANT = 8.99E09;

     //-1: negative
     // 0: neutral
     // 1: positive

     double q;
     
     color[] colors = {#3498DB, #ECF0F1, #E74C3C};
     
     double x, y;
     
     double speedX, speedY;
     
     Charge(double  x_, double y_, double q_){

          x = x_; y = y_; q = q_;
          speedX = Math.random() * 10E-12;
          speedY = Math.random() * 10E-12;          

     } 
     
    double potentialTo(double x_, double y_) {
      
        //V = kq / r
        return ELECTROSTATIC_CONSTANT * q / distanceTo(x_, y_);   
    }

    public double fieldX(double x_, double y_) {
      
        //E  = kq / r^2 > Ex = E * dx / r
        double dx = x_ - this.x;
        double r = distanceTo(x_, y_);
        double E = ELECTROSTATIC_CONSTANT * q / (r * r);  
        return E * dx / r;                               
    }

    public double fieldY(double x_, double y_) {
      
        // E  = kq / r^2 > Ey = E * dy / r
        double dy = y_ - this.y;
        double r = distanceTo(x_, y_);               
        double E = ELECTROSTATIC_CONSTANT * q / (r * r);  
        return E * dy / r;                               
    }

 
    public double distanceTo(double x_, double y_) {
        double dx = x_ - this.x;
        double dy = y_ - this.y;
        return Math.sqrt(dx*dx + dy*dy);
    }


    public boolean isPositivelyCharged() {
        return q > 0;
    }

    public double getX() { return this.x; }
    public double getY() { return this.y; }


    public String toString() {
        return "x: " + this.x + " y: " + this.y + "  charge: " + q;
    }
    
     void draw(float radius_){
          
          //noStroke();
          //fill(colors[(int)polarity + 1]);
          //ellipseMode(CENTER);
          //ellipse(this.x, this.y, radius_, radius_); 
       
     }
  
}

class ChargeList extends ArrayList<Charge>{
  
    final float radius = 12.0;
    
    void draw(){
      
        for(int c = 0; c < this.size(); c++){
            this.get(c).draw(radius);
        }  
      
    }
    
    void move(){
      
        for(int c = 0; c < this.size(); c++){
            if(this.get(c).x < 0 || this.get(c).x > 4.999999858590343E-10) this.get(c).speedX *= -1;
            if(this.get(c).y < 0 || this.get(c).y > 4.999999858590343E-10) this.get(c).speedY *= -1;
            
            this.get(c).x += this.get(c).speedX; this.get(c).y += this.get(c).speedY; 
        }  
      
    }
    
  
}
