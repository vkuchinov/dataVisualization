/*

TEARDROP CURVE

x = cos(t)
y = sin(t) * sinᵐ(½t)

float x = cos( radians(t) ) * radius;
float y = sin( radians(i) ) * pow(sin(radians(t)/2), m) * radius;


where m is a range of values, for this example from 0 to 7

plot has dimensions of x: -1, 1 and y: -1, 1

REFERENCES:
http://mathworld.wolfram.com/TeardropCurve.html

@author   Vladimir V. KUCHINOV
@email    helloworld@vkuchinov.co.uk

*/

Teardrop curve;

void setup(){
  
     size(600, 600, "processing.core.PGraphicsRetina2D"); 
     background(49);
     translate(width/2, height/2);
     
     curve = new Teardrop(0, 16, 220.0);
     curve.draw();
     
}
