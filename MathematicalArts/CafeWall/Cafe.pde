class Cafe{
  
      float theta = 0.0;
      int dimensions;
      
      Cafe(int dimensions_){
        
          dimensions = dimensions_;  
        
      }
      
      void draw(){
        
           float gap = width / (float)dimensions;
           float thetaIncrement = 4.0 * PI / dimensions;
           
           for(int y = 0; y < dimensions; y++){
             
             noFill();
             stroke(0);
             line(0, y * gap, width, y * gap);
             
             for(int x = 0; x < dimensions * 1.5; x++){
    
               if(x % 2 == 0){
                   noStroke();
                   fill(0);
                   float shift = cos(theta) * gap;
                   
                   rect(x * gap - shift, y * gap, gap, gap);
               }
               
             }
             
             theta += thetaIncrement;
             
           }
        
      }
      
}
