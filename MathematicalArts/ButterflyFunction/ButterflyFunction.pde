/*

BUTTERFLY FUNCTION
a fractal-like two-dimensional function

"a" is 'edge sharpness' parameter

f(x,y)=((x^2-y^2)sin((x+y)/a))/(x^2+y^2)

@author Vladimir V. KUCHINOV
@email  helloworld@vkuchinov.co.uk

*/

final float RANGE = 4.0;

float min = Float.MAX_VALUE;
float max = Float.MIN_VALUE;
float a = 0.99;


void setup(){
 
     size(500, 500);
     colorMode(HSB);
     noStroke();
    
            
     for(float y = -RANGE; y < RANGE; y += (2.0 * RANGE / width)){
       for(float x = -RANGE; x < RANGE; x += (2.0 * RANGE / height)){

       float f = ((pow(x, 2.0) - pow(y, 2.0)) * sin ( x + y ) / a) / (pow(x, 2.0) + pow(y, 2.0));
       
       fill(map(f, -1.0, 1.0, 0, 255), 240, 240);

       float xx = map(x, -RANGE, RANGE, 0, width);
       float yy = map(y, -RANGE, RANGE, 0, height);
       
       rect(xx, yy, 1, 1);
       
       }
     }
   
}
