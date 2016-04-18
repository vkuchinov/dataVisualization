class Teardrop{
  
      int[] m = new int[2];
      float radius;
      float ratioY = 0.66;
      
      Teardrop(int m0_, int m1_, float radius_){
       
            m[0] = m0_; m[1] = m1_;
            radius = radius_;
       
      } 
      
      void draw(){
        
           colorMode(HSB);
           noStroke();
        
           for(int p = m[0]; p < m[1]; p++){
               
               fill(map(p, m[0], m[1], 0, 255), 240, 240);
               beginShape();
             
               for(int t = 0; t < 360; t++){
                 
                 float x = cos( radians(t) ) * radius;
                 float y = sin( radians(t) ) * pow(sin(radians(t)/2.0), p) * radius * ratioY;
                 
                 vertex(x, y);
                 
               }
               
               endShape(CLOSE);
           }
        
      }
  
}
