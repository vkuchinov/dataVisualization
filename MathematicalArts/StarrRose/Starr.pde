class Starr{
  
      float a, b, c;
      float radius = 99.9;
      
      Starr(float a_, float b_, float c_){
        
            a = a_; b = b_; c = c_;
            
      }
      
      void draw(){
       
           colorMode(HSB);
           
           for(float r = 0; r < radius; r += 4.0){
               
               stroke(map(r, 0, radius, 255, 0), 240, 240);
               
               for(float angle = 0.0; angle < 360.0; angle+= 1.0){
                 
               double k = 2 + Math.sin( a * radians(angle) ) / 2.0;
               double tt = radians(angle) + Math.sin( b * radians(angle) ) / c;
     
               float x  = width/2 + (float)(r * k * Math.cos( tt ));
               float y =  height/2 + (float)(-(r * k * Math.sin( tt )));
           
               point(x, y);
              
               }
           }
      }
  
}
