class Pythagorean{
  
      int[][] cc;
      
      Pythagorean(int dimensions_){
        
          cc = new int[dimensions_ * 2 + 1][dimensions_ * 2 + 1];
          
          for(int a = -dimensions_; a <= dimensions_; a++){
                for(int b = -dimensions_; b <= dimensions_; b++){
          
                cc[dimensions_ + a][dimensions_ + b] = -1;
                
                float c = sqrt(a * a + b * b);
                if(abs((int)c - c) < Math.ulp(1.0)) { cc[dimensions_ + a][dimensions_ + b] = 1; }
         
                }
          } 
        
      }
      
      void draw(){
        
          float size = 500.0 / cc.length;
          stroke(0);
          fill(0);
          
          for(int y = 0; y < cc.length; y++){
            for(int x = 0; x < cc[y].length; x++){
              
                if(cc[x][y] == 1) rect(20 + x * size, 20 + y * size, size, size);
            }
          }

      }
      
}
