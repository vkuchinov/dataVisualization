class Spirolateral{
  
      int segments;
      float angle;  
      int[] reversals;
      
      float len = 12.0;
      ArrayList<PVector> points = new ArrayList<PVector>();
      
      Spirolateral(int segments_, float angle_, int[] reversals_){
       
            segments = segments_;
            angle = radians(angle_);
            reversals = reversals_;
        
      }
      
      void calculate(int K_){
        
            double EPSILON = Math.ulp(1.0);
            
            double x, y, i, j, k, n, minx, maxx, miny, maxy, angleMulti, currentAngle;
                   x = y = i = j = k = n = minx = maxx = miny = maxy = angleMulti = 0.0;
        
            for(int K = 0; K < K_; K++){
              
                  currentAngle = angleMulti * angle;
                  x += n * Math.cos(currentAngle);
                  y += n * Math.sin(currentAngle);
                  
                  points.add(new PVector((float)x, (float)y));

                  //minx = min(minx, x); maxx = max(maxx, x);
                  //miny = min(miny, y); maxy = max(maxy, y);
            
            }
        
      }
      
      void draw(){
        
        noFill();
        beginShape();
        for(PVector p : points) vertex(p.x, p.y);
        endShape(CLOSE);
        
      }

}
