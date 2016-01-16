class ComplexPlot3D{
  
   int plotWidth, plotHeight, points;
   float offsetX = 0; float offsetY = 0;
   
   float[] rangeX = new float[2];
   float[] rangeY = new float[2];
   
   float minZ = Float.MAX_VALUE; 
   float maxZ = Float.MIN_VALUE;
   
   float[][] plot;
   
   ComplexPlot3D(int w_,int points_, float[] rangeX_, float[] rangeY_){
     
        plotWidth = w_; 
        points = points_;
        
        plot = new float[points_][points_];
        rangeX[0] = rangeX_[0]; rangeX[1] = rangeX_[1];
        rangeY[0] = rangeY_[0]; rangeY[1] = rangeY_[1];
        
        this.function();
    
   } 
   
   void function(){
     
        for(float y = rangeY[0]; y < rangeY[1]; y += (rangeY[1] - rangeY[0]) / points){
            for(float x = rangeX[0]; x < rangeX[1]; x += (rangeX[1] - rangeX[0]) / points){
             
                Complex c = new Complex(x, y);
                
                //function core
                Complex z = c.sin();
                
                //Re(sin[z])
                float result = (float)z.re();
                
                this.set(x, y, result);
              
            }
        } 
   }
   
   void set(float x_, float y_, float z_){
     
        if(z_ < minZ) { minZ = z_; }
        if(z_ > maxZ) { maxZ = z_; }
        
        plot[(int)map(x_, rangeX[0], rangeX[1], 0, points)][(int)map(y_, rangeY[0], rangeY[1], 0, points)] = z_;

   }
   
   void offset(float offsetx_, float offsety_){
     
     offsetX = offsetx_;
     offsetY = offsety_;
     
   }
   
   void display(){
     
        println(minZ, maxZ);
        colorMode(HSB);
        float dim = plotWidth / points;
        
        for(int y = 1; y < plot.length; y++){
          for(int x = 1; x < plot.length; x++){
            
            noStroke();
            IVec pt0 = new IVec(offsetX + (x - 1) * dim, offsetY + (y - 1) * dim, map(plot[x - 1][y - 1], minZ, maxZ, -50, 50));
            IVec pt1 = new IVec(offsetX + (x - 1) * dim, offsetY + (y) * dim, map(plot[x - 1][y], minZ, maxZ, -50, 50));
            IVec pt2 = new IVec(offsetX + (x) * dim, offsetY + (y - 1) * dim, map(plot[x][y - 1], minZ, maxZ, -50, 50));
            IVec pt3 = new IVec(offsetX + x * dim, offsetY + y * dim, map(plot[x][y], minZ, maxZ, -50, 50));
            
            new ISurface(pt0, pt1, pt2, pt3).hsb(map(plot[x][y], minZ, maxZ, 0, 1.0), 0.8, 0.8);
            
          } 
        }
        
   }
   
   void exportData(String url_){
         
        String[] output = new String[plot.length];
        
        for(int y = 0; y < plot.length; y++){
          
          output[y] = "";
          
          for(int x = 0; x < plot.length - 1; x++){
            
            output[y] += str(plot[x][y]) + ", ";
            
          }
          
            output[y] += str(plot[plot.length - 1][y]);
        }
     
        saveStrings("output.txt", output);
   }
  
}
