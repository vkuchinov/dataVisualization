/*

DISTANCE MATRIX CLASS

REFERENCE:
https://en.wikipedia.org/wiki/Distance_matrix
http://mathworld.wolfram.com/GraphDistanceMatrix.html

FURTHER READINGS:
http://mathworld.wolfram.com/ResistanceDistance.html

@author    Vladimir V. KUCHINOV
@email     helloworld@vkuchinov.co.uk

*/

import java.util.Random;

ArrayList<PVector> points = new ArrayList<PVector>();
Random seed = new Random(12345);

void setup(){
  
     size(600, 600, "processing.core.PGraphicsRetina2D"); 
     
     for(int p = 0; p < 32; p++){
           points.add(new PVector(seed.nextInt(256), seed.nextInt(256))); 
     }
     
     Distance matrix = new Distance(100, 100, 400, points);
     matrix.draw();
     
}
