class Poincare{
 
     final int NUM_SEEDS = 999;
     
     PVector center;
     float dimensions;
     
     Poincare(float x_, float y_, float dims_){
      
           center = new PVector(x_, y_);
           dimensions = dims_;
           
     } 
     
     void function(){
      
           //E = 1/8 plotting y(t) vs. y(t) at values where x(t) = 0
            
           stroke(255, 0, 255);
           strokeWeight(1.0);
           
           for(int r = 0; r < NUM_SEEDS; r++){
             
                 //random x (-0.5, 0.5)
                 
                 double dx0; //
                 
             
           }
           
       
     }
     
     void drawAxis(){
       
           stroke(0);
           strokeWeight(1.0);
           
           line(center.x, center.y - dimensions, center.x, center.y + dimensions);
           line(center.x - dimensions, center.y, center.x + dimensions, center.y);
       
     }
  
}
