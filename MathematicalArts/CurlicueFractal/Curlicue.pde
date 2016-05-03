class Curlicue{
   
      int MAX_STEPS;

      double s;
      double theta, phi;
      
      double x0, y0, x1, y1;
      
      double scale = 4.0;
      
      ArrayList<PVector> points = new ArrayList<PVector>();
      
      Curlicue(int steps_){

           MAX_STEPS = steps_;
           theta = 0.0;
           phi = 0.0;
           
           s = 4.66920160910299;
           
           x0 = 0.0; y0 = 0.0;
           
           for(int n = 0; n < MAX_STEPS; n++){
           
                  x1 = x0 + Math.cos(phi) * scale;
                  y1 = y0 + Math.sin(phi) * scale;
                  
                  points.add(new PVector((float)x1, (float)y1));
                  
                  x0 = x1; y0 = y1;
                  
                  phi = (theta + phi) % (2.0 * Math.PI);
                  theta = (theta + 2.0 * Math.PI * s) % (2.0 * Math.PI);
             
           }
            
      }
      
       Curlicue(int steps_,float s_){

           MAX_STEPS = steps_;
           theta = 0.0;
           phi = 0.0;
           
           s = s_;
           
           x0 = 0.0; y0 = 0.0;
           
           for(int n = 0; n < MAX_STEPS; n++){
           
                  x1 = x0 + Math.cos(phi) * scale;
                  y1 = y0 + Math.sin(phi) * scale;
                  
                  points.add(new PVector((float)x1, (float)y1));
                  
                  x0 = x1; y0 = y1;
                  
                  phi = (theta + phi) % (2.0 * Math.PI);
                  theta = (theta + 2.0 * Math.PI * s) % (2.0 * Math.PI);
             
           }
            
      }
      
      void draw(){
 
           for(int p = 1; p < points.size(); p++){
            
                line(points.get(p - 1).x, points.get(p - 1).y, points.get(p).x, points.get(p).y); 
           }
        
      }
      
}
