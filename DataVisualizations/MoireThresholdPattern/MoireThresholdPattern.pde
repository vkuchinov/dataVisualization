/*

MOIRÉ PATTERN [freaky dots]
with threshold post-processing


REFERENCES:
https://en.wikipedia.org/wiki/Moir%C3%A9_pattern
http://mathworld.wolfram.com/MoirePattern.html
https://www.youtube.com/watch?v=QAja2jp1VjE&index=5&list=PLt5AfwLFPxWI9eDSJREzp1wvOJsjt23H_

@author   Vladimir V. KUCHINOV 
@email    helloworld@vkuchinov.co.uk

*/

Moire pattern;

void setup(){
 
     size(800, 800, "processing.core.PGraphicsRetina2D");
     pattern = new Moire(-300, -300, width + 300, height + 300);
     pattern.generateUniformField();

}

void draw(){
  
      background(0);
      pattern.draw();

    
  
}

void keyPressed(){
  
     pattern.keyPressed();
  
}
