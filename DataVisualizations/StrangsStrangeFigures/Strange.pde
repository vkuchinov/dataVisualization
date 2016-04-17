class Strange{
  
      float range;
      int n;
      int func;
      float tanMin = Float.MAX_VALUE;
      float tanMax = Float.MIN_VALUE;
      
      Strange(float range_, int n_, int func_){
       
           n = n_; range = range_; func = func_;
           
           for(int t = 0; t < n; t++){
             
                min(tanMin, tan(t));
                max(tanMax, tan(t));
                
           }
              
      } 
      
      float function(int value_){
        
          switch(func){
            
          case 0: //sin(n): -1, 1
          return map(sin(value_), -range, range, 150, height - 150);
          
          case 1: //tan(n): doesn't have min, max 
          return map(tan(value_), -range, range, 150, height - 150);
          
          case 2: //csc(n) [cosecant]
          return map(1.0/sin(value_), -range, range, 150, height - 150);
          
          default:
          return map(sin(value_), -1, 1, 150, height - 150);

          
          }
          
      }
      
      void draw(){
        
          stroke(0);
          strokeWeight(1.5);
          line(50, height/2, width - 50, height/2);
          line(50, 100, 50, height - 100);
          
          strokeWeight(3.0);
          stroke(255, 0, 0);
          
          for(int p = 0; p < n; p++){
         
                float x = map(p, 0, n, 50, width - 50);
                float y = function(p);
                
                if(y > 150 && y < width - 150) point(x, y);
            
          }
          
      }
  
}
