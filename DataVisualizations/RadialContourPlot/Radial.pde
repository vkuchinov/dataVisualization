class Radial{
  
   float radius;
   
   int plotWidth, plotHeight, points;
   float offsetX = 0; float offsetY = 0;
   
   float[] rangeX = new float[2];
   float[] rangeY = new float[2];
   
   float minZ = Float.MAX_VALUE; 
   float maxZ = Float.MIN_VALUE;
   
   float[][] plot;
   
   Radial(int w_,int points_, float[] rangeX_, float[] rangeY_){
     
        plotWidth = w_; 
        radius = w_;
        
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
        
        println(plot.length);
        
        for(int y = 1; y < plot.length; y++){
          for(int x = 1; x < plot.length; x++){
            
            noStroke();
            fill(map(plot[x][y], minZ, maxZ, 0, 255), 240, 240);
            
            float r = sqrt(x*x + y*y);
            float theta = 0.0;
            theta =  tan((float) y / (float)x ); 
            
            float xx = width/2 + sin(theta) * r;
            float yy = height/2 + cos(theta) * r;
   
            rect(xx, yy, dim*1.5, dim*1.5);
            
          }
        }
        
   }

}
