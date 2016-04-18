class Haferman{
  
      int MAX_LEVELS;
      int[][] cells;
      int level = 0;
      
      Haferman(int max_levels_){
       
            MAX_LEVELS = max_levels_;
            cells = new int[1][1];
            cells[0][0] = 1;
      } 
      
      void weave(int level_){
        
          int[][] tmpCells = new int[cells.length * 3][cells.length * 3];
          
          for(int i = 0; i < cells.length; i++){
            for(int j = 0; j < cells[i].length; j++){
              
                  if(cells[j][i] == 0){
                   
                      //central
                      tmpCells[j*3 + 1][i*3 + 1] = 1;
                      
                      tmpCells[j*3][i*3] = 1;
                      tmpCells[j*3][i*3 + 1] = 1;
                      tmpCells[j*3][i*3 + 2] = 1;
                      tmpCells[j*3 + 1][i*3] = 1;
                      tmpCells[j*3 + 1][i*3 + 2] = 1;
                      tmpCells[j*3 + 2][i*3] = 1;
                      tmpCells[j*3 + 2][i*3 + 1] = 1;
                      tmpCells[j*3 + 2][i*3 + 2] = 1;
                      
                    
                  } else {
                    
                      //central
                      tmpCells[j*3 + 1][i*3 + 1] = 0;
                      
                      tmpCells[j*3][i*3] = 0;
                      tmpCells[j*3][i*3 + 1] = 1;
                      tmpCells[j*3][i*3 + 2] = 0;
                      tmpCells[j*3 + 1][i*3] = 1;
                      tmpCells[j*3 + 1][i*3 + 2] = 1;
                      tmpCells[j*3 + 2][i*3] = 0;
                      tmpCells[j*3 + 2][i*3 + 1] = 1;
                      tmpCells[j*3 + 2][i*3 + 2] = 0;
                    
                  }
            }
          }
          
          cells = tmpCells;
          
          if(level_ < MAX_LEVELS) this.weave(level_ + 1);
        
      }
      
      void draw(){
        
            float size = width / (float)cells.length;
            
            for(int y = 0; y < cells.length; y++){
              for(int x = 0; x < cells[y].length; x++){
                
                  color c = color(0);
                  if(cells[x][y] == 0) c = color(255);
                  
                  noStroke();
                  fill(c);
                  rect(x * size, y * size, size, size);
                
              }
            }
        
      }
  
}
