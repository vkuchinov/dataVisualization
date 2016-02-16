
/*

DATA VISUALIZATION by Wolfram MathWorld Classes

 [-] Anti-Aliasing         [-] Moiré Pattern          [-] Simplex Plot
 [-] Antialiasing          [-] Ordinate               [-] Slope Field
 [-] Bar Chart             [-] Phase Curve            [-] Sparkline
 [x] Binary Plot           [-] Phase Flow             [-] Strang's Strange Figures
 [-] Cartesian Plot        [-] Phase Plane            [-] Surface of Section
 [-] Data Cube             [-] Phase Portrait         [-] Ternary Diagram
 [-] de Finetti Diagram    [-] Phase Space            [-] Ternary Graph
 [-] Equipotential Curve   [-] Pie Chart              [-] Ternary Plot
 [-] Function Graph        [-] Poincaré Section       [-] Tetraview
 [-] Inside-Outside Plot   [x] Pólya Plot             [-] Triangle Plot
 [-] Level Curve           [-] Recurrence Plot        [x] Tupper's Self-Referent*
 [-] Level Set             [-] Saunders Graphic       [-] Vector Field
 [-] Level Surface         [-] Scatter Diagram        [-] Web Diagram
 [-] Log-Log Plot          [-] Scatter Plot           [-] World Line
 [-] Log Plot              [-] Scatterplot 
 
 * Everything formula [Formula of Everything]
 
NOTES:

 [x] Anti-Aliasing / Antialiasing could be skipped, algorithms, not data-visualization models.=
 [-] Binary Plot vs. Euler's Number Triangle
     could be visualized as matryoshka toy.
     Top parts look like 'space invaders'
     Optionals: Losanitsch's Triangle, Pascal's Triangle, Second-Order Eulerian Triangle,
                

REFERENCES:
http://mathworld.wolfram.com/topics/DataVisualization.html

@author Vladimir V. KUCHINOV
@email  helloworld@vkuchinov.co.uk

*/

void setup(){
  
 size(800, 800, "processing.core.PGraphicsRetina2D"); 
 background(255);
 translate(width/2, height/2);
  
 //Polya Plot
 PolyaPlot plot = new PolyaPlot();
 
}
