/*

HINTON DIAGRAM

Hinton diagrams are useful for visualizing the values of a 2D array:

Positive and negative values are represented by white and black 
squares, respectively, and the size of each square represents 
the magnitude of each value.

It is a popular way of visualizing numerical values in 
a matrix/vector, popular in the neural networks and machine 
learning literature. 

REFERENCES:
http://tonysyu.github.io/mpltools/auto_examples/special/plot_hinton.html
http://cse22-iiith.vlabs.ac.in/exp2/index.html

http://cse22-iiith.vlabs.ac.in/exp2/images/figA2.jpg

@author  Vladimir V. KUCHINOV
@email   helloworld@vkuchinov.co.uk

*/

final int DIMENSIONS = 32;

float[][] data = new float[DIMENSIONS][DIMENSIONS];

Hinton diagram;

void setup(){
 
     size(540, 540, "processing.core.PGraphicsRetina2D"); 
  
     //filling data array
     for(int j = 0; j < DIMENSIONS; j++){
         for(int i = 0; i < DIMENSIONS; i++){ data[i][j] = random(-128.0, 128.0); }
     }
     
     //2D data array, dimensions, margins
     diagram = new Hinton(data, -128.0, 128.0, 500.0, 20.0);
     
     diagram.draw();
     
}
