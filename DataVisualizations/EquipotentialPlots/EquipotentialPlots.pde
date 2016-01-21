/*

EQUIPOTENTIAL PLOT [COTOUR PLOT]
based on equipotential curve paradigm, known as well 
as isarithm, isopleth or contour line

REFERENCES:
http://mathworld.wolfram.com/EquipotentialCurve.html
http://mathworld.wolfram.com/ContourPlot.html

https://en.wikipedia.org/wiki/Equipotential

http://hsilomedus.me/wp-content/uploads/d3electricField/electricField.html
http://www.cco.caltech.edu/~phys1/java/phys1/EField/EField.html

JAVA:
https://github.com/sushilshah/learnJava/blob/master/Equipotential.java
http://introcs.cs.princeton.edu/java/32class/DeluxeCharge.java.html

[-] Sn elegant way to generate 0.19081358644112711 with Random() seed

@author   Vladimir V. KUCHINOV
@email    helloworld@vkuchinov.co.uk

*/

import java.util.Random;

Equipotential plot;

Random seed = new Random(12345678);

void setup(){
 
   println(Math.random());
   
   size(800, 800);
   hint(ENABLE_RETINA_PIXELS);
   plot = new Equipotential(9);
   
}

void draw(){
  
  //plot.charges.move();
  
  plot.render();
  //plot.updateRatio(map(mouseX, 0, width, 4.0, 100.0));
  //println(plot.charges.get(0).getX());
   
  
}
