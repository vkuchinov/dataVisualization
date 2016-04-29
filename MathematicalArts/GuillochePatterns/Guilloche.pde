class Guilloche{

      float resolution = 0.008;
      
      //PARAMETERS
      float R = 256.0;
      float r = -0.25;
      float p = 92.0;
      
      int Q = 3;
      int m = 1;
      int n = 6;
      
      Guilloche(){

      }
      
      void draw(){
        
          stroke(255);
          strokeWeight(0.75);
        
          for(float theta = 0.01; theta < 2 * PI; theta += resolution){
            
               //basic 
//               float x0 = (R + r) * cos(theta -  resolution) + (r + p) * cos ( ((R + r)/r) * (theta - resolution));
//               float y0 = (R + r) * sin(theta -  resolution) - (r + p) * sin ( ((R + r)/r) * (theta -  resolution));
//               
//               float x1 = (R + r) * cos(theta) + (r + p) * cos ( ((R + r)/r) * theta );
//               float y1 = (R + r) * sin(theta) - (r + p) * sin ( ((R + r)/r) * theta );
               
               //modified
               float x0 = (R + r) * cos(m * (theta -  resolution)) + (r + p) * cos ( ((R + r)/r) * m * (theta - resolution)) + Q * cos(n * (theta - resolution));
               float y0 = (R + r) * sin(m * (theta -  resolution)) - (r + p) * sin ( ((R + r)/r) * m * (theta -  resolution)) + Q * sin(n * (theta - resolution));;
               
               float x1 = (R + r) * cos(m * theta) + (r + p) * cos ( ((R + r)/r) * m * theta ) + Q * cos(n * theta);
               float y1 = (R + r) * sin(m * theta) - (r + p) * sin ( ((R + r)/r) * m * theta ) + Q * sin(n * theta);

               line(x0, y0, x1, y1);
            
          }
          
      }
      
}
