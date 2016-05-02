/*

MORELLET'S TIRETS

a modified version of the painting Tirets by Francois Morellet, 
small circles seem to appear and disappear as the eye is moved 
over them.

REFERENCES:
http://mathworld.wolfram.com/MorelletsTiretsIllusion.html

@author   Vladimir V. KUCHINOV
@emal     helloworld@vkuchinov.co.uk

*/

Morellets grid;

void setup(){
 
     size(780, 780, "processing.core.PGraphicsRetina2D"); 
  
     grid = new Morellets();
     grid.draw();
     
}
