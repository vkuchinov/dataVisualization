class Hinton{
    
     float[][] data;
     float max, min;
     
     float margins;
     float dimensions;
     
     Hinton(float[][] data_, float min_, float max_, float dimensions_, float margins_){
       
           data = data_;
           dimensions = dimensions_;
           margins = margins_;
           
           min = min_; max = max_;
       
     }
     
     void draw(){
       
         noStroke();
         //fill(255);
         rectMode(CENTER);
         //rect(width/2, height/2, dimensions, dimensions);
         
         for(int j = 0; j < data.length; j++){
           for(int i = 0; i < data.length; i++){
             
               color c = color(0);
               if(data[i][j] <= 0) c = color(255); //if value is negative
               
               fill(c);
               float size = map(abs(data[i][j]), 0, max, 0, dimensions / data.length);
               rect(margins + dimensions / data.length * j +  dimensions / data.length / 2, margins + dimensions / data.length * i + dimensions / data.length / 2, size, size);
           }
         }
       
     }
  
}
