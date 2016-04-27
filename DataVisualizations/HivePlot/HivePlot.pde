/*

HIVE PLOT

The hive plot is a rational visualization method for drawing networks. 
Nodes are mapped to and positioned on radially distributed linear axes — 
this mapping is based on network structural properties. Edges are drawn 
as curved links. Simple and interpretable.

The purpose of the hive plot is to establish a new baseline for visualization 
of large networks — a method that is both general and tunable and useful as 
a starting point in visually exploring network structure.


REFERENCES:
http://www.hiveplot.net/

@author Vladimir V. KUCHINOV
@email  helloworld@vkuchinov.co.uk

*/

Hive plot;

void setup(){
 
     size(600, 600, "processing.core.PGraphicsRetina2D"); 
     background(0);
     
     plot = new Hive();
     plot.draw();
     
}
