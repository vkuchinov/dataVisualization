class Hive{
  
      float data[][][];
      
      color[] c = {color(69, 178, 157), color(239, 201, 76), color(223, 90, 73)};
  
      Hive(){
        
        data = new float [3][2][64];
        
        for(int axis = 0; axis < 3; axis++){
         
            for(int d = 0; d < 64; d++){
              
                 data[axis][0][d] = random(0.05, 0.95);
                 data[axis][1][d] = random(0.05, 0.95);
              
            }
          
        }
       
       
      } 
  
      void draw(){
        
           noFill();
           
           for(int cc = 0; cc < 3; cc++){
           
                float curvatureX1;
                float curvatureY1;
                float curvatureX2;
                float curvatureY2;
                
                strokeWeight(3.0);
                stroke(c[cc]);
                float x = width/2 + cos(radians(-90 + 360.0/3.0*cc)) * 33;
                float y = height/2 + sin(radians(-90 + 360.0/3.0*cc)) * 33;
                
                float x1 = width/2 + cos(radians(-90 + 360.0/3.0*cc)) * 240;
                float y1 = height/2 + sin(radians(-90 + 360.0/3.0*cc)) * 240;
                
                line(x, y, x1, y1);
                
                strokeWeight(0.75);
                for(int d = 0; d < 64; d++){
                  
                     PVector origin = PVector.lerp(new PVector(x, y), new PVector(x1, y1), data[cc][0][d]);
                     point(origin.x, origin.y);
                     
                     if(cc < 2){
                       
                     float xx = width/2 + cos(radians(-90 + 360.0/3.0*(cc+1))) * 33;
                     float yy = height/2 + sin(radians(-90 + 360.0/3.0*(cc+1))) * 33;
                    
                     float xx1 = width/2 + cos(radians(-90 + 360.0/3.0*(cc+1))) * 240;
                     float yy1 = height/2 + sin(radians(-90 + 360.0/3.0*(cc+1))) * 240;
                     
                     float radius = map(max(data[cc][0][d], data[cc][1][d]), 0.05, 0.95, 33, 240);
                     
                     curvatureX1 = width/2 + cos(radians(-90 + 360.0/3.0*cc + 40)) * radius;
                     curvatureY1 = height/2 + sin(radians(-90 + 360.0/3.0*cc + 40)) * radius;
                     curvatureX2 = width/2 + cos(radians(-90 + 360.0/3.0*cc + 80)) * radius;
                     curvatureY2 = height/2 + sin(radians(-90 + 360.0/3.0*cc + 80)) * radius;
                      
                     PVector end = PVector.lerp(new PVector(xx, yy), new PVector(xx1, yy1), data[cc][1][d]);
               
                     bezier(origin.x, origin.y, curvatureX1, curvatureY1, curvatureX2, curvatureY2, end.x, end.y);
      
                  
                  
                     }
                     
                     else {
                     

                       
                     float xx = width/2 + cos(radians(-90)) * 33;
                     float yy = height/2 + sin(radians(-90)) * 33;
                    
                     float xx1 = width/2 + cos(radians(-90)) * 240;
                     float yy1 = height/2 + sin(radians(-90)) * 240;
                     
                     float radius = map(max(data[cc][0][d], data[cc][1][d]), 0.05, 0.95, 33, 240);
                     
                     curvatureX1 = width/2 + cos(radians(-90 + 360.0/3.0*cc + 40)) * radius;
                     curvatureY1 = height/2 + sin(radians(-90 + 360.0/3.0*cc + 40)) * radius;
                     curvatureX2 = width/2 + cos(radians(-90 + 360.0/3.0*cc + 80)) * radius;
                     curvatureY2 = height/2 + sin(radians(-90 + 360.0/3.0*cc + 80)) * radius;
                       
                     PVector end = PVector.lerp(new PVector(xx, yy), new PVector(xx1, yy1), data[cc][1][d]);
                     
                     bezier(origin.x, origin.y, curvatureX1, curvatureY1, curvatureX2, curvatureY2, end.x, end.y);
                  
                     }
                     
                
                }
                
           }
        
      }
}
