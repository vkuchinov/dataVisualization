class Moire{
  
      PGraphics back, fore;
      
      float x0, y0, x1, y1;
      float alpha = 0.0;
      float scale = 1.0;
      
      Moire(float x0_, float y0_, float x1_, float y1_){
        x0 = x0_; y0 = y0_; x1 = x1_; y1 = y1_;
        back = createGraphics((int)(x1 - x0), (int)(y1 - y0));

        
      }
      
      void generateUniformField(){
        
           back.beginDraw(); 
           back.noStroke(); back.fill(0);
           
           for(int n = 0; n < 50000; n++){

                 int x = (int)random(0, x1 - x0);
                 int y = (int)random(0, y1 - y0);
                 back.ellipse(x, y, 2, 2); 
             
           }

           back.endDraw(); 
           fore = back;
        
      }
      
      void generateStructure(){
        
           back.beginDraw(); 
           back.noStroke(); back.fill(0);
           
           for(int y = (int)y0; y < y1; y += 6){
             for(int x = (int)x0; x < x1; x += 6){
           
               back.ellipse(x, y, 3, 3);
               
             }
           }

           back.endDraw(); 
           fore = back;
        
      }
      
      void draw(){
       
          int mX = (int)map(mouseX, 0, width, -50, 50);
          int mY = (int)map(mouseY, 0, width, -50, 50);
         
          image(back, x0, y0); 
          
          pushMatrix();
          rotate(alpha);
          scale(scale);
          image(fore, x0 + mX, y0 + mY);
          popMatrix();
        
      }
      
      void keyPressed(){
        
        if(keyCode == LEFT) alpha -= 0.001;
        if(keyCode == RIGHT) alpha += 0.001;
        if(keyCode == UP) scale -= 0.02;
        if(keyCode == DOWN) scale += 0.02;
        
      }
      
}
