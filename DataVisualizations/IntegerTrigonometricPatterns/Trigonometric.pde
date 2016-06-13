class Trigonometric{
 
      PImage bitmap;
      int size;
      
      int grid [][];

      Trigonometric(int size_){
        
            size = size_;
            bitmap = createImage(size, size, RGB);
            
            grid = new int[size][size];
            
            colorMode(HSB);
            
            for(int y = 0; y < size; y++){
              for(int x = 0; x < size; x++){
                
                float value = sin(x * y);
                value = map(value, -1.0, 1.0, 240, 32);
                
                color c = color(32, 240, value);
                bitmap.set(x, y, c);
         
              }
            }
       
      } 
      

      void draw(){
        
      noSmooth();
      image(bitmap, -width/size, -height/size, width + width/size, height + height/size);
        
      }
      
  
}
