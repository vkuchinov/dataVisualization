class Poincare{
 
     PVector center;
     float dimensions;
     
     Poincare(float x_, float y_, float dims_){
      
           center = new PVector(x_, y_);
           dimensions = dims_;
           
     } 
     
     void function(){
      
           //E = 1/8 plotting y(t) vs. y(t) at values where x(t) = 0
            
           stroke(255, 0, 255);
           strokeWeight(0.5);
           
       
     }
     
     void drawAxis(){
       
           stroke(0);
           strokeWeight(1.0);
           
           line(center.x, center.y - dimensions, center.x, center.y + dimensions);
           line(center.x - dimensions, center.y, center.x + dimensions, center.y);
       
     }
  
}
