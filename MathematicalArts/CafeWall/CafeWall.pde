/*

CAFÉ WALL ILLUSION

The café wall illusion, sometimes also called the Münsterberg 
illusion (Ashton Raggatt McDougall 2006), is an optical illusion 
produced by a black and white rectangular tessellation when 
the tiles are shifted in a zigzag pattern, as illustrated above. 

While the pattern seems to diverge towards the upper and lower 
right corners in the upper figure, the gray lines are actually 
parallel. Interestingly, the illusion greatly diminishes if black 
lines are used instead of gray.

REFERENCES:
http://mathworld.wolfram.com/CafeWallIllusion.html

@author  Vladimir V. KUCHINOV
@email   helloworld@vkuchinov.co.uk

*/

void setup(){
 
     size(700, 700);
     background(255);
     
     Cafe wall = new Cafe(16);
     wall.draw();
  
}
