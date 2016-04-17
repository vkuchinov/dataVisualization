/*

STRANG'S STRANGE FIGURES

Strang's strange figures are the figures produced by plotting 
a periodic function f(z) as a function of an integer argument

n for n=1, 2, .... 

Unexpected patterns and periodicities result from 
near-commensurabilities of certain rational numbers with 
the period. 

Strang figures are shown above for a number of 
common functions.

CSC(N) [cosecant]
the ratio of the hypotenuse (in a right-angled triangle) to 
the side opposite an acute angle; the reciprocal of sine.

REFERENCES:
http://mathworld.wolfram.com/StrangsStrangeFigures.html
http://www.nature.com/articles/srep06193

@author   Vladimir V. KUCHINOV
@email    helloworld@vkuchinov.co.uk

*/

final int SIN = 0;
final int TAN = 1;
final int CSC = 2;

Strange figures;

void setup(){
  
     size(600, 500, "processing.core.PGraphicsRetina2D"); 
  
     figures = new Strange(1, 1500, SIN);
     
     figures.draw();
}
