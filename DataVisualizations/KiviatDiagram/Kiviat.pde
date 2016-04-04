class Kiviat{
  
     int n; //number of radials
     float radius;
     float max = Float.MIN_VALUE;
     float min = Float.MAX_VALUE;
     
     float data[][];
     
     Kiviat(int n_, float radius_){
      
            n = n_;
            radius = radius_;
            
     } 

     Kiviat(int n_, float radius_, float[][] data_){
      
            n = n_;
            radius = radius_;
            
            data = data_;
            
            for(int l = 0; l < data.length; l++){
                  
                  float innerMin = min(data_[l]); float innerMax = max(data_[l]);
                  min = min(min, innerMin); max = max(max, innerMax);
            }
     }
     
     void draw(){
       
         
         for(float a = 0.0; a < 360.0; a += 360.0 / n){
          
              float x = width/2 + cos(radians(-90 + a)) * radius;
              float y = height/2 + sin(radians(-90 + a)) * radius;
             
              strokeWeight(1.5);
              line(width/2, height/2, x, y);     
           
         }
         
         colorMode(HSB);
         
         for(int l = 0; l < data.length; l++){
           
               int count = 0;

               fill(map(l, 0, data.length, 0, 255), 240, 240, 64);
               strokeWeight(2.0);
               stroke(map(l, 0, data.length, 0, 255), 240, 240, 128);
         
               beginShape();
               
               for(float a = 0.0; a < 360.0; a += 360.0 / n){
                
                    float x = width/2 + cos(radians(-90 + a)) * map(data[l][count], min, max, 50.0, radius - 50.0);
                    float y = height/2 + sin(radians(-90 + a)) * map(data[l][count], min, max, 50.0, radius - 50.0);
                   
                    vertex(x, y);
                    count++;
          
               }
               
               endShape(CLOSE);
         
         }
       
     }
}
