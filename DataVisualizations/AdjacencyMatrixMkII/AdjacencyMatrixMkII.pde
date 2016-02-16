/*

ADJACENCY MATRIX CLASS
for graphs visualization

REFERENCE:

Shortest Path Algorithms:
[for the undirected graphs]
https://en.wikipedia.org/wiki/Shortest_path_problem
https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm  Dijkstra, 1959
https://en.wikipedia.org/wiki/Fibonacci_heap Fredman & Tarjan, 1984 [Dijkstra's with Fibonacci heap]
http://dl.acm.org/citation.cfm?id=316548 Thorup, 1999

FURTHER READINGS:
http://mathworld.wolfram.com/ResistanceDistance.html

@author    Vladimir V. KUCHINOV
@email     helloworld@vkuchinov.co.uk

*/

import processing.pdf.*;
import java.util.Random;

ArrayList<PVector> points = new ArrayList<PVector>();
Random seed = new Random(12345);

final String URL = "data/BarnetteGraph.svg";

void setup(){
  
     size(680, 750, "processing.core.PGraphicsRetina2D"); 
     background(255);
     beginRecord(PDF, "output.pdf");
     
     Graph g = new Graph(URL);
     println(g.nodes.size());
     
     Adjacency matrix = new Adjacency(50, 50, 500, g);
     matrix.draw();
     
     endRecord();
     
}
