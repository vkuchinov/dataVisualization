/*

HAFERMAN CARPET

The Haferman carpet is the beautiful fractal constructed 
using string rewriting beginning with a cell and iterating 
the rules.

           1 1 1         0 1 0
       0 > 1 1 1     1 > 1 0 1
           1 1 1         0 1 0
           
       1, 3, 9, 27, 81 ...
       
STRING REWRITING

A substitution system in which rules are used to operate on 
a string consisting of letters of a certain alphabet. 
String rewriting systems are also variously known as 
rewriting systems, reduction systems, or term rewriting systems. 

String rewriting is a particularly useful technique for 
generating successive iterations of certain types of fractals, 
such as the box fractal, Cantor dust, Cantor square fractal, 
and Sierpiński carpet.

REFERENCES:
http://mathworld.wolfram.com/HafermanCarpet.html
http://mathworld.wolfram.com/StringRewritingSystem.html

@author Vladimir V. KUCHINOV
@email  helloworld@vkuchinov.co.uk

*/

Haferman carpet;

void setup(){
  
      size(600, 600, "processing.core.PGraphicsRetina2D");
      
      carpet = new Haferman(4);
      carpet.weave(0);
      carpet.draw();
      
      println(carpet.cells.length);
  
}
