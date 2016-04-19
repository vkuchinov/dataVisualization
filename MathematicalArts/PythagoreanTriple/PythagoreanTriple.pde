/*

PYTHAGOREAN TRIPLE

A Pythagorean triple is a triple of positive integers a, b, and c such 
that a right triangle exists with legs a,b and hypotenuse c. 

By the Pythagorean theorem, this is equivalent to finding positive 
integers a, b, and c satisfying:

    a² + b² = c²

The smallest and best-known Pythagorean triple is (a,b,c)=(3,4,5). 
The right triangle having these side lengths is sometimes called 
the 3, 4, 5 triangle.

REFERENCES:
http://mathworld.wolfram.com/PythagoreanTriple.html
https://sozvyezdami.wordpress.com/2013/07/25/a-picture-of-pythagorean-triples/

@author  Vladimir V. KUCHINOV
@email   helloworld@vkuchinov.co.uk

*/

Pythagorean triple;

void setup(){
 
     size(540, 540);
     //translate(width/2, height/2);
     
     triple = new Pythagorean(32);
     triple.draw();
  
}
