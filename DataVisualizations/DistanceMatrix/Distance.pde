class Distance{
  
     float x, y, w, h, step; 
     float min = Float.MAX_VALUE; float max = Float.MIN_VALUE;

     Distance(float x_, float y_, float w_, ArrayList<PVector> points_){
  
           x = x_; y = y_; w = w_; h = w_;
           step = w / points_.size();
           
           setMinMax();
           
     } 
     
     void setMinMax(){
       
           for(int j = 0; j < points.size(); j++){
               for(int i = 0; i < points.size(); i++){
                 
                      float dist = PVector.dist(points.get(i), points.get(j));
                      min = min(min, dist); max = max(max, dist);
                 
               }
           }
            
     }
     
     void draw(){
      
           rectMode(CORNER);
           fill(255);
           noStroke();
           rect(x, y, w, h);
           
           for(int j = 0; j < points.size(); j++){
               for(int i = 0; i < points.size(); i++){
                 
                      PVector p1 = points.get(i);
                      PVector p2 = points.get(j);
                      
                      float dist = PVector.dist(p1, p2);
                      
                      colorMode(HSB);
                      fill(map(dist, min, max, 0, 256), 240, 240);
                      rect(x + i * step, y + j * step, step, step);
                 
               }
           }
       
     }

}
